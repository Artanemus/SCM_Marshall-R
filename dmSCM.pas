unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.Variants, System.IniFiles, System.IOUtils,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Data.Bind.Components, Data.Bind.DBScope, Data.FMTBcd, Data.SqlExpr;

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
    dsEntrant: TDataSource;
    qrySession: TFDQuery;
    qryHeat: TFDQuery;
    qryEvent: TFDQuery;
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
    qryLaneMemberID: TIntegerField;
    qrySCMSystem: TFDQuery;
    dsSCMSystem: TDataSource;
    qryEventEventID: TFDAutoIncField;
    qryEventEventNum: TIntegerField;
    qryEventNomineeCount: TIntegerField;
    qryEventEntrantCount: TIntegerField;
    qryEventSessionID: TIntegerField;
    qryEventStrokeID: TIntegerField;
    qryEventDistanceID: TIntegerField;
    qryEventEventStatusID: TIntegerField;
    qryEventListTextStr: TWideStringField;
    qryEventListDetailStr: TWideStringField;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSessionStart: TSQLTimeStampField;
    qrySessionSwimClubID: TIntegerField;
    qrySessionSessionStatusID: TIntegerField;
    qrySessionSessionStatusStr: TStringField;
    qrySessionCaption: TWideStringField;
    qrySessionSessionStartStr: TWideStringField;
    qrySessionSessionDetailStr: TWideStringField;
    qryHeatHeatID: TFDAutoIncField;
    qryHeatHeatNum: TIntegerField;
    qryHeatEventID: TIntegerField;
    qryHeatHeatTypeID: TIntegerField;
    qryHeatHeatStatusID: TIntegerField;
    qryHeatStatusStr: TWideStringField;
    qryHeatHeatNumStr1: TStringField;
    qryHeatHeatNumStr2: TStringField;
    qryMemberMemberID: TFDAutoIncField;
    qryMemberMembershipNum: TIntegerField;
    qryMemberMembershipStr: TWideStringField;
    qryMemberFirstName: TWideStringField;
    qryMemberLastName: TWideStringField;
    qryMemberDOB: TSQLTimeStampField;
    qryMemberIsActive: TBooleanField;
    qryMemberEmail: TWideStringField;
    qryMemberEnableEmailOut: TBooleanField;
    qryMemberGenderID: TIntegerField;
    qryMemberSwimClubID: TIntegerField;
    qryMemberFName: TWideStringField;
    qrySCMSystemSCMSystemID: TFDAutoIncField;
    qrySCMSystemDBVersion: TIntegerField;
    qrySCMSystemMajor: TIntegerField;
    qrySCMSystemMinor: TIntegerField;
    qrySCMSystemBuild: TIntegerField;
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
    qryEntrantQualifiedStatus: TStringField;
    qryEntrantHeatNumLaneFNameStr: TWideStringField;
    qryEntrantLastNameStr: TWideStringField;
    qryDCode: TFDQuery;
    qryDCodeDisqualifyCodeID: TFDAutoIncField;
    qryDCodeDCodeStr: TWideStringField;
    qryDCodeABREV: TWideStringField;
    qryDCodeDisqualifyTypeID: TFDAutoIncField;
    qryDCodeTypeStr: TWideStringField;
    dsDCode: TDataSource;
    qryEventEventTypeID: TIntegerField;
    qryEntrantDisqualifyCodeID: TIntegerField;
    qryEntrantABREV: TWideStringField;
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

    // 2023.3.10
    function GetDBVerInfo: string;
    procedure FilterClosedSessions(HideClosedSessions: Boolean);
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
    qrySCMSystem.Open;
    if qrySession.Active then
    begin
      qryMember.Open;
      if qryMember.Active then
      begin
        qryEvent.Open; // EVENT ordered by EventNum
        if qryEvent.Active then
        begin
          if qryDCode.Active then
            qryDCode.Close;
          // normally = qryEvent.StrokeID.
          qryDCode.ParamByName('DISQUALIFYTYPEID').Clear;
          qryDCode.Prepare;
          qryDCode.Open;
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
  scmConnection.Connected := false;
  FIsActive := false;

end;

procedure TSCM.DeActivateTable;
begin
  if qryEntrant.Active then qryEntrant.Close;
  if qryLane.Active then qryLane.Close;
  if qryHeat.Active then qryHeat.Close;
  if qryDCode.Active then qryDCode.Close;
  if qryEvent.Active then qryEvent.Close;
  if qryMember.Active then qryMember.Close;
  if qrySession.Active then qrySession.Close;
  if tblSwimClub.Active then tblSwimClub.Close;

  if qrySCMSystem.Active then qrySCMSystem.Close;

  FIsActive := false;
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

end.
