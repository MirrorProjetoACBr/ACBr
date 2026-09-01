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

unit ACBrDFe.RTC.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDFe.RTC.Classes;

type
  { TDFeRTCXmlWriter }

  TDFeRTCXmlWriter = class(TACBrXmlWriter)
  private
    FpGerarGrupoIBSCBSTot: Boolean;
    FpRedutor: Double;
    FtpEnteGov: TtpEnteGov;
    FModelosDFe: TModelosDFe;
    FtpNFDebito: TtpNFDebito;
  protected
    function CreateOptions: TACBrXmlWriterOptions; override;
  public
    // Usado pela maioria dos DF-e
    function Gerar_gCompraGovReduzido(gCompraGov: TgCompraGovReduzido): TACBrXmlNode;
    function Gerar_gPagAntecipadoProd(gPagAntecipado: TgPagAntecipadoProd): TACBrXmlNode;
    function Gerar_gPagAntecipadoIde(gPagAntecipado: TgPagAntecipado): TACBrXmlNode;

    function Gerar_IBSCBS(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSBPe(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSCTe(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSNF3e(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSNFAg(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSNFCom(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSNFe(IBSCBS: TIBSCBS): TACBrXmlNode;
    function Gerar_IBSCBSNFGas(IBSCBS: TIBSCBS): TACBrXmlNode;

    function Gerar_gIBSCBS(gIBSCBS: TgIBSCBS): TACBrXmlNode;

    function Gerar_gIBSUF(gIBSUF: TgIBSUFValores): TACBrXmlNode;
    function Gerar_gIBSMun(gIBSMun: TgIBSMunValores): TACBrXmlNode;
    function Gerar_gCBS(gCBS: TgCBSValores): TACBrXmlNode;

    function Gerar_gDif(Dif: TgDif): TACBrXmlNode;
    function Gerar_gDevTrib(DevTrib: TgDevTrib): TACBrXmlNode;
    function Gerar_gRed(Red: TgRed): TACBrXmlNode;

    function Gerar_gTribRegular(gTribRegular: TgTribRegular): TACBrXmlNode;
    function Gerar_gTribCompraGov(gTribCompraGov: TgTribCompraGov): TACBrXmlNode;
    function Gerar_gEstornoCred(gEstornoCred: TgEstornoCred): TACBrXmlNode;

    function Gerar_gALCZFMCBS(gALCZFMCBS: TgALCZFMCBS): TACBrXmlNode;

    function Gerar_IBSCBSTot(IBSCBSTot: TIBSCBSTot): TACBrXmlNode;
    function Gerar_gIBSTot(gIBS: TgIBS): TACBrXmlNode;
    function Gerar_gIBSUFTot(gIBSUFTot: TgIBSUFTot): TACBrXmlNode;
    function Gerar_gIBSMunTot(gIBSMunTot: TgIBSMunTot): TACBrXmlNode;
    function Gerar_gCBSTot(gCBS: TgCBS): TACBrXmlNode;
    function Gerar_gEstornoCredTot(gEstornoCred: TgEstornoCred): TACBrXmlNode;

    function Gerar_pgtoVinc(pgtoVinc: TpgtoVinc): TACBrXmlNode;
    function Gerar_pgto(pgto: TpgtoCollection): TACBrXmlNodeArray;

    // Usado pela NF-e
    function Gerar_gCompraGov(gCompraGov: TgCompraGov): TACBrXmlNode;
    function Gerar_gPagAntecipado(gPagAntecipado: TgPagAntecipado): TACBrXmlNode;

    function Gerar_ISel(ISel: TgIS): TACBrXmlNode;

    function Gerar_gIBSCBSMono(gIBSCBSMono: TgIBSCBSMono): TACBrXmlNode;

    function Gerar_gIBSMonoAdRem(gIBSMonoAdRem: TgIBSMonoAdRem): TACBrXmlNode;
    function Gerar_gMonoPadraoIBSQtde(gMonoPadrao: TgMonoPadraoIBSQtde): TACBrXmlNode;
    function Gerar_gMonoRetenIBSQtde(gMonoReten: TgMonoRetenIBSQtde): TACBrXmlNode;
    function Gerar_gMonoRetIBS(gMonoRet: TgMonoRetIBS): TACBrXmlNode;
    function Gerar_gpBioDiferencaIBS(gpBioDiferenca: TgpBioDiferencaIBS): TACBrXmlNode;

    function Gerar_gIBSMonoAdValorem(gIBSMonoAdValorem: TgIBSMonoAdValorem): TACBrXmlNode;
    function Gerar_gMonoPadraoIBSAliq(gMonoPadrao: TgMonoPadraoIBSAliq): TACBrXmlNode;
    function Gerar_gMonoRetenIBSAliq(gMonoReten: TgMonoRetenIBSAliq): TACBrXmlNode;

    function Gerar_gCBSMonoAdRem(gCBSMonoAdRem: TgCBSMonoAdRem): TACBrXmlNode;
    function Gerar_gMonoPadraoCBSQtde(gMonoPadrao: TgMonoPadraoCBSQtde): TACBrXmlNode;
    function Gerar_gMonoRetenCBSQtde(gMonoReten: TgMonoRetenCBSQtde): TACBrXmlNode;
    function Gerar_gMonoRetCBS(gMonoRet: TgMonoRetCBS): TACBrXmlNode;
    function Gerar_gpBioDiferencaCBS(gpBioDiferenca: TgpBioDiferencaCBS): TACBrXmlNode;

    function Gerar_gCBSMonoAdValorem(gCBSMonoAdValorem: TgCBSMonoAdValorem): TACBrXmlNode;
    function Gerar_gMonoPadraoCBSAliq(gMonoPadrao: TgMonoPadraoCBSAliq): TACBrXmlNode;
    function Gerar_gMonoRetenCBSAliq(gMonoReten: TgMonoRetenCBSAliq): TACBrXmlNode;

    function Gerar_gTransfCred(gTransfCred: TgTransfCred): TACBrXmlNode;
    function Gerar_gCredPresIBSZFM(gCredPresIBSZFM: TCredPresIBSZFM): TACBrXmlNode;
    function Gerar_gAjusteCompet(gAjusteCompet: TgAjusteCompet): TACBrXmlNode;
    function Gerar_gCredPresOper(gCredPresOper: TgCredPresOper): TACBrXmlNode;
    function Gerar_gIBSCBSCredPres(IBSCredPres: TgIBSCBSCredPres;
      const Grupo: string): TACBrXmlNode;

    function Gerar_DFeReferenciado(DFeReferenciado: TDFeReferenciado): TACBrXmlNode;

    function Gerar_ISTot(ISTot: TISTot): TACBrXmlNode;
    function Gerar_gMonoTot(Mono: TgMono): TACBrXmlNode;

    property ModelosDFe: TModelosDFe read FModelosDFe write FModelosDFe;
    property tpNFDebito: TtpNFDebito read FtpNFDebito write FtpNFDebito;
  end;

implementation

uses
  ACBrDFeConsts,
  ACBrDFeUtil;

{ TDFeRTCXmlWriter }

function TDFeRTCXmlWriter.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TACBrXmlWriterOptions.Create;
end;

// Usado pela maioria dos DF-e
function TDFeRTCXmlWriter.Gerar_gCompraGovReduzido(
  gCompraGov: TgCompraGovReduzido): TACBrXmlNode;
var
  i: Integer;
begin
  Result := nil;

  FpRedutor := gCompraGov.pRedutor;
  FtpEnteGov := gCompraGov.tpEnteGov;

  if FpRedutor > 0 then
  begin
    Result := FDocument.CreateElement('gCompraGov');

    Result.AppendChild(AddNode(tcStr, 'B32', 'tpEnteGov', 1, 1, 1,
                          tpEnteGovToStr(gCompraGov.tpEnteGov), DSC_TPENTEGOV));

    Result.AppendChild(AddNode(tcDe4, 'B33', 'pRedutor', 1, 7, 1,
                                            gCompraGov.pRedutor, DSC_PREDUTOR));

    Result.AppendChild(AddNode(tcStr, 'B34', 'tpOperGov', 1, 1, 1,
                          tpOperGovToStr(gCompraGov.tpOperGov), DSC_TPOPERGOV));

    for i := 0 to gCompraGov.refDFe.Count - 1 do
    begin
      Result.AppendChild(AddNode(tcStr, 'B35', 'refDFeAnt', 44, 44, 1,
                                    gCompraGov.refDFe[i].refDFeAnt, DSC_CHAVE));
    end;
  end;
end;

function TDFeRTCXmlWriter.Gerar_gPagAntecipadoProd(
  gPagAntecipado: TgPagAntecipadoProd): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gPagAntecipado');

  Result.AppendChild(AddNode(tcStr, '#171', 'chDFePagAnt', 44, 44, 1,
                                  gPagAntecipado.chDFePagAnt, DSC_CHDFEPAGANT));

  Result.AppendChild(AddNode(tcInt, '#172', 'nItemPagAnt', 1, 3, 0,
                                  gPagAntecipado.nItemPagAnt, DSC_NITEMPAGANT));
end;

function TDFeRTCXmlWriter.Gerar_gPagAntecipadoIde(
  gPagAntecipado: TgPagAntecipado): TACBrXmlNode;
var
  i: Integer;
begin
  Result := nil;

  if gPagAntecipado.refNFe.Count > 0 then
  begin
    Result := FDocument.CreateElement('gPagAntecipado');

    for i := 0 to gPagAntecipado.refNFe.Count - 1 do
    begin
      Result.AppendChild(AddNode(tcStr,'BC02','chDFePagAnt', 44, 44, 1,
                             gPagAntecipado.refNFe[i].refDFEChave, DSC_REFNFE));
    end;
  end;

  if gPagAntecipado.refNFe.Count > 99 then
    wAlerta('BB02', 'chDFePagAnt', DSC_REFNFE, ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TDFeRTCXmlWriter.Gerar_IBSCBS(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  if (IBSCBS.CST <> cstNenhum) and (IBSCBS.cClassTrib <> '') then
  begin
    FpGerarGrupoIBSCBSTot := True;
    Result := CreateElement('IBSCBS');

    Result.AppendChild(AddNode(tcStr, '#1', 'CST', 3, 3, 1,
                                          CSTIBSCBSToStr(IBSCBS.CST), DSC_CST));

    Result.AppendChild(AddNode(tcStr, '#2', 'cClassTrib', 6, 6, 1,
                                            IBSCBS.cClassTrib, DSC_CCLASSTRIB));

    if IBSCBS.indDoacao = tieSim then
      Result.AppendChild(AddNode(tcStr, '#3', 'indDoacao', 1, 1, 0,
                                                           '1', DSC_INDDOACAO));

    case ModelosDFe of
      mdfBPe, mdfBPeTM, mdfBPeTA:
        Result.AppendChild(Gerar_IBSCBSBPe(IBSCBS));

      mdfCTe, mdfCTeOS, mdfCTeSimp, mdfGTVe:
        Result.AppendChild(Gerar_IBSCBSCTe(IBSCBS));

      mdfNF3e:
        Result.AppendChild(Gerar_IBSCBSNF3e(IBSCBS));

      mdfNFAg:
        Result.AppendChild(Gerar_IBSCBSNFAg(IBSCBS));

      mdfNFCom:
        Result.AppendChild(Gerar_IBSCBSNFCom(IBSCBS));

      mdfNFe, mdfNFCe:
        Result.AppendChild(Gerar_IBSCBSNFe(IBSCBS));

      mdfNFGas:
        Result.AppendChild(Gerar_IBSCBSNFGas(IBSCBS));
    else
      Result.AppendChild(nil);
    end;
  end;

  if (IBSCBS.gEstornoCred.vIBSEstCred > 0) or (IBSCBS.gEstornoCred.vCBSEstCred > 0) or
     ((ModelosDFe = mdfNFe) and (tpNFDebito = tdPerdaEmEstoque)) then
    Result.AppendChild(Gerar_gEstornoCred(IBSCBS.gEstornoCred));

  if ModelosDFe = mdfNFe then
  begin
    if (IBSCBS.gCredPresOper.cCredPres <> cpNenhum) then
      Result.AppendChild(Gerar_gCredPresOper(IBSCBS.gCredPresOper))
    else if (IBSCBS.gCredPresIBSZFM.tpCredPresIBSZFM <> tcpNenhum) then
      Result.AppendChild(Gerar_gCredPresIBSZFM(IBSCBS.gCredPresIBSZFM));
  end;
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSBPe(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  case ModelosDFe of
    mdfBPe:
      if IBSCBS.CST in [cst000, cst200, cst222] then
        Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);

    mdfBPeTM:
      if IBSCBS.CST in [cst200] then
        Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);

    mdfBPeTA:
      if IBSCBS.CST in [cst000, cst200, cst222] then
        Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);
  end;
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSCTe(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  case ModelosDFe of
    mdfCTe:
      if IBSCBS.CST in [cst000, cst200] then
        Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);

    mdfCTeSimp:
      if IBSCBS.CST in [cst000, cst200] then
        Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);

    mdfCTeOS:
      if IBSCBS.CST in [cst000, cst200, cst222] then
        Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);
  end;
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSNF3e(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  if IBSCBS.CST in [cst000, cst200, cst510, cst830] then
    Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSNFAg(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  if IBSCBS.CST = cst000 then
    Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSNFCom(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  if IBSCBS.CST in [cst000, cst200] then
    Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSNFe(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  case ModelosDFe of
    mdfNFe:
      begin
        case IBSCBS.CST of
          cst000, cst200, cst510, cst515, cst550, cst830:
            Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);

          cst620:
            Result := Gerar_gIBSCBSMono(IBSCBS.gIBSCBSMono);

          cst800:
            Result := Gerar_gTransfCred(IBSCBS.gTransfCred);

          cst811:
            Result := Gerar_gAjusteCompet(IBSCBS.gAjusteCompet);
        end;
      end;

    mdfNFCe:
      begin
        case IBSCBS.CST of
          cst000, cst200:
            Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);

          cst620:
            Result := Gerar_gIBSCBSMono(IBSCBS.gIBSCBSMono);
        end;
      end;
  end;
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSNFGas(IBSCBS: TIBSCBS): TACBrXmlNode;
begin
  Result := nil;

  if IBSCBS.CST = cst000 then
    Result := Gerar_gIBSCBS(IBSCBS.gIBSCBS);
end;

function TDFeRTCXmlWriter.Gerar_gIBSCBS(gIBSCBS: TgIBSCBS): TACBrXmlNode;
begin
  Result := CreateElement('gIBSCBS');

  Result.AppendChild(AddNode(tcDe2, '#4', 'vBC', 1, 15, 1,
                                                   gIBSCBS.vBC, DSC_VBCIBSCBS));

  Result.AppendChild(Gerar_gIBSUF(gIBSCBS.gIBSUF));
  Result.AppendChild(Gerar_gIBSMun(gIBSCBS.gIBSMun));

  Result.AppendChild(AddNode(tcDe2, '#26a', 'vIBS', 1, 15, 1,
                                                       gIBSCBS.vIBS, DSC_VIBS));

  Result.AppendChild(Gerar_gCBS(gIBSCBS.gCBS));

  if gIBSCBS.gTribRegular.CSTReg <> cstNenhum then
    Result.AppendChild(Gerar_gTribRegular(gIBSCBS.gTribRegular));

  if (gIBSCBS.gTribCompraGov.pAliqIBSUF > 0) and (FtpEnteGov <> tcgNenhum) then
    Result.AppendChild(Gerar_gTribCompraGov(gIBSCBS.gTribCompraGov));
end;

function TDFeRTCXmlWriter.Gerar_gIBSUF(
  gIBSUF: TgIBSUFValores): TACBrXmlNode;
begin
  Result := CreateElement('gIBSUF');

  Result.AppendChild(AddNode(tcDe4, '#6', 'pIBSUF', 1, 7, 1,
                                                    gIBSUF.pIBSUF, DSC_PIBSUF));

  if gIBSUF.gDif.pDif > 0 then
    Result.AppendChild(Gerar_gDif(gIBSUF.gDif));

  if gIBSUF.gDevTrib.vDevTrib > 0 then
    Result.AppendChild(Gerar_gDevTrib(gIBSUF.gDevTrib));

  if (gIBSUF.gRed.pRedAliq > 0) or (gIBSUF.gRed.pAliqEfet > 0) or
     (FpRedutor > 0) then
    Result.AppendChild(Gerar_gRed(gIBSUF.gRed));

  Result.AppendChild(AddNode(tcDe2, '#23', 'vIBSUF', 1, 15, 1,
                                                    gIBSUF.vIBSUF, DSC_VIBSUF));
end;

function TDFeRTCXmlWriter.Gerar_gIBSMun(
  gIBSMun: TgIBSMunValores): TACBrXmlNode;
begin
  Result := CreateElement('gIBSMun');

  Result.AppendChild(AddNode(tcDe4, '#6', 'pIBSMun', 1, 7, 1,
                                                 gIBSMun.pIBSMun, DSC_PIBSMUN));

  if gIBSMun.gDif.pDif > 0 then
    Result.AppendChild(Gerar_gDif(gIBSMun.gDif));

  if gIBSMun.gDevTrib.vDevTrib > 0 then
    Result.AppendChild(Gerar_gDevTrib(gIBSMun.gDevTrib));

  if (gIBSMun.gRed.pRedAliq > 0) or (gIBSMun.gRed.pAliqEfet > 0) or
     (FpRedutor > 0) then
    Result.AppendChild(Gerar_gRed(gIBSMun.gRed));

  Result.AppendChild(AddNode(tcDe2, '#23', 'vIBSMun', 1, 15, 1,
                                                 gIBSMun.vIBSMun, DSC_VIBSMUN));
end;

function TDFeRTCXmlWriter.Gerar_gCBS(
  gCBS: TgCBSValores): TACBrXmlNode;
begin
  Result := CreateElement('gCBS');

  Result.AppendChild(AddNode(tcDe4, '#44', 'pCBS', 1, 7, 1,
                                                          gCBS.pCBS, DSC_PCBS));

  if gCBS.gDif.pDif > 0 then
    Result.AppendChild(Gerar_gDif(gCBS.gDif));

  if gCBS.gDevTrib.vDevTrib > 0 then
    Result.AppendChild(Gerar_gDevTrib(gCBS.gDevTrib));

  if (gCBS.gRed.pRedAliq > 0) or (gCBS.gRed.pAliqEfet > 0) or
     (FpRedutor > 0) then
    Result.AppendChild(Gerar_gRed(gCBS.gRed));

  if (gCBS.gALCZFMCBS.pAliqEfetRegCBS > 0) or (gCBS.gALCZFMCBS.vTribRegCBS > 0) then
    Result.AppendChild(Gerar_gALCZFMCBS(gCBS.gALCZFMCBS));

  Result.AppendChild(AddNode(tcDe2, '#61', 'vCBS', 1, 15, 1,
                                                          gCBS.vCBS, DSC_VCBS));
end;

function TDFeRTCXmlWriter.Gerar_gDif(
  Dif: TgDif): TACBrXmlNode;
begin
  Result := CreateElement('gDif');

  Result.AppendChild(AddNode(tcDe4, '#10', 'pDif', 1, 7, 1,
                                                           Dif.pDif, DSC_PDIF));

  Result.AppendChild(AddNode(tcDe2, '#11', 'vDif', 1, 15, 1,
                                                           Dif.vDif, DSC_VDIF));
end;

function TDFeRTCXmlWriter.Gerar_gDevTrib(
  DevTrib: TgDevTrib): TACBrXmlNode;
begin
  Result := CreateElement('gDevTrib');

  Result.AppendChild(AddNode(tcDe2, '#12', 'pDevTrib', 1, 15, 0,
                                               DevTrib.pDevTrib, DSC_PDEVTRIB));

  Result.AppendChild(AddNode(tcDe2, '#13', 'vDevTrib', 1, 15, 1,
                                               DevTrib.vDevTrib, DSC_VDEVTRIB));
end;

function TDFeRTCXmlWriter.Gerar_gRed(
  Red: TgRed): TACBrXmlNode;
begin
  Result := CreateElement('gRed');

  Result.AppendChild(AddNode(tcDe4, '#15', 'pRedAliq', 1, 7, 1,
                                                   Red.pRedAliq, DSC_PREDALIQ));

  Result.AppendChild(AddNode(tcDe2, '#16', 'pAliqEfet', 1, 7, 1,
                                                 Red.pAliqEfet, DSC_PALIQEFET));
end;

function TDFeRTCXmlWriter.Gerar_gTribRegular(
  gTribRegular: TgTribRegular): TACBrXmlNode;
begin
  Result := CreateElement('gTribRegular');

  Result.AppendChild(AddNode(tcStr, '#56', 'CSTReg', 3, 3, 1,
                                 CSTIBSCBSToStr(gTribRegular.CSTReg), DSC_CST));

  Result.AppendChild(AddNode(tcStr, '#57', 'cClassTribReg', 6, 6, 1,
                                   gTribRegular.cClassTribReg, DSC_CCLASSTRIB));

  Result.AppendChild(AddNode(tcDe4, '#58', 'pAliqEfetRegIBSUF', 1, 7, 1,
                                    gTribRegular.pAliqEfetRegIBSUF, DSC_PALIQ));

  Result.AppendChild(AddNode(tcDe2, '#59', 'vTribRegIBSUF', 1, 15, 1,
                                     gTribRegular.vTribRegIBSUF, DSC_VTRIBREG));

  Result.AppendChild(AddNode(tcDe4, '#60', 'pAliqEfetRegIBSMun', 1, 7, 1,
                                   gTribRegular.pAliqEfetRegIBSMun, DSC_PALIQ));

  Result.AppendChild(AddNode(tcDe2, '#61', 'vTribRegIBSMun', 1, 15, 1,
                                    gTribRegular.vTribRegIBSMun, DSC_VTRIBREG));

  Result.AppendChild(AddNode(tcDe4, '#62', 'pAliqEfetRegCBS', 1, 7, 1,
                                      gTribRegular.pAliqEfetRegCBS, DSC_PALIQ));

  Result.AppendChild(AddNode(tcDe2, '#63', 'vTribRegCBS', 1, 15, 1,
                                       gTribRegular.vTribRegCBS, DSC_VTRIBREG));
end;

function TDFeRTCXmlWriter.Gerar_gTribCompraGov(
  gTribCompraGov: TgTribCompraGov): TACBrXmlNode;
begin
  Result := CreateElement('gTribCompraGov');

  Result.AppendChild(AddNode(tcDe4, '#1', 'pAliqIBSUF', 1, 7, 1,
                                    gTribCompraGov.pAliqIBSUF, DSC_PALIQIBSUF));

  Result.AppendChild(AddNode(tcDe2, '#1', 'vTribIBSUF', 1, 15, 1,
                                    gTribCompraGov.vTribIBSUF, DSC_VTRIBIBSUF));

  Result.AppendChild(AddNode(tcDe4, '#1', 'pAliqIBSMun', 1, 7, 1,
                                  gTribCompraGov.pAliqIBSMun, DSC_PALIQIBSMUN));

  Result.AppendChild(AddNode(tcDe2, '#1', 'vTribIBSMun', 1, 15, 1,
                                  gTribCompraGov.vTribIBSMun, DSC_VTRIBIBSMUN));

  Result.AppendChild(AddNode(tcDe4, '#1', 'pAliqCBS', 1, 7, 1,
                                        gTribCompraGov.pAliqCBS, DSC_PALIQCBS));

  Result.AppendChild(AddNode(tcDe2, '#1', 'vTribCBS', 1, 15, 1,
                                        gTribCompraGov.vTribCBS, DSC_VTRIBCBS));
end;

function TDFeRTCXmlWriter.Gerar_gEstornoCred(
  gEstornoCred: TgEstornoCred): TACBrXmlNode;
begin
  Result := CreateElement('gEstornoCred');

  Result.AppendChild(AddNode(tcDe2, '#1', 'vIBSEstCred', 1, 7, 1,
                                    gEstornoCred.vIBSEstCred, DSC_VIBSESTCRED));

  Result.AppendChild(AddNode(tcDe2, '#1', 'vCBSEstCred', 1, 15, 1,
                                    gEstornoCred.vCBSEstCred, DSC_VCBSESTCRED));
end;

function TDFeRTCXmlWriter.Gerar_gALCZFMCBS(
  gALCZFMCBS: TgALCZFMCBS): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gALCZFMCBS');

  Result.AppendChild(AddNode(tcStr, 'UB66b', 'tpALCZFMCBS', 1, 1, 1,
                    tpALCZFMCBSToStr(gALCZFMCBS.tpALCZFMCBS), DSC_TPALCZFMCBS));

  Result.AppendChild(AddNode(tcStr, 'UB66c', 'nProcSuframa', 8, 12, 0,
                                    gALCZFMCBS.nProcSuframa, DSC_NPROCSUFRAMA));

  Result.AppendChild(AddNode(tcDe4, 'UB66d', 'pAliqEfetRegCBS', 1, 7, 1,
                              gALCZFMCBS.pAliqEfetRegCBS, DSC_PALIQEFETREGCBS));

  Result.AppendChild(AddNode(tcDe2, 'UB66e', 'vTribRegCBS', 1, 15, 1,
                                      gALCZFMCBS.vTribRegCBS, DSC_VTRIBREGCBS));
end;

function TDFeRTCXmlWriter.Gerar_IBSCBSTot(IBSCBSTot: TIBSCBSTot): TACBrXmlNode;
begin
  Result := nil;

  if FpGerarGrupoIBSCBSTot then
  begin
    Result := CreateElement('IBSCBSTot');

    Result.AppendChild(AddNode(tcDe2, '#1', 'vBCIBSCBS', 1, 15, 1,
                                             IBSCBSTot.vBCIBSCBS, DSC_VBCCIBS));

    if (IBSCBSTot.gIBS.vIBS > 0) or
       (IBSCBSTot.gIBS.gIBSUFTot.vDif > 0) or (IBSCBSTot.gIBS.gIBSMunTot.vDif > 0) or
       (IBSCBSTot.gIBS.gIBSUFTot.vDevTrib > 0) or (IBSCBSTot.gIBS.gIBSMunTot.vDevTrib > 0) or
       (IBSCBSTot.gIBS.vCredPres > 0) or (IBSCBSTot.gIBS.vCredPresCondSus > 0) then
      Result.AppendChild(Gerar_gIBSTot(IBSCBSTot.gIBS));

    if (IBSCBSTot.gCBS.vCBS > 0) or (IBSCBSTot.gCBS.vDif > 0) or (IBSCBSTot.gCBS.vDevTrib > 0) or
       (IBSCBSTot.gCBS.vCredPres > 0) or (IBSCBSTot.gCBS.vCredPresCondSus > 0) then
      Result.AppendChild(Gerar_gCBSTot(IBSCBSTot.gCBS));

    if (IBSCBSTot.gMono.vIBSMono > 0) or (IBSCBSTot.gMono.vCBSMono > 0) or
       (IBSCBSTot.gMono.vIBSMonoReten > 0) or (IBSCBSTot.gMono.vCBSMonoReten > 0) or
       (IBSCBSTot.gMono.vIBSMonoRet > 0) or (IBSCBSTot.gMono.vCBSMonoRet > 0) then
      Result.AppendChild(Gerar_gMonoTot(IBSCBSTot.gMono));

    if (IBSCBSTot.gEstornoCred.vIBSEstCred > 0) or (IBSCBSTot.gEstornoCred.vCBSEstCred > 0) then
      Result.AppendChild(Gerar_gEstornoCredTot(IBSCBSTot.gEstornoCred));
  end;
end;

function TDFeRTCXmlWriter.Gerar_gIBSTot(gIBS: TgIBS): TACBrXmlNode;
begin
  Result := CreateElement('gIBS');

  Result.AppendChild(Gerar_gIBSUFTot(gIBS.gIBSUFTot));
  Result.AppendChild(Gerar_gIBSMunTot(gIBS.gIBSMunTot));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vIBS', 1, 15, 1,
                                                       gIBS.vIBS, DSC_VIBSTOT));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vCredPres', 1, 15, 1,
                                                gIBS.vCredPres, DSC_VCREDPRES));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vCredPresCondSus', 1, 15, 1,
                                  gIBS.vCredPresCondSus, DSC_VCREDPRESCONDSUS));
