unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SerialComPort, CPort, Grids, ComCtrls, CL_ConnectorFactory,
  CL_TerminalFrame, CL_ProfileFrame, ProfileList, CL_TabFactory,
  ExtCtrls, Tabs, DockTabSet, Menus, ImgList;

type
  TForm1 = class(TForm )
    PageControl1: TPageControl;
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    ImageList1: TImageList;
    Advanced1: TMenuItem;
    ImportControllerLiteiniProfile1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private-Deklarationen }


  public
    { Public-Deklarationen }

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
begin

  tabFactory := TTabManager.Create(pageControl1);

  // create tab
  profileFactory := TProfileFactory( tabFactory.createTab( 'Profiles', 'TProfileFactory' ));

  // create tab
  connectorFactory := TConnectorFactory( tabFactory.createTab( 'Connectors', 'TConnectorFactory' ));

  tabFactory.setActiveTab( profileFactory );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  tabFactory.destroyTab(profileFactory);
  tabFactory.destroyTab(connectorFactory);
  tabFactory.Free;
end;

procedure TForm1.Help1Click(Sender: TObject);
begin
  Help.show();
end;

end.
