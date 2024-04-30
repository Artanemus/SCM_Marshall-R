unit dlgSCMStopWatch;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  // FOR TSTOPWATCH
  System.Diagnostics, System.TimeSpan, FMX.Objects;

type
  TscmStopWatch = class(TForm)
    StyleBook2: TStyleBook;
    Layout1: TLayout;
    edtTime: TEdit;
    Layout2: TLayout;
    btnStart: TButton;
    Layout3: TLayout;
    btnStop: TButton;
    Layout4: TLayout;
    btnSplit: TButton;
    Layout5: TLayout;
    btnReset: TButton;
    Layout6: TLayout;
    Layout7: TLayout;
    btnExit: TButton;
    Layout8: TLayout;
    TrackBar1: TTrackBar;
    MediaPlayer1: TMediaPlayer;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnSplitClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
    StopWatch: TStopWatch;
    FInSplit: Boolean;
    FUseSystemBeep: Boolean;
    FTime: TTime;
    function ConvertMSecToTime(MSec: Int64): TTime;
    procedure scmOptionsRead();
    procedure scmOptionsWrite();
    procedure scmBeep();
    procedure scmThreadTerminate(Sender: TObject);

  public
    { Public declarations }
    property RaceTime: TTime read FTime;

  end;

var
  scmStopWatch: TscmStopWatch;

implementation

{$R *.fmx}

uses
{$IFDEF MSWINDOWS}
  // needed for call to winapi  Beep()
  Winapi.Windows,
{$ENDIF}
  // FOR TINIFILES
  System.IniFiles,
  // FOR TPATH
  System.IOUtils,
  // FOR SINGLE TO CARDINAL CONVERSION
  System.Math;

(*
  Note: In order to play an audio file using TMediaPlayer, use the appropriate format:
  .wav on Windows
  .caf on iOS and OS X
  .3GP on Android
*)

procedure TscmStopWatch.btnExitClick(Sender: TObject);
begin
  // Note: this button has been assigned a ModalResult value.
  // ModalResult = mrCancel;
end;

procedure TscmStopWatch.btnResetClick(Sender: TObject);
begin
  StopWatch.Reset();
  if Timer1.Enabled then Timer1.Enabled := false;
  FTime := 0;

{$IFDEF MSWINDOWS}
  if (FUseSystemBeep) then
    Beep(100, 100)
  else
    scmBeep;
{$ELSE}
  if not FUseSystemBeep then
    scmBeep;
{$ENDIF}
  edtTime.Text := '00:00.000';
  btnStart.Visible := true;
  btnStop.Visible := false;
  btnSplit.Visible := false;
  btnReset.Visible := false;
  btnExit.Visible := true;
  FInSplit := false;
  btnSplit.Text := 'SPLIT';
end;

procedure TscmStopWatch.btnSplitClick(Sender: TObject);
begin
  // order is time critical
  // note:  __int64 ElapsedMilliseconds;
  FTime := ConvertMSecToTime(StopWatch.ElapsedMilliseconds);

{$IFDEF MSWINDOWS}
  if (FUseSystemBeep) then
    Beep(100, 100)
  else
    scmBeep;
{$ELSE}
  if not FUseSystemBeep then
    scmBeep;
{$ENDIF}
  // toggle SPLIT FUNCTION state
  FInSplit := not FInSplit;
  if (FInSplit) then
  begin
    // disable the timer - freeze the display
    if Timer1.Enabled then Timer1.Enabled := false;
    // most current time
    edtTime.Text := FormatDateTime('nn:ss.zzz', FTime);
    btnSplit.Text := 'SPLIT-RESUME';
  end
  else
  begin
    // enable the timer
    if not Timer1.Enabled then Timer1.Enabled := true;
    btnSplit.Text := 'SPLIT';
  end;

  btnStart.Visible := false;
  btnStop.Visible := true;
  btnSplit.Visible := true;
  btnReset.Visible := false;
  btnExit.Visible := true;
