unit dmSCMNom;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, dmSCM;

type
  TscmNom = class(TDataModule)
    qryIsMemberInEvent: TFDQuery;
    qryNomEvent: TFDQuery;
    qryIsMemberNominated: TFDQuery;
    cmdNominateMember: TFDCommand;
    qryNomHeat: TFDQuery;
    cmdCleanLane: TFDCommand;
    cmdDeleteNominee: TFDCommand;
    qryNomEntrant: TFDQuery;
    qryGetEntrantID: TFDQuery;
    cmdInsertEntrant: TFDCommand;
    qryGetEventID: TFDQuery;
    qryIsLaneFilled: TFDQuery;
    cmdUpdateLane: TFDCommand;
    procedure DataModuleCreate(Sender: TObject);

  private const
    SCMCONFIGFILENAME = 'SCMConfig.ini';
  private
    { Private declarations }
    prefCheckUnNomination: Integer;
    FErrMsg: String;

    procedure ReadPreferences();
    procedure DeleteNomination(MemberID, EventID: Integer);
    procedure CleanLane(EntrantID: Integer);
    procedure HeatStatusWarning(HeatStatusID: Integer);

    function IsMemberInEvent(MemberID, EventID: Integer): Boolean;
    function IsMemberNominated(MemberID, EventID: Integer): Boolean;
    function IsMemberAssignedHeat(MemberID, EventID: Integer): Boolean;
    function IsLaneFilled(HeatID, LaneNum: Integer): Boolean;

    function GetEntrantID(MemberID, EventID: Integer): Integer;
    function GetEventID(HeatID: Integer): Integer;
    function GetDistanceID(HeatID: Integer): Integer;
    function GetStrokeID(HeatID: Integer): Integer;
    function GetHeatStatusID(EntrantID: Integer): Integer overload;
    function GetHeatStatusID(MemberID: Integer; EventID: Integer)
      : Integer overload;
    function GetMemberAndEvent(EntrantID: Integer; var MemberID: Integer;
      var EventID: Integer): Boolean;
    function AssertConnection(): Boolean;

  public
    { Public declarations }
    function AssignLane(MemberID, HeatID, LaneNum: Integer): Boolean;
    function NominateMember(MemberID, EventID: Integer): Boolean;
    function UnNominateMember(MemberID, EventID: Integer): Boolean;
    function EmptyLane(EntrantID: Integer): Boolean;
    // only strikes if ... heat isn't closed or raced
    // if member found - will un-nominates first then clean-up lane
    function StrikeLane(MemberID, EventID: Integer): Boolean overload;
    function StrikeLane(EntrantID: Integer): Boolean overload;
    // Execute is an extended version taking most of the code away from the caller.
    procedure StrikeExecute(EntrantID, HeatID: Integer);

    property ErrMsg: string read FErrMsg;

  end;

var
  scmNom: TscmNom;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses System.UITypes, FMX.DialogService, FMX.Dialogs, System.IniFiles,
  System.IOUtils;
{$R *.dfm}
{ TscmNom }

function TscmNom.AssertConnection: Boolean;
begin
  Result := false;
  // Is there a CONNECTION?
  if Assigned(SCM) and SCM.IsActive then
    Result := true;
end;

function TscmNom.AssignLane(MemberID, HeatID, LaneNum: Integer): Boolean;
var
  EventID: Integer;
begin
  Result := false;

  if (MemberID = 0) then
  Begin
    FErrMsg := 'ERROR: Bad MemberID?';
    exit;
  End;

  if not AssertConnection then
  begin
    FErrMsg := 'ERROR: Unexpected error! Are you connected?';
    exit;
  end;

  // Is Empty (no Entrants assigned to lane)
  if IsLaneFilled(HeatID, LaneNum) then
  begin
    FErrMsg := 'ERROR: The lane already has an entrant';
    exit;
  end;
  EventID := GetEventID(HeatID);
  if EventID > 0 then
  begin
    // Has the member already been given a lane in this event?
    if IsMemberInEvent(MemberID, EventID) then
    begin
      FErrMsg := 'ERROR: The member already has a lane for this event!';
      exit;
    end;

    // Member must be nominated .. prior to lane assignment
    if not IsMemberNominated(MemberID, EventID) then
      NominateMember(MemberID, EventID);
    // Prepare to Update the empty lane with the new member

    // Prepare to insert the member into the lane
    if not Assigned(cmdUpdateLane.Connection) then
      cmdUpdateLane.Connection := SCM.scmConnection;
    if cmdUpdateLane.Active then
      cmdUpdateLane.Close;
    cmdUpdateLane.ParamByName('MEMBERID').AsInteger := MemberID;
    cmdUpdateLane.ParamByName('HEATID').AsInteger := HeatID;
    cmdUpdateLane.ParamByName('LANE').AsInteger := LaneNum;
    cmdUpdateLane.Prepare;
    cmdUpdateLane.Execute;
    Result := true;
  end
  else
    FErrMsg := 'ERROR: Lane already assigned nomination.';

