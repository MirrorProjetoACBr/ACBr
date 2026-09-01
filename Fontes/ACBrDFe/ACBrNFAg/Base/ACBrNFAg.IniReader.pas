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

unit ACBrNFAg.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFAg.Classes,
  ACBrNFAg.Conversao,
  ACBrDFe.RTC.IniReader,
  ACBrDFeComum.Proc;

type
  { TNFAgIniReader }

  TNFAgIniReader = class(TDFeRTCIniReader)
  private
    FNFAg: TNFAg;
    FVersaoDF: TVersaoNFAg;
    FAmbiente: Integer;
    FtpEmis: Integer;

    procedure Ler_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Ler_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Ler_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
    procedure Ler_Ligacao(AINIRec: TMemIniFile; Ligacao: TLigacao);
    procedure Ler_gSub(AINIRec: TMemIniFile; gSub: TgSub);
    procedure Ler_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
    procedure Ler_gFatConjunto(AINIRec: TMemIniFile; gFatConjunto: TgFatConjunto);

    procedure Ler_Det(AINIRec: TMemIniFile; Det: TDetCollection);

    procedure Ler_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
    procedure Ler_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);

    procedure Ler_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
    procedure Ler_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);

    procedure Ler_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
    procedure Ler_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
    procedure Ler_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
    procedure Ler_TFS(AINIRec: TMemIniFile; TFS: TTFS; Index: Integer);
    procedure Ler_TFU(AINIRec: TMemIniFile; TFU: TTFU; Index: Integer);

    procedure Ler_Total(AINIRec: TMemIniFile; Total: TTotal);

    procedure Ler_gFat(AINIRec: TMemIniFile; gFat: TgFat);
    procedure Ler_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
    procedure Ler_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);

    procedure Ler_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
    procedure Ler_gAgenciaHistCons(AINIRec: TMemIniFile; gHistCons: TgHistConsCollection);
    procedure Ler_gAgenciaCons(AINIRec: TMemIniFile; gCons: TgConsCollection; HistIndex: Integer);

    procedure Ler_gQualiAgua(AINIRec: TMemIniFile; gQualiAgua: TgQualiAgua);
    procedure Ler_gAnalise(AINIRec: TMemIniFile; gAnalise: TgAnaliseCollection);

    procedure Ler_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Ler_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
    procedure Ler_InfPAA(AINIRec: TMemIniFile; InfPAA: TInfPAA);
    procedure Ler_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);
  public
    constructor Create(AOwner: TNFAg); reintroduce;
    destructor Destroy; override;

    function LerIni(const AIniString: string): Boolean;

    property NFAg: TNFAg read FNFAg write FNFAg;
    property VersaoDF: TVersaoNFAg read FVersaoDF write FVersaoDF;
    property Ambiente: Integer read FAmbiente write FAmbiente;
    property tpEmis: Integer read FtpEmis write FtpEmis;
  end;

implementation

uses
  ACBrNFAg,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

{ TNFAgIniReader }

constructor TNFAgIniReader.Create(AOwner: TNFAg);
begin
  inherited Create;

  FNFAg := AOwner;
end;

destructor TNFAgIniReader.Destroy;
begin

  inherited Destroy;
end;

function TNFAgIniReader.LerIni(const AIniString: string): Boolean;
var
  INIRec: TMemIniFile;
begin
  Result := True;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);

    FNFAg.infNFAg.Versao := StringToFloatDef(INIRec.ReadString('infNFGas', 'versao', VersaoNFAgToStr(VersaoDF)), 0);
    Ler_Identificacao(INIRec, FNFAg.Ide);
    Ler_Emitente(INIRec, FNFAg.Emit);

    FNFAg.Ide.cUF := INIRec.ReadInteger('ide', 'cUF', 35);
    FNFAg.Ide.cMunFG := INIRec.ReadInteger('ide', 'cMunFG', FNFAg.Emit.EnderEmit.cMun);

    Ler_Destinatario(INIRec, FNFAg.Dest);
    Ler_Ligacao(INIRec, FNFAg.Ligacao);
    Ler_gSub(INIRec, FNFAg.gSub);
    Ler_gMed(INIRec, FNFAg.gMed);
    Ler_gFatConjunto(INIRec, FNFAg.gFatConjunto);
    Ler_Det(INIRec, FNFAg.Det);
    Ler_Total(INIRec, FNFAg.Total);
    Ler_pgtoVinc(INIRec, FNFAg.pgtoVinc.pgto);
    Ler_gFat(INIRec, FNFAg.gFat);
    Ler_gAgencia(INIRec, FNFAg.gAgencia);
    Ler_gQualiAgua(INIRec, FNFAg.gQualiAgua);
    Ler_autXML(INIRec, FNFAg.autXML);
    Ler_InfPAA(INIRec, FNFAg.infPAA);
    Ler_InfAdic(INIRec, FNFAg.infAdic);
    Ler_InfRespTec(INIRec, FNFAg.infRespTec);
  finally
    INIRec.Free;
  end;
