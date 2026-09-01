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

unit ACBrNFAg.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFAg.Classes,
  ACBrNFAg.Conversao,
  ACBrDFe.RTC.IniWriter,
  ACBrDFeComum.Proc;

type
  { TNFAgIniWriter }

  TNFAgIniWriter = class(TDFeRTCIniWriter)
  private
    FNFAg: TNFAg;

    procedure Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Gerar_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
    procedure Gerar_Ligacao(AINIRec: TMemIniFile; Ligacao: TLigacao);
    procedure Gerar_gSub(AINIRec: TMemIniFile; gSub: TgSub);
    procedure Gerar_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
    procedure Gerar_gFatConjunto(AINIRec: TMemIniFile; gFatConjunto: TgFatConjunto);

    procedure Gerar_Det(AINIRec: TMemIniFile; Det: TDetCollection);
    procedure Gerar_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);
    procedure Gerar_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);

    procedure Gerar_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
    procedure Gerar_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);

    procedure Gerar_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
    procedure Gerar_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
    procedure Gerar_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
    procedure Gerar_TFS(AINIRec: TMemIniFile; TFS: TTFS; Index: Integer);
    procedure Gerar_TFU(AINIRec: TMemIniFile; TFU: TTFU; Index: Integer);

    procedure Gerar_Total(AINIRec: TMemIniFile; Total: TTotal);

    procedure Gerar_gFat(AINIRec: TMemIniFile; gFat: TgFat);
    procedure Gerar_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
    procedure Gerar_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);

    procedure Gerar_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
    procedure Gerar_gAgenciaHistCons(AINIRec: TMemIniFile; gHistCons: TgHistConsCollection);
    procedure Gerar_gAgenciaCons(AINIRec: TMemIniFile; gCons: TgConsCollection; HistIndex: Integer);

    procedure Gerar_gQualiAgua(AINIRec: TMemIniFile; gQualiAgua: TgQualiAgua);
    procedure Gerar_gAnalise(AINIRec: TMemIniFile; gAnalise: TgAnaliseCollection);

    procedure Gerar_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Gerar_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
    procedure Gerar_InfPAA(AINIRec: TMemIniFile; InfPAA: TInfPAA);

    procedure Gerar_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);

    function DateTimeToIni(const AValue: TDateTime): string;
  public
    constructor Create(AOwner: TNFAg); reintroduce;
    destructor Destroy; override;

    function GravarIni: string;

    property NFAg: TNFAg read FNFAg write FNFAg;
  end;

implementation

uses
  ACBrDFeUtil,
  ACBrNFAg,
  ACBrUtil.Base;

{ TNFAgIniWriter }

constructor TNFAgIniWriter.Create(AOwner: TNFAg);
begin
  inherited Create;

  FNFAg := AOwner;
end;

destructor TNFAgIniWriter.Destroy;
begin

  inherited Destroy;
end;

function TNFAgIniWriter.DateTimeToIni(const AValue: TDateTime): string;
begin
  if AValue <= 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := DateTimeToStr(AValue);
end;

function TNFAgIniWriter.GravarIni: string;
var
  INIRec: TMemIniFile;
  IniNFAg: TStringList;
