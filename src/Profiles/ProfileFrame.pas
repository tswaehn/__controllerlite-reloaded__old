unit ProfileFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ProfileList, profile, Menus, tabmanager;

type
  TProfileView = class(TFrame)
    ListView1: TListView;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Start1: TMenuItem;
    Stop1: TMenuItem;
    N1: TMenuItem;
    Preferences1: TMenuItem;

    constructor Create( AOwner: TComponent; tabManager : TTabManager );

    procedure display();
    procedure Start1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);

    procedure activateProfile();
    procedure deactivateProfile();
    procedure toggleProfile();

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    tabManager : TTabManager;

  protected
    profileList : TProfileList;

  end;

implementation

{$R *.dfm}

constructor TProfileView.Create(AOwner: TComponent; tabManager : TTabManager);
begin
  inherited create( AOwner );
  self.tabManager := tabManager;

  profileList := TProfileList.create( tabmanager );
  profileList.loadProfiles();

  display();
end;


procedure TProfileView.display();
var i:integer;
    profile : TProfile;
    item : TListItem;
begin
  listview1.Clear;

  for i := 0 to profileList.Count - 1 do begin
    profile := profileList[i];
    listview1.AddItem( profile.getName(), profile );
    item := listview1.FindData(0, profile, true, true );

    if (profile.active) then begin
      item.ImageIndex := 1;
    end else begin
      item.ImageIndex := 0;
    end;
  end;
end;

procedure TProfileView.activateProfile;
var selected:integer;
    profile : TProfile;
begin
  selected := listview1.ItemIndex;

  if (selected >= 0) then begin
    profile := TProfile( listview1.Items[selected].data );
    profile.activate();
    display();
  end;
end;

procedure TProfileView.deactivateProfile;
var selected:integer;
    profile : TProfile;
begin
  selected := listview1.ItemIndex;

  if (selected >= 0) then begin
    profile := TProfile( listview1.Items[selected].data );
    profile.deactivate();
    display();
    tabmanager.setActiveTab( self );
  end;

end;

procedure TProfileView.toggleProfile;
var selected:integer;
    profile : TProfile;
begin
  selected := listview1.ItemIndex;

  if (selected >= 0) then begin
    profile := TProfile( listview1.Items[selected].data );

    if profile.active then begin
      deactivateProfile;
    end else begin
      activateProfile;
    end;
  end;

end;

procedure TProfileView.ListView1DblClick(Sender: TObject);
begin
  toggleProfile();
end;

procedure TProfileView.Start1Click(Sender: TObject);
begin
  activateProfile();
end;

procedure TProfileView.Stop1Click(Sender: TObject);
begin
  deactivateProfile();
end;

end.
