unit tabManager;

interface

uses ComCtrls, Controls;

type TTabManager = class (TObject)

  constructor create( pageControl : TPageControl );
  function createTab( caption : string ):TTabSheet;
  procedure destroyTab( child : TWinControl );

  procedure setActiveTab( child : TWinControl );
  function findTabContaining( child : TWinControl ): TTabSheet;

  protected
    pageControl : TPageControl;

end;

implementation

constructor TTabManager.create(pageControl: TPageControl);
begin
  inherited Create();
  self.pageControl := pageControl;
end;

function TTabManager.createTab(caption: string):TTabSheet;
var tabsheet : ttabsheet;
begin

  // erzeuge tab
  tabsheet := TTabsheet.Create( pagecontrol );
  tabsheet.PageControl := pageControl;
  tabsheet.Caption := caption;

  CreateTab := tabsheet;
end;

procedure TTabManager.destroyTab(child: TWinControl);
var tabsheet : TTabSheet;
begin
  tabsheet := findTabContaining( child );
  tabsheet.Free;
  pagecontrol.Repaint;
end;

procedure TTabManager.setActiveTab( child : TWinControl );
var tabsheet: TTabSheet;
begin
  tabsheet:= findTabContaining( child );
  pageControl.ActivePageIndex := tabsheet.TabIndex;
end;


function TTabManager.findTabContaining(child: TWinControl): TTabSheet;
var tabsheet: TTabSheet;
//    i:integer;
begin
  tabsheet := TTabSheet( child.Parent );
//  for I := 0 to pageControl.PageCount - 1 do begin
//    tabsheet := pageControl.Pages[i];
//
//    if (tabsheet. then
//
//
//  end;
  findTabContaining:= tabsheet;
end;

end.
