unit SerialComPort;


interface

uses genericConnector, classes, cport;

type TSerialComPort = class (TGenericConnector)

  public
    constructor Create(); override;
    destructor Destroy(); override;

    procedure setup(); override;
    procedure connect(); override;
    procedure disconnect(); override;

    procedure send( data : string); override;
    procedure onRecive( Sender: TObject ; const rxString: string );

    function connected():boolean; override;

  private
    comPort : TComPort;
    comPortDataPacket: TComDataPacket;

end;

type TSerialComPortClass = class of TSerialComPort;

implementation

constructor TSerialComPort.Create( );
begin
  inherited Create();

  comPort := TComPort.Create( nil );
  comPortDataPacket := TComDataPacket.Create( nil );
  comPortDataPacket.ComPort := comPort;
  comPortDataPacket.StopString := #13+#10;

  comPortDataPacket.OnPacket := onRecive;

  myName := 'SerialComPort';
  myTarget := comPort.Port;

  doOnChanged();
end;

destructor TSerialComPort.Destroy();
begin
 comPort.Free;
 inherited Destroy();
end;

procedure TSerialComPort.setup;
begin
  try
  comPort.ShowSetupDialog();
  finally

  end;

  target := comPort.Port;

  doOnChanged();
end;

procedure TSerialComPort.connect;
begin
  if comPort.Connected then begin
    exit;
  end;
  comPort.Open;
  doOnChanged();
end;

procedure TSerialComPort.disconnect;
begin
  if comPort.Connected = false then begin
    exit;
  end;
  comPort.Close;
  doOnChanged();
end;

procedure TSerialComPort.send(data: string);
begin
  if comPort.Connected then begin
    comPort.WriteStr( data +#13+#10 );
  end;

end;

procedure TSerialComPort.onRecive(Sender: TObject; const rxString: string);
begin
  if Assigned( FOnRecived)  then begin
    FOnRecived( rxString );
  end;
end;


function TSerialComPort.connected():boolean;
begin
  connected := comPort.connected;
end;

end.
