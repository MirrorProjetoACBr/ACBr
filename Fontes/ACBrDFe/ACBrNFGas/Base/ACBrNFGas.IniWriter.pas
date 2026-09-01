{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Jonathas Duarte Pereira                         }
{                              Italo Giurizzato Junior                         }
{                              Juliomar Marchetti                              }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFGas.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFGas.Classes,
  ACBrDFe.RTC.Classes,
  ACBrDFe.RTC.IniWriter,
  ACBrNFGas.Conversao;

type
  { TNFGasIniWriter }

  TNFGasIniWriter = class(TDFeRTCIniWriter)
  private
    FNFGas: TNFGas;

    procedure Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Gerar_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
    procedure Gerar_Instalacao(AINIRec: TMemIniFile; Instalacao: TInstalacao);
    procedure Gerar_gSub(AINIRec: TMemIniFile; gSub: TgSub);
    procedure Gerar_gVolContrat(AINIRec: TMemIniFile; gVolContrat: TgVolContratCollection);
    procedure Gerar_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);

    procedure Gerar_Det(AINIRec: TMemIniFile; Det: TDetCollection);
    procedure Gerar_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);
    procedure Gerar_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
    procedure Gerar_gAgregadora(AINIRec: TMemIniFile; gAgregadora: TgAgregadora; DetIndex: Integer);

    procedure Gerar_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
    procedure Gerar_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);

    procedure Gerar_ICMS(AINIRec: TMemIniFile; ICMS: TICMS; Index: Integer);
    procedure Gerar_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
    procedure Gerar_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
    procedure Gerar_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
    procedure Gerar_TxReg(AINIRec: TMemIniFile; TxReg: TTxReg; Index: Integer);

    procedure Gerar_Total(AINIRec: TMemIniFile; Total: TTotal);

    procedure Gerar_gFat(AINIRec: TMemIniFile; gFat: TgFat);
    procedure Gerar_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
    procedure Gerar_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);

    procedure Gerar_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
    procedure Gerar_gAgenciaHistCons(AINIRec: TMemIniFile; gHistCons: TgHistConsCollection);
    procedure Gerar_gAgenciaCons(AINIRec: TMemIniFile; gCons: TgConsCollection; HistIndex: Integer);

    procedure Gerar_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Gerar_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
    procedure Gerar_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);

    function DateTimeToIni(const AValue: TDateTime): string;
  public
    constructor Create(AOwner: TNFGas); reintroduce;
    destructor Destroy; override;

    function GravarIni: string;

    property NFGas: TNFGas read FNFGas write FNFGas;
  end;

implementation

uses
  ACBrDFeUtil,
  ACBrNFGas,
  ACBrUtil.Base;

{ TNFGasIniWriter }

constructor TNFGasIniWriter.Create(AOwner: TNFGas);
begin
  inherited Create;

  FNFGas := AOwner;
end;

destructor TNFGasIniWriter.Destroy;
begin

  inherited Destroy;
end;

function TNFGasIniWriter.DateTimeToIni(const AValue: TDateTime): string;
begin
  if AValue <= 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := DateTimeToStr(AValue);
end;

function TNFGasIniWriter.GravarIni: string;
var
  INIRec: TMemIniFile;
  IniNFGas: TStringList;
