unit ScriptEngine;

interface

uses Classes, uPSComponent, SysUtils;

type TScriptLog = procedure ( data : string ) of Object;

type TScriptEngine = class( TObject)

  constructor Create();
  destructor Destroy();

  procedure execute( source : TStrings );
  function getNewDefaultScript(): string;

  private
    procedure doLog( msg : string );

  private
    FOnScriptLog : TScriptLog;
    script : TPSScript;

  published
    property OnScriptLog : TScriptLog read FOnScriptLog write FOnScriptLog;

end;


implementation

uses Dialogs;

constructor TScriptEngine.Create;
begin
  script := TPSScript.Create( nil );
end;

destructor TScriptEngine.Destroy;
begin
  script.Free;
end;

procedure TScriptEngine.doLog(msg: string);
begin
  if Assigned( FOnScriptLog ) then begin
    FOnScriptLog( msg );
  end;
end;

procedure TScriptEngine.execute(source: TStrings);
var i:integer;
begin

  script.Script := source;

  // script started :-)
  doLog( 'Script Started' );

  // compile
  if script.Compile = false then begin
    // show errors
    doLog( 'Script Error ('+ IntToStr(script.CompilerMessageCount)+')' );
    for i := 0 to script.CompilerMessageCount - 1 do begin
      doLog( script.CompilerMessages[i].MessageToString);
    end;
  end else begin
    // execute
    script.Execute;
  end;

  // finished
  doLog( 'Script Stopped' );
end;

function TScriptEngine.getNewDefaultScript: string;
var default:string;
begin
  default := 'begin' + #13 + #10;
  default := default + #13 + #10;
  default := default + 'end.' + #13 + #10;

  result := default;
end;

end.
