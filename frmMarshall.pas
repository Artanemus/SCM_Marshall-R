unit frmMarshall;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, System.ImageList, FMX.ImgList, System.Actions, FMX.ActnList,
  Data.Bind.Components, Data.Bind.DBScope, FMX.Objects, FMX.StdCtrls,
  FMX.ListView, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation,
  FMX.TabControl, FMX.Layouts, dmSCM, System.Character,
  System.IOUtils, Data.DB, FireDAC.Stan.Param, FMX.Effects, FMX.Filter.Effects;

type
  TMarshall = class(TForm)
    ScaledLayout1: TScaledLayout;
    layTabs: TLayout;
    TabControl1: TTabControl;
    tabLoginSession: TTabItem;
    layLoginToServer: TLayout;
    layConnectButtons: TLayout;
    btnConnect: TButton;
    btnDisconnect: TButton;
    Label7: TLabel;
    edtServer: TEdit;
    Label8: TLabel;
    edtUser: TEdit;
    Label12: TLabel;
    edtPassword: TEdit;
    chkOsAuthent: TCheckBox;
    Label18: TLabel;
    laySelectSession: TLayout;
    lblSelectSession: TLabel;
    cmbSessionList: TComboBox;
    tabEventHeat: TTabItem;
    layEventHeat: TLayout;
    ListViewEvent: TListView;
    ListViewHeat: TListView;
    layEventHeatTitleBar: TLayout;
    lblEvent: TLabel;
    lblHeat: TLabel;
    tabEntrantRaceTime: TTabItem;
    layEntrantRaceTime: TLayout;
    layRaceTime: TLayout;
    layRaceTimeTitleBar: TLayout;
    Label3: TLabel;
    layRaceTimeDetail: TLayout;
    layRaceTimeText: TLayout;
    layHeatNumber: TLayout;
    lblHeatNumber: TLabel;
    Label2: TLabel;
    layLane: TLayout;
    lblLaneNumber: TLabel;
    txt01: TLabel;
    layEntrantName: TLayout;
    lblEntrantName: TLabel;
    layPersonalBest: TLayout;
    txt03: TLabel;
    lblPersonalBest: TLabel;
    layStoredRaceTime: TLayout;
    Label5: TLabel;
    lblRaceTime: TLabel;
    layTimeToBeat: TLayout;
    Label9: TLabel;
    lblTimeToBeat: TLabel;
    layEntrantList: TLayout;
    ListViewLane: TListView;
    layEntrantListTitleBar: TLayout;
    lblEntrantsHeatNum: TLabel;
    layFooter: TLayout;
    SizeGrip1: TSizeGrip;
    lblConnectionStatus: TLabel;
    layTopBar: TLayout;
    layTitle: TLayout;
    lblSessionTitle: TLabel;
    lblSwimClubTitle: TLabel;
    laySummary: TLayout;
    lblSelectedEntrant: TLabel;
    lblSelectedEvent: TLabel;
    layCenteredButtons: TLayout;
    imgStopWatch: TImage;
    btnOptions: TButton;
    btnRefresh: TButton;
    StyleBook2: TStyleBook;
    BS_tblSwimClub: TBindSourceDB;
    BS_qrySession: TBindSourceDB;
    BS_qryEvent: TBindSourceDB;
    BS_qryHeat: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField2: TLinkListControlToField;
    LinkListControlToField3: TLinkListControlToField;
    LinkListControlToField4: TLinkListControlToField;
    LinkListControlToField1: TLinkListControlToField;
    LinkPropertyToFieldClubName: TLinkPropertyToField;
    LinkPropertyToFieldSessionDate: TLinkPropertyToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText7: TLinkPropertyToField;
    LinkPropertyToFieldText8: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    BS_qryEntrant: TBindSourceDB;
    ActionList1: TActionList;
    actnConnect: TAction;
    actnDisconnect: TAction;
    actnRefresh: TAction;
    actnQualify: TAction;
    actnSCMOptions: TAction;
    BS_qryLane: TBindSourceDB;
    ImageList1: TImageList;
    AniIndicator1: TAniIndicator;
    lblAniIndicatorStatus: TLabel;
    Timer1: TTimer;
    Layout1: TLayout;
    FlowLayout1: TFlowLayout;
    Image2: TImage;
    Image3: TImage;
    Image1: TImage;
    MonochromeEffect2: TMonochromeEffect;
    MonochromeEffect3: TMonochromeEffect;
    MonochromeEffect1: TMonochromeEffect;
    layQualifyStatus: TLayout;
    Label1: TLabel;
    lblQualifyStatus: TLabel;
    layPostQualifyStatus: TLayout;
    btnRTN: TButton;
    LinkPropertyToFieldText9: TLinkPropertyToField;
    LinkPropertyToFieldText10: TLinkPropertyToField;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure actnQualifyExecute(Sender: TObject);
    procedure actnQualifyUpdate(Sender: TObject);
    procedure actnSCMOptionsExecute(Sender: TObject);
    procedure actnSCMOptionsUpdate(Sender: TObject);
    procedure ListViewHeatChange(Sender: TObject);
    procedure ListViewEventChange(Sender: TObject);
    procedure ListViewLaneChange(Sender: TObject);
    procedure cmbSessionListChange(Sender: TObject);
    procedure imgStopWatchClick(Sender: TObject);
    procedure ListViewHeatDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ImageQualifyClick(Sender: TObject);
    procedure ListViewLaneUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewLaneItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure LinkPropertyToFieldText4AssignedValue(Sender: TObject;
      AssignValueRec: TBindingAssignValueRec; const Value: TValue);
    procedure LinkPropertyToFieldText10AssignedValue(Sender: TObject;
      AssignValueRec: TBindingAssignValueRec; const Value: TValue);

  private const
    SCMCONFIGFILENAME = 'SCMConfig.ini';
    CONNECTIONTIMEOUT = 48;

  private
    { Private declarations }
    fEnableAutoReFresh: Boolean;
    fEnableNomination: Boolean;
    fHideClosedSessions: Boolean;
    fConnectionCountdown: Integer;

    procedure scmPostQualify(AQualifyStatus: Integer);
    procedure ConnectOnTerminate(Sender: TObject);
    procedure scmSetBigButtonsEffect(btnTag: Integer);
    function scmGetBigButtonsEffect: Integer;

    procedure GetSCMVerInfo();


  public
    { Public declarations }
    procedure scmOptionsLoad;
    procedure scmRefreshEntrant_Detail;
    procedure scmRefreshLane;
    procedure scmRefreshBigButtons;
    // procedure scmRefresh_tabEntrantRaceTime;
    procedure scmUpdateNomination(EnableNomination: Boolean);
    procedure scmUpdateTabSheetsImages;
    procedure scmUpdateHideClosedSessions;
    property HideClosedsessions: Boolean read fHideClosedSessions;
    property EnableNomination: Boolean read fEnableNomination;

  end;

