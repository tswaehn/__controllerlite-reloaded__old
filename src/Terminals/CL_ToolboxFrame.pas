unit CL_ToolboxFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, ComCtrls, ImgList, CategoryButtons,
  ButtonGroup, ScriptEngine, ProfileSettings, CL_ToolboxInlay;

type
  TToolboxFrame = class(TFrame)
    PageControl1: TPageControl;

    constructor Create(AOwner: TComponent); override;

  private
    procedure setProfileSettings( profileSettings:TSettings );
    procedure refillParameterList();

    procedure createTab( toolboxGroup : TToolboxGroup );
  private
    { Private-Deklarationen }
    mScriptEngine : TScriptEngine;
    mProfileSettings : TSettings;


  public
    { Public-Deklarationen }

  published
    property ScriptEngine : TScriptEngine read mScriptEngine write mScriptEngine;
    property profileSettings : TSettings read mProfileSettings write setProfileSettings;

  end;

implementation

{$R *.dfm}


constructor TToolboxFrame.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

end;

procedure TToolboxFrame.setProfileSettings(profileSettings: TSettings);
begin
  self.mProfileSettings := profileSettings;
  refillParameterList();
end;

procedure TToolboxFrame.refillParameterList;
var
  i: Integer;
  toolboxGroup : TToolboxGroup;
begin
  for i := 0 to profileSettings.toolboxGroups.Count - 1 do begin
    toolboxGroup := profileSettings.toolboxGroups.items[i];

    createTab( toolboxGroup );

  end;

end;

procedure TToolboxFrame.createTab(toolboxGroup : TToolboxGroup);
var tabsheet : ttabsheet;
    frame : TToolboxInlay;
begin

  // erzeuge tab
  tabsheet := TTabsheet.Create( pagecontrol1 );
  tabsheet.PageControl := pageControl1;
  tabsheet.Caption := toolboxGroup.name;
  tabsheet.ImageIndex := -1;

  frame := TToolboxInlay.Create( nil );
  //frame.Create( nil );
  frame.Parent := tabsheet;
  frame.toolboxGroup := toolboxGroup;
  frame.display;

end;


end.