begin
  Result := '';
  ModelosDFe := mdfNFGas;
  tpNFDebito := tdNenhum;

  if not ValidarChave(FNFGas.infNFGas.ID) then
    raise EACBrNFGasException.Create('NFGas Inconsistente para gerar INI. Chave Inválida.');

  INIRec := TMemIniFile.Create('');
  try
    INIRec.WriteString('infNFGas', 'ID', FNFGas.infNFGas.ID);
    INIRec.WriteString('infNFGas', 'Versao', FloatToStr(FNFGas.infNFGas.Versao));

    Gerar_Identificacao(INIRec, FNFGas.Ide);
    Gerar_Emitente(INIRec, FNFGas.Emit);
    Gerar_Destinatario(INIRec, FNFGas.Dest);
    Gerar_Instalacao(INIRec, FNFGas.Instalacao);
    Gerar_gSub(INIRec, FNFGas.gSub);
    Gerar_gVolContrat(INIRec, FNFGas.gVolContrat);
    Gerar_gMed(INIRec, FNFGas.gMed);
    Gerar_Det(INIRec, FNFGas.Det);
    Gerar_Total(INIRec, FNFGas.Total);
    Gerar_pgtoVinc(INIRec, FNFGas.pgtoVinc.pgto);
    Gerar_gFat(INIRec, FNFGas.gFat);
    Gerar_gAgencia(INIRec, FNFGas.gAgencia);
    Gerar_autXML(INIRec, FNFGas.autXML);
    Gerar_InfAdic(INIRec, FNFGas.infAdic);
    Gerar_InfRespTec(INIRec, FNFGas.infRespTec);

    IniNFGas := TStringList.Create;
    try
      INIRec.GetStrings(IniNFGas);

      Result := StringReplace(IniNFGas.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniNFGas.Free;
    end;
  finally
    INIRec.Free;
  end;
end;

procedure TNFGasIniWriter.Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
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
  AINIRec.WriteString(Secao, 'finNFGas', finNFGasToStr(Ide.finNFGas));
  AINIRec.WriteString(Secao, 'tpFat', tpFatToStr(Ide.tpFat));
  AINIRec.WriteString(Secao, 'verProc', Ide.verProc);
  AINIRec.WriteString(Secao, 'dhCont', DateTimeToIni(Ide.dhCont));
  AINIRec.WriteString(Secao, 'xJust', Ide.xJust);

  if Ide.tpPagAnt <> tpaNenhum then
    AINIRec.WriteString(Secao, 'tpPagAnt', tpPagAntToStr(Ide.tpPagAnt));

  Gerar_gCompraGovReduzido(AINIRec, Ide.gCompraGov);
end;

procedure TNFGasIniWriter.Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
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
  AINIRec.WriteInteger(Secao, 'cPais', Emit.EnderEmit.cPais);
  AINIRec.WriteString(Secao, 'xPais', Emit.EnderEmit.xPais);
end;

procedure TNFGasIniWriter.Gerar_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
var
  Secao: string;
begin
  Secao := 'dest';

  AINIRec.WriteString(Secao, 'xNome', Dest.xNome);
  AINIRec.WriteString(Secao, 'CNPJCPF', Dest.CNPJCPF);
  AINIRec.WriteString(Secao, 'idOutros', Dest.idOutros);
  AINIRec.WriteString(Secao, 'indIEDest', indIEDestToStr(Dest.indIEDest));
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
  AINIRec.WriteInteger(Secao, 'cPais', Dest.EnderDest.cPais);
  AINIRec.WriteString(Secao, 'xPais', Dest.EnderDest.xPais);
end;

procedure TNFGasIniWriter.Gerar_Instalacao(AINIRec: TMemIniFile; Instalacao: TInstalacao);
var
  Secao: string;
begin
  Secao := 'Instalacao';

  if Trim(Instalacao.idInstalacao) = '' then
    Exit;

  AINIRec.WriteString(Secao, 'idInstalacao', Instalacao.idInstalacao);
  AINIRec.WriteString(Secao, 'idCodCliente', Instalacao.idCodCliente);
  AINIRec.WriteString(Secao, 'tpInstalacao', InstalacaoToStr(Instalacao.tpInstalacao));
  AINIRec.WriteString(Secao, 'nContrato', Instalacao.nContrato);
  AINIRec.WriteString(Secao, 'tpClasse', ClasseToStr(Instalacao.tpClasse));
  AINIRec.WriteString(Secao, 'xClasse', Instalacao.xClasse);
  AINIRec.WriteString(Secao, 'latGPS', Instalacao.latGPS);
  AINIRec.WriteString(Secao, 'longGPS', Instalacao.longGPS);
  AINIRec.WriteString(Secao, 'codRoteiroLeitura', Instalacao.codRoteiroLeitura);
end;

procedure TNFGasIniWriter.Gerar_gSub(AINIRec: TMemIniFile; gSub: TgSub);
const
  Secao = 'gSub';
begin
  if (Trim(gSub.chNFGas) = '') and (Trim(gSub.gNF.CNPJ) = '') then
    Exit;

  AINIRec.WriteString(Secao, 'chNFGas', gSub.chNFGas);
  AINIRec.WriteString(Secao, 'motSub', MotSubToStr(gSub.motSub));
  AINIRec.WriteString(Secao, 'CNPJ', gSub.gNF.CNPJ);
  AINIRec.WriteString(Secao, 'Serie', gSub.gNF.serie);
  AINIRec.WriteInteger(Secao, 'nNF', gSub.gNF.nNF);
  AINIRec.WriteString(Secao, 'CompetEmis', DateTimeToIni(gSub.gNF.CompetEmis));
  AINIRec.WriteString(Secao, 'CompetApur', DateTimeToIni(gSub.gNF.CompetApur));
  AINIRec.WriteString(Secao, 'hash115', gSub.gNF.hash115);
end;

procedure TNFGasIniWriter.Gerar_gVolContrat(AINIRec: TMemIniFile; gVolContrat: TgVolContratCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gVolContrat.Count - 1 do
  begin
    Secao := 'gVolContrat' + IntToStrZero(Index + 1, 2);

    AINIRec.WriteInteger(Secao, 'nContrat', gVolContrat[Index].nContrat);
    AINIRec.WriteString(Secao, 'tpVolContrat', VolContratToStr(gVolContrat[Index].tpVolContrat));
    AINIRec.WriteFloat(Secao, 'qUnidContrat', gVolContrat[Index].qUnidContrat);
  end;
end;

procedure TNFGasIniWriter.Gerar_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gMed.Count - 1 do
  begin
    Secao := 'gMed' + IntToStrZero(Index + 1, 2);

    AINIRec.WriteInteger(Secao, 'nMed', gMed[Index].nMed);
    AINIRec.WriteString(Secao, 'idEqp', gMed[Index].idEqp);
    AINIRec.WriteString(Secao, 'dMedAnt', DateTimeToIni(gMed[Index].dMedAnt));
    AINIRec.WriteFloat(Secao, 'vMedAnt', gMed[Index].vMedAnt);
    AINIRec.WriteString(Secao, 'dMedAtu', DateTimeToIni(gMed[Index].dMedAtu));
    AINIRec.WriteFloat(Secao, 'vMedAtu', gMed[Index].vMedAtu);
    AINIRec.WriteString(Secao, 'tpEqp', tpEqpToStr(gMed[Index].tpEqp));
    AINIRec.WriteString(Secao, 'tpMedidor', tpMedidorToStr(gMed[Index].tpMedidor));
  end;
end;

procedure TNFGasIniWriter.Gerar_Det(AINIRec: TMemIniFile; Det: TDetCollection);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to Det.Count - 1 do
  begin
    Secao := 'det' + IntToStrZero(Index + 1, 3);

    AINIRec.WriteInteger(Secao, 'nItem', Det[Index].nItem);
    AINIRec.WriteString(Secao, 'chNFGasAnt', Det[Index].chNFGasAnt);
    AINIRec.WriteInteger(Secao, 'nItemAnt', Det[Index].nItemAnt);
    AINIRec.WriteString(Secao, 'orig', OrigToStr(Det[Index].gNormal.Imposto.Orig));
    AINIRec.WriteString(Secao, 'indSemCST', TIndicadorToStr(Det[Index].gNormal.Imposto.indSemCST));
    AINIRec.WriteString(Secao, 'indOrigemQtd', indOrigemQtdToStr(Det[Index].gNormal.Prod.indOrigemQtd));
    AINIRec.WriteString(Secao, 'cProd', Det[Index].gNormal.Prod.cProd);
    AINIRec.WriteString(Secao, 'xProd', Det[Index].gNormal.Prod.xProd);
    AINIRec.WriteInteger(Secao, 'cClass', Det[Index].gNormal.Prod.cClass);
    AINIRec.WriteInteger(Secao, 'CFOP', Det[Index].gNormal.Prod.CFOP);
    AINIRec.WriteString(Secao, 'uMed', uMedItemToStr(Det[Index].gNormal.Prod.uMed));
    AINIRec.WriteInteger(Secao, 'qFaturada', Det[Index].gNormal.Prod.qFaturada);
    AINIRec.WriteFloat(Secao, 'vItem', Det[Index].gNormal.Prod.vItem);
    AINIRec.WriteFloat(Secao, 'fatorPCS', Det[Index].gNormal.Prod.fatorPCS);
    AINIRec.WriteFloat(Secao, 'fatorPTZ', Det[Index].gNormal.Prod.fatorPTZ);
    AINIRec.WriteFloat(Secao, 'fatorP', Det[Index].gNormal.Prod.fatorP);
    AINIRec.WriteFloat(Secao, 'fatorT', Det[Index].gNormal.Prod.fatorT);
    AINIRec.WriteFloat(Secao, 'vProd', Det[Index].gNormal.Prod.vProd);
    AINIRec.WriteString(Secao, 'indDevolucao', TIndicadorToStr(Det[Index].gNormal.Prod.indDevolucao));
    AINIRec.WriteString(Secao, 'infAdProd', Det[Index].gNormal.infAdProd);

    Gerar_gPagAntecipadoProd(AINIRec, Det[Index].gNormal.Prod.gPagAntecipado, Index + 1, -1);
    Gerar_gMedicao(AINIRec, Det[Index].gNormal.Prod.gMedicao, Index + 1);

    Gerar_gTarif(AINIRec, Det[Index].gNormal.gTarif, Index + 1);
    Gerar_gAgregadora(AINIRec, Det[Index].gAgregadora, Index + 1);
    Gerar_gProcRef(AINIRec, Det[Index].gNormal.gProcRef, Index + 1);

    Gerar_ICMS(AINIRec, Det[Index].gNormal.Imposto.ICMS, Index + 1);
    Gerar_IBSCBS(AINIRec, Det[Index].gNormal.Imposto.IBSCBS, Index + 1, -1);
    Gerar_PIS(AINIRec, Det[Index].gNormal.Imposto.PIS, Index + 1);
    Gerar_COFINS(AINIRec, Det[Index].gNormal.Imposto.COFINS, Index + 1);
    Gerar_RetTrib(AINIRec, Det[Index].gNormal.Imposto.RetTrib, Index + 1);
    Gerar_TxReg(AINIRec, Det[Index].gNormal.Imposto.TxReg, Index + 1);
  end;
end;

procedure TNFGasIniWriter.Gerar_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);
var
  Secao: string;
begin
  if (gMedicao.nMed <= 0) and (gMedicao.nContrat <= 0) and (gMedicao.gMedida.vMed = 0) and
     (Trim(gMedicao.xMotNaoLeitura) = '') then
    Exit;

  Secao := 'gMedicao' + IntToStrZero(DetIndex, 3);

  AINIRec.WriteInteger(Secao, 'nMed', gMedicao.nMed);
  AINIRec.WriteInteger(Secao, 'nContrat', gMedicao.nContrat);
  AINIRec.WriteString(Secao, 'uMed', uMedToStr(gMedicao.gMedida.uMed));
  AINIRec.WriteFloat(Secao, 'vMed', gMedicao.gMedida.vMed);
  AINIRec.WriteString(Secao, 'tpMotNaoLeitura', tpMotNaoLeituraToStr(gMedicao.tpMotNaoLeitura));
  AINIRec.WriteString(Secao, 'xMotNaoLeitura', gMedicao.xMotNaoLeitura);
end;

procedure TNFGasIniWriter.Gerar_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
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
    AINIRec.WriteFloat(Secao, 'vTarifAplic', gTarif[TarifIndex].vTarifAplic);
  end;
end;

procedure TNFGasIniWriter.Gerar_gAgregadora(AINIRec: TMemIniFile; gAgregadora: TgAgregadora; DetIndex: Integer);
var
  Secao: string;
begin
  if (Trim(gAgregadora.cClass) = '') and (gAgregadora.vTotDFe = 0) then
    Exit;

  Secao := 'gAgregadora' + IntToStrZero(DetIndex, 3);

  AINIRec.WriteString(Secao, 'cClass', gAgregadora.cClass);
  AINIRec.WriteFloat(Secao, 'vTotDFe', gAgregadora.vTotDFe);
end;

procedure TNFGasIniWriter.Gerar_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
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

procedure TNFGasIniWriter.Gerar_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);
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

