program SCM_Marshall;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmMarshall in 'frmMarshall.pas' {Marshall},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dlgSCMOptions in 'dlgSCMOptions.pas' {scmOptions},
  dlgSCMStopWatch in 'dlgSCMStopWatch.pas' {scmStopWatch},
  dlgSCMNominate in 'dlgSCMNominate.pas' {SCMNominate},
  dmSCMNom in 'dmSCMNom.pas' {scmNom: TDataModule},
  SCMUtility in '..\SCM_SHARED\SCMUtility.pas',
  SCMSimpleConnect in '..\SCM_SHARED\SCMSimpleConnect.pas',
  exeinfo in '..\SCM_SHARED\exeinfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMarshall, Marshall);
  Application.CreateForm(TSCM, SCM);
  Application.Run;
end.
