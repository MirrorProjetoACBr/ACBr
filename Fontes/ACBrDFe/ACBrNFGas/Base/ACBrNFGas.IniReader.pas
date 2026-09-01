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

unit ACBrNFGas.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFGas.Classes,
  ACBrDFe.RTC.Classes,
  ACBrDFe.RTC.IniReader,
  ACBrNFGas.Conversao;

type
  { TNFGasIniReader }

  TNFGasIniReader = class(TDFeRTCIniReader)
  private
    FNFGas: TNFGas;
    FVersaoDF: TVersaoNFGas;
    FAmbiente: Integer;
    FtpEmis: Integer;

    procedure Ler_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Ler_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Ler_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
    procedure Ler_Instalacao(AINIRec: TMemIniFile; Instalacao: TInstalacao);
    procedure Ler_gSub(AINIRec: TMemIniFile; gSub: TgSub);
    procedure Ler_gVolContrat(AINIRec: TMemIniFile; gVolContrat: TgVolContratCollection);
    procedure Ler_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);

    procedure Ler_Det(AINIRec: TMemIniFile; Det: TDetCollection);

    procedure Ler_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
    procedure Ler_gAgregadora(AINIRec: TMemIniFile; gAgregadora: TgAgregadora; DetIndex: Integer);
    procedure Ler_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);

    procedure Ler_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
    procedure Ler_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);

    procedure Ler_ICMS(AINIRec: TMemIniFile; ICMS: TICMS; Index: Integer);
    procedure Ler_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
    procedure Ler_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
    procedure Ler_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
    procedure Ler_TxReg(AINIRec: TMemIniFile; TxReg: TTxReg; Index: Integer);

    procedure Ler_Total(AINIRec: TMemIniFile; Total: TTotal);

    procedure Ler_gFat(AINIRec: TMemIniFile; gFat: TgFat);
    procedure Ler_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
    procedure Ler_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);

    procedure Ler_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
    procedure Ler_gAgenciaHistCons(AINIRec: TMemIniFile; gHistCons: TgHistConsCollection);
    procedure Ler_gAgenciaCons(AINIRec: TMemIniFile; gCons: TgConsCollection; HistIndex: Integer);

    procedure Ler_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Ler_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
    procedure Ler_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);
  public
    constructor Create(AOwner: TNFGas); reintroduce;
    destructor Destroy; override;

    function LerIni(const AIniString: string): Boolean;

    property NFGas: TNFGas read FNFGas write FNFGas;
    property VersaoDF: TVersaoNFGas read FVersaoDF write FVersaoDF;
    property Ambiente: Integer read FAmbiente write FAmbiente;
    property tpEmis: Integer read FtpEmis write FtpEmis;
  end;

implementation

uses
  ACBrNFGas,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

{ TNFGasIniReader }

constructor TNFGasIniReader.Create(AOwner: TNFGas);
begin
  inherited Create;

  FNFGas := AOwner;
end;

destructor TNFGasIniReader.Destroy;
begin

  inherited Destroy;
end;

function TNFGasIniReader.LerIni(const AIniString: string): Boolean;
var
  INIRec: TMemIniFile;
begin
  Result := True;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);

    FNFGas.infNFGas.Versao := StringToFloatDef(INIRec.ReadString('infNFGas', 'versao', VersaoNFGasToStr(VersaoDF)), 0);
    Ler_Identificacao(INIRec, FNFGas.Ide);
    Ler_Emitente(INIRec, FNFGas.Emit);

    FNFGas.Ide.cUF := INIRec.ReadInteger('ide', 'cUF', 35);
    FNFGas.Ide.cMunFG := INIRec.ReadInteger('ide', 'cMunFG', FNFGas.Emit.EnderEmit.cMun);

    Ler_Destinatario(INIRec, FNFGas.Dest);
    Ler_Instalacao(INIRec, FNFGas.Instalacao);
    Ler_gSub(INIRec, FNFGas.gSub);
    Ler_gVolContrat(INIRec, FNFGas.gVolContrat);
    Ler_gMed(INIRec, FNFGas.gMed);
    Ler_Det(INIRec, FNFGas.Det);
    Ler_Total(INIRec, FNFGas.Total);
    Ler_pgtoVinc(INIRec, NFGas.pgtoVinc.pgto);
    Ler_gFat(INIRec, FNFGas.gFat);
    Ler_gAgencia(INIRec, FNFGas.gAgencia);
    Ler_autXML(INIRec, FNFGas.autXML);
    Ler_InfAdic(INIRec, FNFGas.infAdic);
    Ler_InfRespTec(INIRec, FNFGas.infRespTec);
  finally
    INIRec.Free;
  end;