procedure TNFGasIniWriter.Gerar_ICMS(AINIRec: TMemIniFile; ICMS: TICMS; Index: Integer);
var
  Secao: string;
begin
  Secao := 'ICMS' + IntToStrZero(Index, 3);

  AINIRec.WriteString(Secao, 'indSemCST', TIndicadorToStr(ICMS.indSemCST));
  AINIRec.WriteString(Secao, 'CST', CSTICMSToStr(ICMS.CST));
  AINIRec.WriteString(Secao, 'modBC', modBCToStr(ICMS.modBC));
  AINIRec.WriteFloat(Secao, 'pRedBC', ICMS.pRedBC);
  AINIRec.WriteFloat(Secao, 'vBC', ICMS.vBC);
  AINIRec.WriteFloat(Secao, 'pICMS', ICMS.pICMS);
  AINIRec.WriteFloat(Secao, 'vICMS', ICMS.vICMS);
  AINIRec.WriteFloat(Secao, 'vICMSDeson', ICMS.vICMSDeson);
  AINIRec.WriteString(Secao, 'motDesICMS', motDesICMSToStr(ICMS.motDesICMS));
  AINIRec.WriteString(Secao, 'indDeduzDeson', TIndicadorExToStr(ICMS.indDeduzDeson));
  AINIRec.WriteString(Secao, 'cBenef', ICMS.cBenef);
  AINIRec.WriteString(Secao, 'modBCST', modBCSTToStr(ICMS.modBCST));
  AINIRec.WriteFloat(Secao, 'pMVAST', ICMS.pMVAST);
  AINIRec.WriteFloat(Secao, 'pRedBCST', ICMS.pRedBCST);
  AINIRec.WriteFloat(Secao, 'vBCST', ICMS.vBCST);
  AINIRec.WriteFloat(Secao, 'pICMSST', ICMS.pICMSST);
  AINIRec.WriteFloat(Secao, 'vICMSST', ICMS.vICMSST);
  AINIRec.WriteFloat(Secao, 'vBCFCP', ICMS.vBCFCP);
  AINIRec.WriteFloat(Secao, 'pFCPST', ICMS.pFCPST);
  AINIRec.WriteFloat(Secao, 'vFCPST', ICMS.vFCPST);
  AINIRec.WriteFloat(Secao, 'vBCFCPST', ICMS.vBCFCPST);
  AINIRec.WriteFloat(Secao, 'vBCSTRet', ICMS.vBCSTRet);
  AINIRec.WriteFloat(Secao, 'pICMSSTRet', ICMS.pICMSSTRet);
  AINIRec.WriteFloat(Secao, 'vICMSSubstituto', ICMS.vICMSSubstituto);
  AINIRec.WriteFloat(Secao, 'vICMSSTRet', ICMS.vICMSSTRet);
  AINIRec.WriteFloat(Secao, 'vBCFCPSTRet', ICMS.vBCFCPSTRet);
  AINIRec.WriteFloat(Secao, 'pFCPSTRet', ICMS.pFCPSTRet);
  AINIRec.WriteFloat(Secao, 'vFCPSTRet', ICMS.vFCPSTRet);
  AINIRec.WriteFloat(Secao, 'pRedBCEfet', ICMS.pRedBCEfet);
  AINIRec.WriteFloat(Secao, 'vBCEfet', ICMS.vBCEfet);
  AINIRec.WriteFloat(Secao, 'pICMSEfet', ICMS.pICMSEfet);
  AINIRec.WriteFloat(Secao, 'vICMSEfet', ICMS.vICMSEfet);
  AINIRec.WriteFloat(Secao, 'pFCP', ICMS.pFCP);
  AINIRec.WriteFloat(Secao, 'vFCP', ICMS.vFCP);
