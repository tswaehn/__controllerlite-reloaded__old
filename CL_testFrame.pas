unit CL_testFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TProcedureAdd = procedure( str : string ) of object;
  TProcedureRemove = procedure ( index : integer ) of object;


  TTestFrame = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

    constructor create( AOwner : TComponent );  override;



  private
    { Private-Deklarationen }
    procedure onAddDummy( str : string );
    procedure onRemoveDummy( i : integer );
  public
    { Public-Deklarationen }
    onAdd : TProcedureAdd;
    onRemove : TProcedureRemove;
  end;

implementation

{$R *.dfm}

constructor TTestFrame.create ( AOwner : TComponent );
begin
  inherited create( AOwner );
  onAdd := onAddDummy;
  onRemove := onRemoveDummy;
end;

procedure TTestFrame.onAddDummy(str: string);
begin
  showmessage('missing onAdd()');
end;

procedure TTestFrame.onRemoveDummy(i: Integer);
begin
  showmessage('missing onRemove()');
end;


procedure TTestFrame.Button1Click(Sender: TObject);
begin
  onAdd( edit1.Text );
end;

procedure TTestFrame.Button2Click(Sender: TObject);
var i : integer;
begin
  i := listbox1.Itemindex;
  onRemove( i );
end;

end.
