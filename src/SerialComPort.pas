unit SerialComPort;


interface

uses genericConnector, classes, cport;

type TSerialComPort = class (TGenericConnector)

  constructor create(AOwner : TComponent );
  destructor destroy();

    procedure setup(); override;
    procedure connect(); override;
    procedure disconnect(); override;

    function connected():boolean; override;    

  private
    comPort : TComPort;

end;

implementation

constructor TSerialComPort.create( AOwner : TComponent );
begin

  comPort := TComPort.Create( AOwner );

  cName := 'SerialComPort';
  cType := comPort.Port;
end;

destructor TSerialComPort.destroy();
begin
 comPort.Free;
end;

procedure TSerialComPort.setup;
begin
  try
  comPort.ShowSetupDialog();
  finally

  end;
  cType := comPort.Port;
end;

procedure TSerialComPort.connect;
begin
  if comPort.Connected then begin
    exit;
  end;
  comPort.Open;
end;

procedure TSerialComPort.disconnect;
begin
  if comPort.Connected = false then begin
    exit;
  end;
  comPort.Close;
end;

function TSerialComPort.connected():boolean;
begin
  connected := comPort.connected;
end;

end.