end;

procedure TNFAgIniReader.Ler_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
const
  MODELO_NFAg = 75;
var
  Secao: string;
begin
  Secao := 'ide';

  Ide.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(Secao, 'tpAmb', IntToStr(Ambiente)));
  Ide.modelo := AINIRec.ReadInteger(Secao, 'Modelo', MODELO_NFAg);
  Ide.serie := AINIRec.ReadInteger(Secao, 'Serie', 1);
  Ide.nNF := AINIRec.ReadInteger(Secao, 'nNF', 0);
  Ide.cNF := AINIRec.ReadInteger(Secao, 'cNF', 0);
  Ide.dhEmi := StringToDateTime(AINIRec.ReadString(Secao, 'dhEmi', '0'));
  Ide.tpEmis := StrToTipoEmissao(AINIRec.ReadString(Secao, 'tpEmis', IntToStr(tpEmis)));
  Ide.nSiteAutoriz := StrToSiteAutorizator(AINIRec.ReadString(Secao, 'nSiteAutoriz', '0'));
  Ide.verProc := AINIRec.ReadString(Secao, 'verProc', 'ACBrNFAg');
  Ide.finNFAg := StrTofinNFAg(AINIRec.ReadString(Secao, 'finNFAg', '0'));
  Ide.tpFat := StrTotpFat(AINIRec.ReadString(Secao, 'tpFat', '1'));
  Ide.dhCont := StringToDateTime(AINIRec.ReadString(Secao, 'dhCont', '0'));
  Ide.xJust := AINIRec.ReadString(Secao, 'xJust', '');
  Ide.tpPagAnt := StrTotpPagAnt(AINIRec.ReadString(Secao, 'tpPagAnt', ''));

  Ler_gCompraGovReduzido(AINIRec, Ide.gCompraGov);
end;

procedure TNFAgIniReader.Ler_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
var
  Secao: string;
begin
  Secao := 'emit';

  Emit.CNPJ := AINIRec.ReadString(Secao, 'CNPJ', '');
  Emit.IE := AINIRec.ReadString(Secao, 'IE', '');
  Emit.xNome := AINIRec.ReadString(Secao, 'xNome', '');
  Emit.xFant := AINIRec.ReadString(Secao, 'xFant', '');
  Emit.ISUFEmit := AINIRec.ReadString(Secao, 'ISUFEmit', '');

  Emit.EnderEmit.xLgr := AINIRec.ReadString(Secao, 'xLgr', '');
  Emit.EnderEmit.nro := AINIRec.ReadString(Secao, 'nro', '');
  Emit.EnderEmit.xCpl := AINIRec.ReadString(Secao, 'xCpl', '');
  Emit.EnderEmit.xBairro := AINIRec.ReadString(Secao, 'xBairro', '');
  Emit.EnderEmit.cMun := AINIRec.ReadInteger(Secao, 'cMun', 0);
  Emit.EnderEmit.xMun := AINIRec.ReadString(Secao, 'xMun', '');
  Emit.EnderEmit.CEP := AINIRec.ReadInteger(Secao, 'CEP', 0);
  Emit.EnderEmit.UF := AINIRec.ReadString(Secao, 'UF', '');
  Emit.EnderEmit.fone := AINIRec.ReadString(Secao, 'fone', '');
  Emit.EnderEmit.email := AINIRec.ReadString(Secao, 'email', '');
end;