begin
  Result := '';
  ModelosDFe := mdfNFAg;
  tpNFDebito := tdNenhum;

  if not ValidarChave(FNFAg.infNFAg.ID) then
    raise EACBrNFAgException.Create('NFAg Inconsistente para gerar INI. Chave Inválida.');

  INIRec := TMemIniFile.Create('');
  try
    INIRec.WriteString('infNFAg', 'ID', FNFAg.infNFAg.ID);
    INIRec.WriteString('infNFAg', 'versao', VersaoNFAgToStr(DblToVersaoNFAg(FNFAg.infNFAg.versao)));

    Gerar_Identificacao(INIRec, FNFAg.Ide);
    Gerar_Emitente(INIRec, FNFAg.Emit);
    Gerar_Destinatario(INIRec, FNFAg.Dest);
    Gerar_Ligacao(INIRec, FNFAg.Ligacao);
    Gerar_gSub(INIRec, FNFAg.gSub);
    Gerar_gMed(INIRec, FNFAg.gMed);
    Gerar_gFatConjunto(INIRec, FNFAg.gFatConjunto);
    Gerar_Det(INIRec, FNFAg.Det);
    Gerar_Total(INIRec, FNFAg.Total);
    Gerar_pgtoVinc(INIRec, FNFAg.pgtoVinc.pgto);
    Gerar_gFat(INIRec, FNFAg.gFat);
    Gerar_gAgencia(INIRec, FNFAg.gAgencia);
    Gerar_gQualiAgua(INIRec, FNFAg.gQualiAgua);
    Gerar_autXML(INIRec, FNFAg.autXML);
    Gerar_InfAdic(INIRec, FNFAg.infAdic);
    Gerar_InfPAA(INIRec, FNFAg.infPAA);
    Gerar_InfRespTec(INIRec, FNFAg.infRespTec);

    IniNFAg := TStringList.Create;
    try
      INIRec.GetStrings(IniNFAg);
      Result := StringReplace(IniNFAg.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniNFAg.Free;
    end;
  finally
    INIRec.Free;
  end;
end;

procedure TNFAgIniWriter.Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
var
  Secao: string;
begin
  Secao := 'ide';

  AINIRec.WriteInteger(Secao, 'cUF', Ide.cUF);
  AINIRec.WriteString(Secao, 'tpAmb', TipoAmbienteToStr(Ide.tpAmb));
  AINIRec.WriteInteger(Secao, 'Modelo', Ide.modelo);
  AINIRec.WriteInteger(Secao, 'Serie', Ide.serie);
  AINIRec.WriteInteger(Secao, 'nNF', Ide.nNF);
  AINIRec.WriteInteger(Secao, 'cNF', Ide.cNF);
  AINIRec.WriteString(Secao, 'dhEmi', DateTimeToIni(Ide.dhEmi));
  AINIRec.WriteString(Secao, 'tpEmis', TipoEmissaoToStr(Ide.tpEmis));
  AINIRec.WriteString(Secao, 'nSiteAutoriz', SiteAutorizadorToStr(Ide.nSiteAutoriz));
  AINIRec.WriteInteger(Secao, 'cMunFG', Ide.cMunFG);
  AINIRec.WriteString(Secao, 'finNFAg', finNFAgToStr(Ide.finNFAg));
  AINIRec.WriteString(Secao, 'tpFat', tpFatToStr(Ide.tpFat));
  AINIRec.WriteString(Secao, 'verProc', Ide.verProc);
  AINIRec.WriteString(Secao, 'dhCont', DateTimeToIni(Ide.dhCont));
  AINIRec.WriteString(Secao, 'xJust', Ide.xJust);
  AINIRec.WriteString(Secao, 'tpPagAnt', tpPagAntToStr(Ide.tpPagAnt));

  Gerar_gCompraGovReduzido(AINIRec, Ide.gCompraGov);
end;

procedure TNFAgIniWriter.Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
var
  Secao: string;
begin
  Secao := 'emit';

  AINIRec.WriteString(Secao, 'CNPJ', Emit.CNPJ);
  AINIRec.WriteString(Secao, 'IE', Emit.IE);
  AINIRec.WriteString(Secao, 'xNome', Emit.xNome);
  AINIRec.WriteString(Secao, 'xFant', Emit.xFant);
  AINIRec.WriteString(Secao, 'ISUFEmit', Emit.ISUFEmit);

  AINIRec.WriteString(Secao, 'xLgr', Emit.EnderEmit.xLgr);
  AINIRec.WriteString(Secao, 'nro', Emit.EnderEmit.nro);
  AINIRec.WriteString(Secao, 'xCpl', Emit.EnderEmit.xCpl);
  AINIRec.WriteString(Secao, 'xBairro', Emit.EnderEmit.xBairro);
  AINIRec.WriteInteger(Secao, 'cMun', Emit.EnderEmit.cMun);
  AINIRec.WriteString(Secao, 'xMun', Emit.EnderEmit.xMun);
  AINIRec.WriteInteger(Secao, 'CEP', Emit.EnderEmit.CEP);
  AINIRec.WriteString(Secao, 'UF', Emit.EnderEmit.UF);
  AINIRec.WriteString(Secao, 'fone', Emit.EnderEmit.fone);
  AINIRec.WriteString(Secao, 'email', Emit.EnderEmit.email);
end;

procedure TNFAgIniWriter.Gerar_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
var
  Secao: string;
begin
  Secao := 'dest';

  AINIRec.WriteString(Secao, 'xNome', Dest.xNome);
  AINIRec.WriteString(Secao, 'CNPJCPF', Dest.CNPJCPF);
  AINIRec.WriteString(Secao, 'idOutros', Dest.idOutros);
  AINIRec.WriteString(Secao, 'IE', Dest.IE);
  AINIRec.WriteString(Secao, 'IM', Dest.IM);
  AINIRec.WriteString(Secao, 'cNIS', Dest.cNIS);
  AINIRec.WriteString(Secao, 'NB', Dest.NB);
  AINIRec.WriteString(Secao, 'xNomeAdicional', Dest.xNomeAdicional);

  AINIRec.WriteString(Secao, 'xLgr', Dest.EnderDest.xLgr);
  AINIRec.WriteString(Secao, 'nro', Dest.EnderDest.nro);
  AINIRec.WriteString(Secao, 'xCpl', Dest.EnderDest.xCpl);
  AINIRec.WriteString(Secao, 'xBairro', Dest.EnderDest.xBairro);
  AINIRec.WriteInteger(Secao, 'cMun', Dest.EnderDest.cMun);
  AINIRec.WriteString(Secao, 'xMun', Dest.EnderDest.xMun);
  AINIRec.WriteInteger(Secao, 'CEP', Dest.EnderDest.CEP);
  AINIRec.WriteString(Secao, 'UF', Dest.EnderDest.UF);
  AINIRec.WriteString(Secao, 'fone', Dest.EnderDest.fone);
  AINIRec.WriteString(Secao, 'email', Dest.EnderDest.email);
end;

procedure TNFAgIniWriter.Gerar_Ligacao(AINIRec: TMemIniFile; Ligacao: TLigacao);
var
  Secao: string;
begin
  Secao := 'Ligacao';

  if Trim(Ligacao.idLigacao) = '' then
    Exit;

  AINIRec.WriteString(Secao, 'idLigacao', Ligacao.idLigacao);
  AINIRec.WriteString(Secao, 'idCodCliente', Ligacao.idCodCliente);
  AINIRec.WriteString(Secao, 'tpLigacao', tpLigacaoToStr(Ligacao.tpLigacao));
  AINIRec.WriteString(Secao, 'latGPS', Ligacao.latGPS);
  AINIRec.WriteString(Secao, 'longGPS', Ligacao.longGPS);
  AINIRec.WriteString(Secao, 'codRoteiroLeitura', Ligacao.codRoteiroLeitura);
end;

procedure TNFAgIniWriter.Gerar_gSub(AINIRec: TMemIniFile; gSub: TgSub);
const
  Secao = 'gSub';
begin
  if (Trim(gSub.chNFAg) = '') then
    Exit;

  AINIRec.WriteString(Secao, 'chNFAg', gSub.chNFAg);
  AINIRec.WriteString(Secao, 'motSub', MotSubToStr(gSub.motSub));
end;

procedure TNFAgIniWriter.Gerar_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gMed.Count - 1 do
  begin
    Secao := 'gMed' + IntToStrZero(Index + 1, 2);

    AINIRec.WriteInteger(Secao, 'nMed', gMed[Index].nMed);
    AINIRec.WriteString(Secao, 'idMedidor', gMed[Index].idMedidor);
    AINIRec.WriteString(Secao, 'dMedAnt', DateTimeToIni(gMed[Index].dMedAnt));
    AINIRec.WriteString(Secao, 'dMedAtu', DateTimeToIni(gMed[Index].dMedAtu));
  end;
end;

procedure TNFAgIniWriter.Gerar_gFatConjunto(AINIRec: TMemIniFile;
  gFatConjunto: TgFatConjunto);
const
  Secao = 'gFatConjunto';
begin
  if (Trim(gFatConjunto.chNFAgFat) = '') then
    Exit;

  AINIRec.WriteString(Secao, 'chNFAgFat', gFatConjunto.chNFAgFat);
end;

procedure TNFAgIniWriter.Gerar_Det(AINIRec: TMemIniFile; Det: TDetCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to Det.Count - 1 do
  begin
    Secao := 'det' + IntToStrZero(Index + 1, 3);

    AINIRec.WriteInteger(Secao, 'nItem', Det[Index].nItem);
    AINIRec.WriteString(Secao, 'chNFAgAnt', Det[Index].chNFAgAnt);
    AINIRec.WriteInteger(Secao, 'nItemAnt', Det[Index].nItemAnt);

    AINIRec.WriteString(Secao, 'indOrigemQtd', indOrigemQtdToStr(Det[Index].Prod.indOrigemQtd));
    AINIRec.WriteString(Secao, 'cProd', Det[Index].Prod.cProd);
    AINIRec.WriteString(Secao, 'xProd', Det[Index].Prod.xProd);
    AINIRec.WriteInteger(Secao, 'cClass', Det[Index].Prod.cClass);
    AINIRec.WriteString(Secao, 'tpCategoria', tpCategoriaToStr(Det[Index].Prod.tpCategoria));
    AINIRec.WriteString(Secao, 'xCategoria', Det[Index].Prod.xCategoria);
    AINIRec.WriteString(Secao, 'qEconomias', Det[Index].Prod.qEconomias);
    AINIRec.WriteString(Secao, 'uMed', uMedFatToStr(Det[Index].Prod.uMed));
    AINIRec.WriteFloat(Secao, 'qFaturada', Det[Index].Prod.qFaturada);
    AINIRec.WriteFloat(Secao, 'vItem', Det[Index].Prod.vItem);
    AINIRec.WriteFloat(Secao, 'fatorPoluicao', Det[Index].Prod.fatorPoluicao);
    AINIRec.WriteFloat(Secao, 'vProd', Det[Index].Prod.vProd);
    AINIRec.WriteString(Secao, 'indDevolucao', TIndicadorToStr(Det[Index].Prod.indDevolucao));
    AINIRec.WriteString(Secao, 'infAdProd', Det[Index].infAdProd);

    Gerar_gPagAntecipadoProd(AINIRec, Det[Index].Prod.gPagAntecipado, Index, -1);
    Gerar_gMedicao(AINIRec, Det[Index].Prod.gMedicao, Index + 1);
    Gerar_gTarif(AINIRec, Det[Index].gTarif, Index + 1);
    Gerar_gProcRef(AINIRec, Det[Index].gProcRef, Index + 1);
    Gerar_IBSCBS(AINIRec, Det[Index].Imposto.IBSCBS, Index + 1, -1);
    Gerar_PIS(AINIRec, Det[Index].Imposto.PIS, Index + 1);
    Gerar_COFINS(AINIRec, Det[Index].Imposto.COFINS, Index + 1);
    Gerar_RetTrib(AINIRec, Det[Index].Imposto.RetTrib, Index + 1);
    Gerar_TFS(AINIRec, Det[Index].Imposto.TFS, Index + 1);
    Gerar_TFU(AINIRec, Det[Index].Imposto.TFU, Index + 1);
  end;
end;

procedure TNFAgIniWriter.Gerar_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);
var
  Secao: string;
begin
  if (gMedicao.nMed <= 0) and (gMedicao.gMedida.vMed = 0) then
    Exit;

  Secao := 'gMedicao' + IntToStrZero(DetIndex, 3);

  AINIRec.WriteInteger(Secao, 'nMed', gMedicao.nMed);
  AINIRec.WriteString(Secao, 'tpMotNaoLeitura', tpMotNaoLeituraToStr(gMedicao.tpMotNaoLeitura));

  AINIRec.WriteString(Secao, 'tpGrMed', tpGrMedToStr(gMedicao.gMedida.tpGrMed));
  AINIRec.WriteString(Secao, 'nUnidConsumo', gMedicao.gMedida.nUnidConsumo);
  AINIRec.WriteFloat(Secao, 'vUnidConsumo', gMedicao.gMedida.vUnidConsumo);
  AINIRec.WriteString(Secao, 'uMed', uMedFatToStr(gMedicao.gMedida.uMed));
  AINIRec.WriteFloat(Secao, 'vMedAnt', gMedicao.gMedida.vMedAnt);
  AINIRec.WriteFloat(Secao, 'vMedAtu', gMedicao.gMedida.vMedAtu);
  AINIRec.WriteFloat(Secao, 'vConst', gMedicao.gMedida.vConst);
  AINIRec.WriteFloat(Secao, 'vMed', gMedicao.gMedida.vMed);
end;

procedure TNFAgIniWriter.Gerar_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
var
  TarifIndex: Integer;
  Secao: string;
begin
  for TarifIndex := 0 to gTarif.Count - 1 do
  begin
    Secao := 'gTarif' + IntToStrZero(DetIndex, 3) + IntToStrZero(TarifIndex + 1, 1);

    AINIRec.WriteString(Secao, 'dIniTarif', DateTimeToIni(gTarif[TarifIndex].dIniTarif));
    AINIRec.WriteString(Secao, 'dFimTarif', DateTimeToIni(gTarif[TarifIndex].dFimTarif));
    AINIRec.WriteString(Secao, 'nAto', gTarif[TarifIndex].nAto);
    AINIRec.WriteInteger(Secao, 'anoAto', gTarif[TarifIndex].anoAto);
    AINIRec.WriteString(Secao, 'tpFaixaCons', tpFaixaConsToStr(gTarif[TarifIndex].tpFaixaCons));
  end;
end;

procedure TNFAgIniWriter.Gerar_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
var
  Secao: string;
begin
  if (gProcRef.vItem = 0) and (gProcRef.qFaturada = 0) and (gProcRef.vProd = 0) and
     (gProcRef.gProc.Count = 0) then
    Exit;

  Secao := 'gProcRef' + IntToStrZero(DetIndex, 3);

  AINIRec.WriteFloat(Secao, 'vItem', gProcRef.vItem);
  AINIRec.WriteFloat(Secao, 'qFaturada', gProcRef.qFaturada);
  AINIRec.WriteFloat(Secao, 'vProd', gProcRef.vProd);
  AINIRec.WriteString(Secao, 'indDevolucao', TIndicadorToStr(gProcRef.indDevolucao));

  Gerar_gProc(AINIRec, gProcRef.gProc, DetIndex);
end;

procedure TNFAgIniWriter.Gerar_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);
var
  ProcIndex: Integer;
  Secao: string;
