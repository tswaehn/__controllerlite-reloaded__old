unit GenericConnector;

interface

uses classes, ConnectorTypes;


type TGenericConnector = class (TPersistent)

  public
    constructor Create(); virtual;
    destructor Destroy(); override;


  public
    procedure setup(); virtual;
    procedure toggleConnect();
    procedure connect(); virtual;
    procedure disconnect(); virtual;

    function connected():boolean; virtual;

    procedure send( data : string ); virtual; abstract;


  protected
    myName : string;
    myType : string;
    myUser : string;
    FOnRefresh : TConnectorRefresh;

  published
    property cName : string read myName write myName;
    property cType : string read myType write myType;
    property cUser : string read myUser write myUser;

    property onRefresh: TConnectorRefresh read FOnRefresh write FOnRefresh;

end;

type TGenericConnectorClass = class of TGenericConnector;

implementation

(*
    TGenericConnector
*)

constructor TGenericConnector.create( );
begin
  inherited create();

  cName := 'unknown connector';
  cType := 'unknown type';

  if Assigned(FOnRefresh)  then begin
      FOnRefresh();
  end;

end;


destructor TGenericConnector.destroy();
begin
  self.disconnect();

  inherited destroy();
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
  if Assigned( FOnRefresh ) then begin
    FOnRefresh();
  end;

end;

procedure TGenericConnector.disconnect;
begin
  if Assigned( FOnRefresh ) then begin
    FOnRefresh();
  end;
end;


function TGenericConnector.connected():boolean;
begin
  connected := false;
end;



end.
