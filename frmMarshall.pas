unit frmMarshall;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Rtti,
  System.Bindings.Outputs,
  System.ImageList,
  System.Actions,
  System.Character,
  System.IOUtils,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.Bind.DBEngExt,
  FMX.Bind.Editors,
  FMX.ImgList,
  FMX.ActnList,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.ListView,
  FMX.ListBox,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Media,

  XSuperJSON,
  XSuperObject,

  Data.DB,
  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  FireDAC.Stan.Param,

  dmSCM,
  ProgramSetting;

type

  TDefaultFont = class(TInterfacedObject, IFMXSystemFontService)
  public
    function GetDefaultFontFamilyName: string;
    function GetDefaultFontSize: Single;
  end;

  TMarshall = class(TForm)
    ActionList1: TActionList;
    actnConnect: TAction;
    actnDisconnect: TAction;
    actnQualify: TAction;
    actnRefresh: TAction;
    actnSCMOptions: TAction;
    AniIndicator1: TAniIndicator;
    bsEntrant: TBindSourceDB;
    bsLane: TBindSourceDB;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnRefresh: TButton;
    btnRTN: TButton;
    chkbUseOSAuthentication: TCheckBox;
    cmbSessionList: TComboBox;
    edtPassword: TEdit;
    edtServerName: TEdit;
    edtUser: TEdit;
    FlowLayout1: TFlowLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    layConnectButtons: TLayout;
    layEntrantList: TLayout;
    layEntrantName: TLayout;
    layEntrantRaceTime: TLayout;
    layEventHeat: TLayout;
    layEventHeatTitleBar: TLayout;
    layFooter: TLayout;
    layHeatNumber: TLayout;
    layLoginToServer: TLayout;
    Layout1: TLayout;
    layPersonalBest: TLayout;
    layPostQualifyStatus: TLayout;
    layQualifyStatus: TLayout;
    layRaceTime: TLayout;
    layRaceTimeDetail: TLayout;
    layRaceTimeText: TLayout;
    laySelectSession: TLayout;
    layStoredRaceTime: TLayout;
    layTabs: TLayout;
    layTimeToBeat: TLayout;
    lblAniIndicatorStatus: TLabel;
    lblConnectionStatus: TLabel;
    lblEntrantName: TLabel;
    lblEventTitle: TLabel;
    lblHeatTitle: TLabel;
    lblPersonalBest: TLabel;
    lblQualifyStatus: TLabel;
    lblRaceTime: TLabel;
    lblSelectSession: TLabel;
    lblSwimClubTitle: TLabel;
    lblTimeToBeat: TLabel;
    ListViewEvent: TListView;
    ListViewHeat: TListView;
    ListViewLane: TListView;
    MonochromeEffect1: TMonochromeEffect;
    MonochromeEffect2: TMonochromeEffect;
    MonochromeEffect3: TMonochromeEffect;
    ScaledLayout1: TScaledLayout;
    SizeGrip1: TSizeGrip;
    TabControl1: TTabControl;
    tabEntrantRaceTime: TTabItem;
    tabEventHeat: TTabItem;
    tabLoginSession: TTabItem;
    Timer1: TTimer;
    txt03: TLabel;
    bindlist: TBindingsList;
    bsSwimClub: TBindSourceDB;
    bsSession: TBindSourceDB;
    bsEvent: TBindSourceDB;
    bsHeat: TBindSourceDB;
    LinkListControlToField5: TLinkListControlToField;
    LinkPropertyToFieldText11: TLinkPropertyToField;
    LinkListControlToField6: TLinkListControlToField;
    LinkListControlToField7: TLinkListControlToField;
    LinkListControlToField8: TLinkListControlToField;
    chkbHideClosedSessions: TCheckBox;
    LinkPropertyToFieldFNameStr: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    StyleBook2: TStyleBook;
    chkbUseFINAcodes: TCheckBox;
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnQualifyExecute(Sender: TObject);
    procedure actnQualifyUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure actnSCMOptionsUpdate(Sender: TObject);
    procedure cmbSessionListChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImageQualifyClick(Sender: TObject);
    procedure imgStopWatchClick(Sender: TObject);
    procedure ListViewEventChange(Sender: TObject);
    procedure ListViewHeatChange(Sender: TObject);
    procedure ListViewLaneChange(Sender: TObject);
    procedure ListViewLaneItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure TabControl1Change(Sender: TObject);
    procedure tabEntrantRaceTimeClick(Sender: TObject);
    procedure tabEventHeatClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private

    fConnectionCountdown: Integer;
    // Can only be assigned to scmConnection if not connected.
    fLoginTimeOut: Integer;

    procedure ConnectOnTerminate(Sender: TObject);
    procedure GetSCMVerInfo();
    procedure scmPostQualify(AQualifyStatus: Integer);
    procedure scmSetBigButtonsEffect(btnTag: Integer);
    function scmGetBigButtonsEffect: Integer;
    procedure TabOrListChangeTextUpdate;

    // Universal platform - Program Settings
    procedure LoadFromSettings;
    procedure LoadSettings;
    procedure SaveToSettings;

  public
    { Public declarations }
    procedure scmRefreshBigButtons;
    procedure scmRefreshEntrant_Detail;
    procedure scmRefreshLane;
    procedure scmUpdateHideClosedSessions;

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
  // dlgSCMStopWatch,
  // FOR scmLoadOptions
  System.IniFiles,
  // FOR Floor
  System.Math,
  // dlgSCMNominate,
  exeinfo,
  SCMSimpleConnect,
  SCMUtility;

