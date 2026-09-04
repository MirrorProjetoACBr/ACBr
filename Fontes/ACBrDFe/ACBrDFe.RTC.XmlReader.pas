{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFe.RTC.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrXmlReader,
  ACBrDFe.RTC.Classes;

type
  { TDFeRTCXmlReader }

  TDFeRTCXmlReader = class(TACBrXmlReader)
  private
  public
    // Usado pela maioria dos DF-e
    procedure Ler_gCompraGovReduzido(const ANode: TACBrXmlNode; gCompraGov: TgCompraGovReduzido);
    procedure Ler_gPagAntecipadoProd(const ANode: TACBrXmlNode; gPagAntecipado: TgPagAntecipadoProd);
    procedure Ler_gPagAntecipadoIde(const ANode: TACBrXmlNode; gPagAntecipado: TgPagAntecipado);

    procedure Ler_IBSCBS(const ANode: TACBrXmlNode; IBSCBS: TIBSCBS);
    procedure Ler_gIBSCBS(const ANode: TACBrXmlNode; gIBSCBS: TgIBSCBS);

    procedure Ler_gIBSUF(const ANode: TACBrXmlNode; gIBSUF: TgIBSUFValores);
    procedure Ler_gIBSMun(const ANode: TACBrXmlNode; gIBSMun: TgIBSMunValores);
    procedure Ler_gCBS(const ANode: TACBrXmlNode; gCBS: TgCBSValores);

    procedure Ler_gDif(const ANode: TACBrXmlNode; gDif: TgDif);
    procedure Ler_gDevTrib(const ANode: TACBrXmlNode; gDevTrib: TgDevTrib);
    procedure Ler_gRed(const ANode: TACBrXmlNode; gRed: TgRed);

    procedure Ler_gTribRegular(const ANode: TACBrXmlNode; gTribRegular: TgTribRegular);
    procedure Ler_gTribCompraGov(const ANode: TACBrXmlNode; gTribCompraGov: TgTribCompraGov);
    procedure Ler_gEstornoCred(const ANode: TACBrXmlNode; gEstornoCred: TgEstornoCred);

    procedure Ler_gALCZFMCBS(const ANode: TACBrXmlNode; gALCZFMCBS: TgALCZFMCBS);

    procedure Ler_IBSCBSTot(const ANode: TACBrXmlNode; IBSCBSTot: TIBSCBSTot);
    procedure Ler_gIBSTot(const ANode: TACBrXmlNode; gIBS: TgIBS);
    procedure Ler_gIBSUFTot(const ANode: TACBrXmlNode; gIBSUFTot: TgIBSUFTot);
    procedure Ler_gIBSMunTot(const ANode: TACBrXmlNode; gIBSMunTot: TgIBSMunTot);
    procedure Ler_gCBSTot(const ANode: TACBrXmlNode; gCBS: TgCBS);
    procedure Ler_gEstornoCredTot(const ANode: TACBrXmlNode; gEstornoCred: TgEstornoCred);

    procedure Ler_pgtoVinc(const ANode: TACBrXmlNode; pgtoVinc: TpgtoVinc);
    procedure Ler_pgto(const ANode: TACBrXmlNode; pgto: TpgtoCollection);

    // Usado pela NF-e
    procedure Ler_gCompraGov(const ANode: TACBrXmlNode; gCompraGov: TgCompraGov);
    procedure Ler_gPagAntecipado(const ANode: TACBrXmlNode; gPagAntecipado: TgPagAntecipado);

    procedure Ler_ISel(const ANode: TACBrXmlNode; ISel: TgIS);

    procedure Ler_gIBSCBSMono(const ANode: TACBrXmlNode; IBSCBSMono: TgIBSCBSMono);

    procedure Ler_gIBSMonoAdRem(const ANode: TACBrXmlNode; gIBSMonoAdRem: TgIBSMonoAdRem);
    procedure Ler_gMonoPadraoIBSQtde(const ANode: TACBrXmlNode; gMonoPadrao: TgMonoPadraoIBSQtde);
    procedure Ler_gMonoRetenIBSQtde(const ANode: TACBrXmlNode; gMonoReten: TgMonoRetenIBSQtde);
    procedure Ler_gMonoRetIBS(const ANode: TACBrXmlNode; gMonoRet: TgMonoRetIBS);
    procedure Ler_gpBioDiferencaIBS(const ANode: TACBrXmlNode; gpBioDiferenca: TgpBioDiferencaIBS);

    procedure Ler_gIBSMonoAdValorem(const ANode: TACBrXmlNode; gIBSMonoAdValorem: TgIBSMonoAdValorem);
    procedure Ler_gMonoPadraoIBSAliq(const ANode: TACBrXmlNode; gMonoPadrao: TgMonoPadraoIBSAliq);
    procedure Ler_gMonoRetenIBSAliq(const ANode: TACBrXmlNode; gMonoReten: TgMonoRetenIBSAliq);

    procedure Ler_gCBSMonoAdRem(const ANode: TACBrXmlNode; gCBSMonoAdRem: TgCBSMonoAdRem);
    procedure Ler_gMonoPadraoCBSQtde(const ANode: TACBrXmlNode; gMonoPadrao: TgMonoPadraoCBSQtde);
    procedure Ler_gMonoRetenCBSQtde(const ANode: TACBrXmlNode; gMonoReten: TgMonoRetenCBSQtde);
    procedure Ler_gMonoRetCBS(const ANode: TACBrXmlNode; gMonoRet: TgMonoRetCBS);
    procedure Ler_gpBioDiferencaCBS(const ANode: TACBrXmlNode; gpBioDiferenca: TgpBioDiferencaCBS);

    procedure Ler_gCBSMonoAdValorem(const ANode: TACBrXmlNode; gCBSMonoAdValorem: TgCBSMonoAdValorem);
    procedure Ler_gMonoPadraoCBSAliq(const ANode: TACBrXmlNode; gMonoPadrao: TgMonoPadraoCBSAliq);
    procedure Ler_gMonoRetenCBSAliq(const ANode: TACBrXmlNode; gMonoReten: TgMonoRetenCBSAliq);

    procedure Ler_gTransfCred(const ANode: TACBrXmlNode; gTransfCred: TgTransfCred);
    procedure Ler_gCredPresIBSZFM(const ANode: TACBrXmlNode; gCredPresIBSZFM: TCredPresIBSZFM);
    procedure Ler_gAjusteCompet(const ANode: TACBrXmlNode; gAjusteCompet: TgAjusteCompet);
    procedure Ler_gCredPresOper(const ANode: TACBrXmlNode; gCredPresOper: TgCredPresOper);
    procedure Ler_gIBSCredPres(const ANode: TACBrXmlNode; gIBSCredPres: TgIBSCBSCredPres);
    procedure Ler_gCBSCredPres(const ANode: TACBrXmlNode; gCBSCredPres: TgIBSCBSCredPres);

    procedure Ler_DFeReferenciado(const ANode: TACBrXmlNode; DFeReferenciado: TDFeReferenciado);

    procedure Ler_ISTot(const ANode: TACBrXmlNode; ISTot: TISTot);
    procedure Ler_gMonoTot(const ANode: TACBrXmlNode; gMono: TgMono);
  end;

implementation

uses
  ACBrUtil.DateTime;

{ TDFeRTCXmlReader }

// Usado pela maioria dos DF-e
procedure TDFeRTCXmlReader.Ler_gCompraGovReduzido(const ANode: TACBrXmlNode;
  gCompraGov: TgCompraGovReduzido);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  gCompraGov.tpEnteGov := StrTotpEnteGov(ObterConteudo(ANode.Childrens.Find('tpEnteGov'), tcStr));
  gCompraGov.pRedutor := ObterConteudo(ANode.Childrens.Find('pRedutor'), tcDe4);
  gCompraGov.tpOperGov := StrTotpOperGov(ObterConteudo(ANode.Childrens.Find('tpOperGov'), tcStr));

  gCompraGov.refDFe.Clear;
  ANodes := ANode.Childrens.FindAll('refDFeAnt');

  for i := 0 to Length(ANodes) -1 do
  begin
    gCompraGov.refDFe.New;
    gCompraGov.refDFe[i].refDFeAnt := ObterConteudo(ANodes[i], tcStr);
  end;
end;

procedure TDFeRTCXmlReader.Ler_gPagAntecipadoProd(const ANode: TACBrXmlNode;
  gPagAntecipado: TgPagAntecipadoProd);
begin
  if not Assigned(ANode) then Exit;

  gPagAntecipado.chDFePagAnt := ObterConteudo(ANode.Childrens.FindAnyNs('chDFePagAnt'), tcStr);
  gPagAntecipado.nItemPagAnt := ObterConteudo(ANode.Childrens.FindAnyNs('nItemPagAnt'), tcInt);
end;

procedure TDFeRTCXmlReader.Ler_gPagAntecipadoIde(const ANode: TACBrXmlNode;
  gPagAntecipado: TgPagAntecipado);
var
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  ANodes := ANode.Childrens.FindAll('chDFePagAnt');
  for i := 0 to Length(ANodes) - 1 do
  begin
    gPagAntecipado.refNFe.New;
    gPagAntecipado.refNFe[i].refDFEChave := ObterConteudo(ANodes[i], tcStr);
  end;
end;

procedure TDFeRTCXmlReader.Ler_IBSCBS(const ANode: TACBrXmlNode; IBSCBS: TIBSCBS);
begin
  if not Assigned(ANode) then Exit;

  IBSCBS.CST := StrToCSTIBSCBS(ObterConteudo(ANode.Childrens.Find('CST'), tcStr));
  IBSCBS.cClassTrib := ObterConteudo(ANode.Childrens.Find('cClassTrib'), tcStr);
  IBSCBS.indDoacao := StrToTIndicadorEx(ObterConteudo(ANode.Childrens.Find('indDoacao'), tcStr));

  Ler_gIBSCBS(ANode.Childrens.Find('gIBSCBS'), IBSCBS.gIBSCBS);
  Ler_gIBSCBSMono(ANode.Childrens.Find('gIBSCBSMono'), IBSCBS.gIBSCBSMono);
  Ler_gTransfCred(ANode.Childrens.Find('gTransfCred'), IBSCBS.gTransfCred);
  Ler_gAjusteCompet(ANode.Childrens.Find('gAjusteCompet'), IBSCBS.gAjusteCompet);
  Ler_gEstornoCred(ANode.Childrens.Find('gEstornoCred'), IBSCBS.gEstornoCred);
  Ler_gCredPresOper(ANode.Childrens.Find('gCredPresOper'), IBSCBS.gCredPresOper);
  Ler_gCredPresIBSZFM(ANode.Childrens.Find('gCredPresIBSZFM'), IBSCBS.gCredPresIBSZFM);
 end;

procedure TDFeRTCXmlReader.Ler_gIBSCBS(const ANode: TACBrXmlNode; gIBSCBS: TgIBSCBS);
begin
  if not Assigned(ANode) then Exit;

  gIBSCBS.vBC := ObterConteudo(ANode.Childrens.Find('vBC'), tcDe2);
  gIBSCBS.vIBS := ObterConteudo(ANode.Childrens.Find('vIBS'), tcDe2);

  Ler_gIBSUF(ANode.Childrens.Find('gIBSUF'), gIBSCBS.gIBSUF);
  Ler_gIBSMun(ANode.Childrens.Find('gIBSMun'), gIBSCBS.gIBSMun);
  Ler_gCBS(ANode.Childrens.Find('gCBS'), gIBSCBS.gCBS);
  Ler_gTribRegular(ANode.Childrens.Find('gTribRegular'), gIBSCBS.gTribRegular);
  Ler_gTribCompraGov(ANode.Childrens.Find('gTribCompraGov'), gIBSCBS.gTribCompraGov);
end;

procedure TDFeRTCXmlReader.Ler_gIBSUF(const ANode: TACBrXmlNode; gIBSUF: TgIBSUFValores);
begin
  if not Assigned(ANode) then Exit;

  gIBSUF.pIBSUF := ObterConteudo(ANode.Childrens.Find('pIBSUF'), tcDe4);

  Ler_gDif(ANode.Childrens.Find('gDif'), gIBSUF.gDif);
  Ler_gDevTrib(ANode.Childrens.Find('gDevTrib'), gIBSUF.gDevTrib);
  Ler_gRed(ANode.Childrens.Find('gRed'), gIBSUF.gRed);

  gIBSUF.vIBSUF := ObterConteudo(ANode.Childrens.Find('vIBSUF'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gIBSMun(const ANode: TACBrXmlNode; gIBSMun: TgIBSMunValores);
begin
  if not Assigned(ANode) then Exit;

  gIBSMun.pIBSMun := ObterConteudo(ANode.Childrens.Find('pIBSMun'), tcDe4);

  Ler_gDif(ANode.Childrens.Find('gDif'), gIBSMun.gDif);
  Ler_gDevTrib(ANode.Childrens.Find('gDevTrib'), gIBSMun.gDevTrib);
  Ler_gRed(ANode.Childrens.Find('gRed'), gIBSMun.gRed);

  gIBSMun.vIBSMun := ObterConteudo(ANode.Childrens.Find('vIBSMun'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCBS(const ANode: TACBrXmlNode; gCBS: TgCBSValores);
begin
  if not Assigned(ANode) then Exit;

  gCBS.pCBS := ObterConteudo(ANode.Childrens.Find('pCBS'), tcDe4);

  Ler_gDif(ANode.Childrens.Find('gDif'), gCBS.gDif);
  Ler_gDevTrib(ANode.Childrens.Find('gDevTrib'), gCBS.gDevTrib);
  Ler_gRed(ANode.Childrens.Find('gRed'), gCBS.gRed);
  Ler_gALCZFMCBS(ANode.Childrens.Find('gALCZFMCBS'), gCBS.gALCZFMCBS);

  gCBS.vCBS := ObterConteudo(ANode.Childrens.Find('vCBS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gDif(const ANode: TACBrXmlNode; gDif: TgDif);
begin
  if not Assigned(ANode) then Exit;

  gDif.pDif := ObterConteudo(ANode.Childrens.Find('pDif'), tcDe4);
  gDif.vDif := ObterConteudo(ANode.Childrens.Find('vDif'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gDevTrib(const ANode: TACBrXmlNode; gDevTrib: TgDevTrib);
begin
  if not Assigned(ANode) then Exit;

  gDevTrib.pDevTrib := ObterConteudo(ANode.Childrens.Find('pDevTrib'), tcDe4);
  gDevTrib.vDevTrib := ObterConteudo(ANode.Childrens.Find('vDevTrib'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gRed(const ANode: TACBrXmlNode; gRed: TgRed);
begin
  if not Assigned(ANode) then Exit;

  gRed.pRedAliq := ObterConteudo(ANode.Childrens.Find('pRedAliq'), tcDe4);
  gRed.pAliqEfet := ObterConteudo(ANode.Childrens.Find('pAliqEfet'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gTribRegular(const ANode: TACBrXmlNode;
  gTribRegular: TgTribRegular);
begin
  if not Assigned(ANode) then Exit;

  gTribRegular.CSTReg := StrToCSTIBSCBS(ObterConteudo(ANode.Childrens.Find('CSTReg'), tcStr));
  gTribRegular.cClassTribReg := ObterConteudo(ANode.Childrens.Find('cClassTribReg'), tcStr);
  gTribRegular.pAliqEfetRegIBSUF := ObterConteudo(ANode.Childrens.Find('pAliqEfetRegIBSUF'), tcDe4);
  gTribRegular.vTribRegIBSUF := ObterConteudo(ANode.Childrens.Find('vTribRegIBSUF'), tcDe2);
  gTribRegular.pAliqEfetRegIBSMun := ObterConteudo(ANode.Childrens.Find('pAliqEfetRegIBSMun'), tcDe4);
  gTribRegular.vTribRegIBSMun := ObterConteudo(ANode.Childrens.Find('vTribRegIBSMun'), tcDe2);
  gTribRegular.pAliqEfetRegCBS := ObterConteudo(ANode.Childrens.Find('pAliqEfetRegCBS'), tcDe4);
  gTribRegular.vTribRegCBS := ObterConteudo(ANode.Childrens.Find('vTribRegCBS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gTribCompraGov(const ANode: TACBrXmlNode;
  gTribCompraGov: TgTribCompraGov);
begin
  if not Assigned(ANode) then Exit;

  gTribCompraGov.pAliqIBSUF := ObterConteudo(ANode.Childrens.Find('pAliqIBSUF'), tcDe4);
  gTribCompraGov.vTribIBSUF := ObterConteudo(ANode.Childrens.Find('vTribIBSUF'), tcDe2);
  gTribCompraGov.pAliqIBSMun := ObterConteudo(ANode.Childrens.Find('pAliqIBSMun'), tcDe4);
  gTribCompraGov.vTribIBSMun := ObterConteudo(ANode.Childrens.Find('vTribIBSMun'), tcDe2);
  gTribCompraGov.pAliqCBS := ObterConteudo(ANode.Childrens.Find('pAliqCBS'), tcDe4);
  gTribCompraGov.vTribCBS := ObterConteudo(ANode.Childrens.Find('vTribCBS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gEstornoCred(const ANode: TACBrXmlNode;
  gEstornoCred: TgEstornoCred);
begin
  if not Assigned(ANode) then Exit;

  gEstornoCred.vIBSEstCred := ObterConteudo(ANode.Childrens.Find('vIBSEstCred'), tcDe2);
  gEstornoCred.vCBSEstCred := ObterConteudo(ANode.Childrens.Find('vCBSEstCred'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gALCZFMCBS(const ANode: TACBrXmlNode;
  gALCZFMCBS: TgALCZFMCBS);
begin
  if not Assigned(ANode) then Exit;

  gALCZFMCBS.tpALCZFMCBS := StrTotpALCZFMCBS(ObterConteudo(ANode.Childrens.Find('tpALCZFMCBS'), tcStr));
  gALCZFMCBS.nProcSuframa := ObterConteudo(ANode.Childrens.Find('nProcSuframa'), tcStr);
  gALCZFMCBS.pAliqEfetRegCBS := ObterConteudo(ANode.Childrens.Find('pAliqEfetRegCBS'), tcDe4);
  gALCZFMCBS.vTribRegCBS := ObterConteudo(ANode.Childrens.Find('vTribRegCBS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_IBSCBSTot(const ANode: TACBrXmlNode;
  IBSCBSTot: TIBSCBSTot);
begin
  if not Assigned(ANode) then Exit;

  IBSCBSTot.vBCIBSCBS := ObterConteudo(ANode.Childrens.Find('vBCIBSCBS'), tcDe2);

  Ler_gIBSTot(ANode.Childrens.Find('gIBS'), IBSCBSTot.gIBS);
  Ler_gCBSTot(ANode.Childrens.Find('gCBS'), IBSCBSTot.gCBS);
  Ler_gMonoTot(ANode.Childrens.Find('gMono'), IBSCBSTot.gMono);
  Ler_gEstornoCredTot(ANode.Childrens.Find('gEstornoCred'), IBSCBSTot.gEstornoCred);
end;

procedure TDFeRTCXmlReader.Ler_gIBSTot(const ANode: TACBrXmlNode;
  gIBS: TgIBS);
begin
  if not Assigned(ANode) then Exit;

  Ler_gIBSUFTot(ANode.Childrens.Find('gIBSUF'), gIBS.gIBSUFTot);
  Ler_gIBSMunTot(ANode.Childrens.Find('gIBSMun'), gIBS.gIBSMunTot);

  gIBS.vIBS := ObterConteudo(ANode.Childrens.Find('vIBS'), tcDe2);
  gIBS.vCredPres := ObterConteudo(ANode.Childrens.Find('vCredPres'), tcDe2);
  gIBS.vCredPresCondSus := ObterConteudo(ANode.Childrens.Find('vCredPresCondSus'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gIBSUFTot(const ANode: TACBrXmlNode;
  gIBSUFTot: TgIBSUFTot);
begin
  if not Assigned(ANode) then Exit;

  gIBSUFTot.vDif := ObterConteudo(ANode.Childrens.Find('vDif'), tcDe2);
  gIBSUFTot.vDevTrib := ObterConteudo(ANode.Childrens.Find('vDevTrib'), tcDe2);
  gIBSUFTot.vIBSUF := ObterConteudo(ANode.Childrens.Find('vIBSUF'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gIBSMunTot(const ANode: TACBrXmlNode;
  gIBSMunTot: TgIBSMunTot);
begin
  if not Assigned(ANode) then Exit;

  gIBSMunTot.vDif := ObterConteudo(ANode.Childrens.Find('vDif'), tcDe2);
  gIBSMunTot.vDevTrib := ObterConteudo(ANode.Childrens.Find('vDevTrib'), tcDe2);
  gIBSMunTot.vIBSMun := ObterConteudo(ANode.Childrens.Find('vIBSMun'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCBSTot(const ANode: TACBrXmlNode;
  gCBS: TgCBS);
begin
  if not Assigned(ANode) then Exit;

  gCBS.vDif := ObterConteudo(ANode.Childrens.Find('vDif'), tcDe2);
  gCBS.vDevTrib := ObterConteudo(ANode.Childrens.Find('vDevTrib'), tcDe2);
  gCBS.vCBS := ObterConteudo(ANode.Childrens.Find('vCBS'), tcDe2);
  gCBS.vCredPres := ObterConteudo(ANode.Childrens.Find('vCredPres'), tcDe2);
  gCBS.vCredPresCondSus := ObterConteudo(ANode.Childrens.Find('vCredPresCondSus'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gEstornoCredTot(const ANode: TACBrXmlNode;
  gEstornoCred: TgEstornoCred);
begin
  if not Assigned(ANode) then Exit;

  gEstornoCred.vIBSEstCred := ObterConteudo(ANode.Childrens.Find('vIBSEstCred'), tcDe2);
  gEstornoCred.vCBSEstCred := ObterConteudo(ANode.Childrens.Find('vCBSEstCred'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_pgtoVinc(const ANode: TACBrXmlNode;
  pgtoVinc: TpgtoVinc);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  ANodes := ANode.Childrens.FindAll('pgto');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_pgto(ANodes[i], pgtoVinc.pgto);
  end;
end;

procedure TDFeRTCXmlReader.Ler_pgto(const ANode: TACBrXmlNode;
  pgto: TpgtoCollection);
var
  Item: TpgtoCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := pgto.New;

  Item.nPag := StrToInt(ObterConteudoTag(ANode.Attributes.Items['nPag']));
  Item.idTransacao := ObterConteudoTag(ANode.Attributes.Items['idTransacao']);

  Item.tpMeioPgto := ObterConteudo(ANode.Childrens.Find('tpMeioPgto'), tcStr);
  Item.CNPJReceb := ObterConteudo(ANode.Childrens.Find('CNPJReceb'), tcStr);
  Item.CNPJBasePSP := ObterConteudo(ANode.Childrens.Find('CNPJBasePSP'), tcDe2);
end;

// Usado pela NF-e
procedure TDFeRTCXmlReader.Ler_gCompraGov(const ANode: TACBrXmlNode;
  gCompraGov: TgCompraGov);
var
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  gCompraGov.tpEnteGov := StrTotpEnteGov(ObterConteudo(ANode.Childrens.Find('tpEnteGov'), tcStr));
  gCompraGov.pRedutor := ObterConteudo(ANode.Childrens.Find('pRedutor'), tcDe4);
  gCompraGov.tpOperGov := StrTotpOperGov(ObterConteudo(ANode.Childrens.Find('tpOperGov'), tcStr));

  gCompraGov.refDFeAnt.Clear;
  ANodes := ANode.Childrens.FindAll('refDFeAnt');

  for i := 0 to Length(ANodes) -1 do
  begin
    gCompraGov.refDFeAnt.New;
    gCompraGov.refDFeAnt[i].refDFeChave := ObterConteudo(ANodes[i], tcStr);
  end;
end;

procedure TDFeRTCXmlReader.Ler_gPagAntecipado(const ANode: TACBrXmlNode;
  gPagAntecipado: TgPagAntecipado);
var
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  ANodes := ANode.Childrens.FindAll('refNFe');
  for i := 0 to Length(ANodes) - 1 do
  begin
    gPagAntecipado.refNFe.New;
    gPagAntecipado.refNFe[i].refDFEChave := ObterConteudo(ANodes[i], tcStr);
  end;
end;

procedure TDFeRTCXmlReader.Ler_ISel(const ANode: TACBrXmlNode; ISel: TgIS);
begin
  if not Assigned(ANode) then Exit;
  //Usar string até a publicação de uma tabela de CSTs oficial para o IS
  //ISel.CSTIS := StrToCSTIS(ObterConteudo(ANode.Childrens.Find('CSTIS'), tcStr));
  ISel.CSTIS := ObterConteudo(ANode.Childrens.Find('CSTIS'), tcStr);
  ISel.cClassTribIS := ObterConteudo(ANode.Childrens.Find('cClassTribIS'), tcStr);
  ISel.vBCIS := ObterConteudo(ANode.Childrens.Find('vBCIS'), tcDe2);
  ISel.pIS := ObterConteudo(ANode.Childrens.Find('pIS'), tcDe2);
  ISel.adRemIS := ObterConteudo(ANode.Childrens.Find('adRemIS'), tcDe4);
  ISel.uTrib := ObterConteudo(ANode.Childrens.Find('uTrib'), tcStr);
  ISel.qTrib := ObterConteudo(ANode.Childrens.Find('qTrib'), tcDe4);
  ISel.vIS := ObterConteudo(ANode.Childrens.Find('vIS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gIBSCBSMono(const ANode: TACBrXmlNode; IBSCBSMono: TgIBSCBSMono);
begin
  if not Assigned(ANode) then Exit;

  Ler_gIBSMonoAdRem(ANode.Childrens.Find('gIBSMonoAdRem'), IBSCBSMono.gIBSMonoAdRem);
  Ler_gIBSMonoAdValorem(ANode.Childrens.Find('gIBSMonoAdValorem'), IBSCBSMono.gIBSMonoAdValorem);
  Ler_gCBSMonoAdRem(ANode.Childrens.Find('gCBSMonoAdRem'), IBSCBSMono.gCBSMonoAdRem);
  Ler_gCBSMonoAdValorem(ANode.Childrens.Find('gCBSMonoAdValorem'), IBSCBSMono.gCBSMonoAdValorem);

  IBSCBSMono.vTotIBSMonoItem := ObterConteudo(ANode.Childrens.Find('vTotIBSMonoItem'), tcDe2);
  IBSCBSMono.vTotCBSMonoItem := ObterConteudo(ANode.Childrens.Find('vTotCBSMonoItem'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gIBSMonoAdRem(const ANode: TACBrXmlNode;
  gIBSMonoAdRem: TgIBSMonoAdRem);
begin
  if not Assigned(ANode) then Exit;

  Ler_gMonoPadraoIBSQtde(ANode.Childrens.Find('gMonoPadrao'), gIBSMonoAdRem.gMonoPadrao);
  Ler_gMonoRetenIBSQtde(ANode.Childrens.Find('gMonoReten'), gIBSMonoAdRem.gMonoReten);
  Ler_gMonoRetIBS(ANode.Childrens.Find('gMonoRet'), gIBSMonoAdRem.gMonoRet);
  Ler_gpBioDiferencaIBS(ANode.Childrens.Find('gpBioDiferenca'), gIBSMonoAdRem.gpBioDiferenca);
end;

procedure TDFeRTCXmlReader.Ler_gMonoPadraoIBSQtde(const ANode: TACBrXmlNode;
  gMonoPadrao: TgMonoPadraoIBSQtde);
begin
  if not Assigned(ANode) then Exit;

  gMonoPadrao.qBCMono := ObterConteudo(ANode.Childrens.Find('qBCMono'), tcDe4);
  gMonoPadrao.adRemIBS := ObterConteudo(ANode.Childrens.Find('adRemIBS'), tcDe4);
  gMonoPadrao.vIBSMono := ObterConteudo(ANode.Childrens.Find('vIBSMono'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoRetenIBSQtde(const ANode: TACBrXmlNode;
  gMonoReten: TgMonoRetenIBSQtde);
begin
  if not Assigned(ANode) then Exit;

  gMonoReten.qBCMonoReten := ObterConteudo(ANode.Childrens.Find('qBCMonoReten'), tcDe4);
  gMonoReten.adRemIBSReten := ObterConteudo(ANode.Childrens.Find('adRemIBSReten'), tcDe4);
  gMonoReten.vIBSMonoReten := ObterConteudo(ANode.Childrens.Find('vIBSMonoReten'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoRetIBS(const ANode: TACBrXmlNode;
  gMonoRet: TgMonoRetIBS);
begin
  if not Assigned(ANode) then Exit;

  gMonoRet.vIBSMonoRet := ObterConteudo(ANode.Childrens.Find('vIBSMonoRet'), tcDe4);
end;

procedure TDFeRTCXmlReader.Ler_gpBioDiferencaIBS(const ANode: TACBrXmlNode;
  gpBioDiferenca: TgpBioDiferencaIBS);
begin
  if not Assigned(ANode) then Exit;

  gpBioDiferenca.qBCBioComb := ObterConteudo(ANode.Childrens.Find('qBCBioComb'), tcDe4);
  gpBioDiferenca.vIBSDiferenca := ObterConteudo(ANode.Childrens.Find('vIBSDiferenca'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gIBSMonoAdValorem(const ANode: TACBrXmlNode;
  gIBSMonoAdValorem: TgIBSMonoAdValorem);
begin
  if not Assigned(ANode) then Exit;

  Ler_gMonoPadraoIBSAliq(ANode.Childrens.Find('gMonoPadrao'), gIBSMonoAdValorem.gMonoPadrao);
  Ler_gMonoRetenIBSAliq(ANode.Childrens.Find('gMonoReten'), gIBSMonoAdValorem.gMonoReten);
  Ler_gMonoRetIBS(ANode.Childrens.Find('gMonoRet'), gIBSMonoAdValorem.gMonoRet);
end;

procedure TDFeRTCXmlReader.Ler_gMonoPadraoIBSAliq(const ANode: TACBrXmlNode;
  gMonoPadrao: TgMonoPadraoIBSAliq);
begin
  if not Assigned(ANode) then Exit;

  gMonoPadrao.vBCMono := ObterConteudo(ANode.Childrens.Find('vBCMono'), tcDe4);
  gMonoPadrao.pAliqMonoUF := ObterConteudo(ANode.Childrens.Find('pAliqMonoUF'), tcDe4);
  gMonoPadrao.vIBSMonoUF := ObterConteudo(ANode.Childrens.Find('vIBSMonoUF'), tcDe4);
  gMonoPadrao.pAliqMonoMun := ObterConteudo(ANode.Childrens.Find('pAliqMonoMun'), tcDe4);
  gMonoPadrao.vIBSMonoMun := ObterConteudo(ANode.Childrens.Find('vIBSMonoMun'), tcDe4);
  gMonoPadrao.vIBSMono := ObterConteudo(ANode.Childrens.Find('vIBSMono'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoRetenIBSAliq(const ANode: TACBrXmlNode;
  gMonoReten: TgMonoRetenIBSAliq);
begin
  if not Assigned(ANode) then Exit;

  gMonoReten.vBCMonoReten := ObterConteudo(ANode.Childrens.Find('vBCMonoReten'), tcDe2);
  gMonoReten.pAliqMonoReten := ObterConteudo(ANode.Childrens.Find('pAliqMonoReten'), tcDe4);
  gMonoReten.vIBSMonoReten := ObterConteudo(ANode.Childrens.Find('vIBSMonoReten'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCBSMonoAdRem(const ANode: TACBrXmlNode;
  gCBSMonoAdRem: TgCBSMonoAdRem);
begin
  if not Assigned(ANode) then Exit;

  Ler_gMonoPadraoCBSQtde(ANode.Childrens.Find('gMonoPadrao'), gCBSMonoAdRem.gMonoPadrao);
  Ler_gMonoRetenCBSQtde(ANode.Childrens.Find('gMonoReten'), gCBSMonoAdRem.gMonoReten);
  Ler_gMonoRetCBS(ANode.Childrens.Find('gMonoRet'), gCBSMonoAdRem.gMonoRet);
  Ler_gpBioDiferencaCBS(ANode.Childrens.Find('gpBioDiferenca'), gCBSMonoAdRem.gpBioDiferenca);
end;

procedure TDFeRTCXmlReader.Ler_gMonoPadraoCBSQtde(const ANode: TACBrXmlNode;
  gMonoPadrao: TgMonoPadraoCBSQtde);
begin
  if not Assigned(ANode) then Exit;

  gMonoPadrao.qBCMono := ObterConteudo(ANode.Childrens.Find('qBCMono'), tcDe4);
  gMonoPadrao.adRemCBS := ObterConteudo(ANode.Childrens.Find('adRemCBS'), tcDe4);
  gMonoPadrao.vCBSMono := ObterConteudo(ANode.Childrens.Find('vCBSMono'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoRetenCBSQtde(const ANode: TACBrXmlNode;
  gMonoReten: TgMonoRetenCBSQtde);
begin
  if not Assigned(ANode) then Exit;

  gMonoReten.qBCMonoReten := ObterConteudo(ANode.Childrens.Find('qBCMonoReten'), tcDe4);
  gMonoReten.adRemCBSReten := ObterConteudo(ANode.Childrens.Find('adRemCBSReten'), tcDe4);
  gMonoReten.vCBSMonoReten := ObterConteudo(ANode.Childrens.Find('vCBSMonoReten'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoRetCBS(const ANode: TACBrXmlNode;
  gMonoRet: TgMonoRetCBS);
begin
  if not Assigned(ANode) then Exit;

  gMonoRet.vCBSMonoRet := ObterConteudo(ANode.Childrens.Find('vCBSMonoRet'), tcDe4);
end;

procedure TDFeRTCXmlReader.Ler_gpBioDiferencaCBS(const ANode: TACBrXmlNode;
  gpBioDiferenca: TgpBioDiferencaCBS);
begin
  if not Assigned(ANode) then Exit;

  gpBioDiferenca.qBCBioComb := ObterConteudo(ANode.Childrens.Find('qBCBioComb'), tcDe4);
  gpBioDiferenca.vCBSDiferenca := ObterConteudo(ANode.Childrens.Find('vCBSDiferenca'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCBSMonoAdValorem(const ANode: TACBrXmlNode;
  gCBSMonoAdValorem: TgCBSMonoAdValorem);
begin
  if not Assigned(ANode) then Exit;

  Ler_gMonoPadraoCBSAliq(ANode.Childrens.Find('gMonoPadrao'), gCBSMonoAdValorem.gMonoPadrao);
  Ler_gMonoRetenCBSAliq(ANode.Childrens.Find('gMonoReten'), gCBSMonoAdValorem.gMonoReten);
  Ler_gMonoRetCBS(ANode.Childrens.Find('gMonoRet'), gCBSMonoAdValorem.gMonoRet);
end;

procedure TDFeRTCXmlReader.Ler_gMonoPadraoCBSAliq(const ANode: TACBrXmlNode;
  gMonoPadrao: TgMonoPadraoCBSAliq);
begin
  if not Assigned(ANode) then Exit;

  gMonoPadrao.vBCMono := ObterConteudo(ANode.Childrens.Find('vBCMono'), tcDe4);
  gMonoPadrao.pAliqMonoCBS := ObterConteudo(ANode.Childrens.Find('pAliqMonoCBS'), tcDe4);
  gMonoPadrao.vCBSMono := ObterConteudo(ANode.Childrens.Find('vCBSMono'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoRetenCBSAliq(const ANode: TACBrXmlNode;
  gMonoReten: TgMonoRetenCBSAliq);
begin
  if not Assigned(ANode) then Exit;

  gMonoReten.vBCMonoReten := ObterConteudo(ANode.Childrens.Find('vBCMonoReten'), tcDe2);
  gMonoReten.pAliqMonoReten := ObterConteudo(ANode.Childrens.Find('pAliqMonoReten'), tcDe4);
  gMonoReten.vCBSMonoReten := ObterConteudo(ANode.Childrens.Find('vCBSMonoReten'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gTransfCred(const ANode: TACBrXmlNode; gTransfCred: TgTransfCred);
begin
  if not Assigned(ANode) then Exit;

  gTransfCred.vIBS := ObterConteudo(ANode.Childrens.Find('vIBS'), tcDe2);
  gTransfCred.vCBS := ObterConteudo(ANode.Childrens.Find('vCBS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCredPresIBSZFM(const ANode: TACBrXmlNode; gCredPresIBSZFM: TCredPresIBSZFM);
var
  aData: string;
begin
  if not Assigned(ANode) then Exit;

  aData := ObterConteudo(ANode.Childrens.Find('competApur'), tcStr) + '-01';
  gCredPresIBSZFM.competApur := StringToDateTime(aData, 'YYYY-MM-DD');
  gCredPresIBSZFM.tpCredPresIBSZFM := StrToTpCredPresIBSZFM(ObterConteudo(ANode.Childrens.Find('tpCredPresIBSZFM'), tcStr));
  gCredPresIBSZFM.vCredPresIBSZFM := ObterConteudo(ANode.Childrens.Find('vCredPresIBSZFM'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gAjusteCompet(const ANode: TACBrXmlNode; gAjusteCompet: TgAjusteCompet);
var
  aData: string;
begin
  if not Assigned(ANode) then Exit;

  aData := ObterConteudo(ANode.Childrens.Find('competApur'), tcStr) + '-01';
  gAjusteCompet.competApur := StringToDateTime(aData, 'YYYY-MM-DD');
  gAjusteCompet.vIBS := ObterConteudo(ANode.Childrens.Find('vIBS'), tcDe2);
  gAjusteCompet.vCBS := ObterConteudo(ANode.Childrens.Find('vCBS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCredPresOper(const ANode: TACBrXmlNode; gCredPresOper: TgCredPresOper);
begin
  if not Assigned(ANode) then Exit;

  gCredPresOper.vBCCredPres := ObterConteudo(ANode.Childrens.Find('vBCCredPres'), tcDe2);
  gCredPresOper.cCredPres := StrTocCredPres(ObterConteudo(ANode.Childrens.Find('cCredPres'), tcStr));
  Ler_gIBSCredPres(ANode.Childrens.Find('gIBSCredPres'), gCredPresOper.gIBSCredPres);
  Ler_gCBSCredPres(ANode.Childrens.Find('gCBSCredPres'), gCredPresOper.gCBSCredPres);
end;

procedure TDFeRTCXmlReader.Ler_gIBSCredPres(const ANode: TACBrXmlNode;
  gIBSCredPres: TgIBSCBSCredPres);
begin
  if not Assigned(ANode) then Exit;

  gIBSCredPres.pCredPres := ObterConteudo(ANode.Childrens.Find('pCredPres'), tcDe4);
  gIBSCredPres.vCredPres := ObterConteudo(ANode.Childrens.Find('vCredPres'), tcDe2);
  gIBSCredPres.vCredPresCondSus := ObterConteudo(ANode.Childrens.Find('vCredPresCondSus'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gCBSCredPres(const ANode: TACBrXmlNode; gCBSCredPres: TgIBSCBSCredPres);
begin
  if not Assigned(ANode) then Exit;

  gCBSCredPres.pCredPres := ObterConteudo(ANode.Childrens.Find('pCredPres'), tcDe4);
  gCBSCredPres.vCredPres := ObterConteudo(ANode.Childrens.Find('vCredPres'), tcDe2);
  gCBSCredPres.vCredPresCondSus := ObterConteudo(ANode.Childrens.Find('vCredPresCondSus'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_DFeReferenciado(const ANode: TACBrXmlNode;
  DFeReferenciado: TDFeReferenciado);
begin
  if not Assigned(ANode) then Exit;

  DFeReferenciado.chaveAcesso := ObterConteudo(ANode.Childrens.Find('chaveAcesso'), tcStr);
  DFeReferenciado.nItem := ObterConteudo(ANode.Childrens.Find('nItem'), tcInt);
end;

procedure TDFeRTCXmlReader.Ler_ISTot(const ANode: TACBrXmlNode; ISTot: TISTot);
begin
  if not Assigned(ANode) then Exit;

  ISTot.vIS := ObterConteudo(ANode.Childrens.Find('vIS'), tcDe2);
end;

procedure TDFeRTCXmlReader.Ler_gMonoTot(const ANode: TACBrXmlNode; gMono: TgMono);
begin
  if not Assigned(ANode) then Exit;

  gMono.vIBSMono := ObterConteudo(ANode.Childrens.Find('vIBSMono'), tcDe2);
  gMono.vCBSMono := ObterConteudo(ANode.Childrens.Find('vCBSMono'), tcDe2);
  gMono.vIBSMonoReten := ObterConteudo(ANode.Childrens.Find('vIBSMonoReten'), tcDe2);
  gMono.vCBSMonoReten := ObterConteudo(ANode.Childrens.Find('vCBSMonoReten'), tcDe2);
  gMono.vIBSMonoRet := ObterConteudo(ANode.Childrens.Find('vIBSMonoRet'), tcDe2);
  gMono.vCBSMonoRet := ObterConteudo(ANode.Childrens.Find('vCBSMonoRet'), tcDe2);
end;

end.