end;

function TDFeRTCXmlWriter.Gerar_gIBSUFTot(
  gIBSUFTot: TgIBSUFTot): TACBrXmlNode;
begin
  Result := CreateElement('gIBSUF');

  Result.AppendChild(AddNode(tcDe2, '#4', 'vDif', 1, 15, 1,
                                                     gIBSUFTot.vDif, DSC_VDIF));

  Result.AppendChild(AddNode(tcDe2, '#5', 'vDevTrib', 1, 15, 1,
                                             gIBSUFTot.vDevTrib, DSC_VDEVTRIB));

  Result.AppendChild(AddNode(tcDe2, '#7', 'vIBSUF', 1, 15, 1,
                                                 gIBSUFTot.vIBSUF, DSC_VIBSUF));
end;

function TDFeRTCXmlWriter.Gerar_gIBSMunTot(
  gIBSMunTot: TgIBSMunTot): TACBrXmlNode;
begin
  Result := CreateElement('gIBSMun');

  Result.AppendChild(AddNode(tcDe2, '#9', 'vDif', 1, 15, 1,
                                                    gIBSMunTot.vDif, DSC_VDIF));

  Result.AppendChild(AddNode(tcDe2, '#10', 'vDevTrib', 1, 15, 1,
                                            gIBSMunTot.vDevTrib, DSC_VDEVTRIB));

  Result.AppendChild(AddNode(tcDe2, '#12', 'vIBSMun', 1, 15, 1,
                                              gIBSMunTot.vIBSMun, DSC_VIBSMUN));
