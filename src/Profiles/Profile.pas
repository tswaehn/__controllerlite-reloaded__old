unit Profile;

interface

uses ComCtrls, TerminalFrame, TabManager;

type TProfile = class ( TObject )

  constructor Create( AOwner : TObject; tabmanager:TTabManager );

  procedure activate();
  procedure deactivate();

  procedure setName( name : string );
  function getName():string;


  public
  terminal : TTerminalView;
  tabManager : TTabManager;
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
end;

procedure TProfile.activate();
var tabsheet:TTabSheet;
begin
    if (self.active) then begin
      exit;
    end;

    active := true;

    tabsheet := tabmanager.createTab( name );

    terminal := TTerminalView.Create( tabsheet );
    terminal.Parent := tabsheet;

    //tabmanager.setActiveTab( terminal );
end;

procedure TProfile.deactivate();
begin
  active := false;

  tabmanager.destroyTab( terminal );

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