end;

procedure TNFGasIniReader.Ler_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
const
  MODELO_NFGAS = 76;
var
  Secao: string;
begin
  Secao := 'ide';

  Ide.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(Secao, 'tpAmb', IntToStr(Ambiente)));
  Ide.modelo := AINIRec.ReadInteger(Secao, 'Modelo', MODELO_NFGAS);
  Ide.serie := AINIRec.ReadInteger(Secao, 'Serie', 1);
  Ide.nNF := AINIRec.ReadInteger(Secao, 'nNF', 0);
  Ide.cNF := AINIRec.ReadInteger(Secao, 'cNF', 0);
  Ide.dhEmi := StringToDateTime(AINIRec.ReadString(Secao, 'dhEmi', '0'));
  Ide.tpEmis := StrToTipoEmissao(AINIRec.ReadString(Secao, 'tpEmis', IntToStr(tpEmis)));
  Ide.nSiteAutoriz := StrToSiteAutorizator(AINIRec.ReadString(Secao, 'nSiteAutoriz', '0'));
  Ide.verProc := AINIRec.ReadString(Secao, 'verProc', 'ACBrNFGas');
  Ide.finNFGas := StrTofinNFGas(AINIRec.ReadString(Secao, 'finNFGas', '0'));
  Ide.tpFat := StrTotpFat(AINIRec.ReadString(Secao, 'tpFat', '1'));
  Ide.dhCont := StringToDateTime(AINIRec.ReadString(Secao, 'dhCont', '0'));
  Ide.xJust := AINIRec.ReadString(Secao, 'xJust', '');
  Ide.tpPagAnt := StrTotpPagAnt(AINIRec.ReadString(Secao, 'tpPagAnt', ''));

  Ler_gCompraGovReduzido(AINIRec, Ide.gCompraGov);
end;

procedure TNFGasIniReader.Ler_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
var
  Secao: string;
begin
  Secao := 'emit';

  Emit.CNPJ := AINIRec.ReadString(Secao, 'CNPJ', '');
  Emit.IE := AINIRec.ReadString(Secao, 'IE', '');
  Emit.xNome := AINIRec.ReadString(Secao, 'xNome', '');
  Emit.xFant := AINIRec.ReadString(Secao, 'xFant', '');
  Emit.ISUFEmit := AINIRec.ReadString('emit','ISUFEmit', '');

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
  Emit.EnderEmit.cPais := AINIRec.ReadInteger(Secao, 'cPais', 0);
  Emit.EnderEmit.xPais := AINIRec.ReadString(Secao, 'xPais', '');
end;

procedure TNFGasIniReader.Ler_Destinatario(AINIRec: TMemIniFile; Dest: TDest);
var
  Secao: string;
begin
  Secao := 'dest';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  Dest.xNome := AINIRec.ReadString(Secao, 'xNome', '');
  Dest.CNPJCPF := AINIRec.ReadString(Secao, 'CNPJCPF', '');
  Dest.idOutros := AINIRec.ReadString(Secao, 'idOutros', AINIRec.ReadString(Secao, 'idEstrangeiro', ''));
  Dest.indIEDest := StrToindIEDest(AINIRec.ReadString(Secao, 'indIEDest', '1'));
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
  Dest.EnderDest.cPais := AINIRec.ReadInteger(Secao, 'cPais', 0);
  Dest.EnderDest.xPais := AINIRec.ReadString(Secao, 'xPais', '');