end;

procedure TscmNom.CleanLane(EntrantID: Integer);
begin
  if AssertConnection then
  begin
    if cmdCleanLane.Active then
      cmdCleanLane.Close;
    cmdCleanLane.ParamByName('ENTRANTID').AsInteger := EntrantID;
    cmdCleanLane.Connection := SCM.scmConnection;
    cmdCleanLane.Prepare;
    cmdCleanLane.Execute;
  end;
end;

procedure TscmNom.DataModuleCreate(Sender: TObject);
begin
  // Default: don't prompt for confirmation when clearing a lane.
  prefCheckUnNomination := 0;
  FErrMsg := '';
  // ReadPreferences();
end;

procedure TscmNom.DeleteNomination(MemberID, EventID: Integer);
begin
  if AssertConnection then
  begin
    if cmdDeleteNominee.Active then
      cmdDeleteNominee.Close;
    cmdDeleteNominee.ParamByName('MEMBERID').AsInteger := MemberID;
    cmdDeleteNominee.ParamByName('EVENTID').AsInteger := EventID;
    cmdDeleteNominee.Connection := SCM.scmConnection;
    cmdDeleteNominee.Prepare;
    cmdDeleteNominee.Execute;

  end;
end;

function TscmNom.EmptyLane(EntrantID: Integer): Boolean;
var
  HeatStatusID: Integer;
begin
  Result := false;
  HeatStatusID := GetHeatStatusID(EntrantID);
  if HeatStatusID = 1 then
  begin
    // Heat Status is open ...
    CleanLane(EntrantID);
    Result := true;
  end
  else
    HeatStatusWarning(HeatStatusID);
end;

function TscmNom.GetDistanceID(HeatID: Integer): Integer;
begin
  Result := 0;
  if AssertConnection then
  begin
    if qryGetEventID.Active then
      qryGetEventID.Close;
    qryGetEventID.ParamByName('HEATID').AsInteger := HeatID;
    qryGetEventID.Connection := SCM.scmConnection;
    qryGetEventID.Prepare;
    qryGetEventID.Open;
    if qryGetEventID.Active then
      Result := qryGetEventID.FieldByName('DistanceID').AsInteger;
    qryGetEventID.Close;
  end;
end;

function TscmNom.GetEntrantID(MemberID, EventID: Integer): Integer;
var
  AMessage: string;
begin
  Result := 0;
  if AssertConnection then
  begin
    if qryGetEntrantID.Active then
      qryGetEntrantID.Close;
    qryGetEntrantID.ParamByName('MEMBERID').AsInteger := MemberID;
    qryGetEntrantID.ParamByName('EVENTID').AsInteger := EventID;
    qryGetEntrantID.Connection := SCM.scmConnection;
    qryGetEntrantID.Prepare;
    qryGetEntrantID.Open;
    if qryGetEntrantID.Active then
    begin
      if not qryGetEntrantID.IsEmpty then
      begin
        qryGetEntrantID.Last;
        if qryGetEntrantID.RecordCount > 1 then
        begin
          TDialogService.PreferredMode :=
            TDialogService.TPreferredMode.Platform;
          // Show a simple message box with an 'Ok' button to close it.
          AMessage := 'OOPS :: A most unlikely error has been detected.' +
            sLineBreak +
            'The member has been placed multiply times into this event!';
          TDialogService.ShowMessage(AMessage);
        end
        else
          Result := qryGetEntrantID.FieldByName('EntrantID').AsInteger;
      end;
      qryGetEntrantID.Close;
    end;
  end;
end;

