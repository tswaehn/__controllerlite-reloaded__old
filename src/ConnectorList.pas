unit ConnectorList;

interface
uses Classes, GenericConnector, SerialComPort, StdCtrls, SysUtils;

type TConnectorList = class( TList )

  constructor create();
  destructor destroy();

  procedure loadConnectors();

  procedure display();                      overload;
  procedure display( listbox : TListBox ); overload;

  function edit( index : integer ):integer;
  function toggleConnect( index: integer ):integer;
  
  function sortUp( index : integer ) : integer;
  function sortDown( index : integer ) : integer;

  private
    lastUsedListbox : TListBox;
end;


implementation

constructor TConnectorList.create;
begin
  lastUsedListbox := nil;
  loadConnectors();
end;

destructor TConnectorList.destroy;
var connector: TGenericConnector;
begin
  while (Count > 0) do begin
    connector := first;
    remove( connector );
    connector.Free;
  end;
end;


procedure TConnectorList.loadConnectors();
var connector : TGenericConnector;
begin
  // lade aus datei, hier nur zum testen
  connector := TSerialComport.create(nil);
  add( connector );

  connector := TSerialComport.create(nil);
  add( connector );

end;

procedure TConnectorList.display();
begin
  if (lastUsedListBox = nil) then begin
    exit;
  end;

  display( lastUsedListBox );

end;

procedure TConnectorList.display( listbox : TListBox );
var i:integer;
    strId: string;
    connector:TGenericConnector;
    connectStr:string;
begin

  listbox.Clear();
  for i := 0 to Count - 1 do begin
    connector := self.items[i];
    if (i=0) then begin
      strId := 'default';
    end else begin
      strId := IntToStr(i);
    end;
    if (connector.connected) then begin
      connectStr := 'connected';
    end else begin
      connectStr := 'disconnected';
    end;
    listbox.AddItem( strId+' - ' + connector.getName()+ ' ('+connector.getType()+')'+'  --  '+'['+connectStr+']', connector );
  end;

  lastUsedListBox := listbox;
end;

function TConnectorList.edit(index: Integer):integer;
var connector:TGenericConnector;
begin
  if (index < 0) or (index >= count) then begin
    exit;
  end;

  connector := items[index];
  connector.setup();

  display();

  edit:= index;
end;

function TConnectorList.toggleConnect(index: Integer):integer;
var connector:TGenericConnector;
begin
  if (index < 0) or (index >= count) then begin
    exit;
  end;

  connector := items[index];
  try
    connector.toggleConnect();
  finally

  end;

  display();

  toggleConnect:= index;
end;

function TConnectorList.sortUp(index: Integer):integer;
var newIndex : integer;
begin
  if (index < 0) or (index >= count) then begin
    exit;
  end;

  newIndex := index - 1;
  if (newIndex < 0 ) then begin
    newIndex := 0;
  end;

  self.move( index, newIndex );
  display();

  sortUp := newIndex;
end;

function TConnectorList.sortDown(index: Integer):integer;
var newIndex : integer;
begin
  if (index < 0) or (index >= count) then begin
    exit;
  end;

  newIndex := index + 1;
  if (newIndex >= self.Count ) then begin
    newIndex := self.Count - 1;
  end;

  self.move( index, newIndex );
  display();

  sortDown := newIndex;
end;

end.
