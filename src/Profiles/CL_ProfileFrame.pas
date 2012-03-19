unit CL_ProfileFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ProfileList, profile, Menus, CL_tabFactory;

type
  TProfileFactory = class(TFrame)
    ListView1: TListView;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Start1: TMenuItem;
    Stop1: TMenuItem;
    N1: TMenuItem;
    Preferences1: TMenuItem;
    Save1: TMenuItem;

    constructor Create( AOwner : TComponent ); override;
    destructor Destroy(); override;

    procedure display();
    procedure Start1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);

    procedure activateProfile();
    procedure deactivateProfile();
    procedure toggleProfile();
    procedure Save1Click(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }

  protected
    profileList : TProfileList;

  end;

var profileFactory : TProfileFactory;

implementation


{$R *.dfm}

constructor TProfileFactory.Create( AOwner: TComponent );
begin
  inherited create( AOwner );

  profileList := TProfileList.create();
  profileList.loadProfiles();

  display();
end;

destructor TProfileFactory.Destroy;
begin
  profileList.Free;
  inherited Destroy();
end;

procedure TProfileFactory.display();
var i:integer;
    profile : TProfile;
    item : TListItem;
begin
  listview1.Clear;

  for i := 0 to profileList.Count - 1 do begin
    profile := profileList[i];
    listview1.AddItem( profile.getName(), profile );
    item := listview1.FindData(0, profile, true, true );

    if (profile.isActive) then begin
      item.ImageIndex := 1;
    end else begin
      item.ImageIndex := 0;
    end;
  end;
end;

procedure TProfileFactory.activateProfile;
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

procedure TProfileFactory.deactivateProfile;
var selected:integer;
    profile : TProfile;
begin
  selected := listview1.ItemIndex;

  if (selected >= 0) then begin
    profile := TProfile( listview1.Items[selected].data );
    profile.deactivate();
    display();
    tabFactory.setActiveTab( self );
  end;

end;

procedure TProfileFactory.toggleProfile;
var selected:integer;
    profile : TProfile;
begin
  selected := listview1.ItemIndex;

  if (selected >= 0) then begin
    profile := TProfile( listview1.Items[selected].data );

    if profile.isActive then begin
      deactivateProfile;
    end else begin
      activateProfile;
    end;
  end;

end;

procedure TProfileFactory.ListView1DblClick(Sender: TObject);
begin
  toggleProfile();
end;

procedure TProfileFactory.Save1Click(Sender: TObject);
var selected:integer;
    profile : TProfile;
begin
  selected := listview1.ItemIndex;

    if (selected >= 0) then begin
      profile := TProfile( listview1.Items[selected].data );
      profile.settings.storeToFile;
    end;

end;

procedure TProfileFactory.Start1Click(Sender: TObject);
begin
  activateProfile();
end;

procedure TProfileFactory.Stop1Click(Sender: TObject);
begin
  deactivateProfile();
end;

end.
