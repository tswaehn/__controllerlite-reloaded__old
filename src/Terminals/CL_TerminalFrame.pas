unit CL_TerminalFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GenericConnector, ScriptEngine;

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
    Button19: TButton;
    Button20: TButton;
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
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure onRecived( data: string );
    procedure addLog( msg: string );
    procedure send( msg : string );

  private
    scriptEngine : TScriptEngine;
  private
    { Private-Deklarationen }
    procedure update();

  public
    { Public-Deklarationen }
    connector : TGenericConnector;
  end;

implementation

{$R *.dfm}

constructor TTerminalFrame.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  scriptEngine := TScriptEngine.Create;
  scriptEngine.OnScriptLog := addLog;
  scriptEngine.OnScriptSend := send;

end;

destructor TTerminalFrame.Destroy;
begin
  scriptEngine.free;

  inherited destroy();
end;

procedure TTerminalFrame.addLog(msg: string);
begin
  terminalMemo.Lines.Add( msg );
end;

procedure TTerminalFrame.onRecived(data: string);
begin
  terminalMemo.Text := terminalMemo.Text + data;
end;

procedure TTerminalFrame.send(msg: string);
begin
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

procedure TTerminalFrame.Button19Click(Sender: TObject);
begin
  scriptEngine.recived('test');
end;

procedure TTerminalFrame.Button1Click(Sender: TObject);
begin
  send( ComboBox1.Text );
end;

procedure TTerminalFrame.Button20Click(Sender: TObject);
begin
  scriptEngine.pauseScript;
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
