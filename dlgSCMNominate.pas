unit dlgSCMNominate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Actions, FMX.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.FMXUI.Wait;

type
  TSCMNominate = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    StyleBook2: TStyleBook;
    GridPanelLayout1: TGridPanelLayout;
    btnCancel: TButton;
    btnToggle: TButton;
    btnPost: TButton;
    Label1: TLabel;
    ActionList1: TActionList;
    ListView1: TListView;
    qryQuickPick: TFDQuery;
    dsQuickPick: TDataSource;
    actnSortList: TAction;
    actnPost: TAction;
    actnCancel: TAction;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    StatusBar1: TStatusBar;
    lblStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actnPostExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actnCancelExecute(Sender: TObject);
    procedure actnSortListExecute(Sender: TObject);
    procedure actnSortListUpdate(Sender: TObject);
    procedure actnPostUpdate(Sender: TObject);
    procedure ListView1Change(Sender: TObject);
  private
    { Private declarations }
    fEventID: Integer;
    fHeatID: Integer;
    fLaneNum: Integer;
    fSortSwitch: Integer;
    fToogleName: Integer;
    fMemberID: Integer;
//    PostResult: Boolean;

    function RefreshQuery(): Boolean;
    function LocateMemberID(MemberID: Integer): Boolean;
    procedure SetEventID(Value: Integer);
    procedure SetHeatID(Value: Integer);
    procedure SetLaneNum(Value: Integer);
//    procedure PostOnTerminate(Sender: TObject);

  public
    { Public declarations }
    property EventID: Integer read fEventID write SetEventID;
    property HeatID: Integer read fHeatID write SetHeatID;
    property LaneNum: Integer read fLaneNum write SetLaneNum;
  end;

var
  SCMNominate: TSCMNominate;

implementation

{$R *.fmx}

uses dmSCM, dmSCMNom;

procedure TSCMNominate.actnCancelExecute(Sender: TObject);
begin
  // CLOSE FORM
  // IMPORTANT NOTE: Close calls TCloseAction.caFree.
  ModalResult := mrCancel;
end;

procedure TSCMNominate.actnPostExecute(Sender: TObject);
var
  nom: TscmNom;
  fPostResult: Boolean;
begin
  fPostResult := false;
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    fMemberID := qryQuickPick.FieldByName('MemberID').AsInteger;
    fHeatID := SCM.dsLane.DataSet.FieldByName('HeatID').AsInteger;
    fLaneNum := SCM.dsLane.DataSet.FieldByName('LaneNum').AsInteger;
    if (fMemberID > 0) and (fHeatID > 0) and (fLaneNum > 0) then
    begin
        try
          nom := TscmNom.Create(self);
          // TscmNom.AssignLane performs ...
          // checks IsNominated and IsMemberAssignedHeat
          // if required : creates a nomination record.
          // finally... creates new entrant record.
          fPostResult := nom.AssignLane(fMemberID, fHeatID, fLaneNum);
        finally
          FreeAndNil(nom);
          if not fPostResult then
            lblStatus.Text := 'ERROR: Unable to post member. Lane Assignment failed!'
          else
            // CLOSE FORM
            // IMPORTANT NOTE: Close calls TCloseAction.caFree.
            ModalResult := mrOk;
        end;
    end
  end;
end;

procedure TSCMNominate.actnPostUpdate(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.IsActive) then
    btnPost.Enabled := true
  else
    btnPost.Enabled := false;
end;

procedure TSCMNominate.actnSortListExecute(Sender: TObject);
var
  currMemberID: Integer;
  success: Boolean;
begin
  // 'LastName, FirstName'  order by LastName, ASC  [1, 1]
  // 'LastName, FirstName' order by FirstName, ASC [1, 3]
  // 'FirstName, LastName' order by LastName, ASC  [2, 1]
  // 'FirstName, LastName' order by FirstName, ASC [2, 3]
  fToogleName := fToogleName + 1;

  // [1,2]
  if fToogleName > 2 then
    fToogleName := 1;

  // changing the index name can result in a list re-paint
  // NOTE: Both refresh and locate ALSO toogle controls enabled state
  qryQuickPick.DisableControls;

  // sort LastName ASC
  if fToogleName = 1 then
  begin
    fSortSwitch := 1;
    qryQuickPick.IndexName := 'LastFirstName';
  end;
  // sort FirstName
  if fToogleName = 2 then
  begin
    fSortSwitch := 3;
    qryQuickPick.IndexName := 'FirstLastName';
  end;

  // Bookmark
  currMemberID := qryQuickPick.FieldByName('MemberID').AsInteger;
  // Refresh the query ....
  success := RefreshQuery;
  // locate and cue to record (after requery).
  if (currMemberID > 0) and success then
  begin
    success := LocateMemberID(currMemberID);
    if success then
      lblStatus.Text := 'The list was refreshed.'
    else
      lblStatus.Text := '';
  end;

  qryQuickPick.EnableControls;

