unit ProfileList;

interface

uses Classes, Controls, SysUtils, Dialogs, Profile, CL_tabFactory;

type TProfileList = class (TList)

  constructor Create();

  procedure Clear(); override;
  procedure loadProfiles();

  private
    procedure createDirectoryList();

  private
    basepath:string;
    directoryList : TStringList;

  protected

end;

implementation

constructor TProfileList.create();
begin
  inherited Create();
  basepath := '.\profiles\';
  directoryList:=TStringList.Create();

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

procedure TProfileList.createDirectoryList();
var ret:integer;
    search : TSearchRec;
begin

  directoryList.Clear;

  ret := findFirst( basepath + '*', faDirectory, search );
  while (ret = 0) do begin
    if ((search.Name <> '.') and (search.Name <> '..')) then begin
      directoryList.Append( search.Name );
    end;

    ret := findNext( search );

  end;
  findClose( search );

end;
(*
    hier wird normalerweise aus der datei geladen
*)
procedure TProfileList.loadProfiles;
var profile: TProfile;
  i: Integer;
  name:string;
  path:string;
begin

  createDirectoryList();

  for i := 0 to directoryList.Count - 1 do begin
    name := directoryList.Strings[i];
    path:= basepath + name + '\';

    profile := TProfile.Create( self );
    profile.setBasePath( path );
    profile.loadFromFile();

//    aus dem profil lesen !!
//    profile.settings.defaultConnector := 'TSerialComPort';
//    profile.settings.defaultTarget := 'COM1';
    self.Add( profile );

  end;
(*
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
 *)

end;


end.