begin
  for ProcIndex := 0 to gProc.Count - 1 do
  begin
    Secao := 'gProc' + IntToStrZero(DetIndex, 3) + IntToStrZero(ProcIndex + 1, 2);

    AINIRec.WriteString(Secao, 'tpProc', tpProcToStr(gProc[ProcIndex].tpProc));
    AINIRec.WriteString(Secao, 'nProcesso', gProc[ProcIndex].nProcesso);
  end;
end;

procedure TNFAgIniWriter.Gerar_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
var
  Secao: string;
begin
  if (PIS.vBC = 0) and (PIS.pPIS = 0) and (PIS.vPIS = 0) then
    Exit;

  Secao := 'PIS' + IntToStrZero(Index, 3);

  AINIRec.WriteString(Secao, 'CST', CSTPISToStr(PIS.CST));
  AINIRec.WriteFloat(Secao, 'vBC', PIS.vBC);
  AINIRec.WriteFloat(Secao, 'pPIS', PIS.pPIS);
  AINIRec.WriteFloat(Secao, 'vPIS', PIS.vPIS);
end;

procedure TNFAgIniWriter.Gerar_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
var
  Secao: string;
begin
  if (COFINS.vBC = 0) and (COFINS.pCOFINS = 0) and (COFINS.vCOFINS = 0) then
    Exit;

  Secao := 'COFINS' + IntToStrZero(Index, 3);

  AINIRec.WriteString(Secao, 'CST', CSTCOFINSToStr(COFINS.CST));
  AINIRec.WriteFloat(Secao, 'vBC', COFINS.vBC);
  AINIRec.WriteFloat(Secao, 'pCOFINS', COFINS.pCOFINS);
  AINIRec.WriteFloat(Secao, 'vCOFINS', COFINS.vCOFINS);
