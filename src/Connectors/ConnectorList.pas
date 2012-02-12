unit ConnectorList;

interface
uses Classes, GenericConnector, SerialComPort, StdCtrls, SysUtils;

type TConnectorList = class( TList )

  constructor create();
  destructor destroy();

  procedure loadConnectors();

  function createConnector( className : string ):TGenericConnector;


  function edit( index : integer ):integer;
  function toggleConnect( index: integer ):integer;

  function sortUp( index : integer ) : integer;
  function sortDown( index : integer ) : integer;

  private

end;


implementation

constructor TConnectorList.create();
begin
  inherited Create;
  RegisterClass( TGenericConnector );
  RegisterClass( TSerialComport );

  createConnector( 'TSerialComPort' );
  createConnector( 'TSerialComPort' );

end;

destructor TConnectorList.destroy;
var connector: TGenericConnector;
begin
  inherited destroy;

  while (Count > 0) do begin
    connector := first;
    remove( connector );
    connector.Free;
  end;
end;


function TConnectorList.createConnector( className : string ):TGenericConnector;
var connectorClass : TPersistentClass;
    connector : TGenericConnector;
begin

    connectorClass := findClass( className ) ;
    connector := TGenericConnector( connectorClass.Create());
    connector.create();

    add( connector );

    createConnector := connector;
end;

procedure TConnectorList.loadConnectors();
var connector : TGenericConnector;
begin

end;





function TConnectorList.edit(index: Integer):integer;
var connector:TGenericConnector;
begin
  if (index < 0) or (index >= count) then begin
    exit;
  end;

  connector := items[index];
  connector.setup();

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

  
  sortDown := newIndex;
end;

end.