end;

procedure TNFGasIniWriter.Gerar_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
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

procedure TNFGasIniWriter.Gerar_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
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

procedure TNFGasIniWriter.Gerar_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
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

procedure TNFGasIniWriter.Gerar_TxReg(AINIRec: TMemIniFile; TxReg: TTxReg; Index: Integer);
var
  Secao: string;
begin
  if (TxReg.vBC = 0) and (TxReg.pTaxa = 0) and (TxReg.vTaxa = 0) then
    Exit;

  Secao := 'TxReg' + IntToStrZero(Index, 3);

  AINIRec.WriteFloat(Secao, 'vBC', TxReg.vBC);
  AINIRec.WriteFloat(Secao, 'pTaxa', TxReg.pTaxa);
  AINIRec.WriteFloat(Secao, 'vTaxa', TxReg.vTaxa);
end;

procedure TNFGasIniWriter.Gerar_Total(AINIRec: TMemIniFile; Total: TTotal);
var
  Secao: string;
begin
  Secao := 'total';

  AINIRec.WriteFloat(Secao, 'vProd', Total.vProd);
  AINIRec.WriteFloat(Secao, 'vBC', Total.vBC);
  AINIRec.WriteFloat(Secao, 'vICMS', Total.vICMS);
  AINIRec.WriteFloat(Secao, 'vBCST', Total.vBCST);
  AINIRec.WriteFloat(Secao, 'vFCPST', Total.vFCPST);
  AINIRec.WriteFloat(Secao, 'vICMSDeson', Total.vICMSDeson);
  AINIRec.WriteFloat(Secao, 'vFCP', Total.vFCP);
  AINIRec.WriteFloat(Secao, 'vCOFINS', Total.vCOFINS);
  AINIRec.WriteFloat(Secao, 'vPIS', Total.vPIS);
  AINIRec.WriteFloat(Secao, 'vTxReg', Total.vTxReg);
  AINIRec.WriteFloat(Secao, 'vRetPIS', Total.vRetPIS);
  AINIRec.WriteFloat(Secao, 'vRetCOFINS', Total.vRetCOFINS);
  AINIRec.WriteFloat(Secao, 'vRetCSLL', Total.vRetCSLL);
  AINIRec.WriteFloat(Secao, 'vIRRF', Total.vIRRF);
  AINIRec.WriteFloat(Secao, 'vNF', Total.vNF);
  AINIRec.WriteFloat(Secao, 'vTotDFe', Total.vTotDFe);

  Gerar_IBSCBSTot(AINIRec, Total.IBSCBSTot);
