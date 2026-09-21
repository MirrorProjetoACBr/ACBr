program ACBrNFe_Exemplo;

{$MODE Delphi}

uses
  Forms, Interfaces,
  Frm_ACBrNFe in 'Frm_ACBrNFe.pas' {frmACBrNFe},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_ConfiguraSerial in 'Frm_ConfiguraSerial.pas' {frmConfiguraSerial},
  Frm_Status in 'Frm_Status.pas' {frmStatus};


begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrNFe, frmACBrNFe);

  Application.Run;
end.
