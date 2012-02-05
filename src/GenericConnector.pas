unit GenericConnector;

interface

uses classes;

type TGenericConnector = class (TObject)

  constructor create(AOwner : TComponent );
  destructor destroy();

  public
    name : string;
    procedure setup(); virtual;

end;

implementation

constructor TGenericConnector.create(AOwner : TComponent );
begin
  name := 'unknown connector';
  
end;

destructor TGenericConnector.destroy;
begin
  //
end;

procedure TGenericConnector.setup;
begin
  //
end;

end.
