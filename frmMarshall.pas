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
  ProgramSetting, FMX.ExtCtrls;

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
    bindlist: TBindingsList;
    bsEntrant: TBindSourceDB;
    bsEvent: TBindSourceDB;
    bsHeat: TBindSourceDB;
    bsLane: TBindSourceDB;
    bsSession: TBindSourceDB;
    bsSwimClub: TBindSourceDB;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnPost: TButton;
    btnRefresh: TButton;
    chkbSessionVisibility: TCheckBox;
    chkbUseFINAcodes: TCheckBox;
    chkbUseOSAuthentication: TCheckBox;
    cmbSessionList: TComboBox;
    edtFINAcodes: TEdit;
    edtPassword: TEdit;
    edtServerName: TEdit;
    edtUser: TEdit;
    FlowLayout1: TFlowLayout;
    ImageViewer1: TImageViewer;
    imgBigD: TImage;
    imgBigS: TImage;
    imgBigTick: TImage;
    layConnectButtons: TLayout;
    layEntrantList: TLayout;
    layEntrantName: TLayout;
    layEventHeat: TLayout;
    layEventHeatTitleBar: TLayout;
    layFINAcode: TLayout;
    layFooter: TLayout;
    layHeatNumber: TLayout;
    layLaneEntrant: TLayout;
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
    lblFC: TLabel;
    lblFINAcode: TLabel;
    lblHeatTitle: TLabel;
    lblLoginToServer: TLabel;
    lblPassword: TLabel;
    lblPB: TLabel;
    lblPersonalBest: TLabel;
    lblQS: TLabel;
    lblQualifyStatus: TLabel;
    lblRaceTime: TLabel;
    lblRT: TLabel;
    lblSelectSession: TLabel;
    lblServer: TLabel;
    lblTimeToBeat: TLabel;
    lblTTB: TLabel;
    lblUserName: TLabel;
    LinkListControlToField5: TLinkListControlToField;
    LinkListControlToField6: TLinkListControlToField;
    LinkListControlToField7: TLinkListControlToField;
    LinkListControlToField8: TLinkListControlToField;
    LinkPropertyToFieldFNameStr: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    ListViewEvent: TListView;
    ListViewHeat: TListView;
    ListViewLane: TListView;
    MonochromeEffect1: TMonochromeEffect;
    MonochromeEffect2: TMonochromeEffect;
    MonochromeEffect3: TMonochromeEffect;
    ScaledLayout1: TScaledLayout;
    SizeGrip1: TSizeGrip;
    StyleBook2: TStyleBook;
    TabControl1: TTabControl;
    tabEventHeat: TTabItem;
    tabFINAcodes: TTabItem;
    tabLaneEntrant: TTabItem;
    tabLoginSession: TTabItem;
    Timer1: TTimer;
    imgListMain: TImageList;
    bsQualifyState: TBindSourceDB;
    LinkPropertyToFieldText: TLinkPropertyToField;
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnQualifyExecute(Sender: TObject);
    procedure actnQualifyUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure chkbSessionVisibilityChange(Sender: TObject);
    procedure chkbUseFINAcodesChange(Sender: TObject);
    procedure cmbSessionListChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BigButtonClick(Sender: TObject);
    procedure ListViewEventChange(Sender: TObject);
    procedure ListViewHeatChange(Sender: TObject);
    procedure ListViewLaneChange(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure tabEntrantRaceTimeClick(Sender: TObject);
    procedure tabEventHeatClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    fConnectionCountdown: Integer;
    // Can only be assigned to scmConnection if not connected.
    fLoginTimeOut: Integer;
    procedure ConnectOnTerminate(Sender: TObject);
    function GetBigButtonsEffect: Integer;
    function GetSCMVerInfo(): string;
    // Universal platform - Program Settings
    procedure LoadFromSettings;
    procedure LoadSettings;
    procedure PostFINAcode(AbreviationStr: string);
    procedure PostSimplifiied(AQualifyStatus: Integer);
    procedure SaveToSettings;
    procedure SetBigButtonsEffect(btnTag: Integer);
    procedure Update_TabSheetCaptions;
    procedure Update_Layout;
    procedure Update_SessionsVisible;
  public
    { Public declarations }
    procedure Refresh_BigButtons;
    procedure Refresh_Entrant;
    procedure Refresh_Lane;
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
  if (Assigned(SCM) ) then
  begin
    if  SCM.scmConnection.Connected then
      SCM.scmConnection.Connected := false;

    lblAniIndicatorStatus.Text := 'Connecting';
    fConnectionCountdown := fLoginTimeOut;
    AniIndicator1.Visible := true; // progress timer
    AniIndicator1.Enabled := true; // start spinning
    lblAniIndicatorStatus.Visible := true; // a label with countdown
    // lock this button - so user won't start another thread!
    actnConnect.Enabled := false;
    Timer1.Enabled := true; // start the countdown

    application.ProcessMessages;

    Thread := TThread.CreateAnonymousThread(
      procedure
      begin
        // can only be assigned if not connected
        SCM.scmConnection.Params.Values['LoginTimeOut'] :=
          IntToStr(fLoginTimeOut);

        sc := TSimpleConnect.CreateWithConnection(Self, SCM.scmConnection);
        sc.DBName := 'SwimClubMeet'; // DEFAULT
        sc.SimpleMakeTemporyConnection(edtServerName.Text, edtUser.Text,
          edtPassword.Text, chkbUseOSAuthentication.IsChecked);
        Timer1.Enabled := false;
        actnConnect.Enabled := true; // unlock button
        sc.Free;
      end);

    Thread.OnTerminate := ConnectOnTerminate;
    Thread.Start;
  end;

end;

procedure TMarshall.actnConnectUpdate(Sender: TObject);
begin
  // verbose code - stop unecessary repaints ...
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected and actnConnect.Visible  then
        actnConnect.Visible := false;
    if not SCM.scmConnection.Connected and not actnConnect.Visible then
      actnConnect.Visible := true;
  end
  else // D E F A U L T  I N I T  . Data module not created.
  begin
    if not actnConnect.Visible then
      actnConnect.Visible := true;
  end;
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
  SaveToSettings; // As this was a OK connection - store parameters.
  tabEventHeat.Text := 'Event-Heat';
  tabLaneEntrant.Text := 'Lane-Entrant';
  UpdateAction(actnDisconnect);
  UpdateAction(actnConnect);
  Update_Layout;
end;

procedure TMarshall.actnDisconnectUpdate(Sender: TObject);
begin
  // verbose code - stop unecessary repaints ...
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected and not actnDisconnect.Visible then
        actnDisconnect.Visible := true;
    if not SCM.scmConnection.Connected and actnDisconnect.Visible then
        actnDisconnect.Visible := false;
  end
  else // D E F A U L T  I N I T  . Data module not created.
  begin
    if actnDisconnect.Visible then
      actnDisconnect.Visible := false;
  end;
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
      if chkbUseFINAcodes.IsChecked then
        PostFINAcode(edtFINAcodes.Text)
      else
        PostSimplifiied(GetBigButtonsEffect);

    // Update the entrants details.
    // Get the server to ECHO the QUALIFIED STATUS.
    // ie. VISIBLE confirmation that it was POSTED.
    // append a '(Disqualified)' or '(Scratched)' to the
    // FName in the lane listview
    Refresh_Lane;
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
        btnPost.Enabled := true
      else
        btnPost.Enabled := false;
    end
    // session is locked or heat is raced or closed ...
    else
      btnPost.Enabled := false;
  end
  // database isn't connected
  else
    btnPost.Enabled := false;
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
    Refresh_Lane;
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

procedure TMarshall.chkbSessionVisibilityChange(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.scmConnection.Connected) then
    Update_SessionsVisible();
end;

procedure TMarshall.chkbUseFINAcodesChange(Sender: TObject);
begin
  // verbose to reduce repaints
  if TCheckBox(Sender).IsChecked then
  begin
    // display FINA controls
    if not tabFINAcodes.Visible then
      tabFINAcodes.Visible := true;
    if not layFINAcode.Visible then
      layFINAcode.Visible := true;
    if not edtFINAcodes.Visible then
      edtFINAcodes.Visible := true;
    // display FINA tab-sheet
    if not tabFINAcodes.Visible then
      tabFINAcodes.Visible := true;

    // hide simplified system
    if FlowLayout1.Visible then
      FlowLayout1.Visible := false;
    if layQualifyStatus.Visible then
      layQualifyStatus.Visible := false;

  end
  else
  begin
    // hide FINA controls
    if tabFINAcodes.Visible then
      tabFINAcodes.Visible := false;
    if layFINAcode.Visible then
      layFINAcode.Visible := false;
    if edtFINAcodes.Visible then
      edtFINAcodes.Visible := false;
    // hide FINA tab-sheet
    if tabFINAcodes.Visible then
      tabFINAcodes.Visible := true;

    // display simplified system
    if not FlowLayout1.Visible then
      FlowLayout1.Visible := true;
    if not layQualifyStatus.Visible then
      layQualifyStatus.Visible := true;
  end;

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

{$ENDREGION}

procedure TMarshall.cmbSessionListChange(Sender: TObject);
begin
  if Assigned(SCM) and SCM.scmConnection.Connected then
    Update_TabSheetCaptions;
end;

procedure TMarshall.ConnectOnTerminate(Sender: TObject);
begin

  lblAniIndicatorStatus.Visible := false;
  AniIndicator1.Enabled := false;
  AniIndicator1.Visible := false;

  if TThread(Sender).FatalException <> nil then
  begin
    // something went wrong
    // Exit;
  end;

  if not Assigned(SCM) then exit;

  // C O N N E C T E D  .
  if (SCM.scmConnection.Connected) then
  begin
    // Make tables active
    SCM.ActivateTable;
    // ALL TABLES SUCCESSFULLY MADE ACTIVE ...
    if SCM.IsActive then
    begin
      // Set the visibility of closed sessions.
      Update_SessionsVisible;
      // I N I T   L A N E   L I S T .
      Refresh_Lane;
    end;
    // STATUS BAR CAPTION.
    lblConnectionStatus.Text := 'Connected to SwimClubMeet. ';
    lblConnectionStatus.Text := lblConnectionStatus.Text + GetSCMVerInfo();
    lblConnectionStatus.Text := lblConnectionStatus.Text + sLineBreak +
      bsSwimClub.DataSet.FieldByName('Caption').AsString;
  end;

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

  if not SCM.scmConnection.Connected then
  begin
    // Attempt to connect failed.
    lblConnectionStatus.Text :=
      'A connection couldn''t be made. (Check you input values.)';
  end;

  // Disconnect button vivibility
  UpdateAction(actnDisconnect);
  // Connect button vivibility
  UpdateAction(actnConnect);
  // Display of layout panels (holding TListView grids).
  Update_Layout;

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
  chkbSessionVisibility.IsChecked := true;
  fLoginTimeOut := CONNECTIONTIMEOUT;
  fConnectionCountdown := fLoginTimeOut;
  chkbUseFINAcodes.IsChecked := false;
  tabFINAcodes.Visible := false;

  // A Class that uses JSON to read and write application configuration
  if Settings = nil then
    Settings := TPrgSetting.Create;

  // C R E A T E   T H E   D A T A M O D U L E .
  if NOT Assigned(SCM) then
    SCM := TSCM.Create(Self);
  if SCM.scmConnection.Connected then
    SCM.scmConnection.Connected := false;

  // READ APPLICATION   C O N F I G U R A T I O N   PARAMS.
  // JSON connection settings. Windows location :
  // %SYSTEMDRIVE\%%USER%\%USERNAME%\AppData\Roaming\Artanemus\SwimClubMeet
  LoadSettings;

  // TAB_SHEET : DEFAULT: Login-Session
  TabControl1.TabIndex := 0;

  // Prepare display of connection buttons
//  actnConnect.Visible := true;
//  actnDisconnect.Visible := false;

  // and lay-out panel visibility (when not connected).
  Update_Layout;

  // Set-up FINA or simplified mode.
  // via. Call to OnChange event handler
  // Layout visibility only - no DataModule activity.
  // Also sets the visibility of tab sheet tabFINAcodes.
  chkbUseFINAcodesChange(chkbUseFINAcodes);

  // Connection status - located in footer bar.
  lblConnectionStatus.Text := 'NOT CONNECTED';

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

function TMarshall.GetSCMVerInfo(): String;
{$IF defined(MSWINDOWS)}
var
  myExeInfo: TExeInfo;
{$ENDIF}
begin
  result := '';
  // if connected - display the application version
  // and the SwimClubMeet database version.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      result := 'DB v' + SCM.GetDBVerInfo;
{$IF defined(MSWINDOWS)}
  // get the application version number
  myExeInfo := TExeInfo.Create(Self);
  result := 'App v' + myExeInfo.FileVersion + ' - ' + result;
  myExeInfo.Free;
{$ENDIF}
end;

procedure TMarshall.BigButtonClick(Sender: TObject);
begin
  SetBigButtonsEffect(TImage(Sender).Tag)
end;

procedure TMarshall.ListViewEventChange(Sender: TObject);
begin
  Update_TabSheetCaptions;
end;

procedure TMarshall.ListViewHeatChange(Sender: TObject);
begin
  Update_TabSheetCaptions;
end;

procedure TMarshall.ListViewLaneChange(Sender: TObject);
begin
  // NOTE:
  // qryEntrant is parented to qryLane
  // qryEntrant will be empty if the qryLane.EntrantID is NULL
  Refresh_Entrant;
  // Big Buttons are NOT DATA-AWARE : Update monochromatic effects.
  // NOTE: Big Buttons are made invisible if lane is EMPTY
  Refresh_BigButtons;
  // ASSERT the button state for 'Post Qualify Status'
  actnQualifyUpdate(Self);

  Update_TabSheetCaptions;

end;

// load UI components from settings
procedure TMarshall.LoadFromSettings();
begin
  edtServerName.Text := Settings.Server;
  edtUser.Text := Settings.User;
  edtPassword.Text := Settings.Password;
  chkbUseOSAuthentication.IsChecked := Settings.OSAuthent;
  chkbSessionVisibility.IsChecked := Settings.MarshallHideClosedSessions;
  chkbUseFINAcodes.IsChecked := Settings.UseFINAcodes;
  fLoginTimeOut := Settings.LoginTimeOut;
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
  Settings.MarshallHideClosedSessions := chkbSessionVisibility.IsChecked;
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
        Refresh_Lane;
        // Big buttons are NOT DATA-AWARE. Refresh 'QUALIFICATION STATUS'
        Refresh_BigButtons;
      end;
  end;
end;

procedure TMarshall.Timer1Timer(Sender: TObject);
begin
  fConnectionCountdown := fConnectionCountdown - 1;
  lblAniIndicatorStatus.Text := 'Connecting ' + IntToStr(fConnectionCountdown);
end;

procedure TMarshall.Update_TabSheetCaptions;
begin
  if Assigned(SCM) and SCM.scmConnection.Connected then
  begin
    // T A B   S H E E T  C A P T I O N .
    // E V E N T   . .   H E A T .
    if bsEvent.DataSet.IsEmpty then
      tabEventHeat.Text := 'Empty'
    else
    begin
      tabEventHeat.Text := 'Event.' + bsEvent.DataSet.FieldByName
        ('EventNum').AsString;
      if not bsHeat.DataSet.IsEmpty then
        tabEventHeat.Text := tabEventHeat.Text + '-';
      if not bsHeat.DataSet.IsEmpty and not bsHeat.DataSet.FieldByName
        ('HeatNum').IsNull then
        tabEventHeat.Text := tabEventHeat.Text + 'Heat.' +
          bsHeat.DataSet.FieldByName('HeatNum').AsString;
    end;


    // L A N E   . .   E N T R A N T .
    {
      if bsLane.DataSet.IsEmpty then
      tabLaneEntrant.Text := 'Empty'
      else
      tabLaneEntrant.Text := 'Lane' + bsLane.DataSet.FieldByName
      ('LaneNum').AsString;

      if not bsEntrant.DataSet.IsEmpty and not bsEntrant.DataSet.FieldByName
      ('LastNameStr').IsNull then
      begin
      tabLaneEntrant.Text := tabLaneEntrant.Text + '-';
      tabLaneEntrant.Text := tabLaneEntrant.Text + bsEntrant.DataSet.FieldByName
      ('LastNameStr').AsString;
      end;
    }

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
    tabLaneEntrant.Text := 'Lane-Entrant';
  end;
end;

{$REGION 'MISC SCM Declarations' }

function TMarshall.GetBigButtonsEffect: Integer;
begin
  result := 1;
  if (MonochromeEffect1.Enabled and MonochromeEffect3.Enabled) then
    result := 2;
  if (MonochromeEffect1.Enabled and MonochromeEffect2.Enabled) then
    result := 3;
end;

procedure TMarshall.PostFINAcode(AbreviationStr: string);
var
  FoundIt: boolean;
  sl: TStringList;
  EntrantID, codeID: Integer;
begin
  if not Assigned(SCM) then
    exit;
  if not SCM.IsActive then
    exit;
  // Note: only 'OPEN' heats can be modified ...
  if not(SCM.qryHeat.FieldByName('HeatStatusID').AsInteger = 1) then
    exit;
  // Only unloced sessions can be modified ...
  if not(SCM.qrySession.FieldByName('SessionStatusID').AsInteger = 1) then
    exit;
  // check table is active
  if not SCM.tblDisqualifyCode.Active then
    SCM.tblDisqualifyCode.Open;
  If SCM.tblDisqualifyCode.Active then
  begin
    EntrantID := SCM.qryLane.FieldByName('EntrantID').AsInteger;
    // if the string is empty then 'QUALIFY ENTRANT'
    if AbreviationStr.IsNullOrWhiteSpace(AbreviationStr) THEN
    BEGIN
      sl := TStringList.Create;
      sl.Add('USE [SwimClubMeet];');
      sl.Add('SET NOCOUNT ON;');
      sl.Add('Update[dbo].[Entrant] SET');
      sl.Add(' [IsDisqualified] = 0');
      sl.Add(',[IsScratched] = 0');
      sl.Add(',[DisqualifyCodeID] = NULL ');
      sl.Add('WHERE EntrantID = ' + IntToStr(EntrantID));
      sl.Add(';');
      try
        try
          SCM.scmConnection.ExecSQL(sl.Text);
          lblConnectionStatus.Text := 'INFO: The Qualify Status was posted.';
        except
          on E: Exception do
          begin
            lblConnectionStatus.Text :=
              'Error: Unable to post to the SCM database!'
          end;
        end;
      finally
        sl.Free;
      end;
    END
    ELSE
    BEGIN
      // find the first match 'LIKE'
      FoundIt := SCM.LocateQualifyCode(AbreviationStr);
      codeID := SCM.tblDisqualifyCode.FieldByName('DisqualifyCodeID').AsInteger;
      if FoundIt then
      begin
        sl := TStringList.Create;
        sl.Add('USE [SwimClubMeet];');
        sl.Add('SET NOCOUNT ON;');
        sl.Add('Update[dbo].[Entrant] SET');
        sl.Add(' [IsDisqualified] = 1');
        sl.Add(',[IsScratched] = 0');
        sl.Add(',[DisqualifyCodeID] = ' + IntToStr(codeID));
        sl.Add('WHERE EntrantID = ' + IntToStr(EntrantID));
        sl.Add(';');
        try
          try
            SCM.scmConnection.ExecSQL(sl.Text);
            lblConnectionStatus.Text := 'INFO: The Qualify Status was posted.';
          except
            on E: Exception do
            begin
              lblConnectionStatus.Text :=
                'Error: Unable to post to the SCM database!'
            end;
          end;
        finally
          sl.Free;
        end;
      end
      else
        lblConnectionStatus.Text :=
          'Error: Unknown FINA code. Check entered text.'
    end;
  END
end;

procedure TMarshall.PostSimplifiied(AQualifyStatus: Integer);
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

procedure TMarshall.SetBigButtonsEffect(btnTag: Integer);
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

procedure TMarshall.Update_Layout;
begin
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected then
    begin
      // S H O W  the Event, Heat, Lane and Entrant lists
      if not layEventHeat.Visible then
        layEventHeat.Visible := true;
      if not layLaneEntrant.Visible then
        layLaneEntrant.Visible := true;
    end
    else
    begin
      // H I D E .
      if layEventHeat.Visible then
        layEventHeat.Visible := false;
      if layLaneEntrant.Visible then
        layLaneEntrant.Visible := false;
    end;
  end
  else
  begin
    // D E F A U L T   I N I T  - H I D E .
    if layEventHeat.Visible then
      layEventHeat.Visible := false;
    if layLaneEntrant.Visible then
      layLaneEntrant.Visible := false;
  end;
end;

procedure TMarshall.Update_SessionsVisible;
begin
  // remove all the strings held in the combobox
  // note cmbSessionList.Clear doesn't work here.
  cmbSessionList.Items.Clear;
  if Assigned(SCM) then
  begin
    SCM.qrySession.DisableControls;
    SCM.qrySession.Close;
    // ASSIGN PARAM to display or hide CLOSED sessions
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean :=
      chkbSessionVisibility.IsChecked;
    SCM.qrySession.Prepare;
    SCM.qrySession.Open;
    SCM.qrySession.EnableControls;
  end;

end;

{$ENDREGION}
{$REGION 'SCM REFRESH ROUTINES (x3).' }

// Calling scmRefreshLane will refresh entrant details and big buttons.
procedure TMarshall.Refresh_Lane;
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
  Refresh_Entrant;
  // Big Buttons ISN'T DATA-AWARE ...
  Refresh_BigButtons;
end;

procedure TMarshall.Refresh_Entrant;
var
  EntrantID, HeatID: Integer;
begin
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    SCM.qryEntrant.DisableControls;
    // SAFE: if dataset is empty or no swimmer assigned, EntrantID will equal zero.
    EntrantID := SCM.qryLane.FieldByName('EntrantID').AsInteger;
    HeatID := SCM.qryLane.FieldByName('HeatID').AsInteger;
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

procedure TMarshall.Refresh_BigButtons();
var
  EntrantID, HeatID: Integer;
  QualifyStatus: Integer;
begin
  // hide all the buttons
  imgBigS.Visible := false;
  imgBigD.Visible := false;
  imgBigTick.Visible := false;
  // must be connected ...
  QualifyStatus := 1;
  // SAFE - set to default state.
  SetBigButtonsEffect(QualifyStatus);
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

          if chkbUseFINAcodes.IsChecked then
          begin
            // Display codes..

          end
          else
          begin
            // toggle the monchrome effects filter to indicate 'Qualification Status'
            SetBigButtonsEffect(QualifyStatus);
            imgBigTick.Visible := true;
            imgBigD.Visible := true;
            imgBigS.Visible := true;
          end;
        end;
      end;
    end
  end;
end;

procedure TMarshall.tabEntrantRaceTimeClick(Sender: TObject);
begin
  Update_TabSheetCaptions;
end;

procedure TMarshall.tabEventHeatClick(Sender: TObject);
begin
  Update_TabSheetCaptions;
end;

{$ENDREGION}
{ TDefaultFont }

function TDefaultFont.GetDefaultFontFamilyName: string;
begin
  result := 'Tahoma';
end;

function TDefaultFont.GetDefaultFontSize: Single;
begin
  result := 16.0; // Set the default font size here
end;

initialization

TFont.FontService := TDefaultFont.Create;

end.
