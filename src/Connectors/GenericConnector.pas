unit GenericConnector;

interface

uses classes, TerminalFrame;

type TGenericConnector = class (TObject)

  constructor create(AOwner : TComponent );


  public
    procedure setup(); virtual;
    procedure toggleConnect();
    procedure connect(); virtual;
    procedure disconnect(); virtual;

    procedure setTerminal( terminal : TTerminalView );

    function connected():boolean; virtual;
    function getName():string;
    function getType():string;

  protected
    cName : string;
    cType : string;

    terminal : TTerminalView;
end;

implementation

constructor TGenericConnector.create(AOwner : TComponent );
begin
  cName := 'unknown connector';
  cType := 'unknown type';
end;


procedure TGenericConnector.setup;
begin
  //
end;

procedure TGenericConnector.toggleConnect;
begin
  if (connected) then begin
    disconnect();
  end else begin
    connect();
  end;
end;

procedure TGenericConnector.connect;
begin
  //
end;

procedure TGenericConnector.disconnect;
begin
  //
end;

procedure TGenericConnector.setTerminal( terminal : TTerminalView );
begin
   self.terminal := terminal;
end;


function TGenericConnector.connected():boolean;
begin
  connected := false;
end;

function TGenericConnector.getName():string;
begin
  getName := cName;
end;

function TGenericConnector.getType():string;
begin
  getType := cType;
end;

end.