end;

procedure TNFAgIniWriter.Gerar_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
var
  Secao: string;
begin
  if (RetTrib.vRetPIS = 0) and (RetTrib.vRetCOFINS = 0) and (RetTrib.vRetCSLL = 0) and
     (RetTrib.vIRRF = 0) then
    Exit;

  Secao := 'retTrib' + IntToStrZero(Index, 3);

  AINIRec.WriteFloat(Secao, 'vRetPIS', RetTrib.vRetPIS);
  AINIRec.WriteFloat(Secao, 'vRetCOFINS', RetTrib.vRetCOFINS);
  AINIRec.WriteFloat(Secao, 'vRetCSLL', RetTrib.vRetCSLL);
  AINIRec.WriteFloat(Secao, 'vIRRF', RetTrib.vIRRF);
end;

procedure TNFAgIniWriter.Gerar_TFS(AINIRec: TMemIniFile; TFS: TTFS; Index: Integer);
var
  Secao: string;
begin
  if (TFS.vBCTFS = 0) and (TFS.pTFS = 0) and (TFS.vTFS = 0) then
    Exit;

  Secao := 'TFS' + IntToStrZero(Index, 3);

  AINIRec.WriteFloat(Secao, 'vBCTFS', TFS.vBCTFS);
  AINIRec.WriteFloat(Secao, 'pTFS', TFS.pTFS);
  AINIRec.WriteFloat(Secao, 'vTFS', TFS.vTFS);