end;

procedure TNFGasIniReader.Ler_Instalacao(AINIRec: TMemIniFile; Instalacao: TInstalacao);
var
  Secao: string;
begin
  Secao := 'Instalacao';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  Instalacao.idInstalacao := AINIRec.ReadString(Secao, 'idInstalacao', '');
  Instalacao.idCodCliente := AINIRec.ReadString(Secao, 'idCodCliente', '');
  Instalacao.tpInstalacao := StrToInstalacao(AINIRec.ReadString(Secao, 'tpInstalacao', ''));
  Instalacao.nContrato := AINIRec.ReadString(Secao, 'nContrato', '');
  Instalacao.tpClasse := StrToClasse(AINIRec.ReadString(Secao, 'tpClasse', ''));
  Instalacao.xClasse := AINIRec.ReadString(Secao, 'xClasse', '');
  Instalacao.latGPS := AINIRec.ReadString(Secao, 'latGPS', '');
  Instalacao.longGPS := AINIRec.ReadString(Secao, 'longGPS', '');
  Instalacao.codRoteiroLeitura := AINIRec.ReadString(Secao, 'codRoteiroLeitura', '');
end;

procedure TNFGasIniReader.Ler_gSub(AINIRec: TMemIniFile; gSub: TgSub);
const
  Secao = 'gSub';
begin
  if not AINIRec.SectionExists(Secao) then
    Exit;

  gSub.chNFGas := AINIRec.ReadString(Secao, 'chNFGas', '');
  gSub.motSub := StrToMotSub(AINIRec.ReadString(Secao, 'motSub', ''));
  gSub.gNF.CNPJ := AINIRec.ReadString(Secao, 'CNPJ', '');
  gSub.gNF.serie := AINIRec.ReadString(Secao, 'Serie', '');
  gSub.gNF.nNF := AINIRec.ReadInteger(Secao, 'nNF', 0);
  gSub.gNF.CompetEmis := StringToDateTime(AINIRec.ReadString(Secao, 'CompetEmis', '0'));
  gSub.gNF.CompetApur := StringToDateTime(AINIRec.ReadString(Secao, 'CompetApur', '0'));
  gSub.gNF.hash115 := AINIRec.ReadString(Secao, 'hash115', '');
end;

procedure TNFGasIniReader.Ler_gVolContrat(AINIRec: TMemIniFile; gVolContrat: TgVolContratCollection);
var
  Index: Integer;
  Secao: string;
  Valor: string;
  Item: TgVolContratCollectionItem;
begin
  gVolContrat.Clear;
  Index := 1;

  while True do
  begin
    Secao := 'gVolContrat' + IntToStrZero(Index, 2);
    Valor := AINIRec.ReadString(Secao, 'nContrat', 'FIM');

    if (Valor = 'FIM') or (Length(Valor) <= 0) then
      Break;

    Item := gVolContrat.New;
    Item.nContrat := StrToIntDef(Valor, 0);
    Item.tpVolContrat := StrToVolContrat(AINIRec.ReadString(Secao, 'tpVolContrat', ''));
    Item.qUnidContrat := StringToFloatDef(AINIRec.ReadString(Secao, 'qUnidContrat', ''), 0);

    Inc(Index);
  end;
end;

procedure TNFGasIniReader.Ler_gMed(AINIRec: TMemIniFile; gMed: TgMedCollection);
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
    Item.idEqp := AINIRec.ReadString(Secao, 'idEqp', AINIRec.ReadString(Secao, 'idMedidor', ''));
    Item.dMedAnt := StringToDateTime(AINIRec.ReadString(Secao, 'dMedAnt', '0'));
    Item.vMedAnt := StringToFloatDef(AINIRec.ReadString(Secao, 'vMedAnt', ''), 0);
    Item.dMedAtu := StringToDateTime(AINIRec.ReadString(Secao, 'dMedAtu', '0'));
    Item.vMedAtu := StringToFloatDef(AINIRec.ReadString(Secao, 'vMedAtu', ''), 0);
    Item.tpEqp := strTotpEqp(AINIRec.ReadString(Secao, 'tpEqp', ''));
    Item.tpMedidor := StrTotpMedidor(AINIRec.ReadString(Secao, 'tpMedidor', ''));

    Inc(Index);
  end;
