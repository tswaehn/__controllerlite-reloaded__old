unit SerialComPort;


interface

uses genericConnector, classes, cport;

type TSerialComPort = class (TGenericConnector)

  constructor create(AOwner : TComponent );
  destructor destroy();

    procedure setup(); override;
    procedure connect(); override;
    procedure disconnect(); override;

    procedure onRecive( Sender: TObject ; const rxString: string );

    function connected():boolean; override;

  private
    comPort : TComPort;
    comPortDataPacket: TComDataPacket;

end;

implementation

constructor TSerialComPort.create( AOwner : TComponent );
begin

  comPort := TComPort.Create( AOwner );
  comPortDataPacket := TComDataPacket.Create( AOwner );
  comPortDataPacket.ComPort := comPort;
  comPortDataPacket.StopString := #13+#10;

  comPortDataPacket.OnPacket := onRecive;


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

procedure TSerialComPort.onRecive(Sender: TObject; const rxString: string);
begin
       self.terminal.Memo1.Lines.Add( rxString );
end;


function TSerialComPort.connected():boolean;
begin
  connected := comPort.connected;
end;

end.
