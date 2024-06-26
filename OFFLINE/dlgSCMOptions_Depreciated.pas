unit dlgSCMOptions_Depreciated;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.Controls.Presentation,
  FMX.Layouts, dmSCM;

type
  TscmOptions = class(TForm)
    Layout2: TLayout;
    Layout4: TLayout;
    Layout1: TLayout;
    chkEnableAutoRefresh: TCheckBox;
    Layout9: TLayout;
    chkHideClosedSessions: TCheckBox;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    btnClose: TButton;
    StyleBook2: TStyleBook;
    Layout5: TLayout;
    chkEnableNomination: TCheckBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  scmOptions: TscmOptions;

implementation

{$R *.fmx}

uses
  System.IniFiles, System.IOUtils, System.Math;

procedure TscmOptions.btnCloseClick(Sender: TObject);
var
  ini: TIniFile;
  Section: String;
begin
  Section := 'MarshallOptions';
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim + 'SCMConfig.ini');
  try
    // Double value to integer ...
    ini.WriteBool(Section, 'EnableAutoReFresh', chkEnableAutoRefresh.IsChecked);
    ini.WriteBool(Section, 'EnableNomination', chkEnableNomination.IsChecked);
    ini.WriteBool(Section, 'HideClosedSessions',
      chkHideClosedSessions.IsChecked);
  finally
    ini.Free;
  end;

  ModalResult := mrOk;
  Close();
end;

procedure TscmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TscmOptions.FormCreate(Sender: TObject);
var
  ini: TIniFile;
  Section: String;

begin
  Section := 'MarshallOptions';
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim + 'SCMConfig.ini');
  try
    begin
      chkEnableAutoRefresh.IsChecked :=
        ini.ReadBool(Section, 'EnableAutoReFresh', false);
      chkEnableNomination.IsChecked :=
        ini.ReadBool(Section, 'EnableNomination', false);
      chkHideClosedSessions.IsChecked :=
        ini.ReadBool(Section, 'HideClosedSessions', true);
    end
  finally
    ini.Free;
  end;
end;

end.
