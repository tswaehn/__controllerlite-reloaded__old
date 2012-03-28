unit ProfileSettings;

interface

uses Classes, SysUtils, JsonWrapper;


const

  JSON_VERSION = 'version';
  JSON_NAME = 'name';
  JSON_DEFAULT_CONNECTOR = 'defaultConnector';

// ------------------ TScript -----------------------

type TScript = class (TStringList)

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

  procedure loadFromFile();
  procedure storeToFile();
  procedure createSettingsFile();
  procedure processJSONSettings();

  public
    basepath : string;

    name:string;
   defaultConnector : string;
   defaultTarget : string;
   parameterGroup : TParameterGroup;

  private
    json : TJsonWrapper;

    filename : string;

  private
    function getFileName():string;

  published

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

  basepath := '';
  filename := 'settings.json.txt';

  json := TJsonWrapper.Create();
  
end;

destructor TProfileSettings.Destroy;
begin
  parameterGroup.Free;
  json.Free;
  
  inherited Destroy();
end;

function TProfileSettings.getFileName: string;
var temp : string;
begin
  temp := basepath + filename;
  result := temp;
end;

procedure TProfileSettings.createSettingsFile();
begin


  storeToFile();

end;

procedure TProfileSettings.processJSONSettings;
begin

end;

procedure TProfileSettings.loadFromFile;
var filename:string;
begin
  filename:= getFileName();

  if json.loadFile(filename)=false then begin
//    createSettingsFile();
  end;

  // start interpreting
  json.getStrValue(JSON_VERSION, '1.0');
  self.name := json.getStrValue(JSON_NAME,'none');
  self.defaultConnector := json.getStrValue(JSON_DEFAULT_CONNECTOR, 'TSerialConnector');

  storeTofile();
end;

procedure TProfileSettings.storeToFile;
var filename:string;
begin
  filename:= getFileName();

  json.storeFile( filename );


end;


end.
