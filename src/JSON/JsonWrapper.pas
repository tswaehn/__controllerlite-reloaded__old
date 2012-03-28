unit JsonWrapper;

interface

uses  SysUtils, SuperObject;

type
  TJsonWrapper = class (TObject)

    constructor Create();
    function loadFile( filename : string ):boolean;
    procedure storeFile( filename:string);
    
    function getStrValue( namePath : string; alternativeDefaultStr : string ):string;

    private
      procedure process();

    private
      text : string;
      json : ISuperObject;
  end;


implementation

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

function TJsonWrapper.getStrValue(namePath: string; alternativeDefaultStr: string):string;
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
    create
  end;

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
