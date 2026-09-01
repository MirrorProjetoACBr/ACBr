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

unit ACBrNFAg.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrXmlReader,
  ACBrDFe.RTC.XmlReader,
  ACBrNFAg.Classes;

type
  { TNFAgXmlReader }
  TNFAgXmlReader = class(TDFeRTCXmlReader)
  private
    FNFAg: TNFAg;

    procedure Ler_ProtNFAg(const ANode: TACBrXmlNode);
    procedure Ler_InfNFAg(const ANode: TACBrXmlNode);
    procedure Ler_Ide(const ANode: TACBrXmlNode);
    procedure Ler_Emit(const ANode: TACBrXmlNode);
    procedure Ler_EmitEnderEmit(const ANode: TACBrXmlNode);
    procedure Ler_Dest(const ANode: TACBrXmlNode);
    procedure Ler_DestEnderDest(const ANode: TACBrXmlNode);
    procedure Ler_Ligacao(const ANode: TACBrXmlNode; Ligacao: TLigacao);
    procedure Ler_gSub(const ANode: TACBrXmlNode; gSub: TgSub);
    procedure Ler_gMed(const ANode: TACBrXmlNode; gMed: TgMedCollection);
    procedure Ler_gFatConjunto(const ANode: TACBrXmlNode; gFatConjunto: TgFatConjunto);

    procedure Ler_Det(const ANode: TACBrXmlNode);
    procedure Ler_gTarif(const ANode: TACBrXmlNode; gTarif: TgTarifCollection);
    procedure Ler_Prod(const ANode: TACBrXmlNode; Prod: TProd);
    procedure Ler_gMedicao(const ANode: TACBrXmlNode; gMedicao: TgMedicao);
    procedure Ler_gMedida(const ANode: TACBrXmlNode; gMedida: TgMedida);

    procedure Ler_Imposto(const ANode: TACBrXmlNode; Imposto: TImposto);
    procedure Ler_PIS(const ANode: TACBrXmlNode; PIS: TPIS);
    procedure Ler_COFINS(const ANode: TACBrXmlNode; COFINS: TCOFINS);
    procedure Ler_RetTrib(const ANode: TACBrXmlNode; RetTrib: TRetTrib);
    procedure Ler_TFS(const ANode: TACBrXmlNode; TFS: TTFS);
    procedure Ler_TFU(const ANode: TACBrXmlNode; TFU: TTFU);

    procedure Ler_gProcRef(const ANode: TACBrXmlNode; gProcRef: TgProcRef);
    procedure Ler_gProc(const ANode: TACBrXmlNode; gProc: TgProcCollection);

    procedure Ler_Total(const ANode: TACBrXmlNode; Total: TTotal);
    procedure Ler_vRetTribTot(const ANode: TACBrXmlNode; Total: TTotal);

    procedure Ler_gFat(const ANode: TACBrXmlNode; gFat: TgFat);
    procedure Ler_gFatEnderCorresp(const ANode: TACBrXmlNode; EnderCorresp: TEndereco);
    procedure Ler_gFatgPIX(const ANode: TACBrXmlNode; gPIX: TgPIX);

    procedure Ler_gAgencia(const ANode: TACBrXmlNode; gAgencia: TgAgencia);
    procedure Ler_gHistCons(const ANode: TACBrXmlNode; gHistCons: TgHistConsCollection);
    procedure Ler_gCons(const ANode: TACBrXmlNode; gCons: TgConsCollection);

    procedure Ler_gQualiAgua(const ANode: TACBrXmlNode; gQualiAgua: TgQualiAgua);
    procedure Ler_gAnalise(const ANode: TACBrXmlNode; gAnalise: TgAnaliseCollection);
    procedure Ler_autXML(const ANode: TACBrXmlNode);
    procedure Ler_InfPAA(const ANode: TACBrXmlNode; InfPAA: TInfPAA);
    procedure Ler_InfAdic(const ANode: TACBrXmlNode; InfAdic: TInfAdic);
    procedure Ler_InfRespTec(const ANode: TACBrXmlNode; InfRespTec: TInfRespTec);
    procedure Ler_InfNFAgSupl(const ANode: TACBrXmlNode; InfNFAgSupl: TInfNFAgSupl);
  public
    constructor Create(AOwner: TNFAg); reintroduce;
    destructor Destroy; override;

    function LerXml: Boolean; override;

    property NFAg: TNFAg read FNFAg write FNFAg;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrNFAg.Conversao;

{ TNFAgXmlReader }

constructor TNFAgXmlReader.Create(AOwner: TNFAg);
begin
  inherited Create;

  FNFAg := AOwner;
end;

destructor TNFAgXmlReader.Destroy;
begin

  inherited Destroy;
end;

function TNFAgXmlReader.LerXml: Boolean;
Var
  NFAgNode, infNFAgNode: TACBrXmlNode;
  att: TACBrXmlAttribute;
