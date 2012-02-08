unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ConnectorList, SerialComPort, CPort, Grids, ComCtrls,ConnectionFrame,
  ExtCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormCreate(Sender: TObject);

  private
    { Private-Deklarationen }


  public
    { Public-Deklarationen }
    frame : TFrame;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
var tabsheet : ttabsheet;
begin


  //http://edn.embarcadero.com/article/32047
(*
  tabsheet := pagecontrol1.ActivePage;

*)
  frame := TFrame1.create( Tabsheet1 );
  frame.Parent := Tabsheet1;
end;

end.
