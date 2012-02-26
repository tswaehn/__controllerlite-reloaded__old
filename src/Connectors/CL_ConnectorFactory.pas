unit CL_ConnectorFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ConnectorList, ExtCtrls, GenericConnector;

type
  TConnectorFactory = class(TFrame)
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button7: TButton;
    Button1: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

    constructor Create( AOwner : TComponent ); override;

    function createConnector( classStr : string ): TGenericConnector;
    procedure destroyConnector( connector : TGenericConnector );

    procedure display();
    procedure Button1Click(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    connectorList : TConnectorList;
  end;

var connectorFactory : TConnectorFactory;

implementation

{$R *.dfm}
constructor TConnectorFactory.create(AOwner: TComponent );
begin
  inherited Create( AOwner );

  connectorList := TConnectorList.create();
  connectorList.OnRefresh := display;

  display();
end;

function TConnectorFactory.createConnector(classStr: string):TGenericConnector;
var connector : TGenericConnector;
begin
  connector := connectorList.createConnector( classStr );
  display();
  result := connector;
end;

procedure TConnectorFactory.destroyConnector(connector: TGenericConnector);
begin
  connectorList.removeConnector( connector );
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
    listbox1.AddItem( strId+' - ' + connector.cName+ ' ('+connector.cType+' '+ connector.cUser +')'+'  --  '+'['+connectStr+']', connector );
  end;
end;

procedure TConnectorFactory.Button1Click(Sender: TObject);
begin
  display();
end;

procedure TConnectorFactory.Button4Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.edit( selected );
end;

procedure TConnectorFactory.Button5Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.sortUp( selected );
end;


procedure TConnectorFactory.Button6Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.sortDown( selected );
end;

procedure TConnectorFactory.Button7Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.toggleConnect( selected );
end;
end.
