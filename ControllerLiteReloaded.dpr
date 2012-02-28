program ControllerLiteReloaded;

uses
  Forms,
  main in 'src\main.pas' {Form1},
  HelpForm in 'src\HelpForm.pas' {Help},
  GenericConnector in 'src\Connectors\GenericConnector.pas',
  SerialComPort in 'src\Connectors\SerialComPort.pas',
  Profile in 'src\Profiles\Profile.pas',
  CL_TerminalFrame in 'src\Terminals\CL_TerminalFrame.pas' {TerminalView: TFrame},
  ProfileList in 'src\Profiles\ProfileList.pas',
  CL_tabFactory in 'src\CL_tabFactory.pas',
  ProfileSettings in 'src\Profiles\ProfileSettings.pas',
  CL_ConnectorFactory in 'src\Connectors\CL_ConnectorFactory.pas' {ConnectorFactory: TFrame},
  CL_ProfileFrame in 'src\Profiles\CL_ProfileFrame.pas' {ProfileFactory: TFrame},
  ConnectorTypes in 'src\Connectors\ConnectorTypes.pas',
  ScriptEngine in 'src\Terminals\ScriptEngine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ControllerLiteReloaded';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(THelp, Help);
  Application.Run;
end.