{$REGION 'ACTION MANAGER'}

procedure TMarshall.actnConnectExecute(Sender: TObject);
var
  Thread: TThread;
  sc: TSimpleConnect;
begin
  if (Assigned(SCM) and (SCM.scmConnection.Connected = false)) then
  begin
    lblAniIndicatorStatus.Text := 'Connecting';
    fConnectionCountdown := fLoginTimeOut;
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
        // can only be assigned if not connected
        SCM.scmConnection.Params.Values['LoginTimeOut'] := IntToStr(fLoginTimeOut);

        sc := TSimpleConnect.CreateWithConnection(Self, SCM.scmConnection);
        sc.DBName := 'SwimClubMeet'; // DEFAULT
        sc.SimpleMakeTemporyConnection(edtServerName.Text, edtUser.Text,
          edtPassword.Text, chkbUseOSAuthentication.IsChecked);
        Timer1.Enabled := false;
        lblAniIndicatorStatus.Visible := false;
        AniIndicator1.Enabled := false;
        AniIndicator1.Visible := false;
        btnConnect.Enabled := true;
        sc.Free
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
  AniIndicator1.Visible := false;
  lblAniIndicatorStatus.Visible := false;
  AniIndicator1.Enabled := false;
  SaveToSettings;
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

procedure TMarshall.actnSCMOptionsUpdate(Sender: TObject);
begin

end;

{$ENDREGION}

procedure TMarshall.cmbSessionListChange(Sender: TObject);
begin
  TabOrListChangeTextUpdate;
end;