var
  Marshall: TMarshall;

implementation

{$R *.fmx}

uses
{$IFDEF MSWINDOWS}
  // needed for call to winapi MessageBeep & Beep
  Winapi.Windows,
{$ENDIF}
  dlgSCMOptions, dlgSCMStopWatch,
  // FOR scmLoadOptions
  System.IniFiles,
  // FOR Floor
  System.Math, dlgSCMNominate, SCMExeInfo;

{$REGION 'ACTION MANAGER'}

procedure TMarshall.actnConnectExecute(Sender: TObject);
var
  Thread: TThread;
begin
  if (Assigned(SCM) and (SCM.scmConnection.Connected = false)) then
  begin
    lblAniIndicatorStatus.Text := 'Connecting';
    fConnectionCountdown := CONNECTIONTIMEOUT;
    AniIndicator1.Visible := true; // progress timer
    AniIndicator1.Enabled := true; // start spinning
    lblAniIndicatorStatus.Visible := true; // a label with countdown
    // lock this button - so user won't start another thread!
    btnConnect.Enabled := false;
    Timer1.Enabled := true; // start the countdown

    application.ProcessMessages;

    Thread := TThread.CreateAnonymousThread(
      procedure
      begin
        try
          SCM.SimpleMakeTemporyFDConnection(edtServer.Text, edtUser.Text,
            edtPassword.Text, chkOsAuthent.IsChecked);
        finally
          Timer1.Enabled := false;
          lblAniIndicatorStatus.Visible := false;
          AniIndicator1.Enabled := false;
          AniIndicator1.Visible := false;
          btnConnect.Enabled := true;
        end;
      end);
    Thread.OnTerminate := ConnectOnTerminate;
    Thread.Start;
  end;

end;

procedure TMarshall.actnConnectUpdate(Sender: TObject);
begin
  // toggle visibility of Connect button.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      actnConnect.Visible := false
    else
      actnConnect.Visible := true
  else
    actnConnect.Visible := true;
end;

procedure TMarshall.actnDisconnectExecute(Sender: TObject);
begin
  // IF DATA-MODULE EXISTS ... break the current connection.
  if Assigned(SCM) then
  begin
    SCM.DeActivateTable;
    SCM.scmConnection.Connected := false;
    lblConnectionStatus.Text := 'No connection.';
  end;
  // Hides..unhides visibility of icons in tabLoginSession
  scmUpdateTabSheetsImages;
  AniIndicator1.Visible := false;
  lblAniIndicatorStatus.Visible := false;
  AniIndicator1.Enabled := false;

