unit CL_TerminalFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ProfileSettings, GenericConnector, ScriptEngine, CL_ToolboxFrame;

type
  TTerminalFrame = class(TFrame)
    GroupBox1: TGroupBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    GroupBox2: TGroupBox;
    quickMakroMemo: TMemo;
    Button4: TButton;
    Button18: TButton;
    GroupBox3: TGroupBox;
    terminalMemo: TMemo;
    ComboBox1: TComboBox;
    Button1: TButton;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Button3: TButton;
    Button2: TButton;
    Button17: TButton;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    StopButton: TButton;
    PauseButton: TButton;
    Button21: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button22: TButton;

    procedure Button17Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure Button21Click(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure onRecived( data: string );
    procedure addLog( msg: string );
    procedure addRx( msg: string );
    procedure addTx( msg: string );

    procedure send( msg : string );


  public
    { Public-Deklarationen }
    connector : TGenericConnector;


  private
    scriptEngine : TScriptEngine;
    timeStampsEnabled : boolean;
    startTime : TDateTime;
    toolbox: TToolboxFrame;
    mProfileSettings : TProfileSettings;

  private
    { Private-Deklarationen }
    procedure openCloseToolbox;
    procedure update();
    function getStartTime(): string;
    function getDeltaTime(): string;
    function convertTime( convTime : TDateTime ): string;

    procedure onScriptStart();
    procedure onScriptPause();
    procedure onScriptResume();
    procedure onScriptStop();

  published
    property profileSettings : TProfileSettings read mProfileSettings write mProfileSettings;

  end;

implementation

uses CL_tabFactory;

{$R *.dfm}

constructor TTerminalFrame.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  scriptEngine := TScriptEngine.Create;
  scriptEngine.OnScriptLog := addLog;
  scriptEngine.OnScriptSend := send;
  scriptEngine.OnScriptStarted := onScriptStart;
  scriptEngine.OnScriptPaused := onScriptPause;
  scriptEngine.OnScriptResumed := onScriptResume;
  scriptEngine.OnScriptStopped := onScriptStop;

  toolbox:=nil;
end;

destructor TTerminalFrame.Destroy;
begin
  scriptEngine.free;

  if toolbox <> nil then begin
        tabFactory.destroyTab( toolbox );
  end;

  inherited destroy();
end;

procedure TTerminalFrame.openCloseToolbox;
begin
  if toolbox=nil then begin
    //create toolbox
    toolbox:= TToolboxFrame( tabFactory.createTab( mProfileSettings.name + '[ToolBox]', 'TToolboxFrame'));
    toolbox.profileSettings := self.profileSettings;
  end else begin
    //destroy toolbox
    tabFactory.destroyTab( toolbox );
    toolbox := nil;
  end;

end;

procedure TTerminalFrame.onScriptStart;
begin
  StopButton.Enabled := true;
  PauseButton.Enabled := true;
  pauseButton.Caption := 'Pause';
end;

procedure TTerminalFrame.onScriptPause;
begin
  pauseButton.Caption := 'Resume';
end;

procedure TTerminalFrame.onScriptResume;
begin
  pauseButton.Caption := 'Pause';
end;

procedure TTerminalFrame.onScriptStop;
begin
  StopButton.Enabled := false;
  PauseButton.Enabled := false;
  pauseButton.Caption := 'Pause';
end;

function TTerminalFrame.convertTime(convTime: TDateTime):string;
var text:string;
begin
  text := '['+timeToStr( convTime )+']' ;
  result := text;
end;

function TTerminalFrame.getStartTime: string;
var currentTime:TDateTime;
begin
  currentTime := time();
  self.startTime := currentTime;
  result := convertTime( currentTime );
end;

function TTerminalFrame.getDeltaTime:string;
var currentTime,deltaTime: TDateTime;
begin
  currentTime := time();
  deltaTime := currentTime - self.startTime;
  result := convertTime( deltaTime );
end;

procedure TTerminalFrame.addLog(msg: string);
var text:string;
begin
  text:= '>' + msg;
  terminalMemo.Lines.Add( text );
end;

procedure TTerminalFrame.addTx(msg: string);
var text:string;
begin
  text:= getStartTime() + ' TX>'+msg;
  terminalMemo.Lines.Add( text );
end;

procedure TTerminalFrame.addRx(msg: string);
var text:string;
begin
  text := getDeltaTime() + ' RX>'+msg;
  terminalMemo.Lines.Add( text );
end;


procedure TTerminalFrame.onRecived(data: string);
begin
  scriptEngine.recived( data );
  addRx( data );
end;

procedure TTerminalFrame.send(msg: string);
begin
  addTx( msg );
  connector.send( msg );
end;

procedure TTerminalFrame.update;
begin
    label3.Caption := connector.Target + ' '+ connector.connectedStr;
end;

procedure TTerminalFrame.Button17Click(Sender: TObject);
begin
  connector.setup();
  update();
end;

procedure TTerminalFrame.StopButtonClick(Sender: TObject);
begin
  scriptEngine.stopScript();
end;

procedure TTerminalFrame.Button1Click(Sender: TObject);
begin
  send( ComboBox1.Text );
end;

procedure TTerminalFrame.PauseButtonClick(Sender: TObject);
begin
  if (scriptEngine.isPaused) then begin
    scriptEngine.resumeScript;

  end else begin
    scriptEngine.pauseScript;

  end;
end;

procedure TTerminalFrame.Button21Click(Sender: TObject);
begin
  openCloseToolbox;
end;

procedure TTerminalFrame.Button22Click(Sender: TObject);
begin
  quickMakroMemo.Text:=scriptEngine.getNewDefaultScript();
end;

procedure TTerminalFrame.Button2Click(Sender: TObject);
begin
  connector.connect();
  update();
end;

procedure TTerminalFrame.Button3Click(Sender: TObject);
begin
  connector.disconnect();
  update();
end;


procedure TTerminalFrame.Button4Click(Sender: TObject);
begin
  scriptEngine.runScript( quickMakroMemo.Lines );
end;

end.