end;

procedure TNFAgIniWriter.Gerar_TFU(AINIRec: TMemIniFile; TFU: TTFU;
  Index: Integer);
var
  Secao: string;
begin
  if (TFU.vBCTFU = 0) and (TFU.pTFU = 0) and (TFU.vTFU = 0) then
    Exit;

  Secao := 'TFS' + IntToStrZero(Index, 3);

  AINIRec.WriteFloat(Secao, 'vBCTFU', TFU.vBCTFU);
  AINIRec.WriteFloat(Secao, 'pTFU', TFU.pTFU);
  AINIRec.WriteFloat(Secao, 'vTFU', TFU.vTFU);
end;

procedure TNFAgIniWriter.Gerar_Total(AINIRec: TMemIniFile; Total: TTotal);
var
  Secao: string;
begin
  Secao := 'total';

  AINIRec.WriteFloat(Secao, 'vProd', Total.vProd);
  AINIRec.WriteFloat(Secao, 'vRetPIS', Total.vRetPIS);
  AINIRec.WriteFloat(Secao, 'vRetCOFINS', Total.vRetCOFINS);
  AINIRec.WriteFloat(Secao, 'vRetCSLL', Total.vRetCSLL);
  AINIRec.WriteFloat(Secao, 'vIRRF', Total.vIRRF);
  AINIRec.WriteFloat(Secao, 'vCOFINS', Total.vCOFINS);
  AINIRec.WriteFloat(Secao, 'vPIS', Total.vPIS);
  AINIRec.WriteFloat(Secao, 'vTFS', Total.vTFS);
  AINIRec.WriteFloat(Secao, 'vTFU', Total.vTFU);
  AINIRec.WriteFloat(Secao, 'vNF', Total.vNF);
  AINIRec.WriteFloat(Secao, 'vTotDFe', Total.vTotDFe);

  // Reforma Tributária
  Gerar_IBSCBSTot(AINIRec, Total.IBSCBSTot);