begin
  if not Assigned(FNFAg) then
    raise Exception.Create('Destino não informado, informe a classe [TNFAg] de destino.');

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo xml da NFAg não carregado.');

  Result := False;
  Document.Clear();
  Document.LoadFromXml(Arquivo);

  if Document.Root.Name = 'NFAgProc' then
  begin
    Ler_ProtNFAg(Document.Root.Childrens.Find('protNFAg'));
    NFAgNode := Document.Root.Childrens.Find('NFAg');
  end
  else
  begin
    NFAgNode := Document.Root;
  end;

  if NFAgNode <> nil then
  begin
    infNFAgNode := NFAgNode.Childrens.Find('infNFAg');

    if infNFAgNode = nil then
      raise Exception.Create('Arquivo xml incorreto.');

    att := infNFAgNode.Attributes.Items['Id'];
    if att = nil then
      raise Exception.Create('Não encontrei o atributo: Id');

    NFAg.infNFAg.Id := att.Content;

    att := infNFAgNode.Attributes.Items['versao'];
    if att = nil then
      raise Exception.Create('Não encontrei o atributo: versao');

    NFAg.infNFAg.Versao := StringToFloat(att.Content);

    Ler_InfNFAg(infNFAgNode);
    Ler_InfNFAgSupl(NFAgNode.Childrens.Find('infNFAgSupl'), NFAg.infNFAgSupl);

    LerSignature(NFAgNode.Childrens.Find('Signature'), NFAg.signature);

    Result := True;
  end;
end;

procedure TNFAgXmlReader.Ler_ProtNFAg(const ANode: TACBrXmlNode);
var
  ANodeAux: TACBrXmlNode;
begin
  if not Assigned(ANode) then
    Exit;

  ANodeAux := ANode.Childrens.FindAnyNs('infProt');

  if not Assigned(ANodeAux) then
    Exit;

  NFAg.procNFAg.tpAmb := StrToTipoAmbiente(ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpAmb'), tcStr));
  NFAg.procNFAg.verAplic := ObterConteudo(ANodeAux.Childrens.FindAnyNs('verAplic'), tcStr);
  NFAg.procNFAg.chDFe := ObterConteudo(ANodeAux.Childrens.FindAnyNs('chNFAg'), tcStr);
  NFAg.procNFAg.dhRecbto := ObterConteudo(ANodeAux.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
  NFAg.procNFAg.nProt := ObterConteudo(ANodeAux.Childrens.FindAnyNs('nProt'), tcStr);
  NFAg.procNFAg.digVal := ObterConteudo(ANodeAux.Childrens.FindAnyNs('digVal'), tcStr);
  NFAg.procNFAg.cStat := ObterConteudo(ANodeAux.Childrens.FindAnyNs('cStat'), tcInt);
  NFAg.procNFAg.xMotivo := ObterConteudo(ANodeAux.Childrens.FindAnyNs('xMotivo'), tcStr);
  NFAg.procNFAg.cMsg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('cMsg'), tcInt);
  NFAg.procNFAg.xMsg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('xMsg'), tcStr);
end;

procedure TNFAgXmlReader.Ler_InfNFAg(const ANode: TACBrXmlNode);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  Ler_Ide(ANode.Childrens.Find('ide'));
  Ler_Emit(ANode.Childrens.Find('emit'));
  Ler_Dest(ANode.Childrens.Find('dest'));
  Ler_Ligacao(ANode.Childrens.Find('ligacao'), NFAg.ligacao);
  Ler_gSub(ANode.Childrens.Find('gSub'), NFAg.gSub);

  ANodes := ANode.Childrens.FindAll('gMed');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gMed(ANodes[i], NFAg.gMed);
  end;

  Ler_gFatConjunto(ANode.Childrens.Find('gFatConjunto'), NFAg.gFatConjunto);

  NFAg.Det.Clear;
  ANodes := ANode.Childrens.FindAll('det');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_Det(ANodes[i]);
  end;

  Ler_Total(ANode.Childrens.Find('total'), NFAg.Total);
  Ler_pgtoVinc(ANode.Childrens.Find('pgtoVinc'), NFAg.pgtoVinc);
  Ler_gFat(ANode.Childrens.Find('gFat'), NFAg.gFat);
  Ler_gAgencia(ANode.Childrens.Find('gAgencia'), NFAg.gAgencia);
  Ler_gQualiAgua(ANode.Childrens.Find('gQualiAgua'), NFAg.gQualiAgua);

  ANodes := ANode.Childrens.FindAll('autXML');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_autXML(ANodes[i]);
  end;

  Ler_InfAdic(ANode.Childrens.Find('infAdic'), NFAg.infAdic);
  Ler_InfPAA(ANode.Childrens.Find('infPAA'), NFAg.infPAA);
  Ler_InfRespTec(ANode.Childrens.Find('gRespTec'), NFAg.infRespTec);
end;