end;

procedure TNFGasIniWriter.Gerar_gFat(AINIRec: TMemIniFile; gFat: TgFat);
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
  AINIRec.WriteString(Secao, 'infAdFat', gFat.infAdFat);

  Gerar_gFatEnderCorresp(AINIRec, gFat.enderCorresp);
  Gerar_gFatgPIX(AINIRec, gFat.gPIX);
end;


procedure TNFGasIniWriter.Gerar_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
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

procedure TNFGasIniWriter.Gerar_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);
var
  Secao: string;
begin
  Secao := 'gPIX';

  AINIRec.WriteString(Secao, 'urlQRCodePIX', gPIX.urlQRCodePIX);
end;

procedure TNFGasIniWriter.Gerar_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
var
  Secao: string;
begin
  Secao := 'gAgencia';

  AINIRec.WriteString(Secao, 'nomeAgenciaAtend', gAgencia.nomeAgenciaAtend);
  AINIRec.WriteString(Secao, 'enderAgenciaAtend', gAgencia.enderAgenciaAtend);
  AINIRec.WriteString(Secao, 'sitioAgenciaAtend', gAgencia.sitioAgenciaAtend);
  AINIRec.WriteString(Secao, 'infAdReg', gAgencia.infAdReg);

  Gerar_gAgenciaHistCons(AINIRec, gAgencia.gHistCons);
