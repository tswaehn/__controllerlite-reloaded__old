unit ConnectionFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ConnectorList, ExtCtrls;

type
  TFrame1 = class(TFrame)
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
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    connectorList : TConnectorList;
  end;

implementation

{$R *.dfm}
constructor TFrame1.create(AOwner: TControl);
begin
  inherited Create( AOwner );

  connectorList := TConnectorList.create();

  connectorList.display( listbox1 );
end;

procedure TFrame1.Button4Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.edit( selected );
end;

procedure TFrame1.Button5Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.sortUp( selected );
end;


procedure TFrame1.Button6Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.sortDown( selected );
end;

procedure TFrame1.Button7Click(Sender: TObject);
var selected : integer;
begin
  selected := listbox1.ItemIndex;
  listbox1.ItemIndex := connectorList.toggleConnect( selected );
end;
end.