procedure TMarshall.ConnectOnTerminate(Sender: TObject);
begin
  if TThread(Sender).FatalException <> nil then
  begin
    // something went wrong
    // Exit;
  end;

  // Make tables active
  if (SCM.scmConnection.Connected) then
  begin
    SCM.ActivateTable;
    // ALL TABLES SUCCESSFULLY MADE ACTIVE ...
    if SCM.IsActive then
      // TODO: FIRST TIME INIT
      scmRefreshLane;
  end;

  TabOrListChangeTextUpdate;
  // Label showing application and database version
  GetSCMVerInfo;
  // connection buttons visibility state updated.
  actnConnect.Update;
  actnDisconnect.Update;

  // VERY SICK OF BIND COMPONETS BREAKING!
  if Assigned(SCM) and SCM.IsActive then
  begin
    if not Assigned(bsSwimClub.DataSet) then
      bsSwimClub.DataSet := SCM.tblSwimClub;
    if not Assigned(bsSession.DataSet) then
      bsSession.DataSet := SCM.qrySession;
    if not Assigned(bsEvent.DataSet) then
      bsEvent.DataSet := SCM.qryEvent;
    if not Assigned(bsHeat.DataSet) then
      bsHeat.DataSet := SCM.qryHeat;
    if not Assigned(bsEntrant.DataSet) then
      bsEntrant.DataSet := SCM.qryEntrant;
    if not Assigned(bsLane.DataSet) then
      bsLane.DataSet := SCM.qryLane;
  end;

  // Update the visibility of closed sessions in qrySession
  // by modifying it's param HIDECLOSED.
  // This uses value fHideClosedSessions and is best done after a fresh
  // read of JSON values.
  scmUpdateHideClosedSessions;

  // Show status of connection
  if (Assigned(SCM) and SCM.scmConnection.Connected) then
      lblConnectionStatus.Text := 'Connected to SwimClubMeet.'
  else
    lblConnectionStatus.Text :=
      'A connection couldn''t be made. (Check you input values.)';
end;

procedure TMarshall.FormCreate(Sender: TObject);
begin
  // Initialization of params.
  application.ShowHint := true;
  AniIndicator1.Visible := false;
  AniIndicator1.Enabled := false;
  btnDisconnect.Visible := false;
  Timer1.Enabled := false;
  lblAniIndicatorStatus.Visible := false;
  cmbSessionList.Items.Clear;
  chkbHideClosedSessions.IsChecked := true;
  fLoginTimeOut := CONNECTIONTIMEOUT;

  if Settings = nil then
    Settings := TPrgSetting.Create;

  // clean-up the top bar captions
  // lblSwimClubTitle.Text := String.Empty;
  // lblSessionTitle.Text := String.Empty;
  // lblSelectedEvent.Text := String.Empty;
  // lblSelectedEntrant.Text := String.Empty;

  // C R E A T E   T H E   D A T A M O D U L E .
  if NOT Assigned(SCM) then
    SCM := TSCM.Create(Self);
  if SCM.scmConnection.Connected then
    SCM.scmConnection.Connected := false;

  // P O P U L A T E   T H E   C O N N E C T I O N   C O N T R O L S .
  // JSON connection settings. Windows location :
  // %SYSTEMDRIVE\%%USER%\%USERNAME%\AppData\Roaming\Artanemus\SwimClubMeet
  LoadSettings;
  fConnectionCountdown := fLoginTimeOut;

  // Connection status - located in footer bar.
  lblConnectionStatus.Text := '';

  // Login-Session
  TabControl1.TabIndex := 0;

  // Hide controls used by entrant details
  scmRefreshEntrant_Detail;
  // Hide big buttons.
  scmRefreshBigButtons;

  actnConnect.Visible := true;
  actnDisconnect.Visible := false;

end;

procedure TMarshall.FormDestroy(Sender: TObject);
begin
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected then
    begin
      SaveToSettings;
      SCM.scmConnection.Connected := false;
    end;
   SCM.Free;
  end;

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
  myExeInfo := TExeInfo.Create(Self);
  Label4.Text := 'App v' + myExeInfo.FileVersion + ' - ' + Label4.Text;
  myExeInfo.Free;

{$ENDIF}
end;

procedure TMarshall.ImageQualifyClick(Sender: TObject);
begin
  scmSetBigButtonsEffect(TImage(Sender).Tag)
end;

procedure TMarshall.imgStopWatchClick(Sender: TObject);
// var
// dlg: TscmStopWatch;
begin
{$IFNDEF ANDROID}
  // dlg := TscmStopWatch.Create(Self);
  // dlg.ShowModal(
  // procedure(ModalResult: TModalResult)
  // begin
  // if (ModalResult = mrOk) then
  // begin;
  // end;
  // end);

{$ELSE}
  { TODO : Create an android slidebar window for options? }
  // ANDROID platform doesn't do Modal Forms.
{$ENDIF}
  (*
    IMPORTANT NOTE DIALOGUE IS DESTROYED IN TscmStopWatch.FormClose
  *)
