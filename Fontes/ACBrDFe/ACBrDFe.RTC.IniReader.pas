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

unit ACBrDFe.RTC.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.Classes;

type
  { TDFeRTCIniReader }

  TDFeRTCIniReader = class
  private

  public
    // Usado pela maioria dos DF-e
    procedure Ler_gCompraGovReduzido(AINIRec: TMemIniFile; gCompraGov: TgCompraGovReduzido);
    procedure Ler_gPagAntecipadoProd(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipadoProd; Idx1, Idx2: Integer);
    procedure Ler_gPagAntecipadoIde(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipado);

    procedure Ler_refDFeAnt(AINIRec: TMemIniFile; refDFe: TrefDFeAntCollection);

    procedure Ler_IBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
    procedure Ler_gIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS; Idx1, Idx2: Integer);

    procedure Ler_gIBSUF(AINIRec: TMemIniFile; gIBSUF: TgIBSUFValores; Idx1, Idx2: Integer);
    procedure Ler_gIBSMun(AINIRec: TMemIniFile; gIBSMun: TgIBSMunValores; Idx1, Idx2: Integer);
    procedure Ler_gCBS(AINIRec: TMemIniFile; gCBS: TgCBSValores; Idx1, Idx2: Integer);

    procedure Ler_gTribReg(AINIRec: TMemIniFile; gTribRegular: TgTribRegular; Idx1, Idx2: Integer);
    procedure Ler_gTribCompraGov(AINIRec: TMemIniFile; gTribCompraGov: TgTribCompraGov; Idx1, Idx2: Integer);
    procedure Ler_gEstornoCred(AINIRec: TMemIniFile; gEstornoCred: TgEstornoCred; Idx1, Idx2: Integer);

    procedure Ler_gALCZFMCBS(AINIRec: TMemIniFile; gALCZFMCBS: TgALCZFMCBS; Idx1, Idx2: Integer);

    procedure Ler_IBSCBSTot(AINIRec: TMemIniFile; IBSCBSTot: TIBSCBSTot);
    procedure Ler_gIBSTot(AINIRec: TMemIniFile; gIBS: TgIBS);
    procedure Ler_gIBSUFTot(AINIRec: TMemIniFile; gIBSUFTot: TgIBSUFTot);
    procedure Ler_gIBSMunTot(AINIRec: TMemIniFile; gIBSMunTot: TgIBSMunTot);
    procedure Ler_gCBSTot(AINIRec: TMemIniFile; gCBS: TgCBS);
    procedure Ler_gEstornoCredTot(AINIRec: TMemIniFile; gEstornoCred: TgEstornoCred);

    procedure Ler_pgtoVinc(AINIRec: TMemIniFile; pgto: TpgtoCollection);

    // Usado pela NF-e
    procedure Ler_gCompraGov(AINIRec: TMemIniFile; gCompraGov: TgCompraGov);
    procedure Ler_gPagAntecipado(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipado);

    procedure Ler_DFeRef(AINIRec: TMemIniFile; refDFe: TDFErefCollection);

    procedure Ler_ISel(AINIRec: TMemIniFile; ISel: TgIS; Idx: Integer);

    procedure Ler_gIBSCBSMono(AINIRec: TMemIniFile; IBSCBSMono: TgIBSCBSMono; Idx: Integer);

    procedure Ler_gIBSMonoAdRem(AINIRec: TMemIniFile; gIBSMonoAdRem: TgIBSMonoAdRem; Idx: Integer);
    procedure Ler_gMonoPadraoIBSQtde(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoIBSQtde; Idx: Integer);
    procedure Ler_gMonoRetenIBSQtde(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenIBSQtde; Idx: Integer);
    procedure Ler_gMonoRetIBSQtde(AINIRec: TMemIniFile; gMonoRet: TgMonoRetIBS; Idx: Integer);
    procedure Ler_gpBioDiferencaIBS(AINIRec: TMemIniFile; gpBioDiferenca: TgpBioDiferencaIBS; Idx: Integer);

    procedure Ler_gIBSMonoAdValorem(AINIRec: TMemIniFile; gIBSMonoAdValorem: TgIBSMonoAdValorem; Idx: Integer);
    procedure Ler_gMonoPadraoIBSAliq(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoIBSAliq; Idx: Integer);
    procedure Ler_gMonoRetenIBSAliq(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenIBSAliq; Idx: Integer);
    procedure Ler_gMonoRetIBSAliq(AINIRec: TMemIniFile; gMonoRet: TgMonoRetIBS; Idx: Integer);

    procedure Ler_gCBSMonoAdRem(AINIRec: TMemIniFile; gCBSMonoAdRem: TgCBSMonoAdRem; Idx: Integer);
    procedure Ler_gMonoPadraoCBSQtde(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoCBSQtde; Idx: Integer);
    procedure Ler_gMonoRetenCBSQtde(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenCBSQtde; Idx: Integer);
    procedure Ler_gMonoRetCBSQtde(AINIRec: TMemIniFile; gMonoRet: TgMonoRetCBS; Idx: Integer);
    procedure Ler_gpBioDiferencaCBS(AINIRec: TMemIniFile; gpBioDiferenca: TgpBioDiferencaCBS; Idx: Integer);

    procedure Ler_gCBSMonoAdValorem(AINIRec: TMemIniFile; gCBSMonoAdValorem: TgCBSMonoAdValorem; Idx: Integer);
    procedure Ler_gMonoPadraoCBSAliq(AINIRec: TMemIniFile; gMonoPadrao: TgMonoPadraoCBSAliq; Idx: Integer);
    procedure Ler_gMonoRetenCBSAliq(AINIRec: TMemIniFile; gMonoReten: TgMonoRetenCBSAliq; Idx: Integer);
    procedure Ler_gMonoRetCBSAliq(AINIRec: TMemIniFile; gMonoRet: TgMonoRetCBS; Idx: Integer);

    procedure Ler_gTransfCred(AINIRec: TMemIniFile; gTransfCred: TgTransfCred; Idx: Integer);
    procedure Ler_gCredPresIBSZFM(AINIRec: TMemIniFile; gCredPresIBSZFM: TCredPresIBSZFM; Idx: Integer);
    procedure Ler_gAjusteCompet(AINIRec: TMemIniFile; gAjusteCompet: TgAjusteCompet; Idx: Integer);
    procedure Ler_gCredPresOper(AINIRec: TMemIniFile; gCredPresOper: TgCredPresOper; Idx: Integer);
    procedure Ler_gIBSCBSCredPres(AINIRec: TMemIniFile; IBSCredPres: TgIBSCBSCredPres;
      const Grupo: string; Idx: Integer);

    procedure Ler_DFeReferenciado(AINIRec: TMemIniFile;
      DFeReferenciado: TDFeReferenciado; Idx: Integer);

    procedure Ler_ISTot(AINIRec: TMemIniFile; ISTot: TISTot);
    procedure Ler_gMonoTot(AINIRec: TMemIniFile; gMono: TgMono);
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime;

