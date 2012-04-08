unit CL_ToolboxFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, ComCtrls, ImgList, CategoryButtons,
  ButtonGroup, ScriptEngine, ProfileSettings;

type
  TToolboxFrame = class(TFrame)
    ListView1: TListView;
    ImageList1: TImageList;
    ValueListEditor1: TValueListEditor;
    Button1: TButton;

    constructor Create(AOwner: TComponent); override;

  private
    procedure setProfileSettings( profileSettings:TSettings );
    procedure refillParameterList();

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
var parameterGroup:TParameterGroup;
    parameterList : TParameterList;
    parameter : TParameter;
    I,k: Integer;
begin
  if Assigned( profileSettings ) = false then exit;

  // clear list
 ValueListEditor1.Strings.Clear;

  // refill list
  parameterGroup := mProfileSettings.parameterGroup;
  for I := 0 to parameterGroup.Count - 1 do begin
    parameterList := parameterGroup.getList( i );
    for k := 0 to parameterList.Count - 1 do begin
      parameter := parameterList.getParameter(k);
      ValueListEditor1.InsertRow( parameter.name + ' ' + parameter.id, parameter.value, true );
    end;
  end;

end;

end.
