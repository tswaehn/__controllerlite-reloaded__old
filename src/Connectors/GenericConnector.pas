unit GenericConnector;

interface

uses classes, ConnectorTypes;


type TGenericConnector = class (TPersistent)

  public
    constructor Create(); virtual;
    destructor Destroy; override;


  public
    procedure setup(); virtual;
    procedure toggleConnect();
    procedure connect(); virtual;
    procedure disconnect(); virtual;

    function connected():boolean; virtual;
    function connectedStr():string;

    procedure send( data : string ); virtual; abstract;


  protected
    myName : string;
    myTarget : string;
    myUser : string;
    FOnChanged : TConnectorRefresh;
    FOnRecived: TConnectorRecive;

    procedure doOnChanged();


    procedure setName( newName : string );
    procedure setTarget( newTarget : string );
    procedure setUser( newUser: string );


  published
    property Name : string read myName write setName;
    property Target : string read myTarget write setTarget;
    property User : string read myUser write setUser;

    property onChanged: TConnectorRefresh read FOnChanged write FOnChanged;
    property onRecived: TConnectorRecive read FOnRecived write FOnRecived;

end;

type TGenericConnectorClass = class of TGenericConnector;

implementation

(*
    TGenericConnector
*)

constructor TGenericConnector.Create( );
begin
  inherited create();

  myName := 'unknown connector';
  myTarget := 'unknown target';
  myUser := 'unknown user';


end;


destructor TGenericConnector.Destroy();
begin
  self.disconnect();

  inherited Destroy();
end;

procedure TGenericConnector.doOnChanged;
begin
  if Assigned(FOnChanged)  then begin
      FOnChanged();
  end;
end;

procedure TGenericConnector.setName(newName: string);
begin
  myName := newName;
  doOnChanged;
end;

procedure TGenericConnector.setTarget(newTarget: string);
begin
  myTarget:= newTarget;
  doOnChanged;
end;

procedure TGenericConnector.setUser(newUser: string);
begin
  myUser:= newUser;
  doOnChanged;
end;

procedure TGenericConnector.setup;
begin
  //
end;

procedure TGenericConnector.toggleConnect;
begin
  if (connected = true) then begin
    disconnect();
  end else begin
    connect();
  end;
end;

procedure TGenericConnector.connect;
begin
  doOnChanged();
end;

procedure TGenericConnector.disconnect;
begin
  doOnChanged();
end;


function TGenericConnector.connected():boolean;
begin
  connected := false;
end;

function TGenericConnector.connectedStr():string;
begin
  if connected then begin
    result:= 'connected';
  end else begin
    result:= 'disconnected';
  end;

end;




end.
