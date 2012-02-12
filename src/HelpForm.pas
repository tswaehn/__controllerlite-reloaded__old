unit HelpForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  THelp = class(TForm)
    TreeView1: TTreeView;
    Memo1: TMemo;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  help: THelp;

implementation

{$R *.dfm}

end.
