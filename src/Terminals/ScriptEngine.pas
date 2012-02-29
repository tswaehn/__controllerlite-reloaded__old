unit ScriptEngine;

interface

uses Classes, Windows, uPSComponent, SysUtils, SyncObjs;

type TScriptLog = procedure ( data : string ) of Object;
type TScriptSend = procedure ( data : string ) of Object;


type TScriptEngine = class( TThread )

  constructor Create();
  destructor Destroy();  override;


  procedure runScript( source : TStrings );
  procedure pauseScript();
  procedure resumeScript();
  procedure stopScript();

  procedure recived( msg : string );

  function getNewDefaultScript(): string;

  protected
    procedure Execute(); override;

  private
    procedure doLog( msg : string );
    procedure doSend( data : string );
    procedure doSleep( ms : integer );
    procedure doWait( msg: string; timeout : integer );

    procedure compile( source : TPSScript );

  private
    FOnScriptLog : TScriptLog;
    FOnScriptSend : TScriptSend;

    script : TPSScript;

  published
    property OnScriptLog : TScriptLog read FOnScriptLog write FOnScriptLog;
    property OnScriptSend : TScriptSend read FOnScriptSend write FOnScriptSend;

end;

var
  Event : TEvent;

implementation

uses Dialogs;

constructor TScriptEngine.Create;
begin
  inherited Create( true );

  Event := TEvent.Create( nil, true, false, 'myTestEvent'  );
  script := TPSScript.Create( nil );
  script.OnCompile := compile;
end;

destructor TScriptEngine.Destroy;
begin
  self.Terminate;
  self.resume;

  script.Free;
  inherited Destroy();
end;

procedure TScriptEngine.Execute;
var i:integer;

begin
  while (terminated=false) do begin

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
  self.suspend;
  end;
end;

procedure TScriptEngine.compile(source: TPSScript);
begin
  script.AddMethod( self, @TScriptEngine.doLog, 'procedure write( data : string);' );
  script.AddMethod( self, @TScriptEngine.doSend, 'procedure send( data : string);' );
  script.AddMethod( self, @TScriptEngine.doSleep, 'procedure sleep( ms : integer );' );
  script.AddMethod( self, @TScriptEngine.doWait, 'procedure wait( data : string; timeout : integer );' );
end;

procedure TScriptEngine.doLog(msg: string);
begin
  if Assigned( FOnScriptLog ) then begin
    FOnScriptLog( msg );
  end;
end;

procedure TScriptEngine.doSend(data: string);
begin
  if Assigned( FOnScriptSend ) then begin
    FOnScriptSend( data );
  end;
end;

procedure TScriptEngine.doSleep(ms: Integer);
begin
  sleep( ms );
end;

procedure TScriptEngine.doWait( msg: string; timeout: Integer);
begin
  WaitForSingleObject( event.Handle, INFINITE );
  event.ResetEvent;

end;

procedure TScriptEngine.runScript(source: TStrings);
begin

  script.Script := source;
  self.Resume();

end;

procedure TScriptEngine.pauseScript;
begin
  self.Suspend;
end;

procedure TScriptEngine.resumeScript;
begin
  self.resume;
end;

procedure TScriptEngine.stopScript;
begin
  script.Stop;
end;

procedure TScriptEngine.recived(msg: string);
begin
  event.SetEvent;
end;

function TScriptEngine.getNewDefaultScript: string;
var default:string;
begin
  default := '';
  default := default + 'var i:integer;' + #13+#10;
  default := default + 'begin' + #13+#10;
  default := default + ' write( ''hello world'' );' + #13+#10;
  default := default + ' for i:=1 to 5 do' + #13+#10;
  default := default + '  begin'+ #13+#10;
  default := default + '   write(''count ''+inttostr(i));' +#13+#10;
  default := default + '   sleep(1000);'+ #13+#10;
  default := default + '  end;' +#13+#10;
  default := default + ' send(''ap getfirmware'')' + #13+#10;
  default := default + 'end.' + #13 + #10;

  result := default;
end;

end.