function TscmNom.GetEventID(HeatID: Integer): Integer;
begin
  Result := 0;
  if AssertConnection then
  begin
    if qryGetEventID.Active then
      qryGetEventID.Close;
    qryGetEventID.ParamByName('HEATID').AsInteger := HeatID;
    qryGetEventID.Connection := SCM.scmConnection;
    qryGetEventID.Prepare;
    qryGetEventID.Open;
    if qryGetEventID.Active then
      Result := qryGetEventID.FieldByName('EventID').AsInteger;
    qryGetEventID.Close;
  end;
end;

function TscmNom.GetHeatStatusID(MemberID, EventID: Integer): Integer;
var
  EntrantID: Integer;
begin
  Result := 0;
  EntrantID := GetEntrantID(MemberID, EventID);
  if EntrantID > 0 then
    Result := GetHeatStatusID(EntrantID);
end;

function TscmNom.GetHeatStatusID(EntrantID: Integer): Integer;
begin
  Result := 0;
  if AssertConnection then
  begin
    if qryNomEntrant.Active then
      qryNomEntrant.Close;
    qryNomEntrant.ParamByName('ENTRANTID').AsInteger := EntrantID;
    qryNomEntrant.Connection := SCM.scmConnection;
    qryNomEntrant.Prepare;
    qryNomEntrant.Open;
    if qryNomEntrant.Active then
    begin
      if not qryNomEntrant.IsEmpty then
      begin
        Result := qryNomEntrant.FieldByName('HeatStatusID').AsInteger;
        qryNomEntrant.Close;
      end;
    end;
  end;
end;

function TscmNom.GetMemberAndEvent(EntrantID: Integer;
  var MemberID, EventID: Integer): Boolean;
begin
  Result := false;
  if AssertConnection then
  begin
    if qryNomEntrant.Active then
      qryNomEntrant.Close;
    qryNomEntrant.ParamByName('ENTRANTID').AsInteger := EntrantID;
    qryNomEntrant.Connection := SCM.scmConnection;
    qryNomEntrant.Prepare;
    qryNomEntrant.Open;
    if qryNomEntrant.Active then
    begin
      if not qryNomEntrant.IsEmpty then
      begin
        MemberID := qryNomEntrant.FieldByName('MemberID').AsInteger;
        EventID := qryNomEntrant.FieldByName('EventID').AsInteger;
        qryNomEntrant.Close;
        if (MemberID > 0) and (EventID > 0) then
          Result := true;
      end;
      qryNomEntrant.Close;
    end;
  end;
end;

function TscmNom.GetStrokeID(HeatID: Integer): Integer;
begin
  Result := 0;
  if AssertConnection then
  begin
    if qryGetEventID.Active then
      qryGetEventID.Close;
    qryGetEventID.ParamByName('HEATID').AsInteger := HeatID;
    qryGetEventID.Connection := SCM.scmConnection;
    qryGetEventID.Prepare;
    qryGetEventID.Open;
    if qryGetEventID.Active then
      Result := qryGetEventID.FieldByName('StrokeID').AsInteger;
    qryGetEventID.Close;
  end;
end;

procedure TscmNom.HeatStatusWarning(HeatStatusID: Integer);
var
  AMessage: string;
begin
  if (HeatStatusID = 2) or (HeatStatusID = 3) then
    AMessage := 'The heat in a ''raced'' or ''closed''.' + sLineBreak +
      'Changes are not permitted.'
  else
    AMessage := 'The heat status couldn''t be found!';

  TDialogService.PreferredMode := TDialogService.TPreferredMode.Platform;
  // Show a simple message box with an 'Ok' button to close it.
  TDialogService.ShowMessage(AMessage);
end;

function TscmNom.IsLaneFilled(HeatID, LaneNum: Integer): Boolean;
begin
  Result := true;
  if (HeatID = 0) or (LaneNum = 0) then
    exit;
  if AssertConnection then
  begin
    if qryIsLaneFilled.Active then
      qryIsLaneFilled.Close;
    qryIsLaneFilled.ParamByName('HEATID').AsInteger := HeatID;
    qryIsLaneFilled.ParamByName('LANENUM').AsInteger := LaneNum;
    qryIsLaneFilled.Connection := SCM.scmConnection;
    qryIsLaneFilled.Prepare;
    qryIsLaneFilled.Open;
    if qryIsLaneFilled.Active then
    begin
      if qryIsLaneFilled.FieldByName('MemberID').IsNull then
      begin
        Result := false;
      end;
    end;
    qryIsLaneFilled.Close;
  end;
