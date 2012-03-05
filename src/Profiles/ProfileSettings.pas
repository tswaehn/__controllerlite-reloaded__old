unit ProfileSettings;

interface

uses Classes, SysUtils;

// ------------------ TScript -----------------------

type TScript = class (TStrings)

  constructor Create();
  destructor Destroy(); override;

  procedure load();

  public
    name : string;
end;

// ------------------ TParameter -----------------------
type TParameter = class (TObject)

  constructor Create();
  destructor Destroy(); override;

  public
    name:string;
    id:string;
    value:string;
    default: string;
    description:string;

    readScript : TScript;
    writeScript : TScript;
end;

// ------------------ TParameterList -----------------------
type TParameterList = class (TList)

  constructor Create();

  procedure Clear();override;
  procedure load();
  function getParameter( index : integer ):TParameter;

  public
    name : string;

end;
// ------------------ TParameterGroup -----------------------
type TParameterGroup = class (TList)

  constructor Create();

  procedure Clear(); override;
  procedure load();
  function getList( index : integer ):TParameterList;


end;

// ------------------ TProfileSettings -----------------------
type TProfileSettings = class (TObject)

  constructor Create();
  destructor Destroy(); override;

  public
  name:string;
  defaultConnector : string;
  defaultTarget : string;
  parameterGroup : TParameterGroup;

end;


implementation

(*
  TScript
*)
constructor TScript.Create;
begin
  inherited Create();
  self.load;
end;

destructor TScript.Destroy;
begin

  inherited Destroy();
end;

procedure TScript.load;
begin
  name := 'unknown';
  //self.Text := 'hello world';
  //text := TStrings.Create;
  //text.text :=  'begin' +#13+#10 + 'end.';
end;

(*
  TParameter
*)
constructor TParameter.Create;
begin
  name := 'unknown';
  id :='0815';
  default:= 'n.a.';
  value:=default;
  description :='this parameter has no description';

  readScript := TScript.Create;
  writeScript := TScript.Create;
end;

destructor TParameter.Destroy;
begin
  readScript.Free;
  writeScript.Free;
end;

(*
  TParameterList
*)
constructor TParameterList.Create();
begin
    name := 'unknown';
    load;
end;


procedure TParameterList.Clear;
var i:integer;
    parameter:TParameter;
begin
  for i := self.Count - 1  downto 1 do begin
    parameter := TParameter( self.Get(i) );
    parameter.Free;
    self.Delete(i);
  end;
end;

procedure TParameterList.load;
var
  I: Integer;
  parameter:TParameter;
begin
  self.Clear;

  for I := 1 to 5 do begin
    parameter:=TParameter.Create;
    parameter.name:= 'test_'+inttostr(i);
    parameter.id := inttostr(i);
    self.Add( parameter );
  end;

end;

function TParameterList.getParameter(index: Integer):TParameter;
begin
  result := TParameter( self.Get(index));
end;

(*
  TParameterGroup
*)
constructor TParameterGroup.Create;
begin
  inherited Create();
  load;
end;

procedure TParameterGroup.Clear;
var   parameterList:TParameterList;
begin
  while self.Count > 0 do begin
    parameterList := TParameterList(self.first());
    self.Remove( parameterList );
    parameterList.Free;
  end;
end;

procedure TParameterGroup.load;
var   parameterList:TParameterList;
    i:integer;
begin
  self.Clear;

  for I := 1 to 3 do begin
    parameterList := TParameterList.Create;
    parameterList.name := 'list'+inttostr(i);
    parameterList.load;
    self.Add( parameterList );
  end;
end;

function TParameterGroup.getList(index: Integer):TParameterList;
begin
  result := TParameterList( self.Get(index ));
end;
(*
  TProfileSettings
*)
constructor TProfileSettings.Create;
begin
  name := 'unknown';
  defaultConnector := 'none';
  defaultTarget := 'none';
  parameterGroup := TParameterGroup.Create;
  parameterGroup.load;
end;

destructor TProfileSettings.Destroy;
begin
  parameterGroup.Destroy;
  inherited Destroy();
end;

end.
