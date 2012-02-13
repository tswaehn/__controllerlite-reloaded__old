unit Profile;

interface

uses ComCtrls, Classes, TerminalFrame, TabManager, ProfileSettings, GenericConnector, SerialComPort;

type TProfile = class ( TObject )

  constructor Create( AOwner : TObject; tabmanager:TTabManager );

  procedure activate();
  procedure deactivate();

  procedure setName( name : string );
  function getName():string;


  public
  terminal : TTerminalView;
  tabManager : TTabManager;

  settings : TProfileSettings;
  active : boolean;

  protected
  name : string;

end;


implementation

constructor TProfile.Create(AOwner: TObject; tabmanager:TTabManager);
begin
  name := 'unknown';
  active := false;
  self.tabManager := tabmanager;
  settings := TProfileSettings.Create;



end;

procedure TProfile.activate();
begin
    if (self.active) then begin
      exit;
    end;

    active := true;

    terminal := TTerminalView( tabmanager.createTab( name, 'TTerminalView' ));
end;

procedure TProfile.deactivate();
begin
  active := false;

  tabmanager.destroyTab( terminal );
  terminal.Free();
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