{ TDFeRTCIniReader }

// Usado pela maioria dos DF-e
procedure TDFeRTCIniReader.Ler_gCompraGovReduzido(AINIRec: TMemIniFile; gCompraGov: TgCompraGovReduzido);
begin
  gCompraGov.tpEnteGov := StrTotpEnteGov(AINIRec.ReadString('gCompraGov', 'tpEnteGov', ''));
  gCompraGov.pRedutor := StringToFloatDef(AINIRec.ReadString('gCompraGov', 'pRedutor', ''), 0);
  gCompraGov.tpOperGov := StrTotpOperGov(AINIRec.ReadString('gCompraGov', 'tpOperGov', ''));

  Ler_refDFeAnt(AINIRec, gCompraGov.refDFe);
end;

procedure TDFeRTCIniReader.Ler_gPagAntecipadoProd(AINIRec: TMemIniFile;
  gPagAntecipado: TgPagAntecipadoProd; Idx1, Idx2: Integer);
var
  sSecao, sFim: string;
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gPagAntecipado.chDFePagAnt := sFim;
    gPagAntecipado.nItemPagAnt := AINIRec.ReadInteger(sSecao,'nItemPagAnt', 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gPagAntecipadoIde(AINIRec: TMemIniFile;
  gPagAntecipado: TgPagAntecipado);
var
  I: Integer;
  sSecao, sFim: string;
  Item: TrefDFePagAntCollectionItem;
begin
  I := 1;
  while true do
  begin
    sSecao   := 'gPagAntecipado' + IntToStrZero(I, 2);
    sFim := AINIRec.ReadString(sSecao, 'chDFePagAnt', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    Item := gPagAntecipado.refNFe.New;

    Item.refDFEChave := sFim;

    Inc(I);
  end;
end;

procedure TDFeRTCIniReader.Ler_refDFeAnt(AINIRec: TMemIniFile;
  refDFe: TrefDFeAntCollection);
var
  i: Integer;
  sSecao, sFim: string;
  Item: TrefDFeAntCollectionItem;
begin
  i := 1;
  while true do
  begin
    sSecao := 'refDFeAnt' + IntToStrZero(i, 3);
    sFim := AINIRec.ReadString(sSecao, 'refDFeAnt', 'FIM');
    if sFim = 'FIM' then
      break;

    Item := refDFe.New;

    Item.refDFeAnt := sFim;

    Inc(i);
  end;
end;

procedure TDFeRTCIniReader.Ler_IBSCBS(AINIRec: TMemIniFile; IBSCBS: TIBSCBS; Idx1, Idx2: Integer);
var
  sSecao: string;
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

  if AINIRec.SectionExists(sSecao) then
  begin
    IBSCBS.CST := StrToCSTIBSCBS(AINIRec.ReadString(sSecao, 'CST', ''));
    IBSCBS.cClassTrib := AINIRec.ReadString(sSecao, 'cClassTrib', '');
    IBSCBS.indDoacao := StrToTIndicadorEx(AINIRec.ReadString(sSecao, 'indDoacao', ''));

    Ler_gIBSCBS(AINIRec, IBSCBS.gIBSCBS, Idx1, Idx2);
    Ler_gEstornoCred(AINIRec, IBSCBS.gEstornoCred, Idx1, Idx2);

    Ler_gIBSCBSMono(AINIRec, IBSCBS.gIBSCBSMono, Idx1);
    Ler_gTransfCred(AINIRec, IBSCBS.gTransfCred, Idx1);
    Ler_gAjusteCompet(AINIRec, IBSCBS.gAjusteCompet, Idx1);
    Ler_gCredPresOper(AINIRec, IBSCBS.gCredPresOper, Idx1);
    Ler_gCredPresIBSZFM(AINIRec, IBSCBS.gCredPresIBSZFM, Idx1);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSCBS(AINIRec: TMemIniFile; gIBSCBS: TgIBSCBS; Idx1, Idx2: Integer);
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBSCBS.vBC := StringToFloatDef(AINIRec.ReadString(sSecao,'vBC','') ,0);
    gIBSCBS.vIBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBS','') ,0);

    Ler_gIBSUF(AINIRec, gIBSCBS.gIBSUF, Idx1, Idx2);
    Ler_gIBSMun(AINIRec, gIBSCBS.gIBSMun, Idx1, Idx2);
    Ler_gCBS(AINIRec, gIBSCBS.gCBS, Idx1, Idx2);
    Ler_gALCZFMCBS(AINIRec, gIBSCBS.gCBS.gALCZFMCBS, Idx1, Idx2);
    Ler_gTribReg(AINIRec, gIBSCBS.gTribRegular, Idx1, Idx2);
    Ler_gTribCompraGov(AINIRec, gIBSCBS.gTribCompraGov, Idx1, Idx2);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSUF(AINIRec: TMemIniFile; gIBSUF: TgIBSUFValores; Idx1, Idx2: Integer);
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBSUF.pIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'pIBSUF','') ,0);
    gIBSUF.vIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBSUF','') ,0);

    gIBSUF.gDif.pDif := StringToFloatDef(AINIRec.ReadString(sSecao,'pDif','') ,0);
    gIBSUF.gDif.vDif := StringToFloatDef(AINIRec.ReadString(sSecao,'vDif','') ,0);

    gIBSUF.gDevTrib.pDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'pDevTrib', ''), 0);
    gIBSUF.gDevTrib.vDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao,'vDevTrib','') ,0);

    gIBSUF.gRed.pRedAliq := StringToFloatDef(AINIRec.ReadString(sSecao,'pRedAliq','') ,0);
    gIBSUF.gRed.pAliqEfet := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqEfet','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSMun(AINIRec: TMemIniFile; gIBSMun: TgIBSMunValores; Idx1, Idx2: Integer);
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBSMun.pIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'pIBSMun','') ,0);
    gIBSMun.vIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBSMun','') ,0);

    gIBSMun.gDif.pDif := StringToFloatDef(AINIRec.ReadString(sSecao,'pDif','') ,0);
    gIBSMun.gDif.vDif := StringToFloatDef(AINIRec.ReadString(sSecao,'vDif','') ,0);

    gIBSMun.gDevTrib.vDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao,'vDevTrib','') ,0);

    gIBSMun.gRed.pRedAliq := StringToFloatDef(AINIRec.ReadString(sSecao,'pRedAliq','') ,0);
    gIBSMun.gRed.pAliqEfet := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqEfet','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gCBS(AINIRec: TMemIniFile; gCBS: TgCBSValores; Idx1, Idx2: Integer);
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gCBS.pCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'pCBS','') ,0);
    gCBS.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vCBS','') ,0);

    gCBS.gDif.pDif := StringToFloatDef(AINIRec.ReadString(sSecao,'pDif','') ,0);
    gCBS.gDif.vDif := StringToFloatDef(AINIRec.ReadString(sSecao,'vDif','') ,0);

    gCBS.gDevTrib.vDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao,'vDevTrib','') ,0);

    gCBS.gRed.pRedAliq := StringToFloatDef(AINIRec.ReadString(sSecao,'pRedAliq','') ,0);
    gCBS.gRed.pAliqEfet := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqEfet','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gTribReg(AINIRec: TMemIniFile;
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gTribRegular.CSTReg := StrToCSTIBSCBS(AINIRec.ReadString(sSecao, 'CSTReg', ''));
    gTribRegular.cClassTribReg := AINIRec.ReadString(sSecao, 'cClassTribReg', '');
    gTribRegular.pAliqEfetRegIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqEfetRegIBSUF','') ,0);
    gTribRegular.vTribRegIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'vTribRegIBSUF','') ,0);
    gTribRegular.pAliqEfetRegIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqEfetRegIBSMun','') ,0);
    gTribRegular.vTribRegIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'vTribRegIBSMun','') ,0);
    gTribRegular.pAliqEfetRegCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqEfetRegCBS','') ,0);
    gTribRegular.vTribRegCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vTribRegCBS','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gTribCompraGov(AINIRec: TMemIniFile;
  gTribCompraGov: TgTribCompraGov; Idx1, Idx2: Integer);
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gTribCompraGov.pAliqIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqIBSUF','') ,0);
    gTribCompraGov.vTribIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'vTribIBSUF','') ,0);
    gTribCompraGov.pAliqIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqIBSMun','') ,0);
    gTribCompraGov.vTribIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'vTribIBSMun','') ,0);
    gTribCompraGov.pAliqCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'pAliqCBS','') ,0);
    gTribCompraGov.vTribCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vTribCBS','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gEstornoCred(AINIRec: TMemIniFile;
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gEstornoCred.vIBSEstCred := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBSEstCred','') ,0);
    gEstornoCred.vCBSEstCred := StringToFloatDef(AINIRec.ReadString(sSecao,'vCBSEstCred','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gALCZFMCBS(AINIRec: TMemIniFile;
  gALCZFMCBS: TgALCZFMCBS; Idx1, Idx2: Integer);
var
  sSecao, lValor: string;
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

  if AINIRec.SectionExists(sSecao) then
  begin
    gALCZFMCBS.nProcSuframa := AINIRec.ReadString(sSecao, 'nProcSuframa', '');
    gALCZFMCBS.pAliqEfetRegCBS := AINIRec.ReadFloat(sSecao, 'pAliqEfetRegCBS', 0);

    lValor := AINIRec.ReadString(sSecao, 'tpALCZFMCBS', '');
    if lValor <> '' then
      gALCZFMCBS.tpALCZFMCBS := StrTotpALCZFMCBS(lValor);

    gALCZFMCBS.vTribRegCBS := AINIRec.ReadFloat(sSecao, 'vTribRegCBS', 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_IBSCBSTot(AINIRec: TMemIniFile;
  IBSCBSTot: TIBSCBSTot);
var
  sSecao: string;
begin
  sSecao := 'IBSCBSTot';

  if AINIRec.SectionExists(sSecao) then
  begin
    IBSCBSTot.vBCIBSCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vBCIBSCBS','') ,0);

    Ler_gIBSTot(AINIRec, IBSCBSTot.gIBS);
    Ler_gCBSTot(AINIRec, IBSCBSTot.gCBS);
    Ler_gMonoTot(AINIRec, IBSCBSTot.gMono);
    Ler_gEstornoCredTot(AINIRec, IBSCBSTot.gEstornoCred);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSTot(AINIRec: TMemIniFile;
  gIBS: TgIBS);
var
  sSecao: string;
begin
  sSecao := 'gIBS';

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBS.vIBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBS','') ,0);
    gIBS.vCredPres := StringToFloatDef(AINIRec.ReadString(sSecao,'vCredPres','') ,0);
    gIBS.vCredPresCondSus := StringToFloatDef(AINIRec.ReadString(sSecao,'vCredPresCondSus','') ,0);

    Ler_gIBSUFTot(AINIRec, gIBS.gIBSUFTot);
    Ler_gIBSMunTot(AINIRec, gIBS.gIBSMunTot);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSUFTot(AINIRec: TMemIniFile;
  gIBSUFTot: TgIBSUFTot);
var
  sSecao: string;
begin
  sSecao := 'gIBSUFTot';

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBSUFTot.vDif := StringToFloatDef(AINIRec.ReadString(sSecao,'vDif','') ,0);
    gIBSUFTot.vDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao,'vDevTrib','') ,0);
    gIBSUFTot.vIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBSUF','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSMunTot(AINIRec: TMemIniFile;
  gIBSMunTot: TgIBSMunTot);
var
  sSecao: string;
begin
  sSecao := 'gIBSMunTot';

  if AINIRec.SectionExists(sSecao) then
  begin
    gIBSMunTot.vDif := StringToFloatDef(AINIRec.ReadString(sSecao,'vDif','') ,0);
    gIBSMunTot.vDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao,'vDevTrib','') ,0);
    gIBSMunTot.vIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBSMun','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gCBSTot(AINIRec: TMemIniFile;
  gCBS: TgCBS);