end;

procedure TNFGasIniReader.Ler_Det(AINIRec: TMemIniFile; Det: TDetCollection);
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
    Item.chNFGasAnt := AINIRec.ReadString(Secao, 'chNFGasAnt', '');
    Item.nItemAnt := AINIRec.ReadInteger(Secao, 'nItemAnt', 0);

    Item.gNormal.Imposto.Orig := StrToOrig(AINIRec.ReadString(Secao, 'orig', '0'));
    Item.gNormal.Imposto.indSemCST := StrToTIndicador(AINIRec.ReadString(Secao, 'indSemCST', ''));
    Item.gNormal.Prod.indOrigemQtd := StrToindOrigemQtd(AINIRec.ReadString(Secao, 'indOrigemQtd', '1'));
    Item.gNormal.Prod.cProd := AINIRec.ReadString(Secao, 'cProd', '');
    Item.gNormal.Prod.xProd := AINIRec.ReadString(Secao, 'xProd', '');
    Item.gNormal.Prod.cClass := AINIRec.ReadInteger(Secao, 'cClass', 0);
    Item.gNormal.Prod.CFOP := AINIRec.ReadInteger(Secao, 'CFOP', 0);

    Item.gNormal.Prod.uMed := StrTouMedItem(AINIRec.ReadString(Secao, 'uMed', ''));
    Item.gNormal.Prod.qFaturada := AINIRec.ReadInteger(Secao, 'qFaturada', 0);
    Item.gNormal.Prod.vItem := StringToFloatDef(AINIRec.ReadString(Secao, 'vItem', ''), 0);
    Item.gNormal.Prod.fatorPCS := StringToFloatDef(AINIRec.ReadString(Secao, 'fatorPCS', ''), 0);
    Item.gNormal.Prod.fatorPTZ := StringToFloatDef(AINIRec.ReadString(Secao, 'fatorPTZ', ''), 0);
    Item.gNormal.Prod.fatorP := StringToFloatDef(AINIRec.ReadString(Secao, 'fatorP', ''), 0);
    Item.gNormal.Prod.fatorT := StringToFloatDef(AINIRec.ReadString(Secao, 'fatorT', ''), 0);
    Item.gNormal.Prod.vProd := StringToFloatDef(AINIRec.ReadString(Secao, 'vProd', ''), 0);
    Item.gNormal.Prod.indDevolucao := StrToTIndicador(AINIRec.ReadString(Secao, 'indDevolucao', ''));
    Item.gNormal.infAdProd := AINIRec.ReadString(Secao, 'infAdProd', '');

    Ler_gMedicao(AINIRec, Item.gNormal.Prod.gMedicao, Index);
    Ler_gPagAntecipadoProd(AINIRec, Item.gNormal.Prod.gPagAntecipado, Index, -1);

    Ler_gTarif(AINIRec, Item.gNormal.gTarif, Index);
    Ler_gAgregadora(AINIRec, Item.gAgregadora, Index);
    Ler_gProcRef(AINIRec, Item.gNormal.gProcRef, Index);

    Ler_ICMS(AINIRec, Item.gNormal.Imposto.ICMS, Index);
    Ler_IBSCBS(AINIRec, Item.gNormal.Imposto.IBSCBS, Index, -1);
    Ler_PIS(AINIRec, Item.gNormal.Imposto.PIS, Index);
    Ler_COFINS(AINIRec, Item.gNormal.Imposto.COFINS, Index);
    Ler_RetTrib(AINIRec, Item.gNormal.Imposto.RetTrib, Index);
    Ler_TxReg(AINIRec, Item.gNormal.Imposto.TxReg, Index);

    Inc(Index);
  end;
end;

procedure TNFGasIniReader.Ler_gMedicao(AINIRec: TMemIniFile; gMedicao: TgMedicao; DetIndex: Integer);
var
  Secao: string;