procedure TNFAgIniReader.Ler_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
var
  Secao: string;
begin
  Secao := 'dest';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  Dest.xNome := AINIRec.ReadString(Secao, 'xNome', '');
  Dest.CNPJCPF := AINIRec.ReadString(Secao, 'CNPJCPF', '');
  Dest.idOutros := AINIRec.ReadString(Secao, 'idOutros', AINIRec.ReadString(Secao, 'idEstrangeiro', ''));
  Dest.IE := AINIRec.ReadString(Secao, 'IE', '');
  Dest.IM := AINIRec.ReadString(Secao, 'IM', '');
  Dest.cNIS := AINIRec.ReadString(Secao, 'cNIS', '');
  Dest.NB := AINIRec.ReadString(Secao, 'NB', '');
  Dest.xNomeAdicional := AINIRec.ReadString(Secao, 'xNomeAdicional', '');

  Dest.EnderDest.xLgr := AINIRec.ReadString(Secao, 'xLgr', '');
  Dest.EnderDest.nro := AINIRec.ReadString(Secao, 'nro', '');
  Dest.EnderDest.xCpl := AINIRec.ReadString(Secao, 'xCpl', '');
  Dest.EnderDest.xBairro := AINIRec.ReadString(Secao, 'xBairro', '');
  Dest.EnderDest.cMun := AINIRec.ReadInteger(Secao, 'cMun', 0);
  Dest.EnderDest.xMun := AINIRec.ReadString(Secao, 'xMun', '');
  Dest.EnderDest.CEP := AINIRec.ReadInteger(Secao, 'CEP', 0);
  Dest.EnderDest.UF := AINIRec.ReadString(Secao, 'UF', '');
  Dest.EnderDest.fone := AINIRec.ReadString(Secao, 'fone', '');
  Dest.EnderDest.email := AINIRec.ReadString(Secao, 'email', '');
end;

procedure TNFAgIniReader.Ler_Ligacao(AINIRec: TMemIniFile; Ligacao: TLigacao);
var
  Secao: string;
begin
  Secao := 'Ligacao';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  Ligacao.idLigacao := AINIRec.ReadString(Secao, 'idLigacao', '');
  Ligacao.idCodCliente := AINIRec.ReadString(Secao, 'idCodCliente', '');
  Ligacao.tpLigacao := StrTotpLigacao(AINIRec.ReadString(Secao, 'tpLigacao', ''));
  Ligacao.latGPS := AINIRec.ReadString(Secao, 'latGPS', '');
  Ligacao.longGPS := AINIRec.ReadString(Secao, 'longGPS', '');
  Ligacao.codRoteiroLeitura := AINIRec.ReadString(Secao, 'codRoteiroLeitura', '');
end;

procedure TNFAgIniReader.Ler_gSub(AINIRec: TMemIniFile; gSub: TgSub);
const
  Secao = 'gSub';
begin
  if not AINIRec.SectionExists(Secao) then
    Exit;

  gSub.chNFAg := AINIRec.ReadString(Secao, 'chNFAg', '');
  gSub.motSub := StrToMotSub(AINIRec.ReadString(Secao, 'motSub', ''));
end;

procedure TNFAgIniReader.Ler_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
var
  Index: Integer;
  Secao: string;
  Valor: string;
  Item: TgMedCollectionItem;
