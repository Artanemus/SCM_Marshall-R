unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.Variants, System.IniFiles, System.IOUtils;

type
  TSCM = class(TDataModule)
    scmConnection: TFDConnection;
    tblSwimClub: TFDTable;
    tblSwimClubSwimClubID: TFDAutoIncField;
    tblSwimClubCaption: TWideStringField;
    tblSwimClubNickName: TWideStringField;
    tblSwimClubEmail: TWideStringField;
    tblSwimClubContactNum: TWideStringField;
    tblSwimClubWebSite: TWideStringField;
    tblSwimClubHeatAlgorithm: TIntegerField;
    tblSwimClubEnableTeamEvents: TBooleanField;
    tblSwimClubEnableSwimOThon: TBooleanField;
    tblSwimClubEnableExtHeatTypes: TBooleanField;
    tblSwimClubNumOfLanes: TIntegerField;
    tblSwimClubEnableMembershipStr: TBooleanField;
    tblSwimClubLenOfPool: TIntegerField;
    dsSwimClub: TDataSource;
    dsSession: TDataSource;
    dsEvent: TDataSource;
    dsHeat: TDataSource;
    dsMember: TDataSource;
    qryEntrant: TFDQuery;
    qryEntrantEntrantID: TFDAutoIncField;
    qryEntrantHeatID: TIntegerField;
    qryEntrantHeatNum: TIntegerField;
    qryEntrantLane: TIntegerField;
    qryEntrantRaceTime: TTimeField;
    qryEntrantTimeToBeat: TTimeField;
    qryEntrantIsDisqualified: TBooleanField;
    qryEntrantIsScratched: TBooleanField;
    qryEntrantPersonalBest: TTimeField;
    qryEntrantTimeToBetStr: TWideStringField;
    qryEntrantPersonalBestStr: TWideStringField;
    qryEntrantRaceTimeStr: TWideStringField;
    qryEntrantFNameStr: TWideStringField;
    qryEntrantHeatNumLaneFNameStr: TWideStringField;
    dsEntrant: TDataSource;
    qrySession: TFDQuery;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSwimClubID: TIntegerField;
    qrySessionSessionStatusID: TIntegerField;
    qrySessionSessionStatusStr: TStringField;
    qrySessionCaption: TWideStringField;
    qrySessionSessionStartStr: TWideStringField;
    qrySessionSessionDetailStr: TWideStringField;
    qryHeat: TFDQuery;
    qryHeatHeatID: TFDAutoIncField;
    qryHeatHeatNum: TIntegerField;
    qryHeatEventID: TIntegerField;
    qryHeatHeatTypeID: TIntegerField;
    qryHeatHeatStatusID: TIntegerField;
    qryHeatListDetailStr: TWideStringField;
    qryHeatListTextStr: TStringField;
    qryEvent: TFDQuery;
    qryEventEventID: TFDAutoIncField;
    qryEventEventNum: TIntegerField;
    qryEventNomineeCount: TIntegerField;
    qryEventEntrantCount: TIntegerField;
    qryEventSessionID: TIntegerField;
    qryEventEventTypeID: TIntegerField;
    qryEventStrokeID: TIntegerField;
    qryEventDistanceID: TIntegerField;
    qryEventEventStatusID: TIntegerField;
    qryEventListTextStr: TWideStringField;
    qryEventListDetailStr: TWideStringField;
    qryMember: TFDQuery;
    qryLane: TFDQuery;
    qryLaneLaneID: TIntegerField;
    qryLaneLaneNum: TIntegerField;
    qryLaneEntrantID: TFDAutoIncField;
    qryLaneLane: TIntegerField;
    qryLaneHeatID: TFDAutoIncField;
    qryLaneHeatNum: TIntegerField;
    qryLaneEventID: TIntegerField;
    qryLaneFName: TWideStringField;
    dsLane: TDataSource;
    qryEntrantQualifiedStatus: TStringField;
    qryQualifyState: TFDQuery;
    qrySessionSessionStart: TSQLTimeStampField;
    qryLaneMemberID: TIntegerField;
    qrySCMSystem: TFDQuery;
    dsSCMSystem: TDataSource;
    procedure qryHeatAfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);

  private const
    SCMCONFIGFILENAME = 'SCMConfig.ini';

  var
    FIsActive: Boolean;
    FFlagLane: Boolean;
    fDBModel, fDBVersion, fDBMajor, fDBMinor: integer;

  private
    { Private declarations }
    procedure SetFlagLane(Value: Boolean);

  public
    { Public declarations }
    procedure ActivateTable();
    procedure DeActivateTable();
    function LocateEntrantID(EntrantID, HeatID: Integer): Boolean;
    function LocateLaneForEntrant(EntrantID: Integer): Boolean;
    function LocateHeatID(HeatID: Integer): Boolean;
    function LocateEventID(EventID: Integer): Boolean;
    function LocateLaneNum(LaneNum: Integer): Boolean;
    function LocateLaneID(LaneID: Integer): Boolean;
    function GetQualifyState(EntrantID, HeatID: Integer): Integer;
    // 2023.3.10
    function GetDBVerInfo: string;

    procedure FilterClosedSessions(HideClosedSessions: Boolean);
