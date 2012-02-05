unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GenericConnector, SerialComPort, CPort;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ComPort1: TComPort;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private-Deklarationen }
    connection : TGenericConnector;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  connection.setup;
  //ComPort1.ShowSetupDialog;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  connection :=  TSerialComport.create( self );

  label1.Caption := connection.name;
end;

end.