end;

procedure TMarshall.ListViewEventChange(Sender: TObject);
begin
  TabOrListChangeTextUpdate;
end;

procedure TMarshall.ListViewHeatChange(Sender: TObject);
begin
  TabOrListChangeTextUpdate;
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
  actnQualifyUpdate(Self);

  TabOrListChangeTextUpdate;

end;

procedure TMarshall.ListViewLaneItemClickEx(const Sender: TObject;
ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
// var
// dlg: TscmNominate;
// MemberID: Integer;
begin
  // NOTE: The object must be visible to accept user input (click).
  // NOTE: The object will be visible if the lane is EMPTY.
  // Ignore this routine if nomination hasn't been enabled.
  // if fEnableNomination then
  // begin
{$IFNDEF ANDROID}
  // REQUIRES A CONNECTION
  // if ItemObject is TListItemAccessory then
  // begin
  // if (Assigned(SCM) and SCM.IsActive) then
  // begin
  // must be an empty lane
  // if SCM.qryLane.Active then
  // begin
  // MemberID := SCM.qryLane.FieldByName('MemberID').AsInteger;
  // if (MemberID = 0) then
  // begin
  // Dialogue to select a member (who isn't an entrant in this event)
  // dlg := TscmNominate.Create(Self);
  // dlg.EventID := SCM.qryLane.FieldByName('EventID').AsInteger;
  // dlg.HeatID := SCM.qryLane.FieldByName('HeatID').AsInteger;
  // NOTE: the LaneID can resolve both event and heat ...
  // dlg.LaneNum := SCM.qryLane.FieldByName('LaneNum').AsInteger;
  // open the SCM Nomination dialogue.
  // dlg.ShowModal(
  // procedure(dlgModalResult: TModalResult)
  // begin
  // if dlgModalResult = mrOk then
  // begin
  // Update the UI of the tabSheet.
  // scmRefreshLane;
  // end;
  // end);
  // end;
  // end;
  // end;
  // end;

{$ELSE}
  { TODO : Create an android popup window for options? }
  // ANDROID platform doesn't do Modal Forms.
{$ENDIF}
  (*
    IMPORTANT NOTE : DIALOGUE IS DESTROYED IN TscmNominate.OnClose
  *)
  // end;

end;

procedure TMarshall.LoadSettings;
begin
  if Settings = nil then
    Settings := TPrgSetting.Create;

  if not FileExists(Settings.GetDefaultSettingsFilename()) then
  begin
    ForceDirectories(Settings.GetSettingsFolder());
    Settings.SaveToFile();
  end;

  Settings.LoadFromFile();
  LoadFromSettings();
end;

// load UI components from settings
procedure TMarshall.LoadFromSettings();
begin
  edtServerName.Text := Settings.Server;
  edtUser.Text := Settings.User;
  edtPassword.Text := Settings.Password;
  chkbUseOSAuthentication.IsChecked := Settings.OSAuthent;
  chkbHideClosedSessions.IsChecked := Settings.MarshallHideClosedSessions;
  chkbUseFINAcodes.IsChecked := Settings.UseFINAcodes;
  fLoginTimeOut := Settings.LoginTimeOut;
end;

// Save UI components state to settings
procedure TMarshall.SaveToSettings();
begin
  Settings.Server := edtServerName.Text;
  Settings.User := edtUser.Text;
  Settings.Password := edtPassword.Text;
  if chkbUseOSAuthentication.IsChecked then
    Settings.OSAuthent := true
  else
    Settings.OSAuthent := false;
  Settings.MarshallHideClosedSessions := chkbHideClosedSessions.IsChecked;
  Settings.UseFINAcodes := chkbUseFINAcodes.IsChecked;
  Settings.LoginTimeOut := fLoginTimeOut;
  Settings.SaveToFile;
end;

procedure TMarshall.TabControl1Change(Sender: TObject);
begin
  case TabControl1.TabIndex of
    0:
      lblConnectionStatus.Text := '';
    2:
      begin
        lblConnectionStatus.Text := '';
        scmRefreshLane;
        // Big buttons are NOT DATA-AWARE. Refresh 'QUALIFICATION STATUS'
        scmRefreshBigButtons;
      end;
  end;
end;

procedure TMarshall.TabOrListChangeTextUpdate;
begin
  if Assigned(SCM) and SCM.scmConnection.Connected then
  begin
    // T A B   S H E E T  C A P T I O N .
    // E V E N T   . .   H E A T .
    if bsEvent.DataSet.IsEmpty then
      tabEventHeat.Text := 'Empty'
    else
      tabEventHeat.Text := 'Event ' + bsEvent.DataSet.FieldByName
        ('EventNum').AsString;

    tabEventHeat.Text := tabEventHeat.Text + ' .. ';

    if not bsHeat.DataSet.IsEmpty and not bsHeat.DataSet.FieldByName('HeatNum').IsNull
    then
      tabEventHeat.Text := tabEventHeat.Text + 'Heat ' +
        bsHeat.DataSet.FieldByName('HeatNum').AsString;

    // L A N E   . .   E N T R A N T .
    if bsLane.DataSet.IsEmpty then
      tabEntrantRaceTime.Text := 'Empty'
    else
      tabEntrantRaceTime.Text := 'Lane ' + bsLane.DataSet.FieldByName
        ('LaneNum').AsString;

    tabEntrantRaceTime.Text := tabEntrantRaceTime.Text + ' .. ';

    if not bsEntrant.DataSet.IsEmpty and not bsEntrant.DataSet.FieldByName
      ('LastNameStr').IsNull then
      tabEntrantRaceTime.Text := tabEntrantRaceTime.Text +
        bsEntrant.DataSet.FieldByName('LastNameStr').AsString;

    // S T A T U S   L I N E .
    if (bsHeat.DataSet.FieldByName('HeatStatusID').AsInteger <> 1) then
      lblConnectionStatus.Text := 'INFO: The heat is raced or closed.'
    else
      // E V E N T   D E S C R I P T I O  N  .
      // Distance Stroke, NOM and ENT count ....
      lblConnectionStatus.Text := bsEvent.DataSet.FieldByName
        ('ListDetailStr').AsString;
  end
  else
  begin
    lblConnectionStatus.Text := '';
    tabEventHeat.Text := 'Event-Heat';
    tabEntrantRaceTime.Text := 'Lane-Entrant';
  end;
end;

procedure TMarshall.Timer1Timer(Sender: TObject);
begin
  fConnectionCountdown := fConnectionCountdown - 1;
  lblAniIndicatorStatus.Text := 'Connecting ' + IntToStr(fConnectionCountdown);
end;

{$REGION 'MISC SCM Declarations' }

function TMarshall.scmGetBigButtonsEffect: Integer;
begin
  Result := 1;
  if (MonochromeEffect1.Enabled and MonochromeEffect3.Enabled) then
    Result := 2;
  if (MonochromeEffect1.Enabled and MonochromeEffect2.Enabled) then
    Result := 3;
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
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean :=
      chkbHideClosedSessions.IsChecked;
    SCM.qrySession.Prepare;
    SCM.qrySession.Open;
    SCM.qrySession.EnableControls
  end
  // the datamodule exists but qrySession isn't connected..
  else if (Assigned(SCM)) then
  begin
    // qrySession ISN'T ACTIVE ....
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

procedure TMarshall.tabEntrantRaceTimeClick(Sender: TObject);
begin
  TabOrListChangeTextUpdate;
end;

procedure TMarshall.tabEventHeatClick(Sender: TObject);
begin
  TabOrListChangeTextUpdate;
end;

{$ENDREGION}
{ TDefaultFont }

function TDefaultFont.GetDefaultFontFamilyName: string;
begin
  Result := 'Tahoma';
end;

function TDefaultFont.GetDefaultFontSize: Single;
begin
  Result := 16.0; // Set the default font size here
end;

initialization

TFont.FontService := TDefaultFont.Create;

end.
