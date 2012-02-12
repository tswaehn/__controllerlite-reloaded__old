unit ProfileList;

interface

uses Classes, Controls, Profile, tabmanager;

type TProfileList = class (TList)

  constructor create( tabmanager : TTabManager );
  destructor destroy();

  procedure loadProfiles();

  protected
    tabManager:TTabManager;
end;

implementation

constructor TProfileList.create( tabmanager : TTabManager );
begin
  inherited Create();
  self.tabManager := tabManager;
end;

destructor TProfileList.destroy;
var profile : TProfile;
begin
  while self.Count > 0 do begin
    profile := TProfile(self.first());
    self.Remove( profile );
    profile.Free;
  end;
end;

(*
    hier wird normalerweise aus der datei geladen
*)
procedure TProfileList.loadProfiles;
var profile: TProfile;
begin
  profile := TProfile.Create( self, tabManager  );
  profile.setName( 'CAN Master' );
  profile.settings.defaultConnector := 'TSerialComPort';
  profile.settings.defaultTarget := 'COM1';
  self.Add( profile );


  profile := TProfile.Create( self, tabmanager );
  profile.setName( 'Autofokus' );
  profile.settings.defaultConnector := 'TSerialComPort';
  profile.settings.defaultTarget := 'COM1';
  self.Add( profile );

end;


end.