end;

function TscmNom.IsMemberAssignedHeat(MemberID, EventID: Integer): Boolean;
begin
  Result := false;
  if (MemberID = 0) or (EventID = 0) then
    exit;
  if AssertConnection then
  begin
    if qryNomHeat.Active then
      qryNomHeat.Close;
    qryNomHeat.ParamByName('MEMBERID').AsInteger := MemberID;
    qryNomHeat.ParamByName('EVENTID').AsInteger := EventID;
    qryNomHeat.Connection := SCM.scmConnection;
    qryNomHeat.Prepare;
    qryNomHeat.Open;
    if qryNomHeat.Active then
    begin
      if not qryNomHeat.IsEmpty then
      begin
        Result := true;
      end;
      qryNomHeat.Close;
    end;
  end;
end;

function TscmNom.IsMemberInEvent(MemberID, EventID: Integer): Boolean;
begin
  Result := false;
  if (MemberID = 0) or (EventID = 0) then
    exit;
  if AssertConnection then
  begin
    if qryIsMemberInEvent.Active then
      qryIsMemberInEvent.Close;
    qryIsMemberInEvent.ParamByName('MEMBERID').AsInteger := MemberID;
    qryIsMemberInEvent.ParamByName('EVENTID').AsInteger := EventID;
    qryIsMemberInEvent.Connection := SCM.scmConnection;
    qryIsMemberInEvent.Prepare;
    qryIsMemberInEvent.Open;
    if qryIsMemberInEvent.Active then
    begin
      if not qryIsMemberInEvent.IsEmpty then
      begin
        Result := true;
      end;
      qryIsMemberInEvent.Close;
    end;
  end;
end;

function TscmNom.IsMemberNominated(MemberID, EventID: Integer): Boolean;
begin
  Result := true;
  if (MemberID = 0) or (EventID = 0) then
    exit;
  if AssertConnection then
  begin
    if qryIsMemberNominated.Active then
      qryIsMemberNominated.Close;
    qryIsMemberNominated.ParamByName('MEMBERID').AsInteger := MemberID;
    qryIsMemberNominated.ParamByName('EVENTID').AsInteger := EventID;
    qryIsMemberNominated.Connection := SCM.scmConnection;
    qryIsMemberNominated.Prepare;
    qryIsMemberNominated.Open;
    if qryIsMemberNominated.Active then
    begin
      if qryIsMemberNominated.IsEmpty then
      begin
        Result := false;
      end;
      qryIsMemberNominated.Close;
    end;
  end;
end;

function TscmNom.NominateMember(MemberID, EventID: Integer): Boolean;
var
  pass: Boolean;
begin
  Result := false;
  if (MemberID = 0) or (EventID = 0) then
    exit;
  if AssertConnection then
  begin
    // Is the member nominated (for this event)?
    pass := IsMemberNominated(MemberID, EventID);
    if (pass = false) then
      if cmdNominateMember.Active then
        cmdNominateMember.Close;
    cmdNominateMember.ParamByName('MEMBERID').AsInteger := MemberID;
    cmdNominateMember.ParamByName('EVENTID').AsInteger := EventID;
    cmdNominateMember.Connection := SCM.scmConnection;
    cmdNominateMember.Execute;
    cmdNominateMember.Close;
    Result := true;
  end;
end;

procedure TscmNom.ReadPreferences();
var
  iFile: TIniFile;
  Section: String;
begin
  Section := 'MarshallOptions';
  iFile := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    prefCheckUnNomination := iFile.ReadInteger('Preferences',
      'CheckUnNomination', 0);
  finally
    FreeAndNil(iFile);
  end;
end;

procedure TscmNom.StrikeExecute(EntrantID, HeatID: Integer);
var
  MemberID, EventID, intResult: Integer;
  AMessage: string;
