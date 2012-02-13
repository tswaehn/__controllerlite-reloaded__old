program ControllerLiteReloaded;

uses
  Forms,
  main in 'src\main.pas' {Form1},
  HelpForm in 'src\HelpForm.pas' {Help},
  ConnectorFrame in 'src\Connectors\ConnectorFrame.pas' {ConnectorView: TFrame},
  ConnectorList in 'src\Connectors\ConnectorList.pas',
  GenericConnector in 'src\Connectors\GenericConnector.pas',
  SerialComPort in 'src\Connectors\SerialComPort.pas',
  Profile in 'src\Profiles\Profile.pas',
  TerminalFrame in 'src\Terminals\TerminalFrame.pas' {TerminalView: TFrame},
  ProfileList in 'src\Profiles\ProfileList.pas',
  tabManager in 'src\tabManager.pas',
  ProfileSettings in 'src\Profiles\ProfileSettings.pas',
  ProfileFrame in 'src\Profiles\ProfileFrame.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(THelp, Help);
  Application.Run;
end.
