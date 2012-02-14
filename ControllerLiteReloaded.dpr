program ControllerLiteReloaded;

uses
  Forms,
  main in 'src\main.pas' {Form1},
  HelpForm in 'src\HelpForm.pas' {Help},
  ConnectorList in 'src\Connectors\ConnectorList.pas',
  GenericConnector in 'src\Connectors\GenericConnector.pas',
  SerialComPort in 'src\Connectors\SerialComPort.pas',
  Profile in 'src\Profiles\Profile.pas',
  CL_TerminalFrame in 'src\Terminals\CL_TerminalFrame.pas' {TerminalView: TFrame},
  ProfileList in 'src\Profiles\ProfileList.pas',
  CL_tabManager in 'src\CL_tabManager.pas',
  ProfileSettings in 'src\Profiles\ProfileSettings.pas',
  CL_ConnectorFrame in 'src\Connectors\CL_ConnectorFrame.pas' {ConnectorFrame: TFrame},
  CL_ProfileFrame in 'src\Profiles\CL_ProfileFrame.pas' {ProfileFrame: TFrame},
  CL_testList in 'CL_testList.pas',
  CL_testFrame in 'CL_testFrame.pas' {TestFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(THelp, Help);
  Application.Run;
end.