var
  sSecao: string;
begin
  sSecao := 'gCBSTot';

  if AINIRec.SectionExists(sSecao) then
  begin
    gCBS.vDif := StringToFloatDef(AINIRec.ReadString(sSecao,'vDif','') ,0);
    gCBS.vDevTrib := StringToFloatDef(AINIRec.ReadString(sSecao,'vDevTrib','') ,0);
    gCBS.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao,'vCBS','') ,0);
    gCBS.vCredPres := StringToFloatDef(AINIRec.ReadString(sSecao,'vCredPres','') ,0);
    gCBS.vCredPresCondSus := StringToFloatDef(AINIRec.ReadString(sSecao,'vCredPresCondSus','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gEstornoCredTot(AINIRec: TMemIniFile;
  gEstornoCred: TgEstornoCred);
var
  sSecao: string;
begin
  sSecao := 'gEstornoCredTot';

  if AINIRec.SectionExists(sSecao) then
  begin
    gEstornoCred.vIBSEstCred := StringToFloatDef(AINIRec.ReadString(sSecao,'vIBSEstCred','') ,0);
    gEstornoCred.vCBSEstCred := StringToFloatDef(AINIRec.ReadString(sSecao,'vCBSEstCred','') ,0);
  end;
end;

procedure TDFeRTCIniReader.Ler_pgtoVinc(AINIRec: TMemIniFile;
  pgto: TpgtoCollection);
var
  I: Integer;
  sSecao, sFim: String;
  ItemPag: TpgtoCollectionItem;
begin
  //
  // Seção [pgtoVincxx] Dados do Pagamento Vinculado 01-99
  //
  I := 1 ;
  while true do
  begin
    sSecao := 'pgtoVinc' + IntToStrZero(I, 2) ;
    sFim   := AINIRec.ReadString(sSecao, 'nPag', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break ;

    ItemPag := pgto.New;

    ItemPag.nPag := StrToIntDef(sFim, 0);
    ItemPag.idTransacao := AINIRec.ReadString(sSecao, 'idTransacao', '');
    ItemPag.tpMeioPgto := AINIRec.ReadString(sSecao, 'tpMeioPgto', '');
    ItemPag.CNPJReceb := AINIRec.ReadString(sSecao, 'CNPJReceb', '');
    ItemPag.CNPJBasePSP := AINIRec.ReadString(sSecao, 'CNPJBasePSP', '');

    Inc(I);
  end;
end;

// Usado pela NF-e
procedure TDFeRTCIniReader.Ler_gCompraGov(AINIRec: TMemIniFile;
  gCompraGov: TgCompraGov);
begin
  gCompraGov.tpEnteGov := StrTotpEnteGov(AINIRec.ReadString('gCompraGov', 'tpEnteGov', ''));
  gCompraGov.pRedutor := StringToFloatDef(AINIRec.ReadString('gCompraGov', 'pRedutor', ''), 0);
  gCompraGov.tpOperGov := StrTotpOperGov(AINIRec.ReadString('gCompraGov', 'tpOperGov', ''));

  Ler_DFeRef(AINIRec, gCompraGov.refDFeAnt);
end;

procedure TDFeRTCIniReader.Ler_gPagAntecipado(AINIRec: TMemIniFile; gPagAntecipado: TgPagAntecipado);
var
  I: Integer;
  sSecao, sFim: string;
  Item: TrefDFePagAntCollectionItem;
begin
  I := 1;
  while true do
  begin
    sSecao   := 'gPagAntecipado' + IntToStrZero(I, 2);
    sFim := AINIRec.ReadString(sSecao, 'refNFe', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    Item := gPagAntecipado.refNFe.New;

    Item.refDFEChave := sFim;

    Inc(I);
  end;
end;

procedure TDFeRTCIniReader.Ler_DFeRef(AINIRec: TMemIniFile;
  refDFe: TDFErefCollection);
var
  i: Integer;
  sSecao, sFim: string;
  Item: TDFErefCollectionItem;
begin
  i := 1;
  while true do
  begin
    sSecao := 'refDFeAnt' + IntToStrZero(i, 3);
    sFim := AINIRec.ReadString(sSecao, 'refDFeAnt', 'FIM');
    if sFim = 'FIM' then
      break;

    Item := refDFe.New;

    Item.refDFeChave := sFim;

    Inc(i);
  end;
end;

procedure TDFeRTCIniReader.Ler_ISel(AINIRec: TMemIniFile; ISel: TgIS;
  Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'IS' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    //Usar string até a publicação de uma tabela de CSTs oficial para o IS
    //ISel.CSTIS := StrToCSTIS(AINIRec.ReadString(sSecao, 'CSTIS', ''));
    ISel.CSTIS := AINIRec.ReadString(sSecao, 'CSTIS', '');
    ISel.cClassTribIS := AINIRec.ReadString(sSecao, 'cClassTribIS', '');
    ISel.vBCIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCIS', ''), 0);
    ISel.pIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pIS', ''), 0);
    ISel.adRemIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'adRemIS', ''), 0);
    ISel.uTrib := AINIRec.ReadString(sSecao, 'uTrib', '');
    ISel.qTrib := StringToFloatDef(AINIRec.ReadString(sSecao, 'qTrib', ''), 0);
    ISel.vIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIS', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSCBSMono(AINIRec: TMemIniFile;
  IBSCBSMono: TgIBSCBSMono; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gIBSCBSMono' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    IBSCBSMono.vTotIBSMonoItem := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotIBSMonoItem', ''), 0);
    IBSCBSMono.vTotCBSMonoItem := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotCBSMonoItem', ''), 0);

    Ler_gIBSMonoAdRem(AINIRec, IBSCBSMono.gIBSMonoAdRem, Idx);
    Ler_gIBSMonoAdValorem(AINIRec, IBSCBSMono.gIBSMonoAdValorem, Idx);
    Ler_gCBSMonoAdRem(AINIRec, IBSCBSMono.gCBSMonoAdRem, Idx);
    Ler_gCBSMonoAdValorem(AINIRec, IBSCBSMono.gCBSMonoAdValorem, Idx);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSMonoAdRem(AINIRec: TMemIniFile;
  gIBSMonoAdRem: TgIBSMonoAdRem; Idx: Integer);
