unit Profile;

interface

uses ComCtrls, Classes, GenericConnector, CL_TerminalFrame, CL_TabFactory, CL_ConnectorFactory, ProfileSettings, SerialComPort;

type TProfile = class ( TObject )

  constructor Create( AOwner : TObject );
  destructor Destroy(); override;

  procedure activate();
  procedure deactivate();

  procedure setBasePath( path : string );
  procedure loadFromFile();

  procedure setName( name : string );
  function getName():string;


  public
  terminal : TTerminalFrame;

  settings : TProfileSettings;
  isActive : boolean;

  protected

end;


implementation

constructor TProfile.Create(AOwner: TObject);
begin
  isActive := false;
  settings := TProfileSettings.Create;
end;

destructor TProfile.Destroy;
begin
  deactivate;
  settings.Free;
end;

procedure TProfile.setBasePath(path: string);
begin
  settings.basepath:= path;
end;

procedure TProfile.loadFromFile;
begin
  settings.loadFromFile;
end;

procedure TProfile.activate();
var
    connector: TGenericConnector;
begin
    if (isActive) then begin
      exit;
    end;

    isActive := true;

    terminal := TTerminalFrame( tabFactory.createTab( getName(), 'TTerminalFrame' ));
    connector := connectorFactory.createConnector( 'TSerialComPort');
    connector.User := getName();
    connector.onRecived := terminal.onRecived;

    // hand over the connector to the terminal
    terminal.connector := connector;
    terminal.profileSettings := settings;
end;

procedure TProfile.deactivate();
var
    connector: TGenericConnector;
begin
  if (isActive=false) then exit;
  
  isActive := false;

  connector := terminal.connector;
  tabFactory.destroyTab( terminal );
  connectorFactory.destroyConnector( connector );
end;

procedure TProfile.setName(name: string);
begin
  settings.name:=name;
end;

function TProfile.getName():string;
begin
  getName := settings.name;
end;


end.
