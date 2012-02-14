unit Profile;

interface

uses ComCtrls, Classes, CL_TerminalFrame, CL_TabManager, ProfileSettings, GenericConnector, SerialComPort;

type TProfile = class ( TObject )

  constructor Create( AOwner : TObject );

  procedure activate();
  procedure deactivate();

  procedure setName( name : string );
  function getName():string;


  public
  terminal : TTerminalFrame;
  connector: TGenericConnector;

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
begin
    if (self.isActive) then begin
      exit;
    end;

    isActive := true;

    terminal := TTerminalFrame( tabFactory.createTab( name, 'TTerminalFrame' ));
end;

procedure TProfile.deactivate();
begin
  isActive := false;

  tabFactory.destroyTab( terminal );
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