procedure TNFAgXmlReader.Ler_Ide(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  NFAg.ide.cUF := ObterConteudo(ANode.Childrens.Find('cUF'), tcInt);
  NFAg.Ide.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.Find('tpAmb'), tcStr));
  NFAg.ide.modelo := ObterConteudo(ANode.Childrens.Find('mod'), tcInt);
  NFAg.ide.serie := ObterConteudo(ANode.Childrens.Find('serie'), tcInt);
  NFAg.ide.nNF := ObterConteudo(ANode.Childrens.Find('nNF'), tcInt);
  NFAg.ide.cNF := ObterConteudo(ANode.Childrens.Find('cNF'), tcInt);
  NFAg.Ide.cDV := ObterConteudo(ANode.Childrens.Find('cDV'), tcInt);
  NFAg.ide.dhEmi := ObterConteudo(ANode.Childrens.Find('dhEmi'), tcDatHor);
  NFAg.Ide.tpEmis := StrToTipoEmissao(ObterConteudo(ANode.Childrens.Find('tpEmis'), tcStr));
  NFAg.Ide.nSiteAutoriz := StrToSiteAutorizator(ObterConteudo(ANode.Childrens.Find('nSiteAutoriz'), tcStr));
  NFAg.ide.cMunFG := ObterConteudo(ANode.Childrens.Find('cMunFG'), tcInt);
  NFAg.Ide.finNFAg := StrToFinNFAg(ObterConteudo(ANode.Childrens.Find('finNFAg'), tcStr));
  NFAg.Ide.verProc := ObterConteudo(ANode.Childrens.Find('verProc'), tcStr);
  NFAg.Ide.dhCont := ObterConteudo(ANode.Childrens.Find('dhCont'), tcDatHor);
  NFAg.Ide.xJust := ObterConteudo(ANode.Childrens.Find('xJust'), tcStr);
  NFAg.Ide.tpPagAnt := StrTotpPagAnt(ObterConteudo(ANode.Childrens.Find('tpPagAnt'), tcStr));

  // Reforma Tritutária
  Ler_gCompraGovReduzido(ANode.Childrens.Find('gCompraGov'), NFAg.Ide.gCompraGov);
end;

