unit ScriptEngine;

interface

uses Classes, Windows, uPSComponent, SysUtils, SyncObjs;

type TScriptLog = procedure ( data : string ) of Object;
type TScriptSend = procedure ( data : string ) of Object;
type TScriptStarted = procedure () of Object;
type TScriptPaused = procedure () of Object;
type TScriptResumed = procedure () of Object;
type TScriptStopped = procedure () of Object;


type TScriptEngine = class( TThread )

  constructor Create();
  destructor Destroy();  override;

  function runScript( source : TStrings ):string; overload;
  function runScript( scriptFileName : string ):string; overload;

  procedure pauseScript();
  procedure resumeScript();
  procedure stopScript();

  procedure recived( msg : string );

  function getNewDefaultScript(): string;

  function isPaused(): boolean;
  function isActive(): boolean;

  protected
    procedure Execute(); override;

  private
    procedure doLog( msg : string );
    procedure doSend( data : string );
    procedure doSleep( ms : integer );
    procedure doWait( msg: string; timeout : integer );

    procedure compile( source : TPSScript );

    function checkReciveString( msg : string ): boolean;
  private
    lastError : integer;
    active: boolean;
    waitForString : string;

    FOnScriptLog : TScriptLog;
    FOnScriptSend : TScriptSend;
    FOnScriptStarted : TScriptStarted;
    FOnScriptPaused : TScriptPaused;
    FOnScriptResumed : TScriptResumed;
    FOnScriptStopped : TScriptStopped;

    pascalScript : TPSScript;

  published
    property OnScriptLog : TScriptLog read FOnScriptLog write FOnScriptLog;
    property OnScriptSend : TScriptSend read FOnScriptSend write FOnScriptSend;

    property OnScriptStarted : TScriptStarted read FOnScriptStarted write FOnScriptStarted;
    property OnScriptPaused : TScriptPaused read FOnScriptPaused write FOnScriptPaused;
    property OnScriptResumed : TScriptResumed read FOnScriptResumed write FOnScriptResumed;
    property OnScriptStopped : TScriptStopped read FOnScriptStopped write FOnScriptStopped;

end;

var
  Event : TEvent;

implementation

uses Dialogs, StrUtils;

constructor TScriptEngine.Create;
begin
  inherited Create( true );

  Event := TEvent.Create( nil, true, false, 'myTestEvent'  );
  pascalScript := TPSScript.Create( nil );
  pascalScript.OnCompile := compile;

  active := false;
end;

destructor TScriptEngine.Destroy;
begin
  self.Terminate;
  self.resume;

  pascalScript.Free;
  inherited Destroy();
end;

procedure TScriptEngine.Execute;
var i:integer;

begin
  while (terminated=false) do begin

  active := true;
  // script started :-)
  doLog( 'Script Started' );

  if Assigned( FOnScriptStarted)  then FOnScriptStarted;

  // compile
  if pascalScript.Compile = false then begin
    // show errors
    doLog( 'Script Error ('+ IntToStr(pascalScript.CompilerMessageCount)+')' );
    for i := 0 to pascalScript.CompilerMessageCount - 1 do begin
      doLog( pascalScript.CompilerMessages[i].MessageToString);
    end;
  end else begin
    // execute
    pascalScript.Execute;
  end;

  // finished
  doLog( 'Script Stopped' );

  if Assigned( FOnScriptStopped) then FOnScriptStopped;

  active := false;

  self.suspend;
  end;
end;

function TScriptEngine.checkReciveString(msg: string):boolean;
begin

  if (AnsiContainsStr( msg, waitForString) = true) then begin
    result := true;
  end else begin
    result := false;
  end;
end;

procedure TScriptEngine.compile(source: TPSScript);
begin
  pascalScript.AddMethod( self, @TScriptEngine.doLog, 'procedure write( data : string);' );
  pascalScript.AddMethod( self, @TScriptEngine.doSend, 'procedure send( data : string);' );
  pascalScript.AddMethod( self, @TScriptEngine.doSleep, 'procedure sleep( ms : integer );' );
  pascalScript.AddMethod( self, @TScriptEngine.doWait, 'procedure wait( data : string; timeout : integer );' );
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
  // set string
  waitForString := msg;

  WaitForSingleObject( event.Handle, INFINITE );
  event.ResetEvent;

end;

function TScriptEngine.isPaused:boolean;
begin
  if (active and suspended) then 
    result:= true
    else
    result:= false;
end;

function TScriptEngine.isActive:boolean;
begin
  result:= active;
end;

function TScriptEngine.runScript(source: TStrings):string;
begin
  if isActive then begin
    result:='still running a script';
    exit;
  end;

  pascalScript.Script := source;
  self.Resume();

  result:= 'done';
end;

function TScriptEngine.runScript(scriptFileName: string):string;
var F:textfile;
    lines : TStringList;
    line: string;
begin
  if fileexists( scriptFileName ) = false then begin
    result:='file does not exit';
    exit;
  end;

  if isActive then begin
    result:='still running a script';
    exit;
  end;

  lines := TStringList.Create;

  assignFile( F, scriptFileName );
  reset( F );

  while eof(F) = false do begin
    readln(F, line);
    lines.Add( line );
  end;

  closeFile( F );

  // no run the script
  runScript( lines );

  lines.Free;

  result:='done';
end;

procedure TScriptEngine.pauseScript;
begin
  if (suspended) then begin
    exit;
  end;

  self.Suspend;
  if Assigned( FOnScriptPaused ) then FOnScriptPaused();

end;

procedure TScriptEngine.resumeScript;
begin
  if suspended=false then begin
    exit;
  end;

  self.resume;
  if Assigned( FOnScriptResumed) then FOnScriptResumed();

end;

procedure TScriptEngine.stopScript;
begin
  if pascalScript.Running = false then begin
    exit;
  end;

  pascalScript.Stop;

  if self.Suspended then resume;
  
end;

procedure TScriptEngine.recived(msg: string);
begin
  if (self.checkReciveString(msg) = true ) then begin
    event.SetEvent;
  end;
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