//    procedure SimpleMakeTemporyFDConnection(Server, User, Password: String;
//      OsAuthent: Boolean);
//    procedure SimpleSaveSettingString(ASection, AName, AValue: String);
//    procedure SimpleLoadSettingString(ASection, AName: String; var AValue: String);

    property IsActive: Boolean read FIsActive;
    property FlagLane: Boolean read FFlagLane write SetFlagLane;
  end;

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

{$REGION 'ACTIVATE..DE-ACTIVATE TABLES AND QUERIES'}

procedure TSCM.ActivateTable;
begin
  FIsActive := false;
  FFlagLane := false;
  // enable active on all datasets
  tblSwimClub.Open;
  if tblSwimClub.Active then
  begin
    // ASSERT - first item is Boonah swim club (default)
    tblSwimClub.First;
    // SESSION
    qrySession.Open;
    if qrySession.Active then
    begin
      qryMember.Open;
      if qryMember.Active then
      begin
        qryEvent.Open; // EVENT ordered by EventNum
        if qryEvent.Active then
        begin
          // LANE - USES PARAM - ACCEPTS NULL
          // qryLane must be open before qryHeat ...
          if qryLane.Active then
            qryLane.Close;
          qryLane.ParamByName('HEATID').Clear;
          qryLane.Prepare;
          qryLane.Open;
          if qryLane.Active then
          begin
            qryHeat.Open;
            if qryHeat.Active then
            begin
              // ENTRANT
              if qryEntrant.Active then
                qryEntrant.Close;
              qryEntrant.Open;
              if qryEntrant.Active then
                FIsActive := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TSCM.DataModuleCreate(Sender: TObject);
begin
  // make sure the there isn't an active connection
  FIsActive := false;
  scmConnection.Connected := false;
end;

procedure TSCM.DeActivateTable;
begin
  FIsActive := false;
  qryEntrant.Close;
  qryLane.Close;
  qryHeat.Close;
  qryEvent.Close;
  qryMember.Close;
  qrySession.Close;
  tblSwimClub.Close;
end;

{$ENDREGION}

procedure TSCM.FilterClosedSessions(HideClosedSessions: Boolean);
begin
  if HideClosedSessions then
    qrySession.Filter := '(SessionStatusID = 1) OR (SessionStatusID = 2)'
  else
    qrySession.Filter := '(SessionStatusID = 1)';
  if not qrySession.Filtered then
    qrySession.Filtered := True;
end;

function TSCM.GetDBVerInfo: string;
begin
  result := '';
  if scmConnection.Connected then
  begin
    with qrySCMSystem do
    begin
      Connection := scmConnection;
      Open;
      if Active then
      begin
        fDBModel := FieldByName('SCMSystemID').AsInteger;
        fDBVersion := FieldByName('DBVersion').AsInteger;
        fDBMajor := FieldByName('Major').AsInteger;
        fDBMinor := FieldByName('Minor').AsInteger;
        result := IntToStr(fDBModel) + '.' + IntToStr(fDBVersion) + '.' +
          IntToStr(fDBMajor) + '.' + IntToStr(fDBMinor);
      end;
      Close;
    end;
  end;
end;

function TSCM.GetQualifyState(EntrantID, HeatID: Integer): Integer;
begin
  // DEFAULT: the entrant passes qualification.
  Result := 1;
  if qryQualifyState.Active then
    qryQualifyState.Close;
    qryQualifyState.ParamByName('ENTRANTID').AsInteger := EntrantID;
    qryQualifyState.ParamByName('HEATID').AsInteger  := HeatID;
    qryQualifyState.Prepare;
    qryQualifyState.Open;
    if qryQualifyState.Active then
    begin
      if not qryQualifyState.IsEmpty then
        Result := qryQualifyState.FieldByName('QualifyState').AsInteger;
    end;
    qryQualifyState.Close;
end;

{$REGION 'LOCATE SPECIFIC RECORD'}