begin
  Ler_gMonoPadraoIBSQtde(AINIRec, gIBSMonoAdRem.gMonoPadrao, Idx);
  Ler_gMonoRetenIBSQtde(AINIRec, gIBSMonoAdRem.gMonoReten, Idx);
  Ler_gMonoRetIBSQtde(AINIRec, gIBSMonoAdRem.gMonoRet, Idx);
  Ler_gpBioDiferencaIBS(AINIRec, gIBSMonoAdRem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniReader.Ler_gMonoPadraoIBSQtde(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoIBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoIBSQtde' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoPadrao.qBCMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'qBCMono', ''), 0);
    gMonoPadrao.adRemIBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'adRemIBS', ''), 0);
    gMonoPadrao.vIBSMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMono', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetenIBSQtde(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenIBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenIBSQtde' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoReten.qBCMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'qBCMonoReten', ''), 0);
    gMonoReten.adRemIBSReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'adRemIBSReten', ''), 0);
    gMonoReten.vIBSMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoReten', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetIBSQtde(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetIBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetIBSQtde' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoRet.vIBSMonoRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoRet', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gpBioDiferencaIBS(AINIRec: TMemIniFile;
  gpBioDiferenca: TgpBioDiferencaIBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gpBioDiferencaIBS' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gpBioDiferenca.qBCBioComb := StringToFloatDef(AINIRec.ReadString(sSecao, 'qBCBioComb', ''), 0);
    gpBioDiferenca.vIBSDiferenca := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSDiferenca', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSMonoAdValorem(AINIRec: TMemIniFile;
  gIBSMonoAdValorem: TgIBSMonoAdValorem; Idx: Integer);
