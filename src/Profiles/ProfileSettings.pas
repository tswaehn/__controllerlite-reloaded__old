unit ProfileSettings;

interface

type TProfileSettings = class (TObject)

  constructor create();

  public
  defaultConnector : string;
  defaultTarget : string;

end;


implementation

constructor TProfileSettings.create;
begin
  defaultConnector := 'none';
  defaultTarget := 'none';
end;

end.
