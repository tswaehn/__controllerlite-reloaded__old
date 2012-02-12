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

procedure TProfileList.loadProfiles;
var profile: TProfile;
begin
  profile := TProfile.Create( self, tabManager  );
  profile.setName( 'CAN Master' );
  self.Add( profile );


  profile := TProfile.Create( self, tabmanager );
  profile.setName( 'Autofokus' );
  self.Add( profile );

end;


end.