end;

procedure TMarshall.actnDisconnectUpdate(Sender: TObject);
begin
  // toggle visibility of Disconnect button.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      actnDisconnect.Visible := true
    else
      actnDisconnect.Visible := false
  else
    actnDisconnect.Visible := false;
end;

procedure TMarshall.actnQualifyExecute(Sender: TObject);
begin
  // Post RaceTime to the database
  // Check for connection
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // if the heat is closed or raced - then
    // if the session is closed - then
    // the racetime can't be updated ...
    if ((SCM.qryHeat.FieldByName('HeatStatusID').AsInteger <> 1) or
      (SCM.qrySession.FieldByName('SessionStatusID').AsInteger <> 1)) then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblConnectionStatus.Text :=
        'Failed to Post because the session/heat is locked/closed.';
    end
    else
      // routine will post and display a status message
      // uses ExeSQL
      scmPostQualify(scmGetBigButtonsEffect);

    // Update the entrants details.
    // Get the server to ECHO the QUALIFIED STATUS.
    // ie. VISIBLE confirmation that it was POSTED.
    // append a '(Disqualified)' or '(Scratched)' to the
    // FName in the lane listview
    scmRefreshLane;
  end
end;

procedure TMarshall.actnQualifyUpdate(Sender: TObject);
begin
  // connected to SwimClubMeet
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // is the heat open? Is the session unlocked?
    if ((SCM.qryHeat.FieldByName('HeatStatusID').AsInteger = 1) and
      (SCM.qrySession.FieldByName('SessionStatusID').AsInteger = 1)) then
    // Is there a swimmer assigned to the lane?
    begin
      if (not SCM.qryEntrant.IsEmpty) then
        btnRTN.Enabled := true
      else
        btnRTN.Enabled := false;
    end
    // session is locked or heat is raced or closed ...
    else
      btnRTN.Enabled := false;
  end
  // database isn't connected
  else
    btnRTN.Enabled := false;
end;

procedure TMarshall.actnRefreshExecute(Sender: TObject);
var
  EventID, HeatID: Integer;
begin
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // disable listviews
    SCM.qryEvent.DisableControls;
    SCM.qryHeat.DisableControls;
    // store the current database record identities
    EventID := SCM.qryHeat.FieldByName('EventID').AsInteger;
    HeatID := SCM.qryHeat.FieldByName('HeatID').AsInteger;
    // run the queries
    SCM.qryEvent.Refresh;
    lblConnectionStatus.Text := 'SCM Refreshed.';
    // restore database record indexes
    SCM.LocateEventID(EventID);
    SCM.LocateHeatID(HeatID);
    // performs full ReQuery of lane table.
    scmRefreshLane;
  end;
  SCM.qryEvent.EnableControls;
  SCM.qryHeat.EnableControls;
end;

procedure TMarshall.actnRefreshUpdate(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.IsActive) then
    actnRefresh.Enabled := true
  else
    actnRefresh.Enabled := false;
end;

// MODAL FORMS IN FireMonkey
// This topic shows you how to create, configure and display a FireMonkey
// dialog box. It also shows how to handle its return value using a callback
// method, and how to free the memory allocated by your modal dialog box
// after it closes.

// 1. Define a class that takes the TProc__1 interface, and define a function
// to handle the closing of your dialog box:
// ---------------------------------------------------------------------------
// You cannot free the memory allocated for your modal dialog box form within
// the method than handles the closing of your modal dialog box form.
// To free your modal dialog box form, you must handle its (the modal dialog
// box form) OnClose event.
// WIT:
// Action = TCloseAction::caFree;

// ---------------------------------------------------------------------------

// 2. Then pass an instance of this class to ShowModal:
// ---------------------------------------------------------------------------

procedure TMarshall.actnSCMOptionsExecute(Sender: TObject);
var
  dlg: TscmOptions;
begin
{$IFNDEF ANDROID}
  dlg := TscmOptions.Create(self);
  dlg.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      // ... Do something.

      // Always reload SCM options from the scmConfig.ini file.
      // There is no CANCEL for this modal form. What ever the user does,
      // the input values are accepted.
      scmOptionsLoad;
      // update the visibility of the accessory item in the ListViewLane
      // safe - doesn't require connection.
      scmUpdateNomination(fEnableNomination);
      // little status images used on the tabsheets
      scmUpdateTabSheetsImages;
      // Update the visibility of closed sessions in qrySession
      // by modifying it's param HIDECLOSED.
      // This uses value fHideClosedSessions and is best done after a fresh
      // read of the scmConfig.ini values.
      scmUpdateHideClosedSessions;
      // update the visibility of the accessory icon
      if fEnableNomination then
        ListViewLane.ItemAppearanceObjects.ItemObjects.Accessory.Visible := true
      else
        ListViewLane.ItemAppearanceObjects.ItemObjects.Accessory.
          Visible := false;

      // Update GUI state
      actnSCMOptionsUpdate(self);
    end);