end;

function TDFeRTCXmlWriter.Gerar_gCBSTot(gCBS: TgCBS): TACBrXmlNode;
begin
  Result := CreateElement('gCBS');

  Result.AppendChild(AddNode(tcDe2, '#17', 'vDif', 1, 15, 1,
                                                          gCBS.vDif, DSC_VDIF));

  Result.AppendChild(AddNode(tcDe2, '#18', 'vDevTrib', 1, 15, 1,
                                                  gCBS.vDevTrib, DSC_VDEVTRIB));

  Result.AppendChild(AddNode(tcDe2, '#21', 'vCBS', 1, 15, 1,
                                                          gCBS.vCBS, DSC_VCBS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vCredPres', 1, 15, 1,
                                                gCBS.vCredPres, DSC_VCREDPRES));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vCredPresCondSus', 1, 15, 1,
                                  gCBS.vCredPresCondSus, DSC_VCREDPRESCONDSUS));
end;

function TDFeRTCXmlWriter.Gerar_gEstornoCredTot(
  gEstornoCred: TgEstornoCred): TACBrXmlNode;
begin
  Result := CreateElement('gEstornoCred');

  Result.AppendChild(AddNode(tcDe2, '#1', 'vIBSEstCred', 1, 7, 1,
                                    gEstornoCred.vIBSEstCred, DSC_VIBSESTCRED));

  Result.AppendChild(AddNode(tcDe2, '#1', 'vCBSEstCred', 1, 15, 1,
                                    gEstornoCred.vCBSEstCred, DSC_VCBSESTCRED));
