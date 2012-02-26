unit ConnectorList;

interface
uses Classes, GenericConnector, ConnectorTypes, SerialComPort, StdCtrls, SysUtils;

type TConnectorList = class( TList )

  constructor create();
  destructor destroy();

  procedure loadConnectors();

  function createConnector( className : string ):TGenericConnector;
  procedure removeConnector( connector : TGenericConnector );


  function edit( index : integer ):integer;
  function toggleConnect( index: integer ):integer;

  function sortUp( index : integer ) : integer;
  function sortDown( index : integer ) : integer;

  private
    procedure doRefresh();

  private
    FOnRefresh : TConnectorRefresh;

  published
    property OnRefresh : TConnectorRefresh read FOnRefresh write FOnRefresh;

end;


implementation

constructor TConnectorList.create();
begin
  inherited Create;

  // register diverse connectors here
  RegisterClass( TGenericConnector );
  RegisterClass( TSerialComport );

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

procedure TConnectorList.doRefresh();
begin

  if Assigned( FOnRefresh ) then begin
    FOnRefresh();
  end;

end;

function TConnectorList.createConnector( className : string ):TGenericConnector;
var connectorClass : TPersistentClass;
    connector : TGenericConnector;
begin

    connectorClass := findClass( className ) ;
    connector := TGenericConnector( connectorClass.Create());
    connector.create();
    connector.onRefresh := doRefresh;
    
    add( connector );

    createConnector := connector;
end;

procedure TConnectorList.removeConnector(connector: TGenericConnector);
begin
    connector.Free;
    self.Remove( connector );
end;

procedure TConnectorList.loadConnectors();
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

  doRefresh();
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

  doRefresh();
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

  doRefresh();
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

  doRefresh();

  sortDown := newIndex;
end;

end.