begin
  gMed.Clear;
  Index := 1;

  while True do
  begin
    Secao := 'gMed' + IntToStrZero(Index, 2);
    Valor := AINIRec.ReadString(Secao, 'nMed', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;

    Item := gMed.New;
    Item.nMed := StrToIntDef(Valor, 0);
    Item.idMedidor := AINIRec.ReadString(Secao, 'idMedidor', '');
    Item.dMedAnt := StringToDateTime(AINIRec.ReadString(Secao, 'dMedAnt', '0'));
    Item.dMedAtu := StringToDateTime(AINIRec.ReadString(Secao, 'dMedAtu', '0'));

    Inc(Index);
  end;
end;

procedure TNFAgIniReader.Ler_gFatConjunto(AINIRec: TMemIniFile;
  gFatConjunto: TgFatConjunto);
const
  Secao = 'gFatConjunto';
begin
  if not AINIRec.SectionExists(Secao) then
    Exit;

  gFatConjunto.chNFAgFat := AINIRec.ReadString(Secao, 'chNFAgFat', '');
end;

procedure TNFAgIniReader.Ler_Det(AINIRec: TMemIniFile; Det: TDetCollection);
var
  Index: Integer;
  Secao: string;
  Valor: string;
  Item: TDetCollectionItem;
begin
  Index := 1;

  while True do
  begin
    Secao := 'det' + IntToStrZero(Index, 3);
    Valor := AINIRec.ReadString(Secao, 'nItem', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;

    Item := Det.New;

    Item.nItem := StrToIntDef(Valor, 0);
    Item.chNFAgAnt := AINIRec.ReadString(Secao, 'chNFAgAnt', '');
    Item.nItemAnt := AINIRec.ReadInteger(Secao, 'nItemAnt', 0);

    Item.Prod.indOrigemQtd := StrToindOrigemQtd(AINIRec.ReadString(Secao, 'indOrigemQtd', '1'));
    Item.Prod.cProd := AINIRec.ReadString(Secao, 'cProd', '');
    Item.Prod.xProd := AINIRec.ReadString(Secao, 'xProd', '');
    Item.Prod.cClass := AINIRec.ReadInteger(Secao, 'cClass', 0);
    Item.Prod.tpCategoria := StrTotpCategoria(AINIRec.ReadString(Secao, 'tpCategoria', '1'));
    Item.Prod.xCategoria := AINIRec.ReadString(Secao, 'xCategoria', '');
    Item.Prod.qEconomias := AINIRec.ReadString(Secao, 'qEconomias', '');
    Item.Prod.uMed := StrTouMedFat(AINIRec.ReadString(Secao, 'uMed', ''));
    Item.Prod.qFaturada := AINIRec.ReadInteger(Secao, 'qFaturada', 0);
    Item.Prod.vItem := StringToFloatDef(AINIRec.ReadString(Secao, 'vItem', ''), 0);

    Item.Prod.fatorPoluicao := StringToFloatDef(AINIRec.ReadString(Secao, 'fatorPoluicao', ''), 0);
    Item.Prod.vProd := StringToFloatDef(AINIRec.ReadString(Secao, 'vProd', ''), 0);
    Item.Prod.indDevolucao := StrToTIndicador(AINIRec.ReadString(Secao, 'indDevolucao', ''));
    Item.infAdProd := AINIRec.ReadString(Secao, 'infAdProd', '');

    Ler_gPagAntecipadoProd(AINIRec, Item.Prod.gPagAntecipado, Index, -1);
    Ler_gMedicao(AINIRec, Item.Prod.gMedicao, Index);
    Ler_gTarif(AINIRec, Item.gTarif, Index);
    Ler_gProcRef(AINIRec, Item.gProcRef, Index);
    Ler_IBSCBS(AINIRec, Item.Imposto.IBSCBS, Index, -1);
    Ler_PIS(AINIRec, Item.Imposto.PIS, Index);
    Ler_COFINS(AINIRec, Item.Imposto.COFINS, Index);
    Ler_RetTrib(AINIRec, Item.Imposto.RetTrib, Index);
    Ler_TFS(AINIRec, Item.Imposto.TFS, Index);
    Ler_TFU(AINIRec, Item.Imposto.TFU, Index);

    Inc(Index);
  end;
end;

procedure TNFAgIniReader.Ler_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);
var
  Secao: string;
begin
  Secao := 'gMedicao' + IntToStrZero(DetIndex, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gMedicao.nMed := AINIRec.ReadInteger(Secao, 'nMed', 0);
  gMedicao.tpMotNaoLeitura := StrTotpMotNaoLeitura(AINIRec.ReadString(Secao, 'tpMotNaoLeitura', ''));

  gMedicao.gMedida.tpGrMed := StrTotpGrMed(AINIRec.ReadString(Secao, 'tpGrMed', ''));
  gMedicao.gMedida.nUnidConsumo := AINIRec.ReadString(Secao, 'nUnidConsumo', '');
  gMedicao.gMedida.vUnidConsumo := StringToFloatDef(AINIRec.ReadString(Secao, 'vUnidConsumo', ''), 0);
  gMedicao.gMedida.uMed := StrTouMedFat(AINIRec.ReadString(Secao, 'uMed', ''));
  gMedicao.gMedida.vMedAnt := StringToFloatDef(AINIRec.ReadString(Secao, 'vMedAnt', ''), 0);
  gMedicao.gMedida.vMedAtu := StringToFloatDef(AINIRec.ReadString(Secao, 'vMedAtu', ''), 0);
  gMedicao.gMedida.vConst := StringToFloatDef(AINIRec.ReadString(Secao, 'vConst', ''), 0);
  gMedicao.gMedida.vMed := StringToFloatDef(AINIRec.ReadString(Secao, 'vMed', ''), 0);
end;

procedure TNFAgIniReader.Ler_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
var
  TarifIndex: Integer;
  Secao: string;
  Valor: string;
  Item: TgTarifCollectionItem;
begin
  gTarif.Clear;
  TarifIndex := 1;

  while True do
  begin
    Secao := 'gTarif' + IntToStrZero(DetIndex, 3) + IntToStrZero(TarifIndex, 1);
    Valor := AINIRec.ReadString(Secao, 'dIniTarif', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;

    Item := gTarif.New;
    Item.dIniTarif := StringToDateTime(Valor);
    Item.dFimTarif := StringToDateTime(AINIRec.ReadString(Secao, 'dFimTarif', '0'));
    Item.nAto := AINIRec.ReadString(Secao, 'nAto', '');
    Item.anoAto := AINIRec.ReadInteger(Secao, 'anoAto', 0);
    Item.tpFaixaCons := StrTotpFaixaCons(AINIRec.ReadString(Secao, 'tpFaixaCons', ''));

    Inc(TarifIndex);
  end;
end;

procedure TNFAgIniReader.Ler_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
var
  Secao: string;
  Fim: string;
begin
  Secao := 'gProcRef' + IntToStrZero(DetIndex, 3);
  Fim := AINIRec.ReadString(Secao, 'vItem', 'FIM');

  if (Fim = 'FIM') or (Length(Fim) = 0) then
    Exit;

  gProcRef.vItem := StringToFloatDef(Fim, 0);
  gProcRef.qFaturada := StringToFloatDef(AINIRec.ReadString(Secao, 'qFaturada', ''), 0);
  gProcRef.vProd := StringToFloatDef(AINIRec.ReadString(Secao, 'vProd', ''), 0);
  gProcRef.indDevolucao := StrToTIndicador(AINIRec.ReadString(Secao, 'indDevolucao', ''));

  Ler_gProc(AINIRec, gProcRef.gProc, DetIndex);
end;

procedure TNFAgIniReader.Ler_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);
var
  Secao: string;
  Fim: string;
  ProcIndex: Integer;
  Item: TgProcCollectionItem;
begin
  gProc.Clear;
  ProcIndex := 1;

  while True do
  begin
    Secao := 'gProc' + IntToStrZero(DetIndex, 3) + IntToStrZero(ProcIndex, 2);
    Fim := AINIRec.ReadString(Secao, 'nProcesso', 'FIM');

    if (Fim = 'FIM') or (Length(Fim) = 0) then
      Break;

    Item := gProc.New;
    Item.tpProc := StrToTpProc(AINIRec.ReadString(Secao, 'tpProc', ''));
    Item.nProcesso := Fim;

    Inc(ProcIndex);
  end;
end;

procedure TNFAgIniReader.Ler_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
var
  Secao: string;
  Fim: string;
begin
  Secao := 'PIS' + IntToStrZero(Index, 3);
  Fim := AINIRec.ReadString(Secao, 'CST', 'FIM');

  if (Fim = 'FIM') or (Length(Fim) = 0) then
    Exit;

  PIS.CST := StrToCSTPIS(Fim);
  PIS.vBC := StringToFloatDef(AINIRec.ReadString(Secao, 'vBC', ''), 0);
  PIS.pPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'pPIS', ''), 0);
  PIS.vPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'vPIS', ''), 0);