begin
  Secao := 'gMedicao' + IntToStrZero(DetIndex, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gMedicao.nMed := AINIRec.ReadInteger(Secao, 'nMed', 0);
  gMedicao.nContrat := AINIRec.ReadInteger(Secao, 'nContrat', 0);

  gMedicao.gMedida.uMed := StrTouMed(AINIRec.ReadString(Secao, 'uMed', ''));
  gMedicao.gMedida.vMed := StringToFloatDef(AINIRec.ReadString(Secao, 'vMed', ''), 0);
  gMedicao.tpMotNaoLeitura := StrTotpMotNaoLeitura(AINIRec.ReadString(Secao, 'tpMotNaoLeitura', ''));
  gMedicao.xMotNaoLeitura := AINIRec.ReadString(Secao, 'xMotNaoLeitura', '');
end;

procedure TNFGasIniReader.Ler_gTarif(AINIRec: TMemIniFile; gTarif: TgTarifCollection; DetIndex: Integer);
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
    Item.vTarifAplic := StringToFloatDef(AINIRec.ReadString(Secao, 'vTarifAplic', ''), 0);

    Inc(TarifIndex);
  end;
end;

procedure TNFGasIniReader.Ler_gAgregadora(AINIRec: TMemIniFile; gAgregadora: TgAgregadora; DetIndex: Integer);
var
  Secao: string;
begin
  Secao := 'gAgregadora' + IntToStrZero(DetIndex, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gAgregadora.cClass := AINIRec.ReadString(Secao, 'cClass', '');
  gAgregadora.vTotDFe := StringToFloatDef(AINIRec.ReadString(Secao, 'vTotDFe', ''), 0);
end;

procedure TNFGasIniReader.Ler_gProcRef(AINIRec: TMemIniFile; gProcRef: TgProcRef; DetIndex: Integer);
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

procedure TNFGasIniReader.Ler_gProc(AINIRec: TMemIniFile; gProc: TgProcCollection; DetIndex: Integer);
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

procedure TNFGasIniReader.Ler_ICMS(AINIRec: TMemIniFile; ICMS: TICMS; Index: Integer);
var
  Secao: string;
  Ok: Boolean;
begin
  Secao := 'ICMS' + IntToStrZero(Index, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  ICMS.indSemCST := StrToTIndicador(AINIRec.ReadString(Secao, 'indSemCST', ''));
  ICMS.CST := StrToCSTICMS(AINIRec.ReadString(Secao, 'CST', ''));
  ICMS.modBC := StrTomodBC(Ok, AINIRec.ReadString(Secao, 'modBC', ''));
  ICMS.pRedBC := StringToFloatDef(AINIRec.ReadString(Secao, 'pRedBC', ''), 0);
  ICMS.vBC := StringToFloatDef(AINIRec.ReadString(Secao, 'vBC', ''), 0);
  ICMS.pICMS := StringToFloatDef(AINIRec.ReadString(Secao, 'pICMS', ''), 0);
  ICMS.vICMS := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMS', ''), 0);
  ICMS.vICMSDeson := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMSDeson', ''), 0);
  ICMS.motDesICMS := StrTomotDesICMS(Ok, AINIRec.ReadString(Secao, 'motDesICMS', ''));
  ICMS.indDeduzDeson := StrToTIndicadorEx(AINIRec.ReadString(Secao, 'indDeduzDeson', ''));
  ICMS.cBenef := AINIRec.ReadString(Secao, 'cBenef', '');
  ICMS.modBCST := StrToModBCST(Ok, AINIRec.ReadString(Secao, 'modBCST', ''));
  ICMS.pMVAST := StringToFloatDef(AINIRec.ReadString(Secao, 'pMVAST', ''), 0);
  ICMS.pRedBCST := StringToFloatDef(AINIRec.ReadString(Secao, 'pRedBCST', ''), 0);
  ICMS.vBCST := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCST', ''), 0);
  ICMS.pICMSST := StringToFloatDef(AINIRec.ReadString(Secao, 'pICMSST', ''), 0);
  ICMS.vICMSST := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMSST', ''), 0);
  ICMS.vBCFCP := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCFCP', ''), 0);
  ICMS.pFCPST := StringToFloatDef(AINIRec.ReadString(Secao, 'pFCPST', ''), 0);
  ICMS.vFCPST := StringToFloatDef(AINIRec.ReadString(Secao, 'vFCPST', ''), 0);
  ICMS.vBCFCPST := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCFCPST', ''), 0);
  ICMS.vBCSTRet := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCSTRet', ''), 0);
  ICMS.pICMSSTRet := StringToFloatDef(AINIRec.ReadString(Secao, 'pICMSSTRet', ''), 0);
  ICMS.vICMSSubstituto := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMSSubstituto', ''), 0);
  ICMS.vICMSSTRet := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMSSTRet', ''), 0);
  ICMS.vBCFCPSTRet := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCFCPSTRet', ''), 0);
  ICMS.pFCPSTRet := StringToFloatDef(AINIRec.ReadString(Secao, 'pFCPSTRet', ''), 0);
  ICMS.vFCPSTRet := StringToFloatDef(AINIRec.ReadString(Secao, 'vFCPSTRet', ''), 0);
  ICMS.pRedBCEfet := StringToFloatDef(AINIRec.ReadString(Secao, 'pRedBCEfet', ''), 0);
  ICMS.vBCEfet := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCEfet', ''), 0);
  ICMS.pICMSEfet := StringToFloatDef(AINIRec.ReadString(Secao, 'pICMSEfet', ''), 0);
  ICMS.vICMSEfet := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMSEfet', ''), 0);
  ICMS.pFCP := StringToFloatDef(AINIRec.ReadString(Secao, 'pFCP', ''), 0);
  ICMS.vFCP := StringToFloatDef(AINIRec.ReadString(Secao, 'vFCP', ''), 0);
end;

procedure TNFGasIniReader.Ler_PIS(AINIRec: TMemIniFile; PIS: TPIS; Index: Integer);
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

procedure TNFGasIniReader.Ler_COFINS(AINIRec: TMemIniFile; COFINS: TCOFINS; Index: Integer);
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

procedure TNFGasIniReader.Ler_RetTrib(AINIRec: TMemIniFile; RetTrib: TRetTrib; Index: Integer);
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

procedure TNFGasIniReader.Ler_TxReg(AINIRec: TMemIniFile; TxReg: TTxReg; Index: Integer);
var
  Secao: string;
begin
  Secao := 'TxReg' + IntToStrZero(Index, 3);

  if not AINIRec.SectionExists(Secao) then
    Exit;

  TxReg.vBC := StringToFloatDef(AINIRec.ReadString(Secao, 'vBC', ''), 0);
  TxReg.pTaxa := StringToFloatDef(AINIRec.ReadString(Secao, 'pTaxa', ''), 0);
  TxReg.vTaxa := StringToFloatDef(AINIRec.ReadString(Secao, 'vTaxa', ''), 0);
end;

procedure TNFGasIniReader.Ler_Total(AINIRec: TMemIniFile; Total: TTotal);
var
  Secao: string;
begin
  Secao := 'total';

  Total.vProd := StringToFloatDef(AINIRec.ReadString(Secao, 'vProd', ''), 0);
  Total.vBC := StringToFloatDef(AINIRec.ReadString(Secao, 'vBC', ''), 0);
  Total.vICMS := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMS', ''), 0);
  Total.vBCST := StringToFloatDef(AINIRec.ReadString(Secao, 'vBCST', ''), 0);
  Total.vFCPST := StringToFloatDef(AINIRec.ReadString(Secao, 'vFCPST', ''), 0);
  Total.vICMSDeson := StringToFloatDef(AINIRec.ReadString(Secao, 'vICMSDeson', ''), 0);
  Total.vFCP := StringToFloatDef(AINIRec.ReadString(Secao, 'vFCP', ''), 0);
  Total.vCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'vCOFINS', ''), 0);
  Total.vPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'vPIS', ''), 0);
  Total.vTxReg := StringToFloatDef(AINIRec.ReadString(Secao, 'vTxReg', ''), 0);
  Total.vRetPIS := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetPIS', ''), 0);
  Total.vRetCOFINS := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetCOFINS', ''), 0);
  Total.vRetCSLL := StringToFloatDef(AINIRec.ReadString(Secao, 'vRetCSLL', ''), 0);
  Total.vIRRF := StringToFloatDef(AINIRec.ReadString(Secao, 'vIRRF', ''), 0);
  Total.vNF := StringToFloatDef(AINIRec.ReadString(Secao, 'vNF', ''), 0);
  Total.vTotDFe := StringToFloatDef(AINIRec.ReadString(Secao, 'vTotDFe', ''), 0);

  Ler_IBSCBSTot(AINIRec, Total.IBSCBSTot);
