unit SerialComPort;


interface

uses genericConnector, classes, cport;

type TSerialComPort = class (TGenericConnector)

  constructor create(); override;
  destructor Destroy(); override;

    procedure setup(); override;
    procedure connect(); override;
    procedure disconnect(); override;

    procedure onRecive( Sender: TObject ; const rxString: string );

    function connected():boolean; override;

  private
    comPort : TComPort;
    comPortDataPacket: TComDataPacket;

end;

type TSerialComPortClass = class of TSerialComPort;

implementation

constructor TSerialComPort.create();
begin
  inherited create();

  comPort := TComPort.Create( nil );
  comPortDataPacket := TComDataPacket.Create( nil );
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