end;

function TDFeRTCXmlWriter.Gerar_pgtoVinc(pgtoVinc: TpgtoVinc): TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: integer;
begin
  Result := nil;

  if pgtoVinc.pgto.Count > 0 then
  begin
    Result := CreateElement('pgtoVinc');

    nodeArray := Gerar_pgto(pgtoVinc.pgto);
    for i := 0 to pgtoVinc.pgto.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TDFeRTCXmlWriter.Gerar_pgto(pgto: TpgtoCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;

  SetLength(Result, pgto.Count);

  for i := 0 to pgto.Count - 1 do
  begin
    Result[i] := CreateElement('pgto');

    Result[i].SetAttribute('nPag', IntToStr(pgto[i].nPag));

    Result[i].SetAttribute('idTransacao', pgto[i].idTransacao);

    Result[i].AppendChild(AddNode(tcStr, '#44', 'tpMeioPgto', 2, 2, 1,
                                           pgto[i].tpMeioPgto, DSC_TPMEIOPGTO));

    Result[i].AppendChild(AddNode(tcStr, '#44', 'CNPJReceb', 14, 14, 1,
                                             pgto[i].CNPJReceb, DSC_CNPJRECEB));

    Result[i].AppendChild(AddNode(tcStr, '#44', 'CNPJBasePSP', 8, 8, 1,
                                         pgto[i].CNPJBasePSP, DSC_CNPJBASEPSP));
  end;

  if pgto.Count > 99 then
    wAlerta('#42', 'pgto', '', ERR_MSG_MAIOR_MAXIMO + '99');

  if pgto.Count < 1 then
    wAlerta('#42', 'pgto', '', ERR_MSG_MENOR_MINIMO + '1');
end;

// Usado pela NF-e
function TDFeRTCXmlWriter.Gerar_gCompraGov(
  gCompraGov: TgCompraGov): TACBrXmlNode;
var
  i: Integer;
begin
  Result := nil;

  FpRedutor := gCompraGov.pRedutor;
  FtpEnteGov := gCompraGov.tpEnteGov;

  if FpRedutor > 0 then
  begin
    Result := FDocument.CreateElement('gCompraGov');

    Result.AppendChild(AddNode(tcStr, 'B32', 'tpEnteGov', 1, 1, 1,
                          tpEnteGovToStr(gCompraGov.tpEnteGov), DSC_TPENTEGOV));

    Result.AppendChild(AddNode(tcDe4, 'B33', 'pRedutor', 1, 7, 1,
                                            gCompraGov.pRedutor, DSC_PREDUTOR));

    Result.AppendChild(AddNode(tcStr, 'B34', 'tpOperGov', 1, 1, 1,
                          tpOperGovToStr(gCompraGov.tpOperGov), DSC_TPOPERGOV));

    for i := 0 to gCompraGov.refDFeAnt.Count - 1 do
    begin
      Result.AppendChild(AddNode(tcStr, 'B35', 'refDFeAnt', 44, 44, 1,
                               gCompraGov.refDFeAnt[i].refDFeChave, DSC_CHAVE));
    end;
  end;
end;

function TDFeRTCXmlWriter.Gerar_gPagAntecipado(gPagAntecipado: TgPagAntecipado): TACBrXmlNode;
var
  i: Integer;
begin
  Result := nil;

  if gPagAntecipado.refNFe.Count > 0 then
  begin
    Result := FDocument.CreateElement('gPagAntecipado');

    for i := 0 to gPagAntecipado.refNFe.Count - 1 do
    begin
      Result.AppendChild(AddNode(tcStr,'BC02','refNFe', 44, 44, 1,
                             gPagAntecipado.refNFe[i].refDFEChave, DSC_REFNFE));
    end;
  end;

  if gPagAntecipado.refNFe.Count > 99 then
    wAlerta('BB02', 'refNFe', DSC_REFNFE, ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TDFeRTCXmlWriter.Gerar_ISel(ISel: TgIS): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('IS');

  //Usar string até a publicação de uma tabela de CSTs oficial para o IS
//  Result.AppendChild(AddNode(tcStr, 'UB03', 'CSTIS', 3, 3, 1,
//                                              CSTISToStr(ISel.CSTIS), DSC_CST));
  Result.AppendChild(AddNode(tcStr, 'UB03', 'CSTIS', 3, 3, 1,
                                              ISel.CSTIS, DSC_CST));

  Result.AppendChild(AddNode(tcStr, 'UB04', 'cClassTribIS', 6, 6, 1,
                                            ISel.cClassTribIS, DSC_CCLASSTRIB));

  if (ISel.vBCIS > 0) or (ISel.pIS > 0) or (ISel.uTrib <> '') or
     (ISel.qTrib > 0) or (ISel.vIS > 0) then
  begin
    Result.AppendChild(AddNode(tcDe2, 'UB06', 'vBCIS', 1, 15, 1,
                                                    ISel.vBCIS, DSC_VBCIMPSEL));

    Result.AppendChild(AddNode(tcDe2, 'UB07', 'pIS', 1, 5, 1,
                                                        ISel.pIS, DSC_PIMPSEL));

    Result.AppendChild(AddNode(tcDe2, 'UB08', 'pISEspec', 1, 5, 0,
                                              ISel.pISEspec, DSC_PIMPSELESPEC));

    if (ISel.uTrib <> '') or (ISel.qTrib > 0) then
    begin
      Result.AppendChild(AddNode(tcStr, 'UB09', 'uTrib', 1, 6, 1,
                                                        ISel.uTrib, DSC_UTRIB));

      Result.AppendChild(AddNode(tcDe4, 'UB10', 'qTrib', 1, 15, 0,
                                                        ISel.qTrib, DSC_QTRIB));
    end;

    Result.AppendChild(AddNode(tcDe2, 'UB11', 'vIS', 1, 15, 1,
                                                        ISel.vIS, DSC_VIMPSEL));
  end;
end;

function TDFeRTCXmlWriter.Gerar_gIBSCBSMono(
  gIBSCBSMono: TgIBSCBSMono): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gIBSCBSMono');

  if (gIBSCBSMono.gIBSMonoAdRem.gMonoPadrao.qBCMono > 0) or
     (gIBSCBSMono.gIBSMonoAdRem.gMonoReten.qBCMonoReten > 0) or
     (gIBSCBSMono.gIBSMonoAdRem.gMonoRet.vIBSMonoRet > 0) then
    Result.AppendChild(Gerar_gIBSMonoAdRem(gIBSCBSMono.gIBSMonoAdRem))
  else
  begin
    if (gIBSCBSMono.gIBSMonoAdValorem.gMonoPadrao.vBCMono > 0) or
       (gIBSCBSMono.gIBSMonoAdValorem.gMonoReten.vBCMonoReten > 0) or
       (gIBSCBSMono.gIBSMonoAdValorem.gMonoRet.vIBSMonoRet > 0) then
      Result.AppendChild(Gerar_gIBSMonoAdValorem(gIBSCBSMono.gIBSMonoAdValorem));
  end;

  if (gIBSCBSMono.gCBSMonoAdRem.gMonoPadrao.qBCMono > 0) or
     (gIBSCBSMono.gCBSMonoAdRem.gMonoReten.qBCMonoReten > 0) or
     (gIBSCBSMono.gCBSMonoAdRem.gMonoRet.vCBSMonoRet > 0) then
    Result.AppendChild(Gerar_gCBSMonoAdRem(gIBSCBSMono.gCBSMonoAdRem))
  else
  begin
    if (gIBSCBSMono.gCBSMonoAdValorem.gMonoPadrao.vBCMono > 0) or
       (gIBSCBSMono.gCBSMonoAdValorem.gMonoReten.vBCMonoReten > 0) or
       (gIBSCBSMono.gCBSMonoAdValorem.gMonoRet.vCBSMonoRet > 0) then
      Result.AppendChild(Gerar_gCBSMonoAdValorem(gIBSCBSMono.gCBSMonoAdValorem));
  end;

  Result.AppendChild(AddNode(tcDe2, 'UB104', 'vTotIBSMonoItem', 1, 15, 1,
                                 gIBSCBSMono.vTotIBSMonoItem, DSC_VTOTIBSMONO));

  Result.AppendChild(AddNode(tcDe2, 'UB105', 'vTotCBSMonoItem', 1, 15, 1,
                                 gIBSCBSMono.vTotCBSMonoItem, DSC_VTOTCBSMONO));
end;

function TDFeRTCXmlWriter.Gerar_gIBSMonoAdRem(
  gIBSMonoAdRem: TgIBSMonoAdRem): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gIBSMonoAdRem');

  if gIBSMonoAdRem.gMonoPadrao.qBCMono > 0 then
    Result.AppendChild(Gerar_gMonoPadraoIBSQtde(gIBSMonoAdRem.gMonoPadrao));

  if gIBSMonoAdRem.gMonoReten.qBCMonoReten > 0 then
    Result.AppendChild(Gerar_gMonoRetenIBSQtde(gIBSMonoAdRem.gMonoReten));

  if gIBSMonoAdRem.gMonoRet.vIBSMonoRet > 0 then
    Result.AppendChild(Gerar_gMonoRetIBS(gIBSMonoAdRem.gMonoRet));

  if gIBSMonoAdRem.gpBioDiferenca.qBCBioComb > 0 then
    Result.AppendChild(Gerar_gpBioDiferencaIBS(gIBSMonoAdRem.gpBioDiferenca));
end;

function TDFeRTCXmlWriter.Gerar_gMonoPadraoIBSQtde(
  gMonoPadrao: TgMonoPadraoIBSQtde): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoPadrao');

  Result.AppendChild(AddNode(tcDe4, 'UB85', 'qBCMono', 1, 15, 0,
                                             gMonoPadrao.qBCMono, DSC_QBCMONO));

  Result.AppendChild(AddNode(tcDe4, 'UB86', 'adRemIBS', 1, 7, 1,
                                           gMonoPadrao.adRemIBS, DSC_ADREMIBS));

  Result.AppendChild(AddNode(tcDe2, 'UB88', 'vIBSMono', 1, 15, 1,
                                           gMonoPadrao.vIBSMono, DSC_VIBSMONO));
end;

function TDFeRTCXmlWriter.Gerar_gMonoRetenIBSQtde(
  gMonoReten: TgMonoRetenIBSQtde): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoReten');

  Result.AppendChild(AddNode(tcDe4, 'UB91', 'qBCMonoReten', 1, 15, 0,
                                    gMonoReten.qBCMonoReten, DSC_QBCMONORETEN));

  Result.AppendChild(AddNode(tcDe4, 'UB92', 'adRemIBSReten', 1, 7, 1,
                                  gMonoReten.adRemIBSReten, DSC_ADREMIBSRETEN));

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vIBSMonoReten', 1, 15, 1,
                                  gMonoReten.vIBSMonoReten, DSC_VIBSMONORETEN));
