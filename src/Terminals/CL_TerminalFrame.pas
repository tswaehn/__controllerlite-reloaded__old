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
    procedure doClientUpdate();

    procedure setupMakros();

  public
    { Public-Deklarationen }
    connector : TGenericConnector;


  private
    makroButtons : array[0..11] of TButton;

    scriptEngine : TScriptEngine;
    timeStampsEnabled : boolean;
    startTime : TDateTime;
    toolbox: TToolboxFrame;
    mProfileSettings : TSettings;

  private
    { Private-Deklarationen }
    procedure openCloseToolbox;
    function getStartTime(): string;
    function getDeltaTime(): string;
    function convertTime( convTime : TDateTime ): string;

    procedure onScriptStart();
    procedure onScriptPause();
    procedure onScriptResume();
    procedure onScriptStop();

    procedure onScriptButton( Sender : TObject );

  published
    property profileSettings : TSettings read mProfileSettings write mProfileSettings;

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

  makroButtons[0] := Button5;
  makroButtons[1] := button6;
  makroButtons[2] := Button7;
  makroButtons[3] := button8;
  makroButtons[4] := Button9;
  makroButtons[5] := button10;
  makroButtons[6] := Button11;
  makroButtons[7] := button12;
  makroButtons[8] := Button13;
  makroButtons[9] := button14;
  makroButtons[10] := Button15;
  makroButtons[11] := button16;

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
    toolbox:= TToolboxFrame( tabFactory.createTab( mProfileSettings.properties.name + '[ToolBox]', 'TToolboxFrame'));
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

procedure TTerminalFrame.doClientUpdate;
begin
    label3.Caption := connector.Target + ' '+ connector.connectedStr;
    combobox2.Items.Clear;
    comboBox2.Items.Add( connector.Name );
    comboBox2.ItemIndex := 0;

end;

procedure TTerminalFrame.setupMakros;
var
  i: Integer;
begin

  for i := 0 to mProfileSettings.terminalButtons.count - 1 do begin
    self.makroButtons[i].Caption := mProfileSettings.terminalButtons.items[i].caption;
    self.makroButtons[i].Enabled := mProfileSettings.terminalButtons.items[i].enabled;
    self.makroButtons[i].OnClick := self.onScriptButton;
  end;

end;

procedure TTerminalFrame.onScriptButton(Sender: TObject);
var
  i: Integer;
  button : TScriptButton;
  scriptFileName : string;
begin
  for i := 0 to mProfileSettings.terminalButtons.count - 1 do begin
    if Sender=self.makroButtons[i] then begin
      button := mProfileSettings.terminalButtons.items[i];
      break;
    end;
  end;

  if (button <> nil) then begin
    scriptFileName := mProfileSettings.basepath + mProfileSettings.properties.scriptPath + button.filename;
    self.addLog( 'button : ' + button.caption + '(' + scriptFileName + ')' );
    self.addLog( scriptEngine.runScript( scriptFileName ) );
  end;


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
end;

procedure TTerminalFrame.Button3Click(Sender: TObject);
begin
  connector.disconnect();
end;


procedure TTerminalFrame.Button4Click(Sender: TObject);
begin
  scriptEngine.runScript( quickMakroMemo.Lines );
end;

end.
