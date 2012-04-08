unit JsonWrapper;

interface

uses  SysUtils, Classes, SuperObject;

type
  TJsonWrapper = class (TObject)

    constructor Create();
    function loadFile( filename : string ):boolean;
    procedure storeFile( filename:string);
    
    function getStr( namePath : string; alternativeDefaultStr : string ):string;
    function getStrList( namePath : string; alternativeDefaultStr : string ):TStringList;

    function getBool( namePath : string; alternativeDefaultBool : boolean) : boolean;

    private
      procedure process();
      procedure CreateDefault();

    private
      text : string;
      json : ISuperObject;
  end;

type
  TJsonObject = class (TObject)

    // need overwrite
    constructor Create( json_ :TJsonWrapper; namePath_ : string );
    procedure load(); virtual; abstract;


    protected
      function jsonKey( key : string ): string;
      function jsonArray( index: integer) : string;

    protected
      json : TJsonWrapper;
      namePath : string;

  end;

implementation

constructor TJsonObject.Create(json_: TJsonWrapper; namePath_: string);
begin
  json := json_;
  namePath := namePath_;

  load();
end;

function TJsonObject.jsonKey(key: string): string;
begin

  result := namePath +'.'+ key;
end;

function TJsonObject.jsonArray(index: Integer): string;
begin

  result := namePath + '['+ inttostr(index) +']';
end;

constructor TJsonWrapper.Create;
begin
  inherited Create();

  text := '';
end;


function TJsonWrapper.loadFile(filename: string):boolean;
var F: Textfile;
    temp, line: string;
    ch : char;
  i: Integer;
begin




  temp := '';

  if (fileexists(filename) = true) then begin

    assignFile( F, filename );
    reset( F );

    while (eof(F) = false) do begin
      readln(F, line);
      temp := temp + line;
    end;

    closeFile( F);

    text :='';
    for i := 1 to length(temp) do begin
      ch := temp[i];
      if (ch <> #0) then begin
        text := text + ch;
      end;
    end;

  end;



  process();

  result:=true;
end;

procedure TJsonWrapper.storeFile(filename: string );
var path:string;
    doIndent : boolean;
    doEscape : boolean;
begin

  // lege pfad an, falls nicht existent
  path:= extractFileDir( filename );
  if (directoryexists(path) = false) then begin
    forceDirectories(path);
  end;

  doIndent := true;
  doEscape := false;
  json.SaveTo( filename, doIndent, doEscape );

end;

function TJsonWrapper.getStr(namePath: string; alternativeDefaultStr: string):string;
var value:string;
    obj : ISuperObject;
begin
  try
    value := json[namePath].AsString;
  except
    value := alternativeDefaultStr;
    obj := SO(value);
    json[namePath] := obj;
  end;

  result := value;
end;


function TJsonWrapper.getStrList(namePath: string; alternativeDefaultStr: string):TStringList;
var list:TStringList;
    arr : TSuperArray;
    obj : ISuperObject;
    i: Integer;
begin
  list := TStringList.Create;

  try
    arr := json[namePath].AsArray;
    for i := 0 to arr.Length - 1 do begin
      list.Add( arr.S[i] );
    end;

  except
    list.Add( alternativeDefaultStr );
    obj := SA( [alternativeDefaultStr] );
    json[namePath] := obj;
  end;

  result := list;
end;

function TJsonWrapper.getBool( namePath : string; alternativeDefaultBool : boolean) : boolean;
var value:boolean;
    obj : ISuperObject;
begin
  try
    value := json[namePath].AsBoolean;
  except
    value := alternativeDefaultBool;
    obj := SO(value);
    json[namePath] := obj;
  end;

  result := value;

end;


procedure TJsonWrapper.process;
var temp : WideString;
    t : PSOChar;
begin

  // the following type casting is neccessary
  // not sure why
  temp := WideString(text);
  t := PSOChar(temp);

  json := TSuperObject.ParseString( t, true );

  if (json = nil) then begin
    createDefault();
  end;

end;

procedure TJsonWrapper.CreateDefault;
begin
  json := TSuperObject.ParseString('{}', true);
end;

procedure dummy();
begin
(*
    json := TSuperObject.Create();
  json.S[JSON_NAME] := 'unknown';
  json.S[JSON_DEFAULT_CONNECTOR] := 'TSerialConnector';
*)
end;

end.
