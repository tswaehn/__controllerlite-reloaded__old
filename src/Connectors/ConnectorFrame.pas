unit ConnectorFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ConnectorList, ExtCtrls, GenericConnector;

type
  TConnectorView = class(TFrame)
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button7: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

    constructor create( AOwner : TControl );

    procedure display();

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    connectorList : TConnectorList;
  end;

implementation

{$R *.dfm}
constructor TConnectorView.create(AOwner: TControl);
begin
  inherited Create( AOwner );

  connectorList := TConnectorList.create( AOwner );

  display();
end;

procedure TConnectorView.display;
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
    listbox1.AddItem( strId+' - ' + connector.getName()+ ' ('+connector.getType()+')'+'  --  '+'['+connectStr+']', connector );
  end;
end;

procedure TConnectorView.Button4Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.edit( selected );
  display();
end;

procedure TConnectorView.Button5Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.sortUp( selected );
  display();
end;


procedure TConnectorView.Button6Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.sortDown( selected );
  display();
end;

procedure TConnectorView.Button7Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.toggleConnect( selected );
  display();
end;
end.