end;

procedure TNFGasIniWriter.Gerar_gAgenciaHistCons(AINIRec: TMemIniFile; gHistCons: TgHistConsCollection);
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

procedure TNFGasIniWriter.Gerar_gAgenciaCons(AINIRec: TMemIniFile; gCons: TgConsCollection; HistIndex: Integer);
var
  Index: Integer;
  Secao: string;
begin
  for Index := 0 to gCons.Count - 1 do
  begin
    Secao := 'gCons' + IntToStrZero(HistIndex, 1) + IntToStrZero(Index + 1, 2);

    AINIRec.WriteString(Secao, 'CompetFat', DateTimeToIni(gCons[Index].CompetFat));
    AINIRec.WriteString(Secao, 'uMed', uMedToStr(gCons[Index].uMed));
    AINIRec.WriteInteger(Secao, 'qtdDias', gCons[Index].qtdDias);
    AINIRec.WriteFloat(Secao, 'medDiaria', gCons[Index].medDiaria);
    AINIRec.WriteFloat(Secao, 'consumo', gCons[Index].consumo);
    AINIRec.WriteFloat(Secao, 'vFat', gCons[Index].vFat);
  end;
end;

procedure TNFGasIniWriter.Gerar_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
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

procedure TNFGasIniWriter.Gerar_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
var
  Secao: string;
begin
  Secao := 'infAdic';

  AINIRec.WriteString(Secao, 'infAdFisco', InfAdic.infAdFisco);
  { Mudar para uma lista com até 5 ocorrências }
  AINIRec.WriteString(Secao, 'infCpl', InfAdic.infCpl);
end;

procedure TNFGasIniWriter.Gerar_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);
var
  Secao: string;
begin
  if Trim(InfRespTec.CNPJ) = '' then
  begin
    Exit;
  end;

  Secao := 'infRespTec';

  AINIRec.WriteString(Secao, 'CNPJ', InfRespTec.CNPJ);
  AINIRec.WriteString(Secao, 'xContato', InfRespTec.xContato);
  AINIRec.WriteString(Secao, 'email', InfRespTec.email);
  AINIRec.WriteString(Secao, 'fone', InfRespTec.fone);
  AINIRec.WriteInteger(Secao, 'idCSRT', InfRespTec.idCSRT);
  AINIRec.WriteString(Secao, 'hashCSRT', InfRespTec.hashCSRT);
end;

end.
