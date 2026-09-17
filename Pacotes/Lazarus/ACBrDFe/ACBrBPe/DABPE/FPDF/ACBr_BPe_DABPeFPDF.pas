{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_BPe_DABPeFPDF;

{$warn 5023 off : no warning about unused units}
interface

uses
  ACBrBPeDABPeFPDFReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrBPeDABPeFPDFReg', @ACBrBPeDABPeFPDFReg.Register);
end;

initialization
  RegisterPackage('ACBr_BPe_DABPeFPDF', @Register);
end.