{$ELSE}
  { TODO : Create an android popup window for options? }
  // ANDROID platform doesn't do Modal Forms.
{$ENDIF}
  (*
    IMPORTANT NOTE : DIALOGUE IS DESTROYED IN TscmOption.FormClose
  *)
end;

procedure TMarshall.actnSCMOptionsUpdate(Sender: TObject);
begin
  // if (Assigned(SCM) and SCM.IsActive) then
  // ListViewLane.Enabled := true
  // else
  // ListViewLane.Enabled := true;
end;

{$ENDREGION}

procedure TMarshall.cmbSessionListChange(Sender: TObject);
begin
  // clean the statusbar
  lblConnectionStatus.Text := '';
end;

procedure TMarshall.ConnectOnTerminate(Sender: TObject);
begin
  if TThread(Sender).FatalException <> nil then
  begin
    // something went wrong
    // Exit;
  end;

  // Tidy-up display
  // lblAniIndicatorStatus.Visible := false;
  // AniIndicator1.Enabled := false;
  // AniIndicator1.Visible := false;

  // Make tables active
  if (SCM.scmConnection.Connected) then
  begin
    SCM.ActivateTable;
    // ALL TABLES SUCCESSFULLY MADE ACTIVE ...
    if (SCM.IsActive = true) then
    begin
      lblConnectionStatus.Text := 'Connected to SwimClubMeet.';
      // TODO: FIRST TIME INIT
      scmRefreshLane;
    end
    else
      lblConnectionStatus.Text :=
        'Connected to SwimClubMeet but not all tables are active!';
  end;

  // FINAL CHECKS
  if (Assigned(SCM) and (SCM.scmConnection.Connected = false)) then
  begin
    lblConnectionStatus.Text := 'No connection.';
  end;

  // Toggles visibility of icons in tabLoginSession.
  scmUpdateTabSheetsImages;
  // Label showing application and database version
  GetSCMVerInfo;

end;

procedure TMarshall.FormCreate(Sender: TObject);
var
  AValue, ASection, AName: String;

begin
  // Initialization of params.
  application.ShowHint := true;
  ASection := 'MSSQL_SwimClubMeet';
  AniIndicator1.Visible := false;
  AniIndicator1.Enabled := false;
  btnDisconnect.Visible := false;
  fConnectionCountdown := CONNECTIONTIMEOUT;
  fEnableNomination := false;
  Timer1.Enabled := false;
  lblAniIndicatorStatus.Visible := false;

  // note cmbSessionList.Clear doesn't work here.
  cmbSessionList.Items.Clear;

  // clean-up the top bar captions
  lblSwimClubTitle.Text := String.Empty;
  lblSessionTitle.Text := String.Empty;
  lblSelectedEvent.Text := String.Empty;
  lblSelectedEntrant.Text := String.Empty;

  // clean-up TabSheet3
  lblEntrantsHeatNum.Text := 'Entrants ...';

  // ON CREATION SETS - SCM->scmConnection->Active = false;
  SCM := TSCM.Create(self);

  // Read last successful connection params and load into controls
  AName := 'Server';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);
  edtServer.Text := AValue;
  AName := 'User';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);
  edtUser.Text := AValue;
  AName := 'Password';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);
  edtPassword.Text := AValue;
  AName := 'OsAuthent';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);

  if ((UpperCase(AValue) = 'YES') or (UpperCase(AValue) = 'TRUE')) then
    chkOsAuthent.IsChecked := true
  else
    chkOsAuthent.IsChecked := false;

  // Connection status - located in footer bar.
  lblConnectionStatus.Text := '';

  // Login-Session
  TabControl1.TabIndex := 0;
  // read user options
  scmOptionsLoad;
  // update the visibility of the accessory item in the ListViewLane
  // safe - doesn't require connection.
  scmUpdateNomination(fEnableNomination);
  // update the images to use in each tabsheet
  scmUpdateTabSheetsImages;
  // Update the visibility of closed sessions in qrySession
  // by modifying it's param HIDECLOSED.
  // This uses value fHideClosedSessions and is best done after a fresh
  // read of the scmConfig.ini values.
  scmUpdateHideClosedSessions;
  // TIDY ALL TLISTVIEW DISPLAYS - (fixes TViewListLane)
  // on startup SCM will be set to disconnected.
  if Assigned(SCM) then
    SCM.DeActivateTable;

  // Hide controls used by entrant details
  scmRefreshEntrant_Detail;
  // Hide big buttons.
  scmRefreshBigButtons;

