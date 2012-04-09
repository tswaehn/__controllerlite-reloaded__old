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

  JSON_BUTTONS = 'buttons';
  JSON_TERMINAL_BUTTONS = 'terminal.buttons';
    JSON_TERMINAL_BUTTON_CAPTION = 'caption';
    JSON_TERMINAL_BUTTON_ENABLED = 'enabled';
    JSON_TERMINAL_BUTTON_FILENAME = 'filename';

  JSON_PARAMETER = 'parameter';
    JSON_PARAMETER_NAME = 'name';


  JSON_TOOLBOX = 'toolbox';


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
type TParameter = class (TJsonObject)

  constructor Create( json_ :TJsonWrapper; namePath_ : string );
  procedure load(); override;

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
type TParameterList = class ( TJsonObject )

  constructor Create( json_ :TJsonWrapper; namePath_ : string );
  procedure load(); override;

  procedure Clear();


  private
    function getItem( index : integer ):TParameter;
    function getCount():integer;

  private
    list : TList;

  public
    name : string;

  property count:integer read getCount;
  property items[i:integer]: TParameter read getItem;
end;



// ------------------ TScriptButtonSettings -----------------------
type TScriptButton = class (TJsonObject)

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

    private
      function getCount():integer;
      function getItem( index : integer):TScriptButton;

    private
      list : TList;
      maxCount : integer;

    public
      property count : integer read getCount;
      property items[i:integer]:TScriptButton read getItem;
end;


// ------------------ TToolboxGroup -----------------------
type TToolboxGroup = class(TJsonObject)

    constructor Create( json_ :TJsonWrapper; namePath_ : string );
    procedure load(); override;

    public
      parameterList : TParameterList;
      buttonList : TScriptButtonList;
      name : string;
end;

// ------------------ TToolboxGroupList -----------------------
type TToolboxGroupList = class(TJsonObject)

    constructor Create( json_ :TJsonWrapper; namePath_ : string );
    procedure load(); override;

    private
      function getItem( index:integer ):TToolboxGroup;

    private
      list : TList;
      fCount : integer;

    public
        property count:integer read fCount write fCount;
        property items[i:integer]:TToolboxGroup read getItem ;
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

    terminalButtons : TScriptButtonList;

    toolboxGroups : TToolboxGroupList;

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


  basepath := '';
  filename := 'settings.json.txt';

  json := TJsonWrapper.Create();

end;

destructor TSettings.Destroy;
begin

  properties.Free;
  terminalButtons.Free;
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
var temp:string;
begin
  temp:= getFileName();

  if json.loadFile(temp)=false then begin
//    createSettingsFile();
  end;

  // start interpreting
  if (properties <> nil) then properties.free;
  self.properties := TProfileProperties.Create( json, JSON_PROFILE_PROPERTIES );

  //
  self.defaultConnector := json.getStr(JSON_DEFAULT_CONNECTOR, 'TSerialConnector');

  if terminalButtons <> nil then terminalButtons.Free;
  self.terminalButtons := TScriptButtonList.Create( json, JSON_TERMINAL_BUTTONS, 12 );

  //
  if toolboxGroups <> nil then toolboxGroups.Free;
  toolboxGroups := TToolboxGroupList.Create( json, JSON_TOOLBOX );

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
  scriptPath := json.getStr( jsonKey(JSON_SCRIPT_PATH), '.\\scripts\\');
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
constructor TParameter.Create( json_ :TJsonWrapper; namePath_ : string );
begin
  name := 'unknown';
  id :='0815';
  default:= 'n.a.';
  value:=default;
  description :='this parameter has no description';

  readScript := TScript.Create;
  writeScript := TScript.Create;

  inherited Create( json_, namePath_ );
end;

destructor TParameter.Destroy;
begin
  readScript.Free;
  writeScript.Free;
end;

procedure TParameter.load;
begin
  name := json.getStr( jsonKey( JSON_PARAMETER_NAME ), JSON_NONE );

end;

(*
  --------------------------------------------------------------
  TParameterList

*)
constructor TParameterList.Create( json_ :TJsonWrapper; namePath_ : string );
begin
  list := TList.Create;
  inherited Create( json_, namePath_ );
end;


procedure TParameterList.Clear;
var i:integer;
    parameter:TParameter;
begin
  for i := list.Count - 1  downto 0 do begin
    parameter := getItem(i);
    parameter.Free;
    list.Delete(i);
  end;
end;

procedure TParameterList.load;
var
  I: Integer;
  parameter:TParameter;
begin
  list.Clear;

  for I := 0 to 3 do begin
    parameter:=TParameter.Create( json, jsonArray(i) );
    list.Add( parameter );
  end;

end;

function TParameterList.getItem(index: Integer):TParameter;
begin
  result := TParameter( list[index] );
end;

function TParameterList.getCount():integer;
begin
  result := list.Count;
end;

(*
  --------------------------------------------------------------
  TScriptButtonSettings

*)
constructor TScriptButton.Create( json_ :TJsonWrapper; namePath_ : string );
begin
  inherited Create( json_, namePath_ );
end;

procedure TScriptButton.load();
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
  list := TList.Create;
  maxCount := count_;
  
  inherited Create( json_, namePath_ );

end;

procedure TScriptButtonList.load();
var
  i: Integer;
begin
  for i := 0 to maxCount - 1 do begin
    list.Add( TScriptButton.Create( json, jsonArray( i ) ));
  end;

end;

function TScriptButtonList.getCount():integer;
begin
  result := list.Count;
end;

function TScriptButtonList.getItem( index : integer):TScriptButton;
begin
  if (index < 0) or (index >= list.Count) then begin
    result := nil;
    exit;
  end;

  result := TScriptButton( list.Items[index] );
end;


(*
  --------------------------------------------------------------
  TToolboxGroup

*)
constructor TToolboxGroup.Create( json_ :TJsonWrapper; namePath_ : string);
begin

  inherited Create( json_, namePath_ );

end;

procedure TToolboxGroup.load();
var
  i: Integer;
begin

  buttonList := TScriptButtonList.Create( json, jsonKey( JSON_BUTTONS ), 24 );
  parameterList := TParameterList.Create( json, jsonKey( JSON_PARAMETER) );

  name := json.getStr( jsonKey('name'), JSON_NONE );
end;

(*
  --------------------------------------------------------------
  TToolboxGroupList

*)
constructor TToolboxGroupList.Create( json_ :TJsonWrapper; namePath_ : string );
begin
  list := TList.Create;

  inherited Create( json_, namePath_ );

end;

procedure TToolboxGroupList.load();
var
  i: Integer;
  toolboxGroup : TToolboxGroup;
begin
  count := 3;

  for i := 0 to count - 1 do begin
    toolboxGroup := TToolboxGroup.Create( json, jsonArray( i ) );
    list.Add( toolboxGroup );
  end;

end;

function TToolboxGroupList.getItem( index:integer ):TToolboxGroup;
begin
  if (index <= 0) or (index > list.Count) then begin
    result:=nil;
  end;

  result := TToolboxGroup( list.Items[index] );
end;


end.