end;

function TDFeRTCXmlWriter.Gerar_gMonoRetIBS(
  gMonoRet: TgMonoRetIBS): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoRet');

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vIBSMonoRet', 1, 15, 1,
                                        gMonoRet.vIBSMonoRet, DSC_VIBSMONORET));
end;

function TDFeRTCXmlWriter.Gerar_gpBioDiferencaIBS(
  gpBioDiferenca: TgpBioDiferencaIBS): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gpBioDiferenca');

  Result.AppendChild(AddNode(tcDe4, 'UB93', 'qBCBioComb', 1, 15, 1,
                                    gpBioDiferenca.qBCBioComb, DSC_QBCBIOCOMB));

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vIBSDiferenca', 1, 15, 1,
                              gpBioDiferenca.vIBSDiferenca, DSC_VIBSDIFERENCA));
end;

function TDFeRTCXmlWriter.Gerar_gIBSMonoAdValorem(
  gIBSMonoAdValorem: TgIBSMonoAdValorem): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gIBSMonoAdValorem');

  if gIBSMonoAdValorem.gMonoPadrao.vBCMono > 0 then
    Result.AppendChild(Gerar_gMonoPadraoIBSAliq(gIBSMonoAdValorem.gMonoPadrao));

  if gIBSMonoAdValorem.gMonoReten.vBCMonoReten > 0 then
    Result.AppendChild(Gerar_gMonoRetenIBSAliq(gIBSMonoAdValorem.gMonoReten));

  if gIBSMonoAdValorem.gMonoRet.vIBSMonoRet > 0 then
    Result.AppendChild(Gerar_gMonoRetIBS(gIBSMonoAdValorem.gMonoRet));

  if gIBSMonoAdValorem.gpBioDiferenca.qBCBioComb > 0 then
    Result.AppendChild(Gerar_gpBioDiferencaIBS(gIBSMonoAdValorem.gpBioDiferenca));
