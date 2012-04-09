unit CL_ToolboxInlay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, Grids, ValEdit, StdCtrls, profileSettings;

type
  TToolboxInlay = class(TFrame)
    B1: TButton;
    Button3: TButton;
    B3: TButton;
    B4: TButton;
    B5: TButton;
    B6: TButton;
    b7: TButton;
    b8: TButton;
    b9: TButton;
    b10: TButton;
    B2: TButton;
    b11: TButton;
    b13: TButton;
    b14: TButton;
    b15: TButton;
    b16: TButton;
    b17: TButton;
    b18: TButton;
    b19: TButton;
    b20: TButton;
    b21: TButton;
    b23: TButton;
    b22: TButton;
    b12: TButton;
    b24: TButton;

    ValueListEditor1: TValueListEditor;
    ListView1: TListView;

    constructor Create( AOwner : TComponent ); override;

    procedure display();
  private
    { Private-Deklarationen }
    
    mButtons: array [0..23] of TButton;
  public
    { Public-Deklarationen }

    toolboxGroup : TToolboxGroup;
  end;

implementation

{$R *.dfm}
constructor TToolboxInlay.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  mButtons[0] := b1;
  mButtons[1] := b2;
  mButtons[2] := b3;
  mButtons[3] := b4;
  mButtons[4] := b5;
  mButtons[5] := b6;
  mButtons[6] := b7;
  mButtons[7] := b8;
  mButtons[8] := b9;
  mButtons[9] := b10;
  mButtons[10] := b11;
  mButtons[11] := b12;
  mButtons[12] := b13;
  mButtons[13] := b14;
  mButtons[14] := b15;
  mButtons[15] := b16;
  mButtons[16] := b17;
  mButtons[17] := b18;
  mButtons[18] := b19;
  mButtons[19] := b20;
  mButtons[20] := b21;
  mButtons[21] := b22;
  mButtons[22] := b23;
  mButtons[23] := b24;


end;

procedure TToolboxInlay.display;
var
  i: Integer;
  parameter:TParameter;
  parameterList :TParameterList;
  buttonList : TScriptButtonList;
  parCaption:string;
  parValue : string;
begin
  for i := 0 to valueListEditor1.RowCount - 1 do begin
//    ValueListEditor1.DeleteRow(i);
  end;

  // display parameters
  parameterList := toolboxGroup.parameterList;

  for i := 0 to parameterList.Count - 1 do begin
    parameter := parameterList.items[i];
    ValueListEditor1.InsertRow( parameter.name, parameter.value, true );
  end;

  buttonList := toolboxGroup.buttonList;
  for i := 0 to 23 do begin
    mButtons[i].Caption := buttonList.items[i].caption;
    mButtons[i].Enabled := buttonList.items[i].enabled;
  end;

end;


end.