end;

procedure TMarshall.FormDestroy(Sender: TObject);
begin
  // IF DATA-MODULE EXISTS ... break the current connection.
  if Assigned(SCM) then
  begin
    SCM.DeActivateTable;
    SCM.scmConnection.Connected := false;
  end;
  // CLEAN MEMORY
  SCM.Free;
end;

procedure TMarshall.GetSCMVerInfo;
{$IF defined(MSWINDOWS)}
var
  myExeInfo: TExeInfo;
{$ENDIF}
begin
  // if connected - display the application version
  // and the SwimClubMeet database version.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      Label4.Text := 'DB v' + SCM.GetDBVerInfo
    else
      Label4.Text := '';

{$IF defined(MSWINDOWS)}
  // get the application version number
  myExeInfo := TExeInfo.Create(self);
  Label4.Text := 'App v' + myExeInfo.FileVersion + ' - ' +
    Label4.Text;
  myExeInfo.Free;

{$ENDIF}
end;

procedure TMarshall.ImageQualifyClick(Sender: TObject);
begin
  scmSetBigButtonsEffect(TImage(Sender).Tag)
end;

procedure TMarshall.imgStopWatchClick(Sender: TObject);
var
  dlg: TscmStopWatch;
begin
{$IFNDEF ANDROID}
  dlg := TscmStopWatch.Create(self);
  dlg.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      // Do something.
      if (ModalResult = mrOk) then
      begin;
      end;
    end);

{$ELSE}
  { TODO : Create an android slidebar window for options? }
  // ANDROID platform doesn't do Modal Forms.
{$ENDIF}
  (*
    IMPORTANT NOTE DIALOGUE IS DESTROYED IN TscmStopWatch.FormClose
  *)
end;

procedure TMarshall.LinkPropertyToFieldText10AssignedValue(Sender: TObject;
AssignValueRec: TBindingAssignValueRec; const Value: TValue);
var
  v: string;
begin
  // if there is no entrant then lane number is blank
  // use the lane number given in qryLane
  v := Value.AsString;
  if (v.IsEmpty) then
  begin
    if (Assigned(SCM) and SCM.IsActive) then
      lblLaneNumber.Text := SCM.qryLane.FieldByName('LaneNum').AsString
    else
      lblEntrantsHeatNum.Text := '';
  end;
end;

procedure TMarshall.LinkPropertyToFieldText4AssignedValue(Sender: TObject;
AssignValueRec: TBindingAssignValueRec; const Value: TValue);
var
  v: string;
begin
  // If there are no heats ... the Value points to an empty string.
  // Assign a corrected caption above the ListView Entrants.
  // NOTE: Custom Binding Default is "Entrants.. " + %s
  v := Value.AsString;
  if (v.IsEmpty) then
    lblEntrantsHeatNum.Text := 'Entrants ...'
end;

procedure TMarshall.ListViewEventChange(Sender: TObject);
begin
  // clean the statusbar
  lblConnectionStatus.Text := '';
end;

procedure TMarshall.ListViewHeatChange(Sender: TObject);
begin
  if (SCM.qryHeat.FieldByName('HeatStatusID').AsInteger <> 1) then
    lblConnectionStatus.Text :=
      'INFO: The heat is raced or closed. Posting is disabled.'
  else
    lblConnectionStatus.Text := '';
  if SCM.qryLane.IsEmpty then
    ListViewLane.Items.Clear;
end;

procedure TMarshall.ListViewHeatDblClick(Sender: TObject);
begin
  // move to tabsheet 2 (LANE-ENTRANT)
  TabControl1.TabIndex := 2;
end;

procedure TMarshall.ListViewLaneChange(Sender: TObject);
begin
  // NOTE:
  // qryEntrant is parented to qryLane
  // qryEntrant will be empty if the qryLane.EntrantID is NULL
  scmRefreshEntrant_Detail;
  // Big Buttons are NOT DATA-AWARE : Update monochromatic effects.
  // NOTE: Big Buttons are made invisible if lane is EMPTY
  scmRefreshBigButtons;
  // ASSERT the button state for 'Post Qualify Status'
  actnQualifyUpdate(self);

  // clean the statusbar
  lblConnectionStatus.Text := '';
end;

