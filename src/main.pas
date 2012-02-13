unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ConnectorList, SerialComPort, CPort, Grids, ComCtrls,ConnectorFrame,
  TerminalFrame, ProfileFrame, ProfileList, TabManager,
  ExtCtrls, Tabs, DockTabSet, Menus;

type
  TForm1 = class(TForm )
    PageControl1: TPageControl;
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);

  private
    { Private-Deklarationen }


  public
    { Public-Deklarationen }
    tabManager: TTabManager;

    profiles: TProfileFrame;
    connectors : TConnectorView;

    terminal : TTerminalView;

    frame : TFrame;
  end;

var
  Form1: TForm1;

implementation

uses HelpForm, GenericConnector;

{$R *.dfm}



procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate();
end;

procedure TForm1.FormCreate(Sender: TObject);
var tabsheet : ttabsheet;
begin

  tabManager := TTabManager.Create(pageControl1);

  // erzeuge tab
  profiles := TProfileFrame( tabManager.createTab( 'Profiles', 'TProfileFrame' ));

  // erzeuge tab
  connectors := TConnectorView( tabManager.createTab( 'Connectors', 'TConnectorView' ));

end;

procedure TForm1.Help1Click(Sender: TObject);
begin
  Help.show();
end;

end.
