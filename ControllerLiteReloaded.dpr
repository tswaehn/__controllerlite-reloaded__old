program ControllerLiteReloaded;

uses
  Forms,
  main in 'src\main.pas' {Form1},
  GenericConnector in 'src\GenericConnector.pas',
  SerialComPort in 'src\SerialComPort.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