end;

procedure TSCMNominate.actnSortListUpdate(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.IsActive) then
    btnToggle.Enabled := true
  else
    btnToggle.Enabled := false;
end;

procedure TSCMNominate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // IMPORTANT NOTE:  Action DESTROYS FORM
  Action := TCloseAction.caFree;
end;

procedure TSCMNominate.FormCreate(Sender: TObject);
begin
  // init
  fEventID := 0;
  fHeatID := 0;
  fLaneNum := 0;
  fMemberID := 0;

  // It'll need a connection to be active
  // if qryQuickPick.Active then
  // qryQuickPick.Close;

  fToogleName := 2; // LastName, FirstName     [1,2]
  fSortSwitch := 3; // LastName ASC    [1,2,3,4]
  qryQuickPick.IndexName := 'LastFirstName';

  lblStatus.Text := '';

  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // re-assignment is required ... as SCM isn't set to Auto-Create.
    // The ActiveStoredUsage - auRunTime - HAS BEEN DISABLED
    qryQuickPick.Connection := SCM.scmConnection;

    // NOTE: REQUIRES CONNECTION
    fEventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    qryQuickPick.ParamByName('EVENTID').AsInteger := fEventID;
    qryQuickPick.ParamByName('SORTSWITCH').AsInteger := fSortSwitch;
    qryQuickPick.ParamByName('TOGGLENAME').AsInteger := fToogleName;
    qryQuickPick.Prepare;
    qryQuickPick.Open;
  end;

end;

procedure TSCMNominate.FormDestroy(Sender: TObject);
begin
  if qryQuickPick.Active then
    qryQuickPick.Close;
end;

procedure TSCMNominate.ListView1Change(Sender: TObject);
begin
  lblStatus.Text := '';
end;

function TSCMNominate.LocateMemberID(MemberID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;
begin
  Result := false;
  if qryQuickPick.Active then
  begin
    qryQuickPick.DisableControls;
    SearchOptions := [loPartialKey];
    try
      LocateSuccess := qryQuickPick.Locate('MemberID', VarArrayOf([MemberID]),
        SearchOptions);
    except
      on E: Exception do
        LocateSuccess := false
    end;
    qryQuickPick.EnableControls;
    Result := LocateSuccess;
  end;
end;

function TSCMNominate.RefreshQuery(): Boolean;
var
  EventID: Integer;
begin
  Result := false;
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // ASSERT
    EventID := SCM.dsEvent.DataSet.FieldByName('EventID').AsInteger;
    if EventID <> 0 then
    begin

      try
        qryQuickPick.DisableControls;
        if qryQuickPick.Active then
          qryQuickPick.Close;
        qryQuickPick.ParamByName('EVENTID').AsInteger := EventID;
        qryQuickPick.ParamByName('SORTSWITCH').AsInteger := fSortSwitch;
        qryQuickPick.ParamByName('TOGGLENAME').AsInteger := fToogleName;
        qryQuickPick.Prepare;
        qryQuickPick.Open;
      finally
        qryQuickPick.EnableControls;
        if qryQuickPick.Active then
          Result := true;
      end;
    end
    else
    begin
      // clear the list of items.
      ListView1.Items.Clear;
      lblStatus.Text := 'ERROR: Requery failed!.';
    end;
  end;
end;

procedure TSCMNominate.SetEventID(Value: Integer);
begin
  fEventID := Value;
end;

procedure TSCMNominate.SetHeatID(Value: Integer);
begin
  fHeatID := Value;
end;

procedure TSCMNominate.SetLaneNum(Value: Integer);
begin
  fLaneNum := Value;
end;

end.