begin
  Ler_gMonoPadraoIBSAliq(AINIRec, gIBSMonoAdValorem.gMonoPadrao, Idx);
  Ler_gMonoRetenIBSAliq(AINIRec, gIBSMonoAdValorem.gMonoReten, Idx);
  Ler_gMonoRetIBSAliq(AINIRec, gIBSMonoAdValorem.gMonoRet, Idx);
  Ler_gpBioDiferencaIBS(AINIRec, gIBSMonoAdValorem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniReader.Ler_gMonoPadraoIBSAliq(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoIBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoIBSAliq' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoPadrao.vBCMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCMono', ''), 0);
    gMonoPadrao.pAliqMonoUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqMonoUF', ''), 0);
    gMonoPadrao.vIBSMonoUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoUF', ''), 0);
    gMonoPadrao.pAliqMonoMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqMonoMun', ''), 0);
    gMonoPadrao.vIBSMonoMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoMun', ''), 0);
    gMonoPadrao.vIBSMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMono', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetenIBSAliq(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenIBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenIBSAliq' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoReten.vBCMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCMonoReten', ''), 0);
    gMonoReten.pAliqMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqMonoReten', ''), 0);
    gMonoReten.vIBSMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoReten', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetIBSAliq(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetIBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetIBSAliq' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoRet.vIBSMonoRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoRet', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gCBSMonoAdRem(AINIRec: TMemIniFile;
  gCBSMonoAdRem: TgCBSMonoAdRem; Idx: Integer);