procedure TNFAgXmlReader.Ler_Emit(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  NFAg.Emit.CNPJ := ObterCNPJCPF(ANode);
  NFAg.Emit.IE := ObterConteudo(ANode.Childrens.Find('IE'), tcStr);
  NFAg.Emit.xNome := ObterConteudo(ANode.Childrens.Find('xNome'), tcStr);
  NFAg.Emit.xFant := ObterConteudo(ANode.Childrens.Find('xFant'), tcStr);

  Ler_EmitEnderEmit(ANode.Childrens.Find('enderEmit'));

  NFAg.Emit.ISUFEmit := ObterConteudo(ANode.Childrens.Find('ISUFEmit'), tcStr);
end;

procedure TNFAgXmlReader.Ler_EmitEnderEmit(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  NFAg.Emit.enderEmit.xLgr := ObterConteudo(ANode.Childrens.Find('xLgr'), tcStr);
  NFAg.Emit.enderEmit.nro := ObterConteudo(ANode.Childrens.Find('nro'), tcStr);
  NFAg.Emit.enderEmit.xCpl := ObterConteudo(ANode.Childrens.Find('xCpl'), tcStr);
  NFAg.Emit.enderEmit.xBairro := ObterConteudo(ANode.Childrens.Find('xBairro'), tcStr);
  NFAg.Emit.EnderEmit.cMun := ObterConteudo(ANode.Childrens.Find('cMun'), tcInt);
  NFAg.Emit.enderEmit.xMun := ObterConteudo(ANode.Childrens.Find('xMun'), tcStr);
  NFAg.Emit.enderEmit.CEP := ObterConteudo(ANode.Childrens.Find('CEP'), tcInt);
  NFAg.Emit.enderEmit.UF := ObterConteudo(ANode.Childrens.Find('UF'), tcStr);
  NFAg.Emit.enderEmit.fone := ObterConteudo(ANode.Childrens.Find('fone'), tcStr);
  NFAg.Emit.enderEmit.email := ObterConteudo(ANode.Childrens.Find('email'), tcStr);
end;

procedure TNFAgXmlReader.Ler_Dest(const ANode: TACBrXmlNode);
begin
  NFAg.Dest.xNome := ObterConteudo(ANode.Childrens.Find('xNome'), tcStr);

  NFAg.Dest.CNPJCPF := ObterCNPJCPF(ANode);

  if NFAg.Dest.CNPJCPF = '' then
    NFAg.Dest.idOutros := ObterConteudo(ANode.Childrens.Find('idOutros'), tcStr);

  NFAg.Dest.IE := ObterConteudo(ANode.Childrens.Find('IE'), tcStr);
  NFAg.Dest.IM := ObterConteudo(ANode.Childrens.Find('IM'), tcStr);
  NFAg.Dest.cNIS := ObterConteudo(ANode.Childrens.Find('cNIS'), tcStr);
  NFAg.Dest.NB := ObterConteudo(ANode.Childrens.Find('NB'), tcStr);
  NFAg.Dest.xNomeAdicional := ObterConteudo(ANode.Childrens.Find('xNomeAdicional'), tcStr);

  Ler_DestEnderDest(ANode.Childrens.Find('enderDest'));
end;

procedure TNFAgXmlReader.Ler_DestEnderDest(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  NFAg.Dest.enderDest.xLgr := ObterConteudo(ANode.Childrens.Find('xLgr'), tcStr);
  NFAg.Dest.enderDest.nro := ObterConteudo(ANode.Childrens.Find('nro'), tcStr);
  NFAg.Dest.enderDest.xCpl := ObterConteudo(ANode.Childrens.Find('xCpl'), tcStr);
  NFAg.Dest.enderDest.xBairro := ObterConteudo(ANode.Childrens.Find('xBairro'), tcStr);
  NFAg.Dest.enderDest.cMun := ObterConteudo(ANode.Childrens.Find('cMun'), tcInt);
  NFAg.Dest.enderDest.xMun := ObterConteudo(ANode.Childrens.Find('xMun'), tcStr);
  NFAg.Dest.enderDest.CEP := ObterConteudo(ANode.Childrens.Find('CEP'), tcInt);
  NFAg.Dest.enderDest.UF := ObterConteudo(ANode.Childrens.Find('UF'), tcStr);
  NFAg.Dest.enderDest.fone := ObterConteudo(ANode.Childrens.Find('fone'), tcStr);
  NFAg.Dest.enderDest.email := ObterConteudo(ANode.Childrens.Find('email'), tcStr);
end;

procedure TNFAgXmlReader.Ler_Ligacao(const ANode: TACBrXmlNode; Ligacao: TLigacao);
begin
  if not Assigned(ANode) then Exit;

  Ligacao.idLigacao := ObterConteudo(ANode.Childrens.Find('idLigacao'), tcStr);
  Ligacao.idCodCliente := ObterConteudo(ANode.Childrens.Find('idCodCliente'), tcStr);
  Ligacao.tpLigacao := StrTotpLigacao(ObterConteudo(ANode.Childrens.Find('tpLigacao'), tcStr));
  Ligacao.latGPS := ObterConteudo(ANode.Childrens.Find('latGPS'), tcStr);
  Ligacao.longGPS := ObterConteudo(ANode.Childrens.Find('longGPS'), tcStr);
  Ligacao.codRoteiroLeitura := ObterConteudo(ANode.Childrens.Find('codRoteiroLeitura'), tcStr);
end;

procedure TNFAgXmlReader.Ler_gSub(const ANode: TACBrXmlNode; gSub: TgSub);
begin
  if not Assigned(ANode) then Exit;

  gSub.chNFAg := ObterConteudo(ANode.Childrens.Find('chNFAg'), tcStr);
  gSub.motSub := StrToMotSub(ObterConteudo(ANode.Childrens.Find('motSub'), tcStr));
end;

procedure TNFAgXmlReader.Ler_gMed(const ANode: TACBrXmlNode; gMed: TgMedCollection);
var
  Item: TgMedCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := gMed.New;

  Item.nMed := StrToInt(ObterConteudoTag(ANode.Attributes.Items['nMed']));
  Item.idMedidor := ObterConteudo(ANode.Childrens.Find('idMedidor'), tcStr);
  Item.dMedAnt := ObterConteudo(ANode.Childrens.Find('dMedAnt'), tcDat);
  Item.dMedAtu := ObterConteudo(ANode.Childrens.Find('dMedAtu'), tcDat);
end;

procedure TNFAgXmlReader.Ler_gFatConjunto(const ANode: TACBrXmlNode; gFatConjunto: TgFatConjunto);
begin
  if not Assigned(ANode) then Exit;

  gFatConjunto.chNFAgFat := ObterConteudo(ANode.Childrens.Find('chNFAgFat'), tcStr);
end;

procedure TNFAgXmlReader.Ler_Det(const ANode: TACBrXmlNode);
var
  Item: TDetCollectionItem;
  TarifNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFAg.Det.New;

  Item.nItem := StrToIntDef(ObterConteudoTag(ANode.Attributes.Items['nItem']), 0);
  Item.chNFAgAnt := ObterConteudoTag(ANode.Attributes.Items['chNFAgAnt']);
  Item.nItemAnt := StrToIntDef(ObterConteudoTag(ANode.Attributes.Items['nItemAnt']), 0);

  TarifNodes := ANode.Childrens.FindAll('gTarif');
  for i := 0 to Length(TarifNodes) - 1 do
  begin
    Ler_gTarif(TarifNodes[i], Item.gTarif);
  end;

  Ler_Prod(ANode.Childrens.FindAnyNs('prod'), Item.Prod);
  Ler_Imposto(ANode.Childrens.FindAnyNs('imposto'), Item.Imposto);
  Ler_gProcRef(ANode.Childrens.FindAnyNs('gProcRef'), Item.gProcRef);
  Item.infAdProd := ObterConteudo(ANode.Childrens.FindAnyNs('infAdProd'), tcStr);
end;

procedure TNFAgXmlReader.Ler_gTarif(const ANode: TACBrXmlNode;
  gTarif: TgTarifCollection);
var
  Item: TgTarifCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := gTarif.New;

  Item.dIniTarif := ObterConteudo(ANode.Childrens.FindAnyNs('dIniTarif'), tcDat);
  Item.dFimTarif := ObterConteudo(ANode.Childrens.FindAnyNs('dFimTarif'), tcDat);
  Item.nAto := ObterConteudo(ANode.Childrens.FindAnyNs('nAto'), tcStr);
  Item.anoAto := ObterConteudo(ANode.Childrens.FindAnyNs('anoAto'), tcInt);
  Item.tpFaixaCons := StrTotpFaixaCons(ObterConteudo(ANode.Childrens.FindAnyNs('tpFaixaCons'), tcStr));
end;

procedure TNFAgXmlReader.Ler_Prod(const ANode: TACBrXmlNode; Prod: TProd);
var
  Lvalor: string;
begin
  if not Assigned(ANode) then
    Exit;

  Prod.indOrigemQtd := StrToindOrigemQtd(ObterConteudo(ANode.Childrens.FindAnyNs('indOrigemQtd'), tcStr));

  Ler_gMedicao(ANode.Childrens.FindAnyNs('gMedicao'), Prod.gMedicao);

  Prod.cProd := ObterConteudo(ANode.Childrens.FindAnyNs('cProd'), tcStr);
  Prod.xProd := ObterConteudo(ANode.Childrens.FindAnyNs('xProd'), tcStr);
  Prod.cClass := ObterConteudo(ANode.Childrens.FindAnyNs('cClass'), tcStr);
  Prod.tpCategoria := StrTotpCategoria(ObterConteudo(ANode.Childrens.FindAnyNs('tpCategoria'), tcStr));
  Prod.xCategoria := ObterConteudo(ANode.Childrens.FindAnyNs('xCategoria'), tcStr);
  Prod.qEconomias := ObterConteudo(ANode.Childrens.FindAnyNs('qEconomias'), tcStr);
  Prod.uMed := StrTouMedFat(ObterConteudo(ANode.Childrens.FindAnyNs('uMed'), tcStr));
  Prod.qFaturada := ObterConteudo(ANode.Childrens.FindAnyNs('qFaturada'), tcDe4);
  Prod.vItem := ObterConteudo(ANode.Childrens.FindAnyNs('vItem'), tcDe10);
  Prod.fatorPoluicao := ObterConteudo(ANode.Childrens.FindAnyNs('fatorPoluicao'), tcDe4);
  Prod.vProd := ObterConteudo(ANode.Childrens.FindAnyNs('vProd'), tcDe10);

  Lvalor := ObterConteudo(ANode.Childrens.FindAnyNs('indDevolucao'), tcStr);

  if Lvalor <> '' then
    Prod.indDevolucao := StrToTIndicador(Lvalor);

  Ler_gPagAntecipadoProd(ANode.Childrens.FindAnyNs('gPagAntecipado'), Prod.gPagAntecipado);
end;

procedure TNFAgXmlReader.Ler_gMedicao(const ANode: TACBrXmlNode;
  gMedicao: TgMedicao);
var
  Lvalor: string;
begin
  if not Assigned(ANode) then
    Exit;

  gMedicao.nMed := ObterConteudo(ANode.Childrens.FindAnyNs('nMed'), tcInt);

  Ler_gMedida(ANode.Childrens.FindAnyNs('gMedida'), gMedicao.gMedida);

  Lvalor := ObterConteudo(ANode.Childrens.FindAnyNs('tpMotNaoLeitura'), tcStr);

  if Lvalor <> '' then
    gMedicao.tpMotNaoLeitura := StrTotpMotNaoLeitura(Lvalor);
end;

procedure TNFAgXmlReader.Ler_gMedida(const ANode: TACBrXmlNode;
  gMedida: TgMedida);
begin
  if not Assigned(ANode) then
    Exit;

  gMedida.tpGrMed := StrTotpGrMed(ObterConteudo(ANode.Childrens.FindAnyNs('tpGrMed'), tcStr));
  gMedida.nUnidConsumo := ObterConteudo(ANode.Childrens.FindAnyNs('nUnidConsumo'), tcStr);
  gMedida.vUnidConsumo := ObterConteudo(ANode.Childrens.FindAnyNs('vUnidConsumo'), tcDe2);
  gMedida.uMed := StrTouMedFat(ObterConteudo(ANode.Childrens.FindAnyNs('uMed'), tcStr));
  gMedida.vMedAnt := ObterConteudo(ANode.Childrens.FindAnyNs('vMedAnt'), tcDe2);
  gMedida.vMedAtu := ObterConteudo(ANode.Childrens.FindAnyNs('vMedAtu'), tcDe2);
  gMedida.vConst := ObterConteudo(ANode.Childrens.FindAnyNs('vConst'), tcDe2);
  gMedida.vMed := ObterConteudo(ANode.Childrens.FindAnyNs('vMed'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_Imposto(const ANode: TACBrXmlNode;
  Imposto: TImposto);
begin
  if not Assigned(ANode) then
    Exit;

  // Reforma Tributária
  Ler_IBSCBS(ANode.Childrens.FindAnyNs('IBSCBS'), Imposto.IBSCBS);

  Ler_PIS(ANode.Childrens.FindAnyNs('PIS'), Imposto.PIS);
  Ler_COFINS(ANode.Childrens.FindAnyNs('COFINS'), Imposto.COFINS);
  Ler_retTrib(ANode.Childrens.FindAnyNs('retTrib'), Imposto.retTrib);
  Ler_TFS(ANode.Childrens.FindAnyNs('TFS'), Imposto.TFS);
  Ler_TFU(ANode.Childrens.FindAnyNs('TFU'), Imposto.TFU);
end;

procedure TNFAgXmlReader.Ler_PIS(const ANode: TACBrXmlNode; PIS: TPIS);
begin
  if not Assigned(ANode) then
    Exit;

  PIS.CST := StrToCSTPIS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
  PIS.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  PIS.pPIS := ObterConteudo(ANode.Childrens.FindAnyNs('pPIS'), tcDe4);
  PIS.vPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vPIS'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_COFINS(const ANode: TACBrXmlNode; COFINS: TCOFINS);
begin
  if not Assigned(ANode) then
    Exit;

  COFINS.CST := StrToCSTCOFINS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
  COFINS.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  COFINS.pCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('pCOFINS'), tcDe4);
  COFINS.vCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vCOFINS'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_RetTrib(const ANode: TACBrXmlNode;
  RetTrib: TRetTrib);
begin
  if not Assigned(ANode) then
    Exit;

  RetTrib.vRetPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetPIS'), tcDe2);
  RetTrib.vRetCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCofins'), tcDe2);
  RetTrib.vRetCSLL := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCSLL'), tcDe2);
  RetTrib.vIRRF := ObterConteudo(ANode.Childrens.FindAnyNs('vIRRF'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_TFS(const ANode: TACBrXmlNode; TFS: TTFS);
begin
  if not Assigned(ANode) then
    Exit;

  TFS.vBCTFS := ObterConteudo(ANode.Childrens.FindAnyNs('vBCTFS'), tcDe2);
  TFS.pTFS := ObterConteudo(ANode.Childrens.FindAnyNs('pTFS'), tcDe2);
  TFS.vTFS := ObterConteudo(ANode.Childrens.FindAnyNs('vTFS'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_TFU(const ANode: TACBrXmlNode; TFU: TTFU);
begin
  if not Assigned(ANode) then
    Exit;

  TFU.vBCTFU := ObterConteudo(ANode.Childrens.FindAnyNs('vBCTFU'), tcDe2);
  TFU.pTFU := ObterConteudo(ANode.Childrens.FindAnyNs('pTFU'), tcDe2);
  TFU.vTFU := ObterConteudo(ANode.Childrens.FindAnyNs('vTFU'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_gProcRef(const ANode: TACBrXmlNode;
  gProcRef: TgProcRef);
var
  ANodes: TACBrXmlNodeArray;
  i: Integer;
  Lvalor: string;
begin
  if not Assigned(ANode) then
    Exit;

  gProcRef.vItem := ObterConteudo(ANode.Childrens.FindAnyNs('vItem'), tcDe8);
  gProcRef.qFaturada := ObterConteudo(ANode.Childrens.FindAnyNs('qFaturada'), tcDe4);
  gProcRef.vProd := ObterConteudo(ANode.Childrens.FindAnyNs('vProd'), tcDe8);

  Lvalor := ObterConteudo(ANode.Childrens.FindAnyNs('indDevolucao'), tcStr);

  if Lvalor <> '' then
    gProcRef.indDevolucao := StrToTIndicador(Lvalor);

  ANodes := ANode.Childrens.FindAllAnyNs('gProc');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gProc(ANodes[i], gProcRef.gProc);
  end;
end;

procedure TNFAgXmlReader.Ler_gProc(const ANode: TACBrXmlNode;
  gProc: TgProcCollection);
var
  Item: TgProcCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := gProc.New;

  Item.tpProc := StrTotpProc(ObterConteudo(ANode.Childrens.FindAnyNs('tpProc'), tcStr));
  Item.nProcesso := ObterConteudo(ANode.Childrens.FindAnyNs('nProcesso'), tcStr);
end;

procedure TNFAgXmlReader.Ler_Total(const ANode: TACBrXmlNode; Total: TTotal);
begin
  if not Assigned(ANode) then
    Exit;

  Total.vProd := ObterConteudo(ANode.Childrens.FindAnyNs('vProd'), tcDe2);

  Ler_vRetTribTot(ANode.Childrens.FindAnyNs('vRetTribTot'), Total);

  Total.vCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vCOFINS'), tcDe2);
  Total.vPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vPIS'), tcDe2);
  Total.vTFS := ObterConteudo(ANode.Childrens.FindAnyNs('vTFS'), tcDe2);
  Total.vTFU := ObterConteudo(ANode.Childrens.FindAnyNs('vTFU'), tcDe2);
  Total.vNF := ObterConteudo(ANode.Childrens.FindAnyNs('vNF'), tcDe2);

  Ler_IBSCBSTot(ANode.Childrens.FindAnyNs('IBSCBSTot'), Total.IBSCBSTot);

  Total.vTotDFe := ObterConteudo(ANode.Childrens.FindAnyNs('vTotDFe'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_vRetTribTot(const ANode: TACBrXmlNode;
  Total: TTotal);
begin
  if not Assigned(ANode) then
    Exit;

  Total.vRetPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetPIS'), tcDe2);
  Total.vRetCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCofins'), tcDe2);
  Total.vRetCSLL := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCSLL'), tcDe2);
  Total.vIRRF := ObterConteudo(ANode.Childrens.FindAnyNs('vIRRF'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_gFat(const ANode: TACBrXmlNode; gFat: TgFat);
var
  xData: string;
begin
  if not Assigned(ANode) then
    Exit;

  xData := ObterConteudo(ANode.Childrens.FindAnyNs('CompetFat'), tcStr);

  if xData <> '' then
  begin
    xData := '01/' + Copy(xData, 5, 2) + '/' + Copy(xData, 1, 4);
    gFat.CompetFat := StrToDate(xData);
  end
  else
    gFat.CompetFat := 0;

  gFat.dVencFat := ObterConteudo(ANode.Childrens.FindAnyNs('dVencFat'), tcDat);
  gFat.dApresFat := ObterConteudo(ANode.Childrens.FindAnyNs('dApresFat'), tcDat);
  gFat.dProxLeitura := ObterConteudo(ANode.Childrens.FindAnyNs('dProxLeitura'), tcDat);
  gFat.nFat := ObterConteudo(ANode.Childrens.FindAnyNs('nFat'), tcStr);
  gFat.codBarras := ObterConteudo(ANode.Childrens.FindAnyNs('codBarras'), tcStr);
  gFat.codDebAuto := ObterConteudo(ANode.Childrens.FindAnyNs('codDebAuto'), tcStr);
  gFat.codBanco := ObterConteudo(ANode.Childrens.FindAnyNs('codBanco'), tcStr);
  gFat.codAgencia := ObterConteudo(ANode.Childrens.FindAnyNs('codAgencia'), tcStr);

  Ler_gFatEnderCorresp(ANode.Childrens.FindAnyNs('enderCorresp'), gFat.enderCorresp);
  Ler_gFatgPIX(ANode.Childrens.FindAnyNs('gPIX'), gFat.gPIX);
end;

procedure TNFAgXmlReader.Ler_gFatEnderCorresp(const ANode: TACBrXmlNode;
  EnderCorresp: TEndereco);
begin
  if not Assigned(ANode) then
    Exit;

  enderCorresp.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  enderCorresp.nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  enderCorresp.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  enderCorresp.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  enderCorresp.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  enderCorresp.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  enderCorresp.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  enderCorresp.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  enderCorresp.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  enderCorresp.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);
end;

procedure TNFAgXmlReader.Ler_gFatgPIX(const ANode: TACBrXmlNode; gPIX: TgPIX);
begin
  if not Assigned(ANode) then
    Exit;

  gPIX.urlQRCodePIX := ObterConteudo(ANode.Childrens.FindAnyNs('urlQRCodePIX'), tcStr);
end;

procedure TNFAgXmlReader.Ler_gAgencia(const ANode: TACBrXmlNode;
  gAgencia: TgAgencia);
var
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then
    Exit;

  gAgencia.econ := ObterConteudo(ANode.Childrens.FindAnyNs('econ'), tcStr);
  gAgencia.econAcumulada := ObterConteudo(ANode.Childrens.FindAnyNs('econAcumulada'), tcStr);
  gAgencia.sPrestador := ObterConteudo(ANode.Childrens.FindAnyNs('sPrestador'), tcStr);
  gAgencia.dEmissSelo := ObterConteudo(ANode.Childrens.FindAnyNs('dEmissSelo'), tcDat);
  gAgencia.sRegulador := ObterConteudo(ANode.Childrens.FindAnyNs('sRegulador'), tcStr);
  gAgencia.nAgenciaAtend := ObterConteudo(ANode.Childrens.FindAnyNs('nAgenciaAtend'), tcStr);
  gAgencia.enderAgenciaAtend := ObterConteudo(ANode.Childrens.FindAnyNs('enderAgenciaAtend'), tcStr);

  gAgencia.gHistCons.Clear;
  ANodes := ANode.Childrens.FindAll('gHistCons');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gHistCons(ANodes[i], gAgencia.gHistCons);
  end;
end;

procedure TNFAgXmlReader.Ler_gHistCons(const ANode: TACBrXmlNode;
  gHistCons: TgHistConsCollection);
var
  Item: TgHistConsCollectionItem;
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then
    Exit;

  Item := gHistCons.New;

  Item.xHistorico := ObterConteudo(ANode.Childrens.FindAnyNs('xHistorico'), tcStr);
  Item.medMensal := ObterConteudo(ANode.Childrens.FindAnyNs('medMensal'), tcDe4);

  Item.gCons.Clear;
  ANodes := ANode.Childrens.FindAll('gCons');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gCons(ANodes[i], Item.gCons);
  end;
end;

procedure TNFAgXmlReader.Ler_gCons(const ANode: TACBrXmlNode;
  gCons: TgConsCollection);
var
  Item: TgConsCollectionItem;
  xData: string;
begin
  if not Assigned(ANode) then
    Exit;

  Item := gCons.New;

  xData := ObterConteudo(ANode.Childrens.FindAnyNs('CompetFat'), tcStr);

  if xData <> '' then
  begin
    xData := '01/' + Copy(xData, 5, 2) + '/' + Copy(xData, 1, 4);
    Item.CompetFat := StrToDate(xData);
  end
  else
    Item.CompetFat := 0;

  Item.uMed := StrTouMedFat(ObterConteudo(ANode.Childrens.FindAnyNs('uMed'), tcStr));
  Item.qtdDias := ObterConteudo(ANode.Childrens.FindAnyNs('qtdDias'), tcStr);
  Item.medDiaria := ObterConteudo(ANode.Childrens.FindAnyNs('medDiaria'), tcDe4);
  Item.consumo := ObterConteudo(ANode.Childrens.FindAnyNs('consumo'), tcDe4);
  Item.volFat := ObterConteudo(ANode.Childrens.FindAnyNs('volFat'), tcDe2);
end;

procedure TNFAgXmlReader.Ler_gQualiAgua(const ANode: TACBrXmlNode;
  gQualiAgua: TgQualiAgua);
var
  xData: string;
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then
    Exit;

  xData := ObterConteudo(ANode.Childrens.FindAnyNs('CompetAnalise'), tcStr);

  if xData <> '' then
  begin
    xData := '01/' + Copy(xData, 5, 2) + '/' + Copy(xData, 1, 4);
    gQualiAgua.CompetAnalise := StrToDate(xData);
  end
  else
    gQualiAgua.CompetAnalise := 0;

  gQualiAgua.Conclusao := ObterConteudo(ANode.Childrens.FindAnyNs('Conclusao'), tcStr);
  gQualiAgua.cProcesso := ObterConteudo(ANode.Childrens.FindAnyNs('cProcesso'), tcStr);
  gQualiAgua.SistemaAbast := ObterConteudo(ANode.Childrens.FindAnyNs('SistemaAbast'), tcStr);

  gQualiAgua.gAnalise.Clear;
  ANodes := ANode.Childrens.FindAll('gAnalise');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gAnalise(ANodes[i], gQualiAgua.gAnalise);
  end;
end;

procedure TNFAgXmlReader.Ler_gAnalise(const ANode: TACBrXmlNode;
  gAnalise: TgAnaliseCollection);
var
  Item: TgAnaliseCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := gAnalise.New;

  Item.xItemAnalisado := ObterConteudo(ANode.Childrens.FindAnyNs('xItemAnalisado'), tcStr);
  Item.nAmostraMinima := ObterConteudo(ANode.Childrens.FindAnyNs('nAmostraMinima'), tcStr);
  Item.nAmostraAnalisada := ObterConteudo(ANode.Childrens.FindAnyNs('nAmostraAnalisada'), tcStr);
  Item.nAmostraFPadrao := ObterConteudo(ANode.Childrens.FindAnyNs('nAmostraFPadrao'), tcStr);
  Item.nAmostraDPadrao := ObterConteudo(ANode.Childrens.FindAnyNs('nAmostraDPadrao'), tcStr);
  Item.nMediaMensal := ObterConteudo(ANode.Childrens.FindAnyNs('nMediaMensal'), tcStr);
  Item.xValorReferencia := ObterConteudo(ANode.Childrens.FindAnyNs('xValorReferencia'), tcStr);
end;

procedure TNFAgXmlReader.Ler_autXML(const ANode: TACBrXmlNode);
var
  Item: TautXMLCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFAg.autXML.New;

  Item.CNPJCPF := ObterCNPJCPF(ANode);
end;

procedure TNFAgXmlReader.Ler_InfPAA(const ANode: TACBrXmlNode; InfPAA: TInfPAA);
begin
  if not Assigned(ANode) then
    Exit;

  InfPAA.CNPJPAA := ObterConteudo(ANode.Childrens.FindAnyNs('CNPJPAA'), tcStr);
end;

procedure TNFAgXmlReader.Ler_InfAdic(const ANode: TACBrXmlNode;
  InfAdic: TInfAdic);
begin
  if not Assigned(ANode) then
    Exit;

  infAdic.infAdFisco := ObterConteudo(ANode.Childrens.FindAnyNs('infAdFisco'), tcStr);
  {Mudar para aceitar uma lista de até 5 ocorrencias}
  infAdic.infCpl := ObterConteudo(ANode.Childrens.FindAnyNs('infCpl'), tcStr);
end;

procedure TNFAgXmlReader.Ler_InfRespTec(const ANode: TACBrXmlNode;
  InfRespTec: TInfRespTec);
begin
  if not Assigned(ANode) then
    Exit;

  infRespTec.CNPJ := ObterConteudo(ANode.Childrens.FindAnyNs('CNPJ'), tcStr);
  infRespTec.xContato := ObterConteudo(ANode.Childrens.FindAnyNs('xContato'), tcStr);
  infRespTec.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);
  infRespTec.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  infRespTec.idCSRT := ObterConteudo(ANode.Childrens.FindAnyNs('idCSRT'), tcInt);
  infRespTec.hashCSRT := ObterConteudo(ANode.Childrens.FindAnyNs('hashCSRT'), tcStr);
end;

procedure TNFAgXmlReader.Ler_InfNFAgSupl(const ANode: TACBrXmlNode;
  InfNFAgSupl: TInfNFAgSupl);
begin
  if not Assigned(ANode) then
    Exit;

  InfNFAgSupl.qrCodNFAg := ObterConteudo(ANode.Childrens.Find('qrCodNFAg'), tcStr);
  InfNFAgSupl.qrCodNFAg := StringReplace(InfNFAgSupl.qrCodNFAg, '<![CDATA[', '', []);
  InfNFAgSupl.qrCodNFAg := StringReplace(InfNFAgSupl.qrCodNFAg, ']]>', '', []);
end;

end.