begin
  if AssertConnection then
  begin
    if EntrantID > 0 then
    begin
      if GetMemberAndEvent(EntrantID, MemberID, EventID) then
      begin

        AMessage := 'Strike the entrant from the lane and remove' + sLineBreak +
          'the member''s nomination from the ''Entrant Pool''?';

        TDialogService.PreferredMode := TDialogService.TPreferredMode.Platform;
        TDialogService.MessageDialog(AMessage, TMsgDlgType.mtConfirmation,
          FMX.Dialogs.mbYesNo, TMsgDlgBtn.mbNo, 0,
          procedure(const AResult: TModalResult)
          begin
            intResult := AResult;
            case AResult of
              mrYes:
                begin
                  SCM.dsEntrant.DataSet.DisableControls;
                  if StrikeLane(EntrantID) then
                  begin
                    SCM.dsEntrant.DataSet.Refresh;
                    // TODO: can't locate entrant here ... Locate lane in qryLane
                    SCM.LocateEntrantID(EntrantID, HeatID);
                  end;
                  SCM.dsEntrant.DataSet.EnableControls;
                end;
              mrNo:
                begin
                  // possibly no member to strike, so just clean the lane.
                  // (ie. assert it's condition) If heat is open ...
                  EmptyLane(EntrantID);
                end;
            end;
          end);
      end
      else
    end;
  end;
end;

function TscmNom.StrikeLane(EntrantID: Integer): Boolean;
var
  MemberID, EventID, HeatStatusID: Integer;
begin
  Result := false;
  if AssertConnection then
  begin
    if EntrantID > 0 then
    begin
      HeatStatusID := GetHeatStatusID(EntrantID);
      if HeatStatusID = 1 then
      begin
        if (GetMemberAndEvent(EntrantID, MemberID, EventID)) then
          DeleteNomination(MemberID, EventID);
        CleanLane(EntrantID);
        Result := true;
      end
      else
        HeatStatusWarning(HeatStatusID);
    end;
  end;
end;

function TscmNom.StrikeLane(MemberID, EventID: Integer): Boolean;
var
  EntrantID, HeatStatusID: Integer;

begin
  Result := false;
  if AssertConnection then
  begin
    if (MemberID > 0) and (EventID > 0) then
    begin
      HeatStatusID := GetHeatStatusID(MemberID, EventID);
      if HeatStatusID = 1 then
      begin
        // remove nomination ...
        DeleteNomination(MemberID, EventID);
        // clear Entrant Data - clear lane
        EntrantID := GetEntrantID(MemberID, EventID);
        if EntrantID > 0 then
        begin
          // NOTE: not using EmptyLane as heat status has been checked.
          CleanLane(EntrantID);
          Result := true;
        end;
      end

    end;
  end;

end;

function TscmNom.UnNominateMember(MemberID, EventID: Integer): Boolean;
var
  DoDeleteNom, DoEmptyLane: Boolean;
  EntrantID: Integer;
  AMessage: string;
begin
  DoDeleteNom := false;
  DoEmptyLane := false;
  if (MemberID > 0) and (EventID > 0) then
  begin
    // Is the member nominated (for this event)?
    if IsMemberNominated(MemberID, EventID) then
    begin
      // Is the nominated member been assigned a lane in a heat?
      if IsMemberAssignedHeat(MemberID, EventID) then
      begin
        if GetHeatStatusID(MemberID, EventID) = 1 then
        begin
          // Check user preference setting.
          // Gives the user the opportunity to abort the 'Un-Nomination'.
          if prefCheckUnNomination = 1 then
          begin

            AMessage := 'The nominee has been placed into a heat.' + sLineBreak
              + 'Remove the nominee from the ''Nominee Pool''' + sLineBreak +
              'and EMPTY the lane?';

            TDialogService.PreferredMode :=
              TDialogService.TPreferredMode.Platform;
            TDialogService.MessageDialog(AMessage, TMsgDlgType.mtConfirmation,
              FMX.Dialogs.mbYesNo, TMsgDlgBtn.mbNo, 0,
              procedure(const AResult: TModalResult)
              begin
                if AResult = mrYes then
                begin
                  // - flag the tasks to perform
                  DoDeleteNom := true;
                  DoEmptyLane := true;
                end
              end);
          end
          else
          begin
            // Default, all tasks will be performed
            DoDeleteNom := true;
            DoEmptyLane := true;
          end;
        end;
      end
      else
        // At this point, the member has been nominated but not assigned
        // a lane. No lane to empty. (No record in the Entrant table).
        DoDeleteNom := true;
    end;
  end;

  if DoDeleteNom then
    DeleteNomination(MemberID, EventID);

  if DoEmptyLane then
  begin
    EntrantID := GetEntrantID(MemberID, EventID);
    if EntrantID > 0 then
      CleanLane(EntrantID);
  end;

  Result := DoDeleteNom;

end;

end.