begin
  Ler_gMonoPadraoCBSQtde(AINIRec, gCBSMonoAdRem.gMonoPadrao, Idx);
  Ler_gMonoRetenCBSQtde(AINIRec, gCBSMonoAdRem.gMonoReten, Idx);
  Ler_gMonoRetCBSQtde(AINIRec, gCBSMonoAdRem.gMonoRet, Idx);
  Ler_gpBioDiferencaCBS(AINIRec, gCBSMonoAdRem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniReader.Ler_gMonoPadraoCBSQtde(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoCBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoCBSQtde' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoPadrao.qBCMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'qBCMono', ''), 0);
    gMonoPadrao.adRemCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'adRemCBS', ''), 0);
    gMonoPadrao.vCBSMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMono', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetenCBSQtde(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenCBSQtde; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenCBSQtde' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoReten.qBCMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'qBCMonoReten', ''), 0);
    gMonoReten.adRemCBSReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'adRemCBSReten', ''), 0);
    gMonoReten.vCBSMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMonoReten', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetCBSQtde(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetCBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetCBSQtde' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoRet.vCBSMonoRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMonoRet', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gpBioDiferencaCBS(AINIRec: TMemIniFile;
  gpBioDiferenca: TgpBioDiferencaCBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gpBioDiferencaCBS' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gpBioDiferenca.qBCBioComb := StringToFloatDef(AINIRec.ReadString(sSecao, 'qBCBioComb', ''), 0);
    gpBioDiferenca.vCBSDiferenca := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSDiferenca', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gCBSMonoAdValorem(AINIRec: TMemIniFile;
  gCBSMonoAdValorem: TgCBSMonoAdValorem; Idx: Integer);
