unit ProfileList;

interface

uses Classes, Controls, Profile, CL_tabFactory;

type TProfileList = class (TList)

  constructor Create();

  procedure Clear(); override;
  procedure loadProfiles();

  protected

end;

implementation

constructor TProfileList.create();
begin
  inherited Create();
end;


procedure TProfileList.Clear;
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
  profile := TProfile.Create( self );
  profile.setName( 'CAN Master' );
  profile.settings.defaultConnector := 'TSerialComPort';
  profile.settings.defaultTarget := 'COM1';
  self.Add( profile );


  profile := TProfile.Create( self );
  profile.setName( 'Autofokus' );
  profile.settings.defaultConnector := 'TSerialComPort';
  profile.settings.defaultTarget := 'COM1';
  self.Add( profile );

end;


end.
