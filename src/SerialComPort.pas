unit SerialComPort;


interface

uses genericConnector, classes, cport;

type TSerialComPort = class (TGenericConnector)

  constructor create(AOwner : TComponent );
  destructor destroy();

  procedure setup(); override;

  private
    comPort : TComPort;

end;

implementation

constructor TSerialComPort.create( AOwner : TComponent );
begin
  name := 'SerialComPort';
  comPort := TComPort.Create( AOwner );
end;

destructor TSerialComPort.destroy() : destroy;
begin
 comPort.Free;
end;

procedure TSerialComPort.setup;
begin
  comPort.ShowSetupDialog();
  comPort.Open;
  comPort.WriteStr('hello world'+#13+#10);
  

end;

end.