end;

procedure TNFAgIniReader.Ler_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
var
  Secao: string;
  Fim: string;
begin
  Secao := 'COFINS' + IntToStrZero(Index, 3);
  Fim := AINIRec.ReadString(Secao, 'CST', 'FIM');

  if (Fim = 'FIM') or (Length(Fim) = 0) then
    Exit;

  COFINS.CST := StrToCSTCOFINS(Fim);
  COFINS.vBC := StringToFloatDef(AINIRec.ReadString(Secao, 'vBC', ''), 0);
  COFINS.pCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'pCOFINS', ''), 0);
  COFINS.vCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'vCOFINS', ''), 0);
end;

procedure TNFAgIniReader.Ler_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
var
  Secao: string;
begin
  Secao := 'retTrib' + IntToStrZero(Index, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  RetTrib.vRetPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetPIS', ''), 0);
  RetTrib.vRetCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetCOFINS', ''), 0);
  RetTrib.vRetCSLL := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetCSLL', ''), 0);
  RetTrib.vIRRF := StringToFloatDef(AINIRec.ReadString(Secao, 'vIRRF', ''), 0);
end;

procedure TNFAgIniReader.Ler_TFS(AINIRec: TMemIniFile; TFS: TTFS; Index: Integer);
var
  Secao: string;
begin
  Secao := 'TFS' + IntToStrZero(Index, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  TFS.vBCTFS := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCTFS', ''), 0);
  TFS.pTFS := StringToFloatDef(AINIRec.ReadString(Secao, 'pTFS', ''), 0);
  TFS.vTFS := StringToFloatDef(AINIRec.ReadString(Secao, 'vTFS', ''), 0);
end;

procedure TNFAgIniReader.Ler_TFU(AINIRec: TMemIniFile; TFU: TTFU;
  Index: Integer);
var
  Secao: string;
begin
  Secao := 'TFU' + IntToStrZero(Index, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  TFU.vBCTFU := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCTFU', ''), 0);
  TFU.pTFU := StringToFloatDef(AINIRec.ReadString(Secao, 'pTFU', ''), 0);
  TFU.vTFU := StringToFloatDef(AINIRec.ReadString(Secao, 'vTFU', ''), 0);
end;

procedure TNFAgIniReader.Ler_Total(AINIRec: TMemIniFile; Total: TTotal);
var
  Secao: string;
begin
  Secao := 'total';

  Total.vProd := StringToFloatDef(AINIRec.ReadString(Secao, 'vProd', ''), 0);
  Total.vRetPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetPIS', ''), 0);
  Total.vRetCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetCOFINS', ''), 0);
  Total.vRetCSLL := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetCSLL', ''), 0);
  Total.vIRRF := StringToFloatDef(AINIRec.ReadString(Secao, 'vIRRF', ''), 0);
  Total.vCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'vCOFINS', ''), 0);
  Total.vPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'vPIS', ''), 0);
  Total.vTFS := StringToFloatDef(AINIRec.ReadString(Secao, 'vTFS', ''), 0);
  Total.vTFU := StringToFloatDef(AINIRec.ReadString(Secao, 'vTFU', ''), 0);
  Total.vNF := StringToFloatDef(AINIRec.ReadString(Secao, 'vNF', ''), 0);
  Total.vTotDFe := StringToFloatDef(AINIRec.ReadString(Secao, 'vTotDFe', ''), 0);

  Ler_IBSCBSTot(AINIRec, Total.IBSCBSTot);