procedure TMarshall.ListViewLaneItemClickEx(const Sender: TObject;
ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
var
  dlg: TscmNominate;
  MemberID: Integer;
begin
  // NOTE: The object must be visible to accept user input (click).
  // NOTE: The object will be visible if the lane is EMPTY.
  // Ignore this routine if nomination hasn't been enabled.
  if fEnableNomination then
  begin
{$IFNDEF ANDROID}
    // REQUIRES A CONNECTION
    if ItemObject is TListItemAccessory then
    begin
      if (Assigned(SCM) and SCM.IsActive) then
      begin
        // must be an empty lane
        if SCM.qryLane.Active then
        begin
          MemberID :=  SCM.qryLane.FieldByName('MemberID').AsInteger;
          if (MemberID = 0) then
          begin
            // Dialogue to select a member (who isn't an entrant in this event)
            dlg := TscmNominate.Create(self);
            dlg.EventID := SCM.qryLane.FieldByName('EventID').AsInteger;
            //dlg.HeatID := SCM.qryLane.FieldByName('HeatID').AsInteger;
            // NOTE: the LaneID can resolve both event and heat ...
            // dlg.LaneNum := SCM.qryLane.FieldByName('LaneNum').AsInteger;
            // open the SCM Nomination dialogue.
            dlg.ShowModal(
              procedure(dlgModalResult: TModalResult)
              begin
                if dlgModalResult = mrOk then
                begin
                  // Update the UI of the tabSheet.
                  scmRefreshLane;
                end;
              end);
          end;
        end;
      end;
    end;

{$ELSE}
    { TODO : Create an android popup window for options? }
    // ANDROID platform doesn't do Modal Forms.
{$ENDIF}
    (*
      IMPORTANT NOTE : DIALOGUE IS DESTROYED IN TscmNominate.OnClose
    *)
  end;

end;

procedure TMarshall.ListViewLaneUpdateObjects(const Sender: TObject;
const AItem: TListViewItem);
var
  obj: TListItemAccessory;
begin
  // obj := AItem.View.FindDrawable('Accessory') ;
  obj := AItem.Objects.AccessoryObject;
  if Assigned(obj) then
  begin
    if fEnableNomination then
      obj.Visible := true
    else
      obj.Visible := false;
  end;
end;

{$REGION 'MISC SCM Declarations' }

function TMarshall.scmGetBigButtonsEffect: Integer;
begin
  Result := 1;
  if (MonochromeEffect1.Enabled and MonochromeEffect3.Enabled) then Result := 2;
  if (MonochromeEffect1.Enabled and MonochromeEffect2.Enabled) then Result := 3;
end;

procedure TMarshall.scmOptionsLoad;
var
  ini: TIniFile;
  Section: String;
begin
  Section := 'MarshallOptions';
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    fEnableAutoReFresh := ini.ReadBool(Section, 'EnableAutoReFresh', false);
    fEnableNomination := ini.ReadBool(Section, 'EnableNomination', false);
    fHideClosedSessions := ini.ReadBool(Section, 'HideClosedSessions', true);
  finally
    ini.Free;
  end;

end;

procedure TMarshall.scmPostQualify(AQualifyStatus: Integer);
var
  SQL: string;
  EntrantID: Integer;
begin
  if Assigned(SCM) and SCM.IsActive then
  begin
    // Note: only 'OPEN' heats can be modified ...
    if ((SCM.qryHeat.FieldByName('HeatStatusID').AsInteger = 1) and
      (SCM.qrySession.FieldByName('SessionStatusID').AsInteger = 1)) then
    begin
      // Are there ENTRANTS?
      if (not SCM.qryLane.FieldByName('EntrantID').IsNull) then
      begin
        // init PARAMS
        EntrantID := SCM.qryLane.FieldByName('EntrantID').AsInteger;
        // USER INPUT DATA
        case AQualifyStatus of
          1:
            begin
              SQL := 'USE [SwimClubMeet]; ' + 'SET NOCOUNT ON; ' +
                'UPDATE [dbo].[Entrant] ' +
                'SET [IsDisqualified] = 0 ,[IsScratched] = 0 ' +
                'WHERE EntrantID = ' + IntToStr(EntrantID) + '; ';
            end;
          2:
            begin
              SQL := 'USE [SwimClubMeet]; ' + 'SET NOCOUNT ON; ' +
                'UPDATE [dbo].[Entrant] ' +
                'SET [IsDisqualified] = 1 ,[IsScratched] = 0 ' +
                'WHERE EntrantID = ' + IntToStr(EntrantID) + '; ';
            end;
          3:
            begin
              SQL := 'USE [SwimClubMeet]; ' + 'SET NOCOUNT ON; ' +
                'UPDATE [dbo].[Entrant] ' +
                'SET [IsDisqualified] = 0 ,[IsScratched] = 1 ' +
                'WHERE EntrantID = ' + IntToStr(EntrantID) + '; ';
            end;
        end;

        try
          begin
            SCM.scmConnection.ExecSQL(SQL);
{$IFDEF MSWINDOWS}
            MessageBeep(MB_ICONINFORMATION);
{$ENDIF}
            lblConnectionStatus.Text := 'INFO: The Qualify Status was posted.';
          end
        except

          on E: Exception do
          begin
            // bad conversion
{$IFDEF MSWINDOWS}
            MessageBeep(MB_ICONERROR);
{$ENDIF}
            lblConnectionStatus.Text :=
              'Error: Unable to post to the SCM database!'
          end;
        end;
      end
      else
      begin
{$IFDEF MSWINDOWS}
        MessageBeep(MB_ICONERROR);
{$ENDIF}
        lblConnectionStatus.Text := 'Error: Entrant not found!'
      end;
    end
    else
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblConnectionStatus.Text := 'Error: Only OPEN heats can be modified!'
    end;
  end;
end;

procedure TMarshall.scmUpdateNomination(EnableNomination: Boolean);
begin
  // Toggle the display of the TListItemAccessory
  // Doesn't require connection.
  if EnableNomination then
    // ENABLED
    ListViewLane.ItemAppearanceObjects.ItemObjects.Accessory.Visible := true
  else
    // DISABLED (default)
    ListViewLane.ItemAppearanceObjects.ItemObjects.Accessory.Visible := false;
end;

procedure TMarshall.scmSetBigButtonsEffect(btnTag: Integer);
begin
  case btnTag of
    1: // Qualified
      begin
        MonochromeEffect1.Enabled := false;
        MonochromeEffect2.Enabled := true;
        MonochromeEffect3.Enabled := true;
      end;
    2: // Disqualified
      begin
        MonochromeEffect1.Enabled := true;
        MonochromeEffect2.Enabled := false;
        MonochromeEffect3.Enabled := true;

      end;
    3: // Scratched
      begin
        MonochromeEffect1.Enabled := true;
        MonochromeEffect2.Enabled := true;
        MonochromeEffect3.Enabled := false;
      end;
  end;
end;

procedure TMarshall.scmUpdateHideClosedSessions;
begin
  if Assigned(SCM) and SCM.qrySession.Active then
  begin
    SCM.qrySession.DisableControls;
    // remove all the strings held in the combobox
    // note cmbSessionList.Clear doesn't work here.
    cmbSessionList.Items.Clear;
    SCM.qrySession.Close;
    // ASSIGN PARAM to display or hide CLOSED sessions
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean := fHideClosedSessions;
    SCM.qrySession.Prepare;
    SCM.qrySession.Open;
    SCM.qrySession.EnableControls
  end
  // the datamodule exists but qrySession isn't connected..
  else if (Assigned(SCM)) then
  begin
    // qrySession ISN'T ACTIVE ....
    // update state of qryLane PARAM
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean := fHideClosedSessions;
  end;

end;

procedure TMarshall.scmUpdateTabSheetsImages;
begin
  // Update image indicators in the tabsheets.
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    if (fEnableNomination) then
    begin
      if (fEnableNomination) then
        // small red pin on tabsheet
        tabEntrantRaceTime.ImageIndex := 1
      else
        // small white pin on tabsheet
        tabEntrantRaceTime.ImageIndex := 0
    end;

    if (fHideClosedSessions) then
      tabLoginSession.ImageIndex := 3
    else
      tabLoginSession.ImageIndex := 2;

    if (fEnableAutoReFresh) then
      tabEventHeat.ImageIndex := 4
    else
      tabEventHeat.ImageIndex := -1;
  end
  // Not connect - hide all
  else
  begin
    tabEntrantRaceTime.ImageIndex := -1;
    tabLoginSession.ImageIndex := -1;
    tabEventHeat.ImageIndex := -1;
  end;
end;

{$ENDREGION}

{$REGION 'SCM REFRESH ROUTINES (x3).' }

// Calling scmRefreshLane will refresh entrant details and big buttons.
procedure TMarshall.scmRefreshLane;
var
  LaneNum: Integer;
begin
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    SCM.qryEntrant.DisableControls;
    SCM.qryLane.DisableControls;
    if (not SCM.qryHeat.IsEmpty) then
    begin
      // store the current selected lane
      LaneNum := SCM.qryLane.FieldByName('LaneNum').AsInteger;
      // Re-constructs qryLane data
      SCM.qryHeatAfterScroll(SCM.qryHeat);
      SCM.LocateLaneNum(LaneNum);
    end
    else
    begin
      // Clear the list
      ListViewLane.Items.Clear;
    end;
    SCM.qryLane.EnableControls;
    SCM.qryEntrant.EnableControls;
  end;
  // NOTE: qryEntrant is parented to qryLane but need re-painting.
  scmRefreshEntrant_Detail;
  // Big Buttons ISN'T DATA-AWARE ...
  scmRefreshBigButtons;
end;

procedure TMarshall.scmRefreshEntrant_Detail;
var
  EntrantID, HeatID: Integer;
begin
  // Tidy up interface. No connection - selected entrant controls are hidden.
  // Controls are hidden/revealed by design stack order else layout changes.
  //
  layPostQualifyStatus.Visible := false;
  layQualifyStatus.Visible := false;
  layStoredRaceTime.Visible := false;
  layPersonalBest.Visible := false;
  layTimeToBeat.Visible := false;
  layEntrantName.Visible := false;
  layLane.Visible := false;
  layHeatNumber.Visible := false;
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    SCM.qryEntrant.DisableControls;
    // SAFE: if dataset is empty or no swimmer assigned, EntrantID will equal zero.
    EntrantID := SCM.qryLane.FieldByName('EntrantID').AsInteger;
    HeatID := SCM.qryLane.FieldByName('HeatID').AsInteger;
    // Any heats for this event?
    if (not SCM.qryHeat.IsEmpty) then
    begin
      // Is there a swimmer assigned to the lane?
      if not(SCM.qryLane.FieldByName('EntrantID').IsNull) then
      begin
        // SWIMMER IN LANE - SHOW ALL ENTRANT DETAILS
        layHeatNumber.Visible := true;
        layLane.Visible := true;
        layEntrantName.Visible := true;
        layTimeToBeat.Visible := true;
        layPersonalBest.Visible := true;
        layStoredRaceTime.Visible := true;
        layQualifyStatus.Visible := true;
        layPostQualifyStatus.Visible := true;
      end
      else
      begin
        // SHOW HEAT AND LANE
        // Selected controls remain hidden.
        layHeatNumber.Visible := true;
        layLane.Visible := true;
      end;
    end;
    // Note: The Refresh method does not work for all TDataSet descendants.
    // In particular, TQuery components do not support the Refresh method if
    // the query is not "live".
    // To refresh a static TQuery, close and reopen the dataset.
    //
    // Each time qryLane is closed, then re-assigned parameters, prepared
    // and finally reopened ... FlagLane is set true.
    // This ONLY occurs at ...
    // procedure TSCM.qryHeatAfterScroll(DataSet: TDataSet);
    //
    // NOTE: This flag was created to OPTIMIZE listview updates.
    // (closing and re-opening qryEntrant is a little slow).
    if SCM.FlagLane then
    begin
      // qryLane was trashed :: full requery required
      SCM.qryEntrant.Close;
      SCM.qryEntrant.Open;
      // reset the flag
      SCM.FlagLane := false;
    end;
    // SAFE: ZERO values.
    SCM.LocateEntrantID(EntrantID, HeatID);
    SCM.qryEntrant.EnableControls;
  end;
end;

procedure TMarshall.scmRefreshBigButtons;
var
  EntrantID, HeatID: Integer;
  QualifyStatus: Integer;
begin
  // hide all the buttons
  Image3.Visible := false;
  Image2.Visible := false;
  Image1.Visible := false;
  // must be connected ...
  QualifyStatus := 1;
  // SAFE - set to default state.
  scmSetBigButtonsEffect(QualifyStatus);
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    begin
      // empty dataset
      if not SCM.qryLane.IsEmpty then
      begin
        // Is there a swimmer assigned to the lane?
        if not(SCM.qryLane.FieldByName('EntrantID').IsNull) then
        begin
          EntrantID := SCM.qryLane.FieldByName('EntrantID').AsInteger;
          HeatID := SCM.qryLane.FieldByName('HeatID').AsInteger;
          // DEFAULT = 1 (is qualified)
          QualifyStatus := SCM.GetQualifyState(EntrantID, HeatID);
          // toggle the monchrome effects filter to indicate 'Qualification Status'
          scmSetBigButtonsEffect(QualifyStatus);
          Image1.Visible := true;
          Image2.Visible := true;
          Image3.Visible := true;
        end;
      end;
    end
  end;
end;

{$ENDREGION}

procedure TMarshall.TabControl1Change(Sender: TObject);
begin
  case TabControl1.TabIndex of
    0:
      lblConnectionStatus.Text := '';
    1:
      // each time EVENT..HEAT tabsheet is selected ... refresh data
      if (fEnableAutoReFresh) then
        actnRefreshExecute(self);
    2:
      begin
        lblConnectionStatus.Text := '';
        scmRefreshLane;
        // Big buttons are NOT DATA-AWARE. Refresh 'QUALIFICATION STATUS'
        scmRefreshBigButtons;
      end;
  end;
end;

procedure TMarshall.Timer1Timer(Sender: TObject);
begin
  fConnectionCountdown := fConnectionCountdown - 1;
  lblAniIndicatorStatus.Text := 'Connecting ' + IntToStr(fConnectionCountdown);
end;

end.