end;

procedure TscmStopWatch.btnStartClick(Sender: TObject);
begin
  StopWatch.Start();
  FTime := 0;

{$IFDEF MSWINDOWS}
  if (FUseSystemBeep) then
    Beep(100, 100)
  else
    scmBeep;
{$ELSE}
  if not FUseSystemBeep then
    scmBeep;
{$ENDIF}
  if not Timer1.Enabled then Timer1.Enabled := true;
  btnStart.Visible := false;
  btnStop.Visible := true;
  FInSplit := false;
  TrackBar1.Enabled := false;
  btnSplit.Text := 'SPLIT';
  btnSplit.Visible := true;
  btnReset.Visible := false;
  btnExit.Visible := true;
end;

procedure TscmStopWatch.btnStopClick(Sender: TObject);
begin
  StopWatch.Stop;

{$IFDEF MSWINDOWS}
  if (FUseSystemBeep) then
    MessageBeep(MB_ICONMASK)
  else
    scmBeep;
{$ELSE}
  if not FUseSystemBeep then
    scmBeep;
{$ENDIF}
  if Timer1.Enabled then Timer1.Enabled := false;
  // most current time
  FTime := ConvertMSecToTime(StopWatch.ElapsedMilliseconds);
  // REFRESH DISPLAY -most current time
  edtTime.Text := FormatDateTime('nn:ss.zzz', FTime);

  btnStart.Visible := true;
  btnStop.Visible := false;
  btnSplit.Visible := false;
  btnReset.Visible := true;
  btnExit.Visible := true;
  FInSplit := false;
  btnSplit.Text := 'SPLIT';
  TrackBar1.Enabled := true;
end;

function TscmStopWatch.ConvertMSecToTime(MSec: Int64): TTime;
begin
  // In a day there are 24*60*60 = 86400 seconds
  // (SecsPerDay constant declared in SysUtils)
  Result := MSec / (SecsPerDay * 1000.0);
end;

procedure TscmStopWatch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  scmOptionsWrite;
  // signal for the form to be destroy - required for FMX CALLBACK
  Action := TCloseAction.caFree;
end;

procedure TscmStopWatch.FormCreate(Sender: TObject);
var
  s, fileName: String;
begin
  StopWatch.Create;
  // set the visibility on buttons
  btnStart.Visible := true;
  btnStop.Visible := false;
  btnSplit.Visible := false;
  btnReset.Visible := false;
  btnExit.Visible := true;
  FInSplit := false;
  FTime := 0;
  edtTime.Text := '00:00.000';
  // init the TrackBar
  // NOTE: Calling scmOptions results in OnChange event for TrackBar
  // which then assigns interval to Timer1.
  scmOptionsRead;
  // NOTE: Timer1 on creation is DISABLED.
  if Timer1.Enabled then Timer1.Enabled := false;

  // load the sound file...
  FUseSystemBeep := false;

  // Note: In order to play an audio file using TMediaPlayer, use the appropriate format:
  // .wav on Windows
  // .caf on iOS and OS X
  // .3GP on Android
  fileName := 'StopWatchBeep.wav';

{$IFDEF IOS}
  fileName := ChangeFileExt(s, '.caf');
{$ENDIF}
{$IFDEF MACOS}
  fileName := ChangeFileExt(s, '.caf');
{$ENDIF}
{$IFDEF ANDROID}
  fileName := ChangeFileExt(s, '.3GP');
{$ENDIF}
  // Standard RTL path Functions
  // https://docwiki.embarcadero.com/RADStudio/Sydney/en/Standard_RTL_Path_Functions_across_the_Supported_Target_Platforms

  // Same path of Executable file.
  // Application PATH  -  MSWINDOWS - CSIDL_APPDATA
  s := IncludeTrailingPathDelimiter(TPath.GetLibraryPath) + fileName;
  if FileExists(s) then
    MediaPlayer1.fileName := s
  else
  begin
    // MSWINDOWS - CSIDL_PERSONAL - \Users\<username>\Documents
    // Note: OneDrive enabled: 'Personal'
    // The routine TPath.GetDocumentsPath normally returns ...
    // C:\Users\<username>\Documents (Windows Vista or later)
    // but is instead mapped to C:\Users\<username>\OneDrive\Documents.
    //
    s := IncludeTrailingPathDelimiter(TPath.GetDocumentsPath) + fileName;
    if FileExists(s) then
      MediaPlayer1.fileName := s
    else
      FUseSystemBeep := true;
  end;