end;

function TDFeRTCXmlWriter.Gerar_gMonoPadraoIBSAliq(
  gMonoPadrao: TgMonoPadraoIBSAliq): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoPadrao');

  Result.AppendChild(AddNode(tcDe2, 'UB85', 'vBCMono', 1, 15, 0,
                                             gMonoPadrao.vBCMono, DSC_VBCMONO));

  Result.AppendChild(AddNode(tcDe4, 'UB86', 'pAliqMonoUF', 1, 7, 1,
                                     gMonoPadrao.pAliqMonoUF, DSC_PALIQMONOUF));

  Result.AppendChild(AddNode(tcDe2, 'UB88', 'vIBSMonoUF', 1, 15, 1,
                                       gMonoPadrao.vIBSMonoUF, DSC_VIBSMONOUF));

  Result.AppendChild(AddNode(tcDe4, 'UB88', 'pAliqMonoMun', 1, 15, 1,
                                   gMonoPadrao.pAliqMonoMun, DSC_PALIQMONOMUN));

  Result.AppendChild(AddNode(tcDe2, 'UB88', 'vIBSMonoMun', 1, 15, 1,
                                     gMonoPadrao.vIBSMonoMun, DSC_VIBSMONOMUN));

  Result.AppendChild(AddNode(tcDe2, 'UB88', 'vIBSMono', 1, 15, 1,
                                           gMonoPadrao.vIBSMono, DSC_VIBSMONO));
