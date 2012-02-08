program ControllerLiteReloaded;

uses
  Forms,
  main in 'src\main.pas' {Form1},
  GenericConnector in 'src\GenericConnector.pas',
  SerialComPort in 'src\SerialComPort.pas',
  ConnectorList in 'src\ConnectorList.pas',
  ConnectionFrame in 'src\ConnectionFrame.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