end;

procedure TscmStopWatch.FormDestroy(Sender: TObject);
begin
  MediaPlayer1.Stop;
end;

procedure TscmStopWatch.scmBeep;
var
  DoLoop: Boolean;
  loopCount: integer;
begin
  // do nothing else ...
  DoLoop := true;
  loopCount := 0;
  while (DoLoop) do
  begin
    case (MediaPlayer1.State) of
      TMediaState.Unavailable:
        begin
          MediaPlayer1.Stop;
          loopCount := loopCount + 1;
          if (loopCount > 8000) then
            DoLoop := false;
        end;
      TMediaState.Playing:
        begin
          MediaPlayer1.Stop();
          MediaPlayer1.CurrentTime := 0;
          MediaPlayer1.Play();
          DoLoop := false;
        end;
      TMediaState.Stopped:
        begin
          MediaPlayer1.CurrentTime := 0;
          MediaPlayer1.Play;
          DoLoop := false;
        end
    else
      DoLoop := false;
    end;
  end;
end;

procedure TscmStopWatch.scmOptionsRead;
var
  ini: TIniFile;
  section: String;
  i: Single;
begin
  section := 'TimeKeeperOptions';
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim + 'SCMConfig.ini ');
  try
    begin
      i := ini.ReadFloat(section, 'StopwatchTimerInterval', 100);
      if (i > TrackBar1.Max) or (i < TrackBar1.Min) then
        TrackBar1.Value := TrackBar1.Max
      else
        TrackBar1.Value := i;
    end;
  finally
    ini.free;
  end;
end;

procedure TscmStopWatch.scmOptionsWrite;
var
  ini: TIniFile;
  section: String;
begin
  //
  section := 'TimeKeeperOptions';
  ini := TIniFile.Create(TPath.GetDocumentsPath() + PathDelim +
    'SCMConfig.ini');
  try
    ini.WriteFloat(section, 'StopwatchTimerInterval', TrackBar1.Value)
  finally
    ini.free;
  end;
end;

procedure TscmStopWatch.Timer1Timer(Sender: TObject);
begin
  if not FInSplit then
  begin
    // while InSplit - edtTime display handled by btnSplitClick()
    // update edtTime display (default is every second)...
    FTime := ConvertMSecToTime(StopWatch.ElapsedMilliseconds);
    edtTime.Text := FormatDateTime('nn:ss.zzz', FTime);
  end;
end;

procedure TscmStopWatch.TrackBar1Change(Sender: TObject);
var
  fThread: TThread;
  fStoreState: Boolean;
begin
  fThread := TThread.CreateAnonymousThread(
    procedure
    begin
      // conversion of single (float)  to cardinal (unsigned int)
      fStoreState := Timer1.Enabled;
      Timer1.Enabled := false;
      Timer1.Interval := Floor(TrackBar1.Value);
      Timer1.Enabled := fStoreState;

      // This works... (bit converluted for me)
      // myTimer.Interval := PCardinal(TrackBar1.Value)^;
    end
    );
  fThread.OnTerminate := scmThreadTerminate;
  fThread.Start;
end;

procedure TscmStopWatch.scmThreadTerminate(Sender: TObject);
begin
  if TThread(Sender).FatalException <> nil then
  begin
    // something went wrong
    Exit;
  end;
  // Do next jobs with query
end;

end.


