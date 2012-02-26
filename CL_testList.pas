unit CL_testList;

interface

uses CL_testFrame, classes;

type TTestList = class (TList)

  constructor create();

  procedure removeItem( index : integer);
  procedure addItem( str : string );
  procedure display();

  protected
  frame : TTestFrame;
end;

implementation

uses CL_tabFactory;

type TString = class (TObject)

  str : string;
end;

constructor TTestList.Create;
begin
  inherited create();

  frame := TTestFrame( tabFactory.createTab('test', 'TTestFrame' ));
  frame.onAdd := self.addItem;
 // frame.onRemove := self.removeItem;
end;

procedure TTestList.display;
var i:integer;
    str : TString;
begin
  frame.ListBox1.Clear;

  for i := 0 to self.Count - 1 do begin
    str := TString(self.Items[i]);
    frame.ListBox1.Items.Add( str.str );
  end;

end;

procedure TTestList.addItem(str: string);
var s:TString;
begin
  s := TString.Create;
  s.str := str;

  self.Add( s );
  display();
end;

procedure TTestList.removeItem(index: Integer);
var str:TString;
begin
  if (index >= 0) and (index < self.Count) then begin
    str := TString(self.items[index]);
    self.Remove( str );
  end;
  display();
end;

end.
