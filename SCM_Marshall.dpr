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
  SCMExeInfo in 'SCMExeInfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMarshall, Marshall);
  Application.Run;
end.