end;

procedure TNFAgIniReader.Ler_gFat(AINIRec: TMemIniFile; gFat: TgFat);
var
  Secao: string;
begin
  Secao := 'gFat';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gFat.CompetFat := StringToDateTime(AINIRec.ReadString(Secao, 'CompetFat', '0'));
  gFat.dVencFat := StringToDateTime(AINIRec.ReadString(Secao, 'dVencFat', '0'));
  gFat.dApresFat := StringToDateTime(AINIRec.ReadString(Secao, 'dApresFat', '0'));
  gFat.dProxLeitura := StringToDateTime(AINIRec.ReadString(Secao, 'dProxLeitura', '0'));
  gFat.nFat := AINIRec.ReadString(Secao, 'nFat', '');
  gFat.codBarras := AINIRec.ReadString(Secao, 'codBarras', '');
  gFat.codDebAuto := AINIRec.ReadString(Secao, 'codDebAuto', '');
  gFat.codBanco := AINIRec.ReadString(Secao, 'codBanco', '');
  gFat.codAgencia := AINIRec.ReadString(Secao, 'codAgencia', '');

  Ler_gFatEnderCorresp(AINIRec, gFat.enderCorresp);
  Ler_gFatgPIX(AINIRec, gFat.gPIX);
end;

procedure TNFAgIniReader.Ler_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
var
  Secao: string;