function TSCM.LocateEntrantID(EntrantID, HeatID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  Result := false;
  if (EntrantID = 0) or (HeatID = 0)  then exit;

  if not qryEntrant.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryEntrant.Locate('EntrantID; HeatID', VarArrayOf([EntrantID, HeatID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  Result := LocateSuccess;

end;

function TSCM.LocateEventID(EventID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  Result := false;
  if not qryEvent.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryEvent.Locate('EventID', VarArrayOf([EventID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  Result := LocateSuccess;

end;

function TSCM.LocateHeatID(HeatID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  Result := false;
  if not qryHeat.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryHeat.Locate('HeatID', VarArrayOf([HeatID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  Result := LocateSuccess;

end;

{ TODO : Refactor LocateLaneNum }
function TSCM.LocateLaneNum(LaneNum: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  Result := false;
  if not qryLane.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryLane.Locate('LaneNum', VarArrayOf([LaneNum]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  Result := LocateSuccess;

end;

function TSCM.LocateLaneID(LaneID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  Result := false;
  if not qryLane.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryLane.Locate('LaneID', VarArrayOf([LaneID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  Result := LocateSuccess;

end;

{ TODO : Refactor LocateEntrantOnQryLane }
function TSCM.LocateLaneForEntrant(EntrantID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  Result := false;
  if not qryLane.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryLane.Locate('EntrantID', VarArrayOf([EntrantID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  Result := LocateSuccess;

end;

{$ENDREGION}

procedure TSCM.qryHeatAfterScroll(DataSet: TDataSet);
// var
// EntrantID: Integer;
begin
  // syncronize param dependant qryLane
  qryLane.DisableControls;
  if qryHeat.IsEmpty then
  begin
    qryLane.EmptyDataSet;
  end
  else
  begin
    if (qryLane.Active) then
      qryLane.Close;
    // ASSIGN PARAM - ACCEPTS NULL HeatID VALUE
    qryLane.ParamByName('HEATID').AsInteger := qryHeat.FieldByName('HeatID')
      .AsInteger;
    qryLane.Prepare;
    qryLane.Open;
    FFlagLane := true; // indicates full rebuild of table.
  end;
  qryLane.EnableControls;

end;

procedure TSCM.SetFlagLane(Value: Boolean);
begin
  FFlagLane := Value;
end;


{$REGION 'SIMPLE TEMPORY CONNECTION AND INIFILES CONFIGURATION'}
{
procedure TSCM.SimpleLoadSettingString(ASection, AName: String; var AValue: String);
var
  ini: TIniFile;
begin
  // Note: OneDrive enabled: 'Personal'
  // The routine TPath.GetDocumentsPath normally returns ...
  // C:\Users\<username>\Documents (Windows Vista or later)
  // but is instead mapped to C:\Users\<username>\OneDrive\Documents.
  //
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    AValue := ini.ReadString(ASection, AName, '');
  finally
    ini.Free;
  end;

end;

(*
  User_Name=Ben
  Database=SwimClubMeet
  OSAuthent=Yes
  Server=localhost\SQLEXPRESS
  DriverID=MSSQL
  MetaDefSchema=dbo
  ExtendedMetadata=False
  MetaDefCatalog=
  ApplicationName=SwimClubMeet
  Workstation=localhost
  MARS=yes
  User_Name=
  Password=*****
  Name=MSSQL_SwimClubMeet
*)

procedure TSCM.SimpleMakeTemporyFDConnection(Server, User, Password: String;
  OsAuthent: Boolean);
var
  AValue, ASection, AName: String;
begin

  if (scmConnection.Connected) then
    scmConnection.Connected := false;

  scmConnection.Params.Clear();
  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  scmConnection.Params.Add('Database=SwimClubMeet');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if OsAuthent then
    AValue := 'Yes'
  else
    AValue := 'No';
  scmConnection.Params.Add('OSAuthent=' + AValue);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('ApplicationName=scmMarshall');
  scmConnection.Connected := True;

  // ON SUCCESS - Save connection details.
  if scmConnection.Connected Then
  begin
    ASection := 'MSSQL_SwimClubMeet';
    AName := 'Server';
    SimpleSaveSettingString(ASection, AName, Server);
    AName := 'User';
    SimpleSaveSettingString(ASection, AName, User);
    AName := 'Password';
    SimpleSaveSettingString(ASection, AName, Password);
    AName := 'OSAuthent';
    SimpleSaveSettingString(ASection, AName, AValue);
  end

end;

procedure TSCM.SimpleSaveSettingString(ASection, AName, AValue: String);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    ini.WriteString(ASection, AName, AValue);
  finally
    ini.Free;
  end;

end;
}
{$ENDREGION}

end.