end;

procedure TNFAgIniWriter.Gerar_gFat(AINIRec: TMemIniFile; gFat: TgFat);
var
  Secao: string;
begin
  Secao := 'gFat';

  AINIRec.WriteString(Secao, 'CompetFat', DateTimeToIni(gFat.CompetFat));
  AINIRec.WriteString(Secao, 'dVencFat', DateTimeToIni(gFat.dVencFat));
  AINIRec.WriteString(Secao, 'dApresFat', DateTimeToIni(gFat.dApresFat));
  AINIRec.WriteString(Secao, 'dProxLeitura', DateTimeToIni(gFat.dProxLeitura));
  AINIRec.WriteString(Secao, 'nFat', gFat.nFat);
  AINIRec.WriteString(Secao, 'codBarras', gFat.codBarras);
  AINIRec.WriteString(Secao, 'codDebAuto', gFat.codDebAuto);
  AINIRec.WriteString(Secao, 'codBanco', gFat.codBanco);
  AINIRec.WriteString(Secao, 'codAgencia', gFat.codAgencia);

  Gerar_gFatEnderCorresp(AINIRec, gFat.enderCorresp);
  Gerar_gFatgPIX(AINIRec, gFat.gPIX);
end;

procedure TNFAgIniWriter.Gerar_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
var
  Secao: string;