begin
  Secao := 'enderCorresp';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  enderCorresp.xLgr := AINIRec.ReadString(Secao, 'xLgr', '');
  enderCorresp.nro := AINIRec.ReadString(Secao, 'nro', '');
  enderCorresp.xCpl := AINIRec.ReadString(Secao, 'xCpl', '');
  enderCorresp.xBairro := AINIRec.ReadString(Secao, 'xBairro', '');
  enderCorresp.cMun := AINIRec.ReadInteger(Secao, 'cMun', 0);
  enderCorresp.xMun := AINIRec.ReadString(Secao, 'xMun', '');
  enderCorresp.CEP := AINIRec.ReadInteger(Secao, 'CEP', 0);
  enderCorresp.UF := AINIRec.ReadString(Secao, 'UF', '');
  enderCorresp.fone := AINIRec.ReadString(Secao, 'fone', '');
  enderCorresp.email := AINIRec.ReadString(Secao, 'email', '');
end;

procedure TNFAgIniReader.Ler_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);
var
  Secao: string;
begin
  Secao := 'gPIX';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gPIX.urlQRCodePIX := AINIRec.ReadString(Secao, 'urlQRCodePIX', '');
end;

procedure TNFAgIniReader.Ler_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
var
  Secao: string;
begin
  Secao := 'gAgencia';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gAgencia.econ := AINIRec.ReadString(Secao, 'econ', '');
  gAgencia.econAcumulada := AINIRec.ReadString(Secao, 'econAcumulada', '');
  gAgencia.sPrestador := AINIRec.ReadString(Secao, 'sPrestador', '');
  gAgencia.dEmissSelo := StringToDateTime(AINIRec.ReadString(Secao, 'dEmissSelo', '0'));
  gAgencia.sRegulador := AINIRec.ReadString(Secao, 'sRegulador', '');
  gAgencia.nAgenciaAtend := AINIRec.ReadString(Secao, 'nAgenciaAtend', '');
  gAgencia.enderAgenciaAtend := AINIRec.ReadString(Secao, 'enderAgenciaAtend', '');

  Ler_gAgenciaHistCons(AINIRec, gAgencia.gHistCons);
end;

procedure TNFAgIniReader.Ler_gAgenciaHistCons(AINIRec: TMemIniFile;
  gHistCons: TgHistConsCollection);
var
  Index: Integer;
  Secao: string;
  Valor: string;
