unit CL_ConnectorFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ConnectorTypes, GenericConnector, SerialComPort;

type
  TConnectorFactory = class(TFrame)
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);

  public
    constructor Create( AOwner : TComponent ); override;
    destructor Destroy();

    function createConnector( classStr : string ): TGenericConnector;
    procedure destroyConnector( connector : TGenericConnector );

    procedure display();
    procedure doRefresh();

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    connectorList : TList;
  end;

var connectorFactory : TConnectorFactory;

implementation

{$R *.dfm}
constructor TConnectorFactory.create(AOwner: TComponent );
begin
  inherited Create( AOwner );

  // register diverse connectors here
  RegisterClass( TGenericConnector );
  RegisterClass( TSerialComport );

  connectorList := TList.create();

  display();
end;

destructor TConnectorFactory.Destroy();
var connector : TGenericConnector;
begin

  while (connectorList.Count > 0) do begin
    connector := connectorList.first;
    connectorList.remove( connector );
    connector.Free;
  end;
end;


procedure TConnectorFactory.doRefresh();
begin

  display();

end;

function TConnectorFactory.createConnector(classStr: string):TGenericConnector;
var connectorClass : TPersistentClass;
    connector : TGenericConnector;
begin

    connectorClass := findClass( classStr ) ;
    connector := TGenericConnector( connectorClass.Create());

    connector.create();
    connector.OnUpdateConnectorList := doRefresh;

    connectorList.add( connector );

    display();
    result := connector;
end;

procedure TConnectorFactory.destroyConnector(connector: TGenericConnector);
begin
    connector.Free;
    connectorList.Remove( connector );
    display();
end;

procedure TConnectorFactory.display;
var i:integer;
    strId: string;
    connector:TGenericConnector;
    connectStr:string;
begin

  listbox1.Clear();
  for i := 0 to connectorList.Count - 1 do begin
    connector := connectorList.items[i];
    strId := IntToStr(i);
    if (connector.connected) then begin
      connectStr := 'connected';
    end else begin
      connectStr := 'disconnected';
    end;
    listbox1.AddItem( strId+' - ' + connector.Name+ ' ('+connector.Target+' '+ connector.User +')'+'  --  '+'['+connectStr+']', connector );
  end;
end;

procedure TConnectorFactory.Button1Click(Sender: TObject);
begin
  display();
end;

end.
