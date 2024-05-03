program SCM_Marshall;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmMarshall in 'frmMarshall.pas' {Marshall},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  SCMUtility in '..\SCM_SHARED\SCMUtility.pas',
  SCMSimpleConnect in '..\SCM_SHARED\SCMSimpleConnect.pas',
  exeinfo in '..\SCM_SHARED\exeinfo.pas',
  XSuperJSON in '..\x-superobject\XSuperJSON.pas',
  XSuperObject in '..\x-superobject\XSuperObject.pas',
  ProgramSetting in 'ProgramSetting.pas',
  DCode in 'DCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMarshall, Marshall);
  Application.Run;
end.