begin
  Secao := 'enderCorresp';

  AINIRec.WriteString(Secao, 'xLgr', enderCorresp.xLgr);
  AINIRec.WriteString(Secao, 'nro', enderCorresp.nro);
  AINIRec.WriteString(Secao, 'xCpl', enderCorresp.xCpl);
  AINIRec.WriteString(Secao, 'xBairro', enderCorresp.xBairro);
  AINIRec.WriteInteger(Secao, 'cMun', enderCorresp.cMun);
  AINIRec.WriteString(Secao, 'xMun', enderCorresp.xMun);
  AINIRec.WriteInteger(Secao, 'CEP', enderCorresp.CEP);
  AINIRec.WriteString(Secao, 'UF', enderCorresp.UF);
  AINIRec.WriteString(Secao, 'fone', enderCorresp.fone);
  AINIRec.WriteString(Secao, 'email', enderCorresp.email);
end;

procedure TNFAgIniWriter.Gerar_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);
var
  Secao: string;
begin
  Secao := 'gPIX';

  AINIRec.WriteString(Secao, 'urlQRCodePIX', gPIX.urlQRCodePIX);
end;

procedure TNFAgIniWriter.Gerar_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
var
  Secao: string;
begin
  Secao := 'gAgencia';

  AINIRec.WriteString(Secao, 'econ', gAgencia.econ);
  AINIRec.WriteString(Secao, 'econAcumulada', gAgencia.econAcumulada);
  AINIRec.WriteString(Secao, 'sPrestador', gAgencia.sPrestador);
  AINIRec.WriteString(Secao, 'dEmissSelo', DateTimeToIni(gAgencia.dEmissSelo));
  AINIRec.WriteString(Secao, 'sRegulador', gAgencia.sRegulador);
  AINIRec.WriteString(Secao, 'nAgenciaAtend', gAgencia.nAgenciaAtend);
  AINIRec.WriteString(Secao, 'enderAgenciaAtend', gAgencia.enderAgenciaAtend);

  Gerar_gAgenciaHistCons(AINIRec, gAgencia.gHistCons);
end;