end;

procedure TNFGasIniReader.Ler_gFat(AINIRec: TMemIniFile; gFat: TgFat);
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
  gFat.infAdFat := AINIRec.ReadString(Secao, 'infAdFat', '');

  Ler_gFatEnderCorresp(AINIRec, gFat.enderCorresp);
  Ler_gFatgPIX(AINIRec, gFat.gPIX);
end;

procedure TNFGasIniReader.Ler_gFatEnderCorresp(AINIRec: TMemIniFile; enderCorresp: TEndereco);
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

procedure TNFGasIniReader.Ler_gFatgPIX(AINIRec: TMemIniFile; gPIX: TgPIX);
var
  Secao: string;
begin
  Secao := 'gPIX';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gPIX.urlQRCodePIX := AINIRec.ReadString(Secao, 'urlQRCodePIX', '');
end;

procedure TNFGasIniReader.Ler_gAgencia(AINIRec: TMemIniFile; gAgencia: TgAgencia);
var
  Secao: string;
begin
  Secao := 'gAgencia';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  gAgencia.nomeAgenciaAtend := AINIRec.ReadString(Secao, 'nomeAgenciaAtend', '');
  gAgencia.enderAgenciaAtend := AINIRec.ReadString(Secao, 'enderAgenciaAtend', '');
  gAgencia.sitioAgenciaAtend := AINIRec.ReadString(Secao, 'sitioAgenciaAtend', '');
  gAgencia.infAdReg := AINIRec.ReadString(Secao, 'infAdReg', '');

  Ler_gAgenciaHistCons(AINIRec, gAgencia.gHistCons);