begin
  gHistCons.Clear;

  Index := 1;
  while True do
  begin
    Secao := 'gHistCons' + IntToStrZero(Index, 1);
    Valor := AINIRec.ReadString(Secao, 'xHistorico', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;


    with gHistCons.New do
    begin
      xHistorico := Valor;
      medMensal := StringToFloatDef(AINIRec.ReadString(Secao, 'medMensal', ''), 0);
    end;

    Ler_gAgenciaCons(AINIRec, gHistCons[Index - 1].gCons, Index);

    Inc(Index);
  end;
end;

procedure TNFAgIniReader.Ler_gAgenciaCons(AINIRec: TMemIniFile;
  gCons: TgConsCollection; HistIndex: Integer);
var
  Index: Integer;
  Secao: string;
  Valor: string;
begin
  gCons.Clear;

  Index := 1;
  while True do
  begin
    Secao := 'gCons' + IntToStrZero(HistIndex, 1) + IntToStrZero(Index, 2);
    Valor := AINIRec.ReadString(Secao, 'CompetFat', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;


    with gCons.New do
    begin
      CompetFat := StringToDateTime(Valor);
      uMed := StrTouMedFat(AINIRec.ReadString(Secao, 'uMed', ''));
      qtdDias := AINIRec.ReadString(Secao, 'qtdDias', '');
      medDiaria := StringToFloatDef(AINIRec.ReadString(Secao, 'medDiaria', ''), 0);
      consumo := StringToFloatDef(AINIRec.ReadString(Secao, 'consumo', ''), 0);
      volFat := StringToFloatDef(AINIRec.ReadString(Secao, 'volFat', ''), 0);
    end;

    Inc(Index);
  end;
end;

procedure TNFAgIniReader.Ler_gQualiAgua(AINIRec: TMemIniFile;
  gQualiAgua: TgQualiAgua);
var
  Secao: string;
begin
  Secao := 'gQualiAgua';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gQualiAgua.CompetAnalise := StringToDateTime(AINIRec.ReadString(Secao, 'CompetAnalise', '0'));
  gQualiAgua.Conclusao := AINIRec.ReadString(Secao, 'Conclusao', '');
  gQualiAgua.cProcesso := AINIRec.ReadString(Secao, 'cProcesso', '');
  gQualiAgua.SistemaAbast := AINIRec.ReadString(Secao, 'SistemaAbast', '');

  Ler_gAnalise(AINIRec, gQualiAgua.gAnalise);
end;

procedure TNFAgIniReader.Ler_gAnalise(AINIRec: TMemIniFile;
  gAnalise: TgAnaliseCollection);
var
  Index: Integer;
  Secao: string;
  Valor: string;
begin
  gAnalise.Clear;

  Index := 1;
  while True do
  begin
    Secao := 'gAnalise' + IntToStrZero(Index, 2);
    Valor := AINIRec.ReadString(Secao, 'xItemAnalisado', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;


    with gAnalise.New do
    begin
      xItemAnalisado := Valor;
      nAmostraMinima := AINIRec.ReadString(Secao, 'nAmostraMinima', '');
      nAmostraAnalisada := AINIRec.ReadString(Secao, 'nAmostraAnalisada', '');
      nAmostraFPadrao := AINIRec.ReadString(Secao, 'nAmostraFPadrao', '');
      nAmostraDPadrao := AINIRec.ReadString(Secao, 'nAmostraDPadrao', '');
      nMediaMensal := AINIRec.ReadString(Secao, 'nMediaMensal', '');
      xValorReferencia := AINIRec.ReadString(Secao, 'xValorReferencia', '');
    end;

    Inc(Index);
  end;
end;

procedure TNFAgIniReader.Ler_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
var
  Index: Integer;
  Secao: string;
  CNPJCPF: string;
begin
  autXML.Clear;

  Index := 1;
  while True do
  begin
    Secao := 'autXML' + IntToStrZero(Index, 2);
    CNPJCPF := OnlyCPFCNPJAlphaNum(AINIRec.ReadString(Secao, 'CNPJCPF', ''));

    if CNPJCPF = '' then
      Break;

    autXML.New.CNPJCPF := CNPJCPF;
    Inc(Index);
  end;
end;

procedure TNFAgIniReader.Ler_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
var
  Secao: string;
begin
  Secao := 'infAdic';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  InfAdic.infAdFisco := AINIRec.ReadString(Secao, 'infAdFisco', '');
  InfAdic.infCpl := AINIRec.ReadString(Secao, 'infCpl', '');
end;

procedure TNFAgIniReader.Ler_InfPAA(AINIRec: TMemIniFile; InfPAA: TInfPAA);
var
  Secao: string;
begin
  Secao := 'infPAA';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  infPAA.CNPJPAA := AINIRec.ReadString(Secao, 'CNPJPAA', '');
end;

procedure TNFAgIniReader.Ler_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);
var
  Secao: string;
begin
  Secao := 'infRespTec';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  InfRespTec.CNPJ := AINIRec.ReadString(Secao, 'CNPJ', '');
  InfRespTec.xContato := AINIRec.ReadString(Secao, 'xContato', '');
  InfRespTec.email := AINIRec.ReadString(Secao, 'email', '');
  InfRespTec.fone := AINIRec.ReadString(Secao, 'fone', '');
  InfRespTec.idCSRT := AINIRec.ReadInteger(Secao, 'idCSRT', 0);
  InfRespTec.hashCSRT := AINIRec.ReadString(Secao, 'hashCSRT', '');
end;

end.
