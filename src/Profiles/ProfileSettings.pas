unit ProfileSettings;

interface

uses Classes, SysUtils, StdCtrls, JsonWrapper;


const
  JSON_NONE = 'none';

  JSON_PROFILE_PROPERTIES = 'profile';
    JSON_VERSION = 'version';
    JSON_NAME = 'name';
    JSON_SCRIPT_PATH = 'scriptPath';

  JSON_DEFAULT_CONNECTOR = 'connector.defaultConnector';

  JSON_TERMINAL_BUTTONS = 'terminal.buttons';
    JSON_TERMINAL_BUTTON_CAPTION = 'caption';
    JSON_TERMINAL_BUTTON_ENABLED = 'enabled';
    JSON_TERMINAL_BUTTON_FILENAME = 'filename';


// ------------------ TProfileProperties -----------------------
type TProfileProperties = class (TJsonObject)

  constructor Create( json_ :TJsonWrapper; namePath_ : string );

  procedure load(); override;

  public
    name:string;
    version : string;
    scriptPath : string;
end;

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


// ------------------ TScriptButtonSettings -----------------------
type TScriptButtonSettings = class (TJsonObject)

    constructor Create( json_ :TJsonWrapper; namePath_ : string );
    procedure load(); override;

  public
    enabled:boolean;
    caption : string;
    filename : string;

    script : TScript;

    button : TButton;

end;

// ------------------ TScriptButtonList -----------------------
type TScriptButtonList = class(TJsonObject)

    constructor Create( json_ :TJsonWrapper; namePath_ : string; count_ : integer );
    procedure load(); override;

    public
      list : array of TScriptButtonSettings;
      count : integer;
end;

// ------------------ TProfileSettings -----------------------
type TSettings = class (TObject)

  constructor Create();
  destructor Destroy(); override;

  procedure loadFromFile();
  procedure storeToFile();
  procedure createSettingsFile();
  procedure processJSONSettings();

  public
    basepath : string;

    defaultConnector : string;
    defaultTarget : string;
    parameterGroup : TParameterGroup;
    terminalButtons : TScriptButtonList;

    properties: TProfileProperties;

  private
    json : TJsonWrapper;

    filename : string;

  private
    function getFileName():string;

  published

end;


implementation


(*
  --------------------------------------------------------------
  TProfileSettings

*)
constructor TSettings.Create;
begin
  defaultConnector := JSON_NONE;
  defaultTarget := JSON_NONE;
  parameterGroup := TParameterGroup.Create;
  parameterGroup.load;

  basepath := '';
  filename := 'settings.json.txt';

  json := TJsonWrapper.Create();

end;

destructor TSettings.Destroy;
begin
  parameterGroup.Free;
  json.Free;

  inherited Destroy();
end;

function TSettings.getFileName: string;
var temp : string;
begin
  temp := basepath + filename;
  result := temp;
end;

procedure TSettings.createSettingsFile();
begin


  storeToFile();

end;

procedure TSettings.processJSONSettings;
begin

end;

procedure TSettings.loadFromFile;
var filename:string;
begin
  filename:= getFileName();

  if json.loadFile(filename)=false then begin
//    createSettingsFile();
  end;

  // start interpreting
  self.properties := TProfileProperties.Create( json, JSON_PROFILE_PROPERTIES );

  self.defaultConnector := json.getStr(JSON_DEFAULT_CONNECTOR, 'TSerialConnector');

  self.terminalButtons := TScriptButtonList.Create( json, JSON_TERMINAL_BUTTONS, 12 );
  storeTofile();
end;

procedure TSettings.storeToFile;
var filename:string;
begin
  filename:= getFileName();

  json.storeFile( filename );


end;


constructor TProfileProperties.Create(json_: TJsonWrapper; namePath_: string);
begin
  inherited Create( json_, namePath_ );

end;

procedure TProfileProperties.load;
begin
  version := json.getStr( jsonKey(JSON_VERSION), 'v1.0');
  name := json.getStr( jsonKey(JSON_NAME), JSON_NONE);
  scriptPath := json.getStr( jsonKey(JSON_SCRIPT_PATH), './scripts');
end;

(*
  --------------------------------------------------------------
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
  --------------------------------------------------------------
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
  --------------------------------------------------------------
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
  --------------------------------------------------------------
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
  --------------------------------------------------------------
  TScriptButtonSettings

*)
constructor TScriptButtonSettings.Create( json_ :TJsonWrapper; namePath_ : string );
begin
  inherited Create( json_, namePath_ );
end;

procedure TScriptButtonSettings.load();
begin
  caption := json.getStr( jsonKey(JSON_TERMINAL_BUTTON_CAPTION), JSON_NONE );
  enabled := json.getBool( jsonKey(JSON_TERMINAL_BUTTON_ENABLED), false );
  filename := json.getStr( jsonKey(JSON_TERMINAL_BUTTON_FILENAME), JSON_NONE);
end;

(*
  --------------------------------------------------------------
  TScriptButtonList

*)
constructor TScriptButtonList.Create( json_ :TJsonWrapper; namePath_ : string; count_ : integer );
begin
  count := count_;
  setlength( list, count );

  inherited Create( json_, namePath_ );

end;

procedure TScriptButtonList.load();
var
  i: Integer;
begin
  for i := 0 to count - 1 do begin
    if (list[i] <> nil) then begin
      list[i].Free;
    end;
    list[i] := TScriptButtonSettings.Create( json, jsonArray( i ) );
  end;

end;


end.