procedure TNFAgIniWriter.Gerar_gAgenciaHistCons(AINIRec: TMemIniFile; gHistCons: TgHistConsCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gHistCons.Count - 1 do
  begin
    Secao := 'gHistCons' + IntToStrZero(Index + 1, 1);

    AINIRec.WriteString(Secao, 'xHistorico', gHistCons[Index].xHistorico);
    AINIRec.WriteFloat(Secao, 'medMensal', gHistCons[Index].medMensal);

    Gerar_gAgenciaCons(AINIRec, gHistCons[Index].gCons, Index + 1);
  end;
end;

procedure TNFAgIniWriter.Gerar_gAgenciaCons(AINIRec: TMemIniFile; gCons: TgConsCollection; HistIndex: Integer);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gCons.Count - 1 do
  begin
    Secao := 'gCons' + IntToStrZero(HistIndex, 1) + IntToStrZero(Index + 1, 2);

    AINIRec.WriteString(Secao, 'CompetFat', DateTimeToIni(gCons[Index].CompetFat));
    AINIRec.WriteString(Secao, 'uMed', uMedFatToStr(gCons[Index].uMed));
    AINIRec.WriteString(Secao, 'qtdDias', gCons[Index].qtdDias);
    AINIRec.WriteFloat(Secao, 'medDiaria', gCons[Index].medDiaria);
    AINIRec.WriteFloat(Secao, 'consumo', gCons[Index].consumo);
    AINIRec.WriteFloat(Secao, 'volFat', gCons[Index].volFat);
  end;
end;

procedure TNFAgIniWriter.Gerar_gQualiAgua(AINIRec: TMemIniFile;
  gQualiAgua: TgQualiAgua);
var
  Secao: string;
begin
  Secao := 'gQualiAgua';

  AINIRec.WriteString(Secao, 'CompetAnalise', DateTimeToIni(gQualiAgua.CompetAnalise));
  AINIRec.WriteString(Secao, 'Conclusao', gQualiAgua.Conclusao);
  AINIRec.WriteString(Secao, 'cProcesso', gQualiAgua.cProcesso);
  AINIRec.WriteString(Secao, 'SistemaAbast', gQualiAgua.SistemaAbast);

  Gerar_gAnalise(AINIRec, gQualiAgua.gAnalise);
end;

procedure TNFAgIniWriter.Gerar_gAnalise(AINIRec: TMemIniFile;
  gAnalise: TgAnaliseCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gAnalise.Count - 1 do
  begin
    Secao := 'gAnalise' + IntToStrZero(Index + 1, 2);

    AINIRec.WriteString(Secao, 'xItemAnalisado', gAnalise[Index].xItemAnalisado);
    AINIRec.WriteString(Secao, 'nAmostraMinima', gAnalise[Index].nAmostraMinima);
    AINIRec.WriteString(Secao, 'nAmostraAnalisada', gAnalise[Index].nAmostraAnalisada);
    AINIRec.WriteString(Secao, 'nAmostraFPadrao', gAnalise[Index].nAmostraFPadrao);
    AINIRec.WriteString(Secao, 'nAmostraDPadrao', gAnalise[Index].nAmostraDPadrao);
    AINIRec.WriteString(Secao, 'nMediaMensal', gAnalise[Index].nMediaMensal);
    AINIRec.WriteString(Secao, 'xValorReferencia', gAnalise[Index].xValorReferencia);
  end;
end;

procedure TNFAgIniWriter.Gerar_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to autXML.Count - 1 do
  begin
    Secao := 'autXML' + IntToStrZero(Index + 1, 2);
    AINIRec.WriteString(Secao, 'CNPJCPF', autXML[Index].CNPJCPF);
  end;
end;

procedure TNFAgIniWriter.Gerar_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
var
  Secao: string;
begin
  Secao := 'infAdic';

  AINIRec.WriteString(Secao, 'infAdFisco', InfAdic.infAdFisco);
  { Mudar para uma lista com até 5 ocorrências }
  AINIRec.WriteString(Secao, 'infCpl', InfAdic.infCpl);
end;

procedure TNFAgIniWriter.Gerar_InfPAA(AINIRec: TMemIniFile; InfPAA: TInfPAA);
var
  Secao: string;
begin
  Secao := 'infPAA';

  AINIRec.WriteString(Secao, 'CNPJPAA', infPAA.CNPJPAA);
end;

procedure TNFAgIniWriter.Gerar_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);
var
  Secao: string;
begin
  if Trim(InfRespTec.CNPJ) = '' then
    Exit;

  Secao := 'infRespTec';

  AINIRec.WriteString(Secao, 'CNPJ', InfRespTec.CNPJ);
  AINIRec.WriteString(Secao, 'xContato', InfRespTec.xContato);
  AINIRec.WriteString(Secao, 'email', InfRespTec.email);
  AINIRec.WriteString(Secao, 'fone', InfRespTec.fone);
  AINIRec.WriteInteger(Secao, 'idCSRT', InfRespTec.idCSRT);
  AINIRec.WriteString(Secao, 'hashCSRT', InfRespTec.hashCSRT);
end;

end.
