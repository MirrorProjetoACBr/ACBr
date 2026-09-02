program ACBrLibBPeTest;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, ACBrLibBPeStaticImportMT, GuiTestRunner,
  ACBrLibConsts, ACBrLibBPeTestCase;

{$R *.res}

begin
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