end;

function TDFeRTCXmlWriter.Gerar_gMonoRetenIBSAliq(
  gMonoReten: TgMonoRetenIBSAliq): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoReten');

  Result.AppendChild(AddNode(tcDe2, 'UB91', 'vBCMonoReten', 1, 15, 0,
                                    gMonoReten.vBCMonoReten, DSC_VBCMONORETEN));

  Result.AppendChild(AddNode(tcDe4, 'UB92', 'pAliqMonoReten', 1, 7, 1,
                                gMonoReten.pAliqMonoReten, DSC_PALIQMONORETEN));

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vIBSMonoReten', 1, 15, 1,
                                  gMonoReten.vIBSMonoReten, DSC_VIBSMONORETEN));
end;

function TDFeRTCXmlWriter.Gerar_gCBSMonoAdRem(
  gCBSMonoAdRem: TgCBSMonoAdRem): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gCBSMonoAdRem');

  if gCBSMonoAdRem.gMonoPadrao.qBCMono > 0 then
    Result.AppendChild(Gerar_gMonoPadraoCBSQtde(gCBSMonoAdRem.gMonoPadrao));

  if gCBSMonoAdRem.gMonoReten.qBCMonoReten > 0 then
    Result.AppendChild(Gerar_gMonoRetenCBSQtde(gCBSMonoAdRem.gMonoReten));

  if gCBSMonoAdRem.gMonoRet.vCBSMonoRet > 0 then
    Result.AppendChild(Gerar_gMonoRetCBS(gCBSMonoAdRem.gMonoRet));

  if gCBSMonoAdRem.gpBioDiferenca.qBCBioComb > 0 then
    Result.AppendChild(Gerar_gpBioDiferencaCBS(gCBSMonoAdRem.gpBioDiferenca));
end;

function TDFeRTCXmlWriter.Gerar_gMonoPadraoCBSQtde(
  gMonoPadrao: TgMonoPadraoCBSQtde): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoPadrao');

  Result.AppendChild(AddNode(tcDe4, 'UB85', 'qBCMono', 1, 15, 0,
                                             gMonoPadrao.qBCMono, DSC_QBCMONO));

  Result.AppendChild(AddNode(tcDe4, 'UB86', 'adRemCBS', 1, 7, 1,
                                           gMonoPadrao.adRemCBS, DSC_ADREMCBS));

  Result.AppendChild(AddNode(tcDe2, 'UB88', 'vCBSMono', 1, 15, 1,
                                           gMonoPadrao.vCBSMono, DSC_VCBSMONO));
end;

function TDFeRTCXmlWriter.Gerar_gMonoRetenCBSQtde(
  gMonoReten: TgMonoRetenCBSQtde): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoReten');

  Result.AppendChild(AddNode(tcDe4, 'UB91', 'qBCMonoReten', 1, 15, 0,
                                    gMonoReten.qBCMonoReten, DSC_QBCMONORETEN));

  Result.AppendChild(AddNode(tcDe4, 'UB92', 'adRemCBSReten', 1, 7, 1,
                                  gMonoReten.adRemCBSReten, DSC_ADREMCBSRETEN));

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vCBSMonoReten', 1, 15, 1,
                                  gMonoReten.vCBSMonoReten, DSC_VCBSMONORETEN));
end;

function TDFeRTCXmlWriter.Gerar_gMonoRetCBS(
  gMonoRet: TgMonoRetCBS): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoRet');

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vCBSMonoRet', 1, 15, 1,
                                        gMonoRet.vCBSMonoRet, DSC_VCBSMONORET));
end;

function TDFeRTCXmlWriter.Gerar_gpBioDiferencaCBS(
  gpBioDiferenca: TgpBioDiferencaCBS): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gpBioDiferenca');

  Result.AppendChild(AddNode(tcDe4, 'UB93', 'qBCBioComb', 1, 15, 1,
                                    gpBioDiferenca.qBCBioComb, DSC_QBCBIOCOMB));

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vCBSDiferenca', 1, 15, 1,
                              gpBioDiferenca.vCBSDiferenca, DSC_VCBSDIFERENCA));
end;

function TDFeRTCXmlWriter.Gerar_gCBSMonoAdValorem(
  gCBSMonoAdValorem: TgCBSMonoAdValorem): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gCBSMonoAdValorem');

  if gCBSMonoAdValorem.gMonoPadrao.vBCMono > 0 then
    Result.AppendChild(Gerar_gMonoPadraoCBSAliq(gCBSMonoAdValorem.gMonoPadrao));

  if gCBSMonoAdValorem.gMonoReten.vBCMonoReten > 0 then
    Result.AppendChild(Gerar_gMonoRetenCBSAliq(gCBSMonoAdValorem.gMonoReten));

  if gCBSMonoAdValorem.gMonoRet.vCBSMonoRet > 0 then
    Result.AppendChild(Gerar_gMonoRetCBS(gCBSMonoAdValorem.gMonoRet));

  if gCBSMonoAdValorem.gpBioDiferenca.qBCBioComb > 0 then
    Result.AppendChild(Gerar_gpBioDiferencaCBS(gCBSMonoAdValorem.gpBioDiferenca));
end;

function TDFeRTCXmlWriter.Gerar_gMonoPadraoCBSAliq(
  gMonoPadrao: TgMonoPadraoCBSAliq): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoPadrao');

  Result.AppendChild(AddNode(tcDe2, 'UB85', 'vBCMono', 1, 15, 0,
                                             gMonoPadrao.vBCMono, DSC_VBCMONO));

  Result.AppendChild(AddNode(tcDe4, 'UB86', 'pAliqMonoCBS', 1, 7, 1,
                                   gMonoPadrao.pAliqMonoCBS, DSC_PALIQMONOCBS));

  Result.AppendChild(AddNode(tcDe2, 'UB88', 'vCBSMono', 1, 15, 1,
                                           gMonoPadrao.vCBSMono, DSC_VCBSMONO));