begin
  Ler_gMonoPadraoCBSAliq(AINIRec, gCBSMonoAdValorem.gMonoPadrao, Idx);
  Ler_gMonoRetenCBSAliq(AINIRec, gCBSMonoAdValorem.gMonoReten, Idx);
  Ler_gMonoRetCBSAliq(AINIRec, gCBSMonoAdValorem.gMonoRet, Idx);
  Ler_gpBioDiferencaCBS(AINIRec, gCBSMonoAdValorem.gpBioDiferenca, Idx);
end;

procedure TDFeRTCIniReader.Ler_gMonoPadraoCBSAliq(AINIRec: TMemIniFile;
  gMonoPadrao: TgMonoPadraoCBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoPadraoCBSAliq' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoPadrao.vBCMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCMono', ''), 0);
    gMonoPadrao.pAliqMonoCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqMonoCBS', ''), 0);
    gMonoPadrao.vCBSMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMono', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetenCBSAliq(AINIRec: TMemIniFile;
  gMonoReten: TgMonoRetenCBSAliq; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetenCBSAliq' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoReten.vBCMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBCMonoReten', ''), 0);
    gMonoReten.pAliqMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAliqMonoReten', ''), 0);
    gMonoReten.vCBSMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMonoReten', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gMonoRetCBSAliq(AINIRec: TMemIniFile;
  gMonoRet: TgMonoRetCBS; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gMonoRetCBSAliq' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gMonoRet.vCBSMonoRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMonoRet', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gTransfCred(AINIRec: TMemIniFile;
  gTransfCred: TgTransfCred; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gTransfCred' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gTransfCred.vIBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBS', ''), 0);
    gTransfCred.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBS', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gCredPresIBSZFM(AINIRec: TMemIniFile;
  gCredPresIBSZFM: TCredPresIBSZFM; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gCredPresIBSZFM' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gCredPresIBSZFM.competApur := StringToDateTime(AINIRec.ReadString( sSecao,'competApur','0'));
    gCredPresIBSZFM.tpCredPresIBSZFM := StrToTpCredPresIBSZFM(AINIRec.ReadString(sSecao, 'tpCredPresIBSZFM', ''));
    gCredPresIBSZFM.vCredPresIBSZFM := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCredPresIBSZFM', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gAjusteCompet(AINIRec: TMemIniFile;
  gAjusteCompet: TgAjusteCompet; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gAjusteCompet' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gAjusteCompet.competApur := StringToDateTime(AINIRec.ReadString( sSecao,'competApur','0'));
    gAjusteCompet.vIBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBS', ''), 0);
    gAjusteCompet.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBS', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_gCredPresOper(AINIRec: TMemIniFile;
  gCredPresOper: TgCredPresOper; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'gCredPresOper' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    gCredPresOper.vBCCredPres := StringToFloatDef(AINIRec.ReadString(sSecao,'vBCCredPres','') ,0);
    gCredPresOper.cCredPres := StrTocCredPres(AINIRec.ReadString(sSecao, 'cCredPres', ''));

    Ler_gIBSCBSCredPres(AINIRec, gCredPresOper.gIBSCredPres, 'gIBSCredPres', Idx);
    Ler_gIBSCBSCredPres(AINIRec, gCredPresOper.gCBSCredPres, 'gCBSCredPres', Idx);
  end;
