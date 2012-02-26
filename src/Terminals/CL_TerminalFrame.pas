unit CL_TerminalFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GenericConnector;

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
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    GroupBox2: TGroupBox;
    Memo2: TMemo;
    Button4: TButton;
    Button18: TButton;
    GroupBox3: TGroupBox;
    Memo1: TMemo;
    ComboBox1: TComboBox;
    Button1: TButton;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Button3: TButton;
    Button2: TButton;
    Button17: TButton;
    Label1: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;

    destructor Destroy(); override;
    procedure Button17Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    connector : TGenericConnector;
  end;

implementation

{$R *.dfm}

procedure TTerminalFrame.Button17Click(Sender: TObject);
begin
  connector.setup();
end;

procedure TTerminalFrame.Button1Click(Sender: TObject);
begin
  connector.send( ComboBox1.Text );
end;

procedure TTerminalFrame.Button2Click(Sender: TObject);
begin
  connector.connect();
end;

procedure TTerminalFrame.Button3Click(Sender: TObject);
begin
  connector.disconnect();
end;

destructor TTerminalFrame.Destroy;
begin
  inherited destroy();

end;

end.
