unit GenericConnector;

interface

uses classes, CL_TerminalFrame;

type TGenericConnector = class (TPersistent)

 constructor create(); virtual;


  public
    procedure setup(); virtual;
    procedure toggleConnect();
    procedure connect(); virtual;
    procedure disconnect(); virtual;

    procedure setTerminal( terminal : TTerminalFrame );

    function connected():boolean; virtual;
    function getName():string;
    function getType():string;

  protected
    cName : string;
    cType : string;

    terminal : TTerminalFrame;
end;

type TGenericConnectorClass = class of TGenericConnector;

implementation

constructor TGenericConnector.create();
begin
  inherited create();

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

procedure TGenericConnector.setTerminal( terminal : TTerminalFrame );
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