end;

function TDFeRTCXmlWriter.Gerar_gMonoRetenCBSAliq(
  gMonoReten: TgMonoRetenCBSAliq): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMonoReten');

  Result.AppendChild(AddNode(tcDe2, 'UB91', 'vBCMonoReten', 1, 15, 0,
                                    gMonoReten.vBCMonoReten, DSC_VBCMONORETEN));

  Result.AppendChild(AddNode(tcDe4, 'UB92', 'pAliqMonoReten', 1, 7, 1,
                                gMonoReten.pAliqMonoReten, DSC_PALIQMONORETEN));

  Result.AppendChild(AddNode(tcDe2, 'UB93', 'vCBSMonoReten', 1, 15, 1,
                                  gMonoReten.vCBSMonoReten, DSC_VCBSMONORETEN));
end;

function TDFeRTCXmlWriter.Gerar_gTransfCred(
  gTransfCred: TgTransfCred): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gTransfCred');

  Result.AppendChild(AddNode(tcDe2, 'UB85', 'vIBS', 1, 15, 1,
                                                   gTransfCred.vIBS, DSC_VIBS));

  Result.AppendChild(AddNode(tcDe2, 'UB86', 'vCBS', 1, 15, 1,
                                                   gTransfCred.vCBS, DSC_VCBS));
end;

function TDFeRTCXmlWriter.Gerar_gCredPresIBSZFM(
  gCredPresIBSZFM: TCredPresIBSZFM): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gCredPresIBSZFM');

  Result.AppendChild(AddNode(tcStr, 'UB132', 'competApur', 7, 7, 1,
                        FormatDateTime('yyyy-mm', gCredPresIBSZFM.competApur)));

  Result.AppendChild(AddNode(tcStr, 'UB133', 'tpCredPresIBSZFM', 1, 15, 1,
    TpCredPresIBSZFMToStr(gCredPresIBSZFM.tpCredPresIBSZFM), DSC_TPCREDPRESIBSZFM));

  Result.AppendChild(AddNode(tcDe2, 'UB134', 'vCredPresIBSZFM', 1, 15, 1,
                         gCredPresIBSZFM.vCredPresIBSZFM, DSC_VCREDPRESIBSZFM));
end;

function TDFeRTCXmlWriter.Gerar_gAjusteCompet(
  gAjusteCompet: TgAjusteCompet): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gAjusteCompet');

  Result.AppendChild(AddNode(tcStr, 'UB112', 'competApur', 7, 7, 1,
                          FormatDateTime('yyyy-mm', gAjusteCompet.competApur)));

  Result.AppendChild(AddNode(tcDe2, 'UB113', 'vIBS', 1, 15, 1,
                                                 gAjusteCompet.vIBS, DSC_VIBS));

  Result.AppendChild(AddNode(tcDe2, 'UB114', 'vCBS', 1, 15, 1,
                                                 gAjusteCompet.vCBS, DSC_VCBS));
end;

function TDFeRTCXmlWriter.Gerar_gCredPresOper(
  gCredPresOper: TgCredPresOper): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gCredPresOper');

  Result.AppendChild(AddNode(tcDe2, '#1', 'vBCCredPres', 1, 15, 1,
                                   gCredPresOper.vBCCredPres, DSC_VBCCREDPRES));

  Result.AppendChild(AddNode(tcStr, '#1', 'cCredPres', 2, 2, 1,
                     cCredPresToStr(gCredPresOper.cCredPres), DSC_VCBSESTCRED));

  if gCredPresOper.gIBSCredPres.pCredPres > 0 then
    Result.AppendChild(Gerar_gIBSCBSCredPres(gCredPresOper.gIBSCredPres, 'gIBSCredPres'));

  if gCredPresOper.gCBSCredPres.pCredPres > 0 then
    Result.AppendChild(Gerar_gIBSCBSCredPres(gCredPresOper.gCBSCredPres, 'gCBSCredPres'));
end;

function TDFeRTCXmlWriter.Gerar_gIBSCBSCredPres(
  IBSCredPres: TgIBSCBSCredPres; const Grupo: string): TACBrXmlNode;
begin
  Result := FDocument.CreateElement(Grupo);

  Result.AppendChild(AddNode(tcDe4, 'UB57', 'pCredPres', 1, 7, 1,
                                         IBSCredPres.pCredPres, DSC_PCREDPRES));

  if IBSCredPres.vCredPresCondSus > 0 then
    Result.AppendChild(AddNode(tcDe2, 'UB59', 'vCredPresCondSus', 1, 15, 1,
                            IBSCredPres.vCredPresCondSus, DSC_VCREDPRESCONDSUS))
  else
    Result.AppendChild(AddNode(tcDe2, 'UB58', 'vCredPres', 1, 15, 1,
                                         IBSCredPres.vCredPres, DSC_VCREDPRES));
end;

function TDFeRTCXmlWriter.Gerar_DFeReferenciado(DFeReferenciado: TDFeReferenciado): TACBrXmlNode;
begin
  Result := nil;

  if Trim(DFeReferenciado.chaveAcesso) <> '' then
  begin
    Result := FDocument.CreateElement('DFeReferenciado');

    Result.AppendChild(AddNode(tcStr, 'VB02', 'chaveAcesso', 44, 44, 1,
                                 DFeReferenciado.chaveAcesso, DSC_CHAVEACESSO));

    if not ValidarChave(DFeReferenciado.chaveAcesso) then
      wAlerta('VB02', 'chaveAcesso', DSC_CHAVEACESSO, ERR_MSG_INVALIDO);

    Result.AppendChild(AddNode(tcInt, 'VB03', 'nItem', 1, 3, 0,
                                             DFeReferenciado.nItem, DSC_NITEM));
  end;
end;

function TDFeRTCXmlWriter.Gerar_ISTot(ISTot: TISTot): TACBrXmlNode;
begin
  Result := nil;

  if ISTot.vIS > 0 then
  begin
    Result := FDocument.CreateElement('ISTot');

    Result.AppendChild(AddNode(tcDe2, 'W35', 'vIS', 1, 15, 1,
                                                           ISTot.vIS, DSC_VIS));
  end;
end;

function TDFeRTCXmlWriter.Gerar_gMonoTot(Mono: TgMono): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMono');

  Result.AppendChild(AddNode(tcDe2, 'W58', 'vIBSMono', 1, 15, 1,
                                            Mono.vIBSMono, DSC_VIBSMONO));

  Result.AppendChild(AddNode(tcDe2, 'W59', 'vCBSMono', 1, 15, 1,
                                            Mono.vCBSMono, DSC_VCBSMONO));

  Result.AppendChild(AddNode(tcDe2, 'W58', 'vIBSMonoReten', 1, 15, 1,
                                        Mono.vIBSMonoReten, DSC_VIBSMONORETEN));

  Result.AppendChild(AddNode(tcDe2, 'W59', 'vCBSMonoReten', 1, 15, 1,
                                        Mono.vCBSMonoReten, DSC_VCBSMONORETEN));

  Result.AppendChild(AddNode(tcDe2, 'W58', 'vIBSMonoRet', 1, 15, 1,
                                            Mono.vIBSMonoRet, DSC_VIBSMONORET));

  Result.AppendChild(AddNode(tcDe2, 'W59', 'vCBSMonoRet', 1, 15, 1,
                                            Mono.vCBSMonoRet, DSC_VCBSMONORET));
end;

end.