end;

procedure TDFeRTCIniReader.Ler_gIBSCBSCredPres(
  AINIRec: TMemIniFile; IBSCredPres: TgIBSCBSCredPres; const Grupo: string;
  Idx: Integer);
var
  sSecao: string;
begin
  sSecao := Grupo + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    IBSCredPres.pCredPres := StringToFloatDef(AINIRec.ReadString(sSecao, 'pCredPres', ''), 0);
    IBSCredPres.vCredPres := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCredPres', ''), 0);
    IBSCredPres.vCredPresCondSus := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCredPresCondSus', ''), 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_DFeReferenciado(AINIRec: TMemIniFile;
  DFeReferenciado: TDFeReferenciado; Idx: Integer);
var
  sSecao: string;
begin
  sSecao := 'DFeReferenciado' + IntToStrZero(Idx, 3);

  if AINIRec.SectionExists(sSecao) then
  begin
    DFeReferenciado.chaveAcesso := AINIRec.ReadString(sSecao, 'chaveAcesso', '');
    DFeReferenciado.nItem := AINIRec.ReadInteger(sSecao, 'nItem', 0);
  end;
end;

procedure TDFeRTCIniReader.Ler_ISTot(AINIRec: TMemIniFile; ISTot: TISTot);
var
  sSecao: string;
begin
  sSecao := 'ISTot';

  if AINIRec.SectionExists(sSecao) then
    ISTot.vIS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIS', ''), 0);
end;

procedure TDFeRTCIniReader.Ler_gMonoTot(AINIRec: TMemIniFile;
  gMono: TgMono);
var
  sSecao: string;
begin
  sSecao := 'gMono';

  if AINIRec.SectionExists(sSecao) then
  begin
    gMono.vIBSMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMono', ''), 0);
    gMono.vCBSMono := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMono', ''), 0);
    gMono.vIBSMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoReten', ''), 0);
    gMono.vCBSMonoReten := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMonoReten', ''), 0);
    gMono.vIBSMonoRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMonoRet', ''), 0);
    gMono.vCBSMonoRet := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBSMonoRet', ''), 0);
  end;
end;

end.