end;

procedure TNFGasIniReader.Ler_gAgenciaHistCons(AINIRec: TMemIniFile;
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

procedure TNFGasIniReader.Ler_gAgenciaCons(AINIRec: TMemIniFile;
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
      uMed := StrTouMed(AINIRec.ReadString(Secao, 'uMed', ''));
      qtdDias := AINIRec.ReadInteger(Secao, 'qtdDias', 0);
      medDiaria := StringToFloatDef(AINIRec.ReadString(Secao, 'medDiaria', ''), 0);
      consumo := StringToFloatDef(AINIRec.ReadString(Secao, 'consumo', ''), 0);
      vFat := StringToFloatDef(AINIRec.ReadString(Secao, 'vFat', ''), 0);
    end;

    Inc(Index);
  end;
end;

procedure TNFGasIniReader.Ler_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
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

procedure TNFGasIniReader.Ler_InfAdic(AINIRec: TMemIniFile; InfAdic: TInfAdic);
var
  Secao: string;
begin
  Secao := 'infAdic';

  if not AINIRec.SectionExists(Secao) then
    Exit;

  InfAdic.infAdFisco := AINIRec.ReadString(Secao, 'infAdFisco', '');
  InfAdic.infCpl := AINIRec.ReadString(Secao, 'infCpl', '');
end;

procedure TNFGasIniReader.Ler_InfRespTec(AINIRec: TMemIniFile; InfRespTec: TinfRespTec);
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
