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

unit ACBrDFe.RTC.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.Classes;

type
  { TDFeRTCIniWriter }

  TDFeRTCIniWriter = class
  private
    FtpNFDebito: TtpNFDebito;
    FModelosDFe: TModelosDFe;

  public
    // Usado pela maioria dos DF-e
    procedure Gerar_gCompraGovReduzido(AINIRec: TMemIniFile; gCompraGov: TgCompraGovReduzido);
    procedure Gerar_gPagAntecipadoProd(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipadoProd; Idx1, Idx2: Integer);
    procedure Gerar_gPagAntecipadoIde(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipado);

    procedure Gerar_refDFe(AINIRec: TMemIniFile; refDFe: TrefDFeAntCollection);

    procedure Gerar_IBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);

    procedure Gerar_IBSCBSBPe(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBSCTe(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBSNF3e(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBSNFAg(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBSNFCom(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBSNFe(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Gerar_IBSCBSNFGas(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);

    procedure Gerar_gIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS; Idx1, Idx2: Integer);

    procedure Gerar_gIBSUF(AINIRec: TMemIniFile; gIBSUF: TgIBSUFValores; Idx1, Idx2: Integer);
    procedure Gerar_gIBSMun(AINIRec: TMemIniFile; gIBSMun: TgIBSMunValores; Idx1, Idx2: Integer);
    procedure Gerar_gCBS(AINIRec: TMemIniFile; gCBS: TgCBSValores; Idx1, Idx2: Integer);

    procedure Gerar_gTribRegular(AINIRec: TMemIniFile; gTribRegular: TgTribRegular;
      Idx1, Idx2: Integer);
    procedure Gerar_gTribCompraGov(AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov;
      Idx1, Idx2: Integer);
    procedure Gerar_gEstornoCred(AINIRec: TMemIniFile; gEstornoCred: TgEstornoCred;
      Idx1, Idx2: Integer);

    procedure Gerar_gALCZFMCBS(AINIRec: TMemIniFile; gALCZFMCBS: TgALCZFMCBS;
      Idx1, Idx2: Integer);

    procedure Gerar_IBSCBSTot(AINIRec: TMemIniFile; IBSCBSTot: TIBSCBSTot);
    procedure Gerar_gIBSTot(AINIRec: TMemIniFile; gIBS: TgIBS);
    procedure Gerar_gIBSUFTot(AINIRec: TMemIniFile; gIBSUFTot: TgIBSUFTot);
    procedure Gerar_gIBSMunTot(AINIRec: TMemIniFile; gIBSMunTot: TgIBSMunTot);
    procedure Gerar_gCBSTot(AINIRec: TMemIniFile; gCBS: TgCBS);
    procedure Gerar_gEstornoCredTot(AINIRec: TMemIniFile; gEstornoCred: TgEstornoCred);

    procedure Gerar_pgtoVinc(AINIRec: TMemIniFile; pgto: TpgtoCollection);

    // Usado pela NF-e
    procedure Gerar_gCompraGov(AINIRec: TMemIniFile; gCompraGov: TgCompraGov);
    procedure Gerar_gPagAntecipado(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipado);

    procedure Gerar_DFeRef(AINIRec: TMemIniFile; refDFe: TDFErefCollection);

    procedure Gerar_ISel(AINIRec: TMemIniFile; ISel: TgIS; Idx: Integer);

    procedure Gerar_gIBSCBSMono(AINIRec: TMemIniFile; IBSCBSMono: TgIBSCBSMono; Idx: Integer);

    procedure Gerar_gIBSMonoAdRem(AINIRec: TMemIniFile; gIBSMonoAdRem: TgIBSMonoAdRem; Idx: Integer);
    procedure Gerar_gMonoPadraoIBSQtde(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoIBSQtde; Idx: Integer);
    procedure Gerar_gMonoRetenIBSQtde(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenIBSQtde; Idx: Integer);
    procedure Gerar_gMonoRetIBSQtde(AINIRec: TMemIniFile; gMonoRet: TgMonoRetIBS; Idx: Integer);
    procedure Gerar_gpBioDiferencaIBS(AINIRec: TMemIniFile; gpBioDiferenca: TgpBioDiferencaIBS; Idx: Integer);

    procedure Gerar_gIBSMonoAdValorem(AINIRec: TMemIniFile; gIBSMonoAdValorem: TgIBSMonoAdValorem; Idx: Integer);
    procedure Gerar_gMonoPadraoIBSAliq(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoIBSAliq; Idx: Integer);
    procedure Gerar_gMonoRetenIBSAliq(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenIBSAliq; Idx: Integer);
    procedure Gerar_gMonoRetIBSAliq(AINIRec: TMemIniFile; gMonoRet: TgMonoRetIBS; Idx: Integer);

    procedure Gerar_gCBSMonoAdRem(AINIRec: TMemIniFile; gCBSMonoAdRem: TgCBSMonoAdRem; Idx: Integer);
    procedure Gerar_gMonoPadraoCBSQtde(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoCBSQtde; Idx: Integer);
    procedure Gerar_gMonoRetenCBSQtde(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenCBSQtde; Idx: Integer);
    procedure Gerar_gMonoRetCBSQtde(AINIRec: TMemIniFile; gMonoRet: TgMonoRetCBS; Idx: Integer);
    procedure Gerar_gpBioDiferencaCBS(AINIRec: TMemIniFile; gpBioDiferenca: TgpBioDiferencaCBS; Idx: Integer);

    procedure Gerar_gCBSMonoAdValorem(AINIRec: TMemIniFile; gCBSMonoAdValorem: TgCBSMonoAdValorem; Idx: Integer);
    procedure Gerar_gMonoPadraoCBSAliq(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoCBSAliq; Idx: Integer);
    procedure Gerar_gMonoRetenCBSAliq(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenCBSAliq; Idx: Integer);
    procedure Gerar_gMonoRetCBSAliq(AINIRec: TMemIniFile; gMonoRet: TgMonoRetCBS; Idx: Integer);

    procedure Gerar_gTransfCred(AINIRec: TMemIniFile; gTransfCred: TgTransfCred; Idx: Integer);
    procedure Gerar_gCredPresIBSZFM(AINIRec: TMemIniFile; gCredPresIBSZFM: TCredPresIBSZFM; Idx: Integer);
    procedure Gerar_gAjusteCompet(AINIRec: TMemIniFile; gAjusteCompet: TgAjusteCompet; Idx: Integer);
    procedure Gerar_gCredPresOper(AINIRec: TMemIniFile; gCredPresOper: TgCredPresOper; Idx: Integer);
    procedure Gerar_gIBSCBSCredPres(AINIRec: TMemIniFile; IBSCredPres: TgIBSCBSCredPres;
      const Grupo: string; Idx: Integer);

    procedure Gerar_DFeReferenciado(AINIRec: TMemIniFile;
      DFeReferenciado: TDFeReferenciado; Idx: Integer);

    procedure Gerar_ISTot(AINIRec: TMemIniFile; ISTot: TISTot);
    procedure Gerar_gMonoTot(AINIRec: TMemIniFile; gMono: TgMono);

    property ModelosDFe: TModelosDFe read FModelosDFe write FModelosDFe;
    property tpNFDebito: TtpNFDebito read FtpNFDebito write FtpNFDebito;
  end;

implementation

uses
  ACBrDFeUtil,
  ACBrUtil.Base;

{ TDFeRTCIniWriter }

// Usado pela maioria dos DF-e
procedure TDFeRTCIniWriter.Gerar_gCompraGovReduzido(AINIRec: TMemIniFile; gCompraGov: TgCompraGovReduzido);
var
  sSecao: string;
begin
  sSecao := 'gCompraGov';

  if (gCompraGov.pRedutor > 0) then
  begin
    AINIRec.WriteString(sSecao, 'tpEnteGov', tpEnteGovToStr(gCompraGov.tpEnteGov));
    AINIRec.WriteFloat(sSecao, 'pRedutor', gCompraGov.pRedutor);
    AINIRec.WriteString(sSecao, 'tpOperGov', tpOperGovToStr(gCompraGov.tpOperGov));

    Gerar_refDFe(AINIRec, gCompraGov.refDFe);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_gPagAntecipadoProd(AINIRec: TMemIniFile;
  gPagAntecipado: TgPagAntecipadoProd; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gPagAntecipado'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gPagAntecipado' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gPagAntecipado' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteString(sSecao, 'chDFePagAnt', gPagAntecipado.chDFePagAnt);
  AINIRec.WriteInteger(sSecao, 'nItemPagAnt', gPagAntecipado.nItemPagAnt);
end;

procedure TDFeRTCIniWriter.Gerar_gPagAntecipadoIde(AINIRec: TMemIniFile;
  gPagAntecipado: TgPagAntecipado);
var
  I: Integer;
  sSecao: string;
begin
  for I := 0 to gPagAntecipado.refNFe.Count - 1 do
  begin
    sSecao := 'gPagAntecipado' + IntToStrZero(I + 1, 2);
    AINIRec.WriteString(sSecao, 'chDFePagAnt', gPagAntecipado.refNFe[I].refDFEChave);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_refDFe(AINIRec: TMemIniFile;
  refDFe: TrefDFeAntCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to refDFe.Count - 1 do
  begin
    sSecao := 'refDFeAnt' + IntToStrZero(i + 1, 3);

    AINIRec.WriteString(sSecao, 'refDFeAnt', refDFe[i].refDFeAnt);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if (IBSCBS.gIBSCBS.vBC > 0) then
  begin
    if Idx1 = -1 then
      sSecao := 'IBSCBS'
    else
    begin
      if Idx2 = -1 then
        sSecao := 'IBSCBS' + IntToStrZero(Idx1, 3)
      else
        sSecao := 'IBSCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
    end;

    AINIRec.WriteString(sSecao, 'CST', CSTIBSCBSToStr(IBSCBS.CST));
    AINIRec.WriteString(sSecao, 'cClassTrib', IBSCBS.cClassTrib);
    AINIRec.WriteString(sSecao, 'indDoacao', TIndicadorExToStr(IBSCBS.indDoacao));

    case ModelosDFe of
      mdfBPe, mdfBPeTM, mdfBPeTA:
        Gerar_IBSCBSBPe(AINIRec, IBSCBS, Idx1, Idx2);

      mdfCTe, mdfCTeOS, mdfCTeSimp, mdfGTVe:
        Gerar_IBSCBSCTe(AINIRec, IBSCBS, Idx1, Idx2);

      mdfNF3e:
        Gerar_IBSCBSNF3e(AINIRec, IBSCBS, Idx1, Idx2);

      mdfNFAg:
        Gerar_IBSCBSNFAg(AINIRec, IBSCBS, Idx1, Idx2);

      mdfNFCom:
        Gerar_IBSCBSNFCom(AINIRec, IBSCBS, Idx1, Idx2);

      mdfNFe, mdfNFCe:
        Gerar_IBSCBSNFe(AINIRec, IBSCBS, Idx1, Idx2);

      mdfNFGas:
        Gerar_IBSCBSNFGas(AINIRec, IBSCBS, Idx1, Idx2);
    end;
  end;

  if (IBSCBS.gEstornoCred.vIBSEstCred > 0) or (IBSCBS.gEstornoCred.vCBSEstCred > 0) or
     ((ModelosDFe = mdfNFe) and (tpNFDebito = tdPerdaEmEstoque)) then
    Gerar_gEstornoCred(AINIRec, IBSCBS.gEstornoCred, Idx1, Idx2);

  if ModelosDFe = mdfNFe then
  begin
    if (IBSCBS.gCredPresOper.cCredPres <> cpNenhum) then
      Gerar_gCredPresOper(AINIRec, IBSCBS.gCredPresOper, Idx1)
    else if (IBSCBS.gCredPresIBSZFM.tpCredPresIBSZFM <> tcpNenhum) then
      Gerar_gCredPresIBSZFM(AINIRec, IBSCBS.gCredPresIBSZFM, Idx1);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSBPe(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  case ModelosDFe of
    mdfBPe:
      if IBSCBS.CST in [cst000, cst200, cst222] then
        Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);

    mdfBPeTM:
      if IBSCBS.CST in [cst200] then
        Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);

    mdfBPeTA:
      if IBSCBS.CST in [cst000, cst200, cst222] then
        Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSCTe(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  case ModelosDFe of
    mdfCTe:
      if IBSCBS.CST in [cst000, cst200] then
        Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);

    mdfCTeSimp:
      if IBSCBS.CST in [cst000, cst200] then
        Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);

    mdfCTeOS:
      if IBSCBS.CST in [cst000, cst200, cst222] then
        Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSNF3e(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  if IBSCBS.CST in [cst000, cst200, cst510, cst830] then
    Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSNFAg(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  if IBSCBS.CST = cst000 then
    Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSNFCom(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  if IBSCBS.CST in [cst000, cst200] then
    Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSNFe(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  case ModelosDFe of
    mdfNFe:
      begin
        case IBSCBS.CST of
          cst000, cst200, cst510, cst515, cst550, cst830:
            Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);

          cst620:
            Gerar_gIBSCBSMono(AINIRec, IBSCBS.gIBSCBSMono, Idx1);

          cst800:
            Gerar_gTransfCred(AINIRec, IBSCBS.gTransfCred, Idx1);

          cst811:
            Gerar_gAjusteCompet(AINIRec, IBSCBS.gAjusteCompet, Idx1);
        end;
      end;

    mdfNFCe:
      begin
        case IBSCBS.CST of
          cst000, cst200:
            Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);

          cst620:
            Gerar_gIBSCBSMono(AINIRec, IBSCBS.gIBSCBSMono, Idx1);
        end;
      end;
  end;
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSNFGas(AINIRec: TMemIniFile;
  IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
begin
  if IBSCBS.CST = cst000 then
    Gerar_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gIBSCBS'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gIBSCBS' + IntToStrZero(Idx1, 3)
    else
     sSecao := 'gIBSCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteFloat(sSecao, 'vBC', gIBSCBS.vBC);
  AINIRec.WriteFloat(sSecao, 'vIBS', gIBSCBS.vIBS);

  Gerar_gIBSUF(AINIRec, gIBSCBS.gIBSUF, Idx1, Idx2);
  Gerar_gIBSMun(AINIRec, gIBSCBS.gIBSMun, Idx1, Idx2);
  Gerar_gCBS(AINIRec, gIBSCBS.gCBS, Idx1, Idx2);
  Gerar_gALCZFMCBS(AINIRec, gIBSCBS.gCBS.gALCZFMCBS, Idx1, Idx2);

  if gIBSCBS.gTribRegular.vTribRegIBSUF > 0 then
    Gerar_gTribRegular(AINIRec, gIBSCBS.gTribRegular, Idx1, Idx2);

  if gIBSCBS.gTribCompraGov.pAliqIBSUF > 0 then
    Gerar_gTribCompraGov(AINIRec, gIBSCBS.gTribCompraGov, Idx1, Idx2);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSUF(AINIRec: TMemIniFile;
  gIBSUF: TgIBSUFValores; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gIBSUF'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gIBSUF' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gIBSUF' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteFloat(sSecao, 'pIBSUF', gIBSUF.pIBSUF);
  AINIRec.WriteFloat(sSecao, 'vIBSUF', gIBSUF.vIBSUF);

  AINIRec.WriteFloat(sSecao, 'pDif', gIBSUF.gDif.pDif);
  AINIRec.WriteFloat(sSecao, 'vDif', gIBSUF.gDif.vDif);

  AINIRec.WriteFloat(sSecao, 'pDevTrib', gIBSUF.gDevTrib.pDevTrib);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSUF.gDevTrib.vDevTrib);

  AINIRec.WriteFloat(sSecao, 'pRedAliq', gIBSUF.gRed.pRedAliq);
  AINIRec.WriteFloat(sSecao, 'pAliqEfet', gIBSUF.gRed.pAliqEfet);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSMun(AINIRec: TMemIniFile;
  gIBSMun: TgIBSMunValores; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gIBSMun'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gIBSMun' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gIBSMun' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteFloat(sSecao, 'pIBSMun', gIBSMun.pIBSMun);
  AINIRec.WriteFloat(sSecao, 'vIBSMun', gIBSMun.vIBSMun);

  AINIRec.WriteFloat(sSecao, 'pDif', gIBSMun.gDif.pDif);
  AINIRec.WriteFloat(sSecao, 'vDif', gIBSMun.gDif.vDif);

  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSMun.gDevTrib.vDevTrib);

  AINIRec.WriteFloat(sSecao, 'pRedAliq', gIBSMun.gRed.pRedAliq);
  AINIRec.WriteFloat(sSecao, 'pAliqEfet', gIBSMun.gRed.pAliqEfet);
end;

procedure TDFeRTCIniWriter.Gerar_gCBS(AINIRec: TMemIniFile;
  gCBS: TgCBSValores; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gCBS'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gCBS' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteFloat(sSecao, 'pCBS', gCBS.pCBS);
  AINIRec.WriteFloat(sSecao, 'vCBS', gCBS.vCBS);

  AINIRec.WriteFloat(sSecao, 'pDif', gCBS.gDif.pDif);
  AINIRec.WriteFloat(sSecao, 'vDif', gCBS.gDif.vDif);

  AINIRec.WriteFloat(sSecao, 'vDevTrib', gCBS.gDevTrib.vDevTrib);

  AINIRec.WriteFloat(sSecao, 'pRedAliq', gCBS.gRed.pRedAliq);
  AINIRec.WriteFloat(sSecao, 'pAliqEfet', gCBS.gRed.pAliqEfet);
end;

procedure TDFeRTCIniWriter.Gerar_gTribRegular(AINIRec: TMemIniFile;
  gTribRegular: TgTribRegular; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gTribRegular'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gTribRegular' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gTribRegular' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteString(sSecao, 'CSTReg', CSTIBSCBSToStr(gTribRegular.CSTReg));
  AINIRec.WriteString(sSecao, 'cClassTribReg', gTribRegular.cClassTribReg);
  AINIRec.WriteFloat(sSecao, 'pAliqEfetRegIBSUF', gTribRegular.pAliqEfetRegIBSUF);
  AINIRec.WriteFloat(sSecao, 'vTribRegIBSUF', gTribRegular.vTribRegIBSUF);
  AINIRec.WriteFloat(sSecao, 'pAliqEfetRegIBSMun', gTribRegular.pAliqEfetRegIBSMun);
  AINIRec.WriteFloat(sSecao, 'vTribRegIBSMun', gTribRegular.vTribRegIBSMun);
  AINIRec.WriteFloat(sSecao, 'pAliqEfetRegCBS', gTribRegular.pAliqEfetRegCBS);
  AINIRec.WriteFloat(sSecao, 'vTribRegCBS', gTribRegular.vTribRegCBS);
end;

procedure TDFeRTCIniWriter.Gerar_gTribCompraGov(
  AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov;
  Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gTribCompraGov'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gTribCompraGov' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gTribCompraGov' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteFloat(sSecao, 'pAliqIBSUF', gTribCompraGov.pAliqIBSUF);
  AINIRec.WriteFloat(sSecao, 'vTribIBSUF', gTribCompraGov.vTribIBSUF);
  AINIRec.WriteFloat(sSecao, 'pAliqIBSMun', gTribCompraGov.pAliqIBSMun);
  AINIRec.WriteFloat(sSecao, 'vTribIBSMun', gTribCompraGov.vTribIBSMun);
  AINIRec.WriteFloat(sSecao, 'pAliqCBS', gTribCompraGov.pAliqCBS);
  AINIRec.WriteFloat(sSecao, 'vTribCBS', gTribCompraGov.vTribCBS);
end;

procedure TDFeRTCIniWriter.Gerar_gEstornoCred(AINIRec: TMemIniFile;
  gEstornoCred: TgEstornoCred; Idx1, Idx2: Integer);
var
  sSecao: string;
begin
  if Idx1 = -1 then
    sSecao := 'gEstornoCred'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gEstornoCred' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gEstornoCred' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteFloat(sSecao, 'vIBSEstCred', gEstornoCred.vIBSEstCred);
  AINIRec.WriteFloat(sSecao, 'vCBSEstCred', gEstornoCred.vCBSEstCred);
end;

procedure TDFeRTCIniWriter.Gerar_gALCZFMCBS(AINIRec: TMemIniFile;
  gALCZFMCBS: TgALCZFMCBS; Idx1, Idx2: Integer);
var
  sSecao: String;
begin
  if Idx1 = -1 then
    sSecao := 'gALCZFMCBS'
  else
  begin
    if Idx2 = -1 then
      sSecao := 'gALCZFMCBS' + IntToStrZero(Idx1, 3)
    else
      sSecao := 'gALCZFMCBS' + IntToStrZero(Idx1, 2) + IntToStrZero(Idx2, 3);
  end;

  AINIRec.WriteString(sSecao, 'tpALCZFMCBS', tpALCZFMCBSToStr(gALCZFMCBS.tpALCZFMCBS) );
  AINIRec.WriteString(sSecao, 'nProcSuframa', gALCZFMCBS.nProcSuframa);
  AINIRec.WriteFloat( sSecao, 'pAliqEfetRegCBS', gALCZFMCBS.pAliqEfetRegCBS);
  AINIRec.WriteFloat( sSecao, 'vTribRegCBS', gALCZFMCBS.vTribRegCBS);
end;

procedure TDFeRTCIniWriter.Gerar_IBSCBSTot(AINIRec: TMemIniFile; IBSCBSTot: TIBSCBSTot);
var
  sSecao: string;
begin
  sSecao := 'IBSCBSTot';

  AINIRec.WriteFloat(sSecao, 'vBCIBSCBS', IBSCBSTot.vBCIBSCBS);

  Gerar_gIBSTot(AINIRec, IBSCBSTot.gIBS);
  Gerar_gCBSTot(AINIRec, IBSCBSTot.gCBS);
  Gerar_gEstornoCredTot(AINIRec, IBSCBSTot.gEstornoCred);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSTot(AINIRec: TMemIniFile; gIBS: TgIBS);
var
  sSecao: string;
begin
  sSecao := 'gIBS';

  AINIRec.WriteFloat(sSecao, 'vIBS', gIBS.vIBS);
  AINIRec.WriteFloat(sSecao, 'vCredPres', gIBS.vCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', gIBS.vCredPresCondSus);

  Gerar_gIBSUFTot(AINIRec, gIBS.gIBSUFTot);
  Gerar_gIBSMunTot(AINIRec, gIBS.gIBSMunTot);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSUFTot(AINIRec: TMemIniFile;
  gIBSUFTot: TgIBSUFTot);
var
  sSecao: string;
begin
  sSecao := 'gIBSUFTot';

  AINIRec.WriteFloat(sSecao, 'vDif', gIBSUFTot.vDif);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSUFTot.vDevTrib);
  AINIRec.WriteFloat(sSecao, 'vIBSUF', gIBSUFTot.vIBSUF);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSMunTot(AINIRec: TMemIniFile;
  gIBSMunTot: TgIBSMunTot);
var
  sSecao: string;
begin
  sSecao := 'gIBSMunTot';

  AINIRec.WriteFloat(sSecao, 'vDif', gIBSMunTot.vDif);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gIBSMunTot.vDevTrib);
  AINIRec.WriteFloat(sSecao, 'vIBSMun', gIBSMunTot.vIBSMun);
end;

procedure TDFeRTCIniWriter.Gerar_gCBSTot(AINIRec: TMemIniFile; gCBS: TgCBS);
var
  sSecao: string;
begin
  sSecao := 'gCBSTot';

  AINIRec.WriteFloat(sSecao, 'vDif', gCBS.vDif);
  AINIRec.WriteFloat(sSecao, 'vDevTrib', gCBS.vDevTrib);
  AINIRec.WriteFloat(sSecao, 'vCBS', gCBS.vCBS);
  AINIRec.WriteFloat(sSecao, 'vCredPres', gCBS.vCredPres);
  AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', gCBS.vCredPresCondSus);
end;

procedure TDFeRTCIniWriter.Gerar_gEstornoCredTot(AINIRec: TMemIniFile;
  gEstornoCred: TgEstornoCred);
var
  sSecao: string;
begin
  sSecao := 'gEstornoCredTot';

  AINIRec.WriteFloat(sSecao, 'vIBSEstCred', gEstornoCred.vIBSEstCred);
  AINIRec.WriteFloat(sSecao, 'vCBSEstCred', gEstornoCred.vCBSEstCred);
end;

procedure TDFeRTCIniWriter.Gerar_pgtoVinc(AINIRec: TMemIniFile;
  pgto: TpgtoCollection);
var
  i: integer;
  sSecao: string;
begin
  // Pagamentos Vinculados

  for i := 0 to pgto.Count - 1 do
  begin
    sSecao := 'pgtoVinc' + IntToStrZero(i + 1, 2);

    AINIRec.WriteInteger(sSecao, 'nPag', pgto[I].nPag);
    AINIRec.WriteString(sSecao, 'idTransacao', pgto[I].idTransacao);
    AINIRec.WriteString(sSecao, 'tpMeioPgto', pgto[I].tpMeioPgto);
    AINIRec.WriteString(sSecao, 'CNPJReceb', pgto[I].CNPJReceb);
    AINIRec.WriteString(sSecao, 'CNPJBasePSP', pgto[I].CNPJBasePSP);
  end;
end;

// Usado pela NF-e
procedure TDFeRTCIniWriter.Gerar_gCompraGov(AINIRec: TMemIniFile;
  gCompraGov: TgCompraGov);
var
  sSecao: string;
begin
  sSecao := 'gCompraGov';

  if (gCompraGov.pRedutor > 0) then
  begin
    AINIRec.WriteString(sSecao, 'tpEnteGov', tpEnteGovToStr(gCompraGov.tpEnteGov));
    AINIRec.WriteFloat(sSecao, 'pRedutor', gCompraGov.pRedutor);
    AINIRec.WriteString(sSecao, 'tpOperGov', tpOperGovToStr(gCompraGov.tpOperGov));
  end;
end;

procedure TDFeRTCIniWriter.Gerar_gPagAntecipado(AINIRec: TMemIniFile;
  gPagAntecipado: TgPagAntecipado);
var
  I: Integer;
  sSecao: string;
begin
  for I := 0 to gPagAntecipado.refNFe.Count - 1 do
  begin
    sSecao := 'gPagAntecipado' + IntToStrZero(I + 1, 2);
    AINIRec.WriteString(sSecao, 'refNFe', gPagAntecipado.refNFe[I].refDFEChave);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_DFeRef(AINIRec: TMemIniFile;
  refDFe: TDFErefCollection);
var
  i: Integer;
  sSecao: string;
begin
  for i := 0 to refDFe.Count - 1 do
  begin
    sSecao := 'refDFeAnt' + IntToStrZero(i + 1, 3);

    AINIRec.WriteString(sSecao, 'refDFeAnt', refDFe[i].refDFeChave);
  end;
end;

procedure TDFeRTCIniWriter.Gerar_ISel(AINIRec: TMemIniFile; ISel: TgIS;
  Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'IS' + IntToStrZero(Idx, 3);

  //Usar string até a publicação de uma tabela de CSTs oficial para o IS
  //AINIRec.WriteString(sSecao, 'CSTIS', CSTISToStr(ISel.CSTIS));
  AINIRec.WriteString(sSecao, 'CSTIS', ISel.CSTIS);
  AINIRec.WriteString(sSecao, 'cClassTribIS', ISel.cClassTribIS);
  AINIRec.WriteFloat(sSecao, 'vBCIS', ISel.vBCIS);
  AINIRec.WriteFloat(sSecao, 'pIS', ISel.pIS);
  AINIRec.WriteFloat(sSecao, 'adRemIS', ISel.adRemIS);
  AINIRec.WriteString(sSecao, 'uTrib', ISel.uTrib);
  AINIRec.WriteFloat(sSecao, 'qTrib', ISel.qTrib);
  AINIRec.WriteFloat(sSecao, 'vIS', ISel.vIS);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSCBSMono(AINIRec: TMemIniFile;
  IBSCBSMono: TgIBSCBSMono; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gIBSCBSMono' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vTotIBSMonoItem', IBSCBSMono.vTotIBSMonoItem);
  AINIRec.WriteFloat(sSecao, 'vTotCBSMonoItem', IBSCBSMono.vTotCBSMonoItem);

  Gerar_gIBSMonoAdRem(AINIRec, IBSCBSMono.gIBSMonoAdRem, Idx);
  Gerar_gIBSMonoAdValorem(AINIRec, IBSCBSMono.gIBSMonoAdValorem, Idx);
  Gerar_gCBSMonoAdRem(AINIRec, IBSCBSMono.gCBSMonoAdRem, Idx);
  Gerar_gCBSMonoAdValorem(AINIRec, IBSCBSMono.gCBSMonoAdValorem, Idx);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSMonoAdRem(AINIRec: TMemIniFile;
  gIBSMonoAdRem: TgIBSMonoAdRem; Idx: Integer);
begin
  Gerar_gMonoPadraoIBSQtde(AINIRec, gIBSMonoAdRem.gMonoPadrao, Idx);
  Gerar_gMonoRetenIBSQtde(AINIRec, gIBSMonoAdRem.gMonoReten, Idx);
  Gerar_gMonoRetIBSQtde(AINIRec, gIBSMonoAdRem.gMonoRet, Idx);
  Gerar_gpBioDiferencaIBS(AINIRec, gIBSMonoAdRem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoPadraoIBSQtde(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoIBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoIBSQtde' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'qBCMono', gMonoPadrao.qBCMono);
  AINIRec.WriteFloat(sSecao, 'adRemIBS', gMonoPadrao.adRemIBS);
  AINIRec.WriteFloat(sSecao, 'vIBSMono', gMonoPadrao.vIBSMono);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetenIBSQtde(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenIBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenIBSQtde' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'qBCMonoReten', gMonoReten.qBCMonoReten);
  AINIRec.WriteFloat(sSecao, 'adRemIBSReten', gMonoReten.adRemIBSReten);
  AINIRec.WriteFloat(sSecao, 'vIBSMonoReten', gMonoReten.vIBSMonoReten);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetIBSQtde(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetIBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetIBSQtde' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vIBSMonoRet', gMonoRet.vIBSMonoRet);
end;

procedure TDFeRTCIniWriter.Gerar_gpBioDiferencaIBS(AINIRec: TMemIniFile;
  gpBioDiferenca: TgpBioDiferencaIBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gpBioDiferencaIBS' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'qBCBioComb', gpBioDiferenca.qBCBioComb);
  AINIRec.WriteFloat(sSecao, 'vIBSDiferenca', gpBioDiferenca.vIBSDiferenca);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSMonoAdValorem(AINIRec: TMemIniFile;
  gIBSMonoAdValorem: TgIBSMonoAdValorem; Idx: Integer);
begin
  Gerar_gMonoPadraoIBSAliq(AINIRec, gIBSMonoAdValorem.gMonoPadrao, Idx);
  Gerar_gMonoRetenIBSAliq(AINIRec, gIBSMonoAdValorem.gMonoReten, Idx);
  Gerar_gMonoRetIBSAliq(AINIRec, gIBSMonoAdValorem.gMonoRet, Idx);
  Gerar_gpBioDiferencaIBS(AINIRec, gIBSMonoAdValorem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoPadraoIBSAliq(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoIBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoIBSAliq' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vBCMono', gMonoPadrao.vBCMono);
  AINIRec.WriteFloat(sSecao, 'pAliqMonoUF', gMonoPadrao.pAliqMonoUF);
  AINIRec.WriteFloat(sSecao, 'vIBSMonoUF', gMonoPadrao.vIBSMonoUF);
  AINIRec.WriteFloat(sSecao, 'pAliqMonoMun', gMonoPadrao.pAliqMonoMun);
  AINIRec.WriteFloat(sSecao, 'vIBSMonoMun', gMonoPadrao.vIBSMonoMun);
  AINIRec.WriteFloat(sSecao, 'vIBSMono', gMonoPadrao.vIBSMono);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetenIBSAliq(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenIBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenIBSAliq' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vBCMonoReten', gMonoReten.vBCMonoReten);
  AINIRec.WriteFloat(sSecao, 'pAliqMonoReten', gMonoReten.pAliqMonoReten);
  AINIRec.WriteFloat(sSecao, 'vIBSMonoReten', gMonoReten.vIBSMonoReten);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetIBSAliq(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetIBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetIBSAliq' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vIBSMonoRet', gMonoRet.vIBSMonoRet);
end;

procedure TDFeRTCIniWriter.Gerar_gCBSMonoAdRem(AINIRec: TMemIniFile;
  gCBSMonoAdRem: TgCBSMonoAdRem; Idx: Integer);
begin
  Gerar_gMonoPadraoCBSQtde(AINIRec, gCBSMonoAdRem.gMonoPadrao, Idx);
  Gerar_gMonoRetenCBSQtde(AINIRec, gCBSMonoAdRem.gMonoReten, Idx);
  Gerar_gMonoRetCBSQtde(AINIRec, gCBSMonoAdRem.gMonoRet, Idx);
  Gerar_gpBioDiferencaCBS(AINIRec, gCBSMonoAdRem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoPadraoCBSQtde(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoCBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoCBSQtde' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'qBCMono', gMonoPadrao.qBCMono);
  AINIRec.WriteFloat(sSecao, 'adRemCBS', gMonoPadrao.adRemCBS);
  AINIRec.WriteFloat(sSecao, 'vCBSMono', gMonoPadrao.vCBSMono);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetenCBSQtde(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenCBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenCBSQtde' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'qBCMonoReten', gMonoReten.qBCMonoReten);
  AINIRec.WriteFloat(sSecao, 'adRemCBSReten', gMonoReten.adRemCBSReten);
  AINIRec.WriteFloat(sSecao, 'vCBSMonoReten', gMonoReten.vCBSMonoReten);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetCBSQtde(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetCBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetCBSQtde' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vCBSMonoRet', gMonoRet.vCBSMonoRet);
end;

procedure TDFeRTCIniWriter.Gerar_gpBioDiferencaCBS(AINIRec: TMemIniFile;
  gpBioDiferenca: TgpBioDiferencaCBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gpBioDiferencaCBS' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'qBCBioComb', gpBioDiferenca.qBCBioComb);
  AINIRec.WriteFloat(sSecao, 'vIBSDiferenca', gpBioDiferenca.vCBSDiferenca);
end;

procedure TDFeRTCIniWriter.Gerar_gCBSMonoAdValorem(AINIRec: TMemIniFile;
  gCBSMonoAdValorem: TgCBSMonoAdValorem; Idx: Integer);
begin
  Gerar_gMonoPadraoCBSAliq(AINIRec, gCBSMonoAdValorem.gMonoPadrao, Idx);
  Gerar_gMonoRetenCBSAliq(AINIRec, gCBSMonoAdValorem.gMonoReten, Idx);
  Gerar_gMonoRetCBSAliq(AINIRec, gCBSMonoAdValorem.gMonoRet, Idx);
  Gerar_gpBioDiferencaCBS(AINIRec, gCBSMonoAdValorem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoPadraoCBSAliq(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoCBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoCBSAliq' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vBCMono', gMonoPadrao.vBCMono);
  AINIRec.WriteFloat(sSecao, 'pAliqMonoCBS', gMonoPadrao.pAliqMonoCBS);
  AINIRec.WriteFloat(sSecao, 'vCBSMono', gMonoPadrao.vCBSMono);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetenCBSAliq(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenCBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenCBSAliq' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vBCMonoReten', gMonoReten.vBCMonoReten);
  AINIRec.WriteFloat(sSecao, 'pAliqMonoReten', gMonoReten.pAliqMonoReten);
  AINIRec.WriteFloat(sSecao, 'vCBSMonoReten', gMonoReten.vCBSMonoReten);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoRetCBSAliq(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetCBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetCBSAliq' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vCBSMonoRet', gMonoRet.vCBSMonoRet);
end;

procedure TDFeRTCIniWriter.Gerar_gTransfCred(AINIRec: TMemIniFile;
  gTransfCred: TgTransfCred; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gTransfCred' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vIBS', gTransfCred.vIBS);
  AINIRec.WriteFloat(sSecao, 'vCBS', gTransfCred.vCBS);
end;

procedure TDFeRTCIniWriter.Gerar_gCredPresIBSZFM(AINIRec: TMemIniFile;
  gCredPresIBSZFM: TCredPresIBSZFM; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gCredPresIBSZFM' + IntToStrZero(Idx, 3);

  AINIRec.WriteString(sSecao, 'competApur', DateToStr(gCredPresIBSZFM.competApur));
  AINIRec.WriteString(sSecao, 'tpCredPresIBSZFM', TpCredPresIBSZFMToStr(gCredPresIBSZFM.tpCredPresIBSZFM));
  AINIRec.WriteFloat(sSecao, 'vCredPresIBSZFM', gCredPresIBSZFM.vCredPresIBSZFM);
end;

procedure TDFeRTCIniWriter.Gerar_gAjusteCompet(AINIRec: TMemIniFile;
  gAjusteCompet: TgAjusteCompet; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gAjusteCompet' + IntToStrZero(Idx, 3);

  AINIRec.WriteString(sSecao, 'competApur', DateToStr(gAjusteCompet.competApur));
  AINIRec.WriteFloat(sSecao, 'vIBS', gAjusteCompet.vIBS);
  AINIRec.WriteFloat(sSecao, 'vCBS', gAjusteCompet.vCBS);
end;

procedure TDFeRTCIniWriter.Gerar_gCredPresOper(AINIRec: TMemIniFile;
  gCredPresOper: TgCredPresOper; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gCredPresOper' + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'vBCCredPres', gCredPresOper.vBCCredPres);
  AINIRec.WriteString(sSecao, 'cCredPres', cCredPresToStr(gCredPresOper.cCredPres));

  if gCredPresOper.gIBSCredPres.pCredPres > 0 then
    Gerar_gIBSCBSCredPres(AINIRec, gCredPresOper.gIBSCredPres, 'gIBSCredPres', Idx);

  if gCredPresOper.gCBSCredPres.pCredPres > 0 then
    Gerar_gIBSCBSCredPres(AINIRec, gCredPresOper.gCBSCredPres, 'gCBSCredPres', Idx);
end;

procedure TDFeRTCIniWriter.Gerar_gIBSCBSCredPres(
  AINIRec: TMemIniFile; IBSCredPres: TgIBSCBSCredPres; const Grupo: string;
  Idx: Integer);
var
  sSecao: string;
begin
  sSecao := Grupo + IntToStrZero(Idx, 3);

  AINIRec.WriteFloat(sSecao, 'pCredPres', IBSCredPres.pCredPres);

  if IBSCredPres.vCredPres > 0 then
    AINIRec.WriteFloat(sSecao, 'vCredPres', IBSCredPres.vCredPres)
  else
    AINIRec.WriteFloat(sSecao, 'vCredPresCondSus', IBSCredPres.vCredPresCondSus);
end;

procedure TDFeRTCIniWriter.Gerar_DFeReferenciado(AINIRec: TMemIniFile;
  DFeReferenciado: TDFeReferenciado; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'DFeReferenciado' + IntToStrZero(Idx, 3);

  AINIRec.WriteString(sSecao, 'chaveAcesso', DFeReferenciado.chaveAcesso);
  AINIRec.WriteInteger(sSecao, 'nItem', DFeReferenciado.nItem);
end;

procedure TDFeRTCIniWriter.Gerar_ISTot(AINIRec: TMemIniFile; ISTot: TISTot);
var
  sSecao: string;
begin
  sSecao := 'ISTot';

  if ISTot.vIS > 0 then
    AINIRec.WriteFloat(sSecao, 'vIS', ISTot.vIS);
end;

procedure TDFeRTCIniWriter.Gerar_gMonoTot(AINIRec: TMemIniFile;
  gMono: TgMono);
var
  sSecao: string;
begin
  sSecao := 'gMono';

  AINIRec.WriteFloat(sSecao, 'vIBSMono', gMono.vIBSMono);
  AINIRec.WriteFloat(sSecao, 'vCBSMono', gMono.vCBSMono);
  AINIRec.WriteFloat(sSecao, 'vIBSMonoReten', gMono.vIBSMonoReten);
  AINIRec.WriteFloat(sSecao, 'vCBSMonoReten', gMono.vCBSMonoReten);
  AINIRec.WriteFloat(sSecao, 'vIBSMonoRet', gMono.vIBSMonoRet);
  AINIRec.WriteFloat(sSecao, 'vCBSMonoRet', gMono.vCBSMonoRet);
end;

end.
