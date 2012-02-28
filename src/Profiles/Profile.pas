unit Profile;

interface

uses ComCtrls, Classes, GenericConnector, CL_TerminalFrame, CL_TabFactory, CL_ConnectorFactory, ProfileSettings, SerialComPort;

type TProfile = class ( TObject )

  constructor Create( AOwner : TObject );

  procedure activate();
  procedure deactivate();

  procedure setName( name : string );
  function getName():string;


  public
  terminal : TTerminalFrame;

  settings : TProfileSettings;
  isActive : boolean;

  protected
  name : string;

end;


implementation

constructor TProfile.Create(AOwner: TObject);
begin
  name := 'unknown';
  isActive := false;
  settings := TProfileSettings.Create;
end;

procedure TProfile.activate();
var
    connector: TGenericConnector;
begin
    if (self.isActive) then begin
      exit;
    end;

    isActive := true;

    terminal := TTerminalFrame( tabFactory.createTab( name, 'TTerminalFrame' ));
    connector := connectorFactory.createConnector( 'TSerialComPort');
    connector.User := self.name;
    connector.onRecived := terminal.onRecived;

    // hand over the connector to the terminal
    terminal.connector := connector;
end;

procedure TProfile.deactivate();
var
    connector: TGenericConnector;
begin
  isActive := false;

  connector := terminal.connector;
  tabFactory.destroyTab( terminal );
  connectorFactory.destroyConnector( connector );

end;

procedure TProfile.setName(name: string);
begin
  self.name:= name;
end;

function TProfile.getName():string;
begin
  getName := name;
end;


end.
