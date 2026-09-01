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

unit ACBrNFGas.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrXmlReader,
  ACBrNFGas.Classes,
  ACBrDFe.RTC.Classes,
  ACBrDFe.RTC.XmlReader;

type
  { TNFGasXmlReader }

  TNFGasXmlReader = class(TDFeRTCXmlReader)
  private
    FNFGas: TNFGas;

    procedure Ler_ProtNFGas(const ANode: TACBrXmlNode);
    procedure Ler_InfNFGas(const ANode: TACBrXmlNode);
    procedure Ler_Ide(const ANode: TACBrXmlNode);
    procedure Ler_Emit(const ANode: TACBrXmlNode);
    procedure Ler_EmitEnderEmit(const ANode: TACBrXmlNode);
    procedure Ler_Dest(const ANode: TACBrXmlNode);
    procedure Ler_DestEnderDest(const ANode: TACBrXmlNode);
    procedure Ler_Instalacao(const ANode: TACBrXmlNode);
    procedure Ler_gSub(const ANode: TACBrXmlNode);
    procedure Ler_gNF(const ANode: TACBrXmlNode);
    procedure Ler_gVolContrat(const ANode: TACBrXmlNode);
    procedure Ler_gMed(const ANode: TACBrXmlNode);

    procedure Ler_Det(const ANode: TACBrXmlNode);
    procedure Ler_DetgNormal(const ANode: TACBrXmlNode; gNormal: TgNormal);
    procedure Ler_DetgAgregadora(const ANode: TACBrXmlNode; gAgregadora: TgAgregadora);

    procedure Ler_gTarif(const ANode: TACBrXmlNode; gTarif: TgTarifCollection);
    procedure Ler_Prod(const ANode: TACBrXmlNode; Prod: TProd);
    procedure Ler_gMedicao(const ANode: TACBrXmlNode; gMedicao: TgMedicao);
    procedure Ler_gMedida(const ANode: TACBrXmlNode; gMedida: TgMedida);

    procedure Ler_Imposto(const ANode: TACBrXmlNode; Imposto: TImposto);
    procedure Ler_ICMS(const ANode: TACBrXmlNode; ICMS: TICMS);
    procedure Ler_PIS(const ANode: TACBrXmlNode; PIS: TPIS);
    procedure Ler_COFINS(const ANode: TACBrXmlNode; COFINS: TCOFINS);
    procedure Ler_RetTrib(const ANode: TACBrXmlNode; RetTrib: TRetTrib);
    procedure Ler_TxReg(const ANode: TACBrXmlNode; TxReg: TTxReg);

    procedure Ler_gProcRef(const ANode: TACBrXmlNode; gProcRef: TgProcRef);
    procedure Ler_gProc(const ANode: TACBrXmlNode; gProc: TgProcCollection);

    procedure Ler_Total(const ANode: TACBrXmlNode; Total: TTotal);
    procedure Ler_ICMSTot(const ANode: TACBrXmlNode; Total: TTotal);
    procedure Ler_vRetTribTot(const ANode: TACBrXmlNode; Total: TTotal);

    procedure Ler_gFat(const ANode: TACBrXmlNode; gFat: TgFat);
    procedure Ler_gFatEnderCorresp(const ANode: TACBrXmlNode; EnderCorresp: TEndereco);
    procedure Ler_gFatgPIX(const ANode: TACBrXmlNode; gPIX: TgPIX);

    procedure Ler_gAgencia(const ANode: TACBrXmlNode; gAgencia: TgAgencia);
    procedure Ler_gHistCons(const ANode: TACBrXmlNode; gHistCons: TgHistConsCollection);
    procedure Ler_gCons(const ANode: TACBrXmlNode; gCons: TgConsCollection);

    procedure Ler_autXML(const ANode: TACBrXmlNode);
    procedure Ler_InfAdic(const ANode: TACBrXmlNode; InfAdic: TInfAdic);
    procedure Ler_InfRespTec(const ANode: TACBrXmlNode; InfRespTec: TInfRespTec);
    procedure Ler_InfNFGasSupl(const ANode: TACBrXmlNode; InfNFGasSupl: TInfNFGasSupl);
  public
    constructor Create(AOwner: TNFGas); reintroduce;
    destructor Destroy; override;

    function LerXml: Boolean; override;

    property NFGas: TNFGas read FNFGas write FNFGas;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrNFGas.Conversao;

{ TNFGasXmlReader }

constructor TNFGasXmlReader.Create(AOwner: TNFGas);
begin
  inherited Create;

  FNFGas := AOwner;
end;

destructor TNFGasXmlReader.Destroy;
begin

  inherited Destroy;
end;

function TNFGasXmlReader.LerXml: Boolean;
var
  NFGasNode: TACBrXmlNode;
  infNFGasNode: TACBrXmlNode;
  Att: TACBrXmlAttribute;
begin
  if not Assigned(FNFGas) then
    raise Exception.Create('Destino não informado, informe a classe [TNFGas] de destino.');

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo XML da NFGas não carregado.');

  Result := False;
  Document.Clear;
  Document.LoadFromXml(Arquivo);

  if Document.Root.Name = 'nfgasProc' then
  begin
    Ler_ProtNFGas(Document.Root.Childrens.Find('protNFGas'));
    NFGasNode := Document.Root.Childrens.Find('NFGas');
  end
  else
  begin
    NFGasNode := Document.Root;
  end;

  if NFGasNode <> nil then
  begin
    infNFGasNode := NFGasNode.Childrens.Find('infNFGas');

    if infNFGasNode = nil then
      raise Exception.Create('Arquivo xml incorreto.');

    att := infNFGasNode.Attributes.Items['Id'];
    if att = nil then
      raise Exception.Create('Não encontrei o atributo: Id');

    NFGas.infNFGas.Id := att.Content;

    att := infNFGasNode.Attributes.Items['versao'];
    if att = nil then
      raise Exception.Create('Não encontrei o atributo: versao');

    NFGas.infNFGas.Versao := StringToFloat(att.Content);

    Ler_InfNFGas(infNFGasNode);
    Ler_InfNFGasSupl(NFGasNode.Childrens.Find('infNFGasSupl'), NFGas.infNFGasSupl);

    LerSignature(NFGasNode.Childrens.Find('Signature'), NFGas.signature);

    Result := True;
  end;
end;

procedure TNFGasXmlReader.Ler_ProtNFGas(const ANode: TACBrXmlNode);
var
  ANodeAux: TACBrXmlNode;
begin
  if not Assigned(ANode) then
    Exit;

  ANodeAux := ANode.Childrens.FindAnyNs('infProt');

  if not Assigned(ANodeAux) then
    Exit;

  NFGas.procNFGas.tpAmb := StrToTipoAmbiente(ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpAmb'), tcStr));
  NFGas.procNFGas.verAplic := ObterConteudo(ANodeAux.Childrens.FindAnyNs('verAplic'), tcStr);
  NFGas.procNFGas.chDFe := ObterConteudo(ANodeAux.Childrens.FindAnyNs('chNFGas'), tcStr);
  NFGas.procNFGas.dhRecbto := ObterConteudo(ANodeAux.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
  NFGas.procNFGas.nProt := ObterConteudo(ANodeAux.Childrens.FindAnyNs('nProt'), tcStr);
  NFGas.procNFGas.digVal := ObterConteudo(ANodeAux.Childrens.FindAnyNs('digVal'), tcStr);
  NFGas.procNFGas.cStat := ObterConteudo(ANodeAux.Childrens.FindAnyNs('cStat'), tcInt);
  NFGas.procNFGas.xMotivo := ObterConteudo(ANodeAux.Childrens.FindAnyNs('xMotivo'), tcStr);
  NFGas.procNFGas.cMsg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('cMsg'), tcInt);
  NFGas.procNFGas.xMsg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('xMsg'), tcStr);
end;

procedure TNFGasXmlReader.Ler_InfNFGas(const ANode: TACBrXmlNode);
var
  Index: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then
    Exit;

  Ler_Ide(ANode.Childrens.Find('ide'));
  Ler_Emit(ANode.Childrens.FindAnyNs('emit'));
  Ler_Dest(ANode.Childrens.FindAnyNs('dest'));
  Ler_Instalacao(ANode.Childrens.FindAnyNs('instalacao'));
  Ler_gSub(ANode.Childrens.FindAnyNs('gSub'));

  NFGas.gVolContrat.Clear;
  ANodes := ANode.Childrens.FindAllAnyNs('gVolContrat');
  for Index := 0 to Length(ANodes) - 1 do
  begin
    Ler_gVolContrat(ANodes[Index]);
  end;

  NFGas.gMed.Clear;
  ANodes := ANode.Childrens.FindAllAnyNs('gMed');
  for Index := 0 to Length(ANodes) - 1 do
  begin
    Ler_gMed(ANodes[Index]);
  end;

  NFGas.det.Clear;
  ANodes := ANode.Childrens.FindAllAnyNs('det');
  for Index := 0 to Length(ANodes) - 1 do
  begin
    Ler_Det(ANodes[Index]);
  end;

  Ler_Total(ANode.Childrens.FindAnyNs('total'), NFGas.Total);
  Ler_pgtoVinc(ANode.Childrens.FindAnyNs('pgtoVinc'), NFGas.pgtoVinc);
  Ler_gFat(ANode.Childrens.FindAnyNs('gFat'), NFGas.gFat);
  Ler_gAgencia(ANode.Childrens.FindAnyNs('gAgencia'), NFGas.gAgencia);

  NFGas.autXML.Clear;
  ANodes := ANode.Childrens.FindAllAnyNs('autXML');
  for Index := 0 to Length(ANodes) - 1 do
  begin
    Ler_autXML(ANodes[Index]);
  end;

  Ler_InfAdic(ANode.Childrens.FindAnyNs('infAdic'), NFGas.infAdic);
  Ler_InfRespTec(ANode.Childrens.FindAnyNs('gRespTec'), NFGas.infRespTec);
end;

procedure TNFGasXmlReader.Ler_Ide(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.Ide.cUF := ObterConteudo(ANode.Childrens.FindAnyNs('cUF'), tcInt);
  NFGas.Ide.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  NFGas.Ide.modelo := ObterConteudo(ANode.Childrens.FindAnyNs('mod'), tcInt);
  NFGas.Ide.serie := ObterConteudo(ANode.Childrens.FindAnyNs('serie'), tcInt);
  NFGas.Ide.nNF := ObterConteudo(ANode.Childrens.FindAnyNs('nNF'), tcInt);
  NFGas.Ide.cNF := ObterConteudo(ANode.Childrens.FindAnyNs('cNF'), tcInt);
  NFGas.Ide.cDV := ObterConteudo(ANode.Childrens.FindAnyNs('cDV'), tcInt);
  NFGas.Ide.dhEmi := ObterConteudo(ANode.Childrens.FindAnyNs('dhEmi'), tcDatHor);
  NFGas.Ide.tpEmis := StrToTipoEmissao(ObterConteudo(ANode.Childrens.FindAnyNs('tpEmis'), tcStr));
  NFGas.Ide.nSiteAutoriz := StrToSiteAutorizator(ObterConteudo(ANode.Childrens.FindAnyNs('nSiteAutoriz'), tcStr));
  NFGas.Ide.cMunFG := ObterConteudo(ANode.Childrens.FindAnyNs('cMunFG'), tcInt);
  NFGas.Ide.finNFGas := StrTofinNFGas(ObterConteudo(ANode.Childrens.FindAnyNs('finNFGas'), tcStr));
  NFGas.Ide.tpFat := strTotpFat(ObterConteudo(ANode.Childrens.FindAnyNs('tpFat'), tcStr));
  NFGas.Ide.verProc := ObterConteudo(ANode.Childrens.FindAnyNs('verProc'), tcStr);
  NFGas.Ide.dhCont := ObterConteudo(ANode.Childrens.FindAnyNs('dhCont'), tcDatHor);
  NFGas.Ide.xJust := ObterConteudo(ANode.Childrens.FindAnyNs('xJust'), tcStr);
  NFGas.Ide.tpPagAnt := StrTotpPagAnt(ObterConteudo(ANode.Childrens.FindAnyNs('tpPagAnt'), tcStr));

  Ler_gCompraGovReduzido(ANode.Childrens.FindAnyNs('gCompraGov'), NFGas.Ide.gCompraGov);
end;

procedure TNFGasXmlReader.Ler_Emit(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.Emit.CNPJ := ObterCNPJCPF(ANode);
  NFGas.Emit.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  NFGas.Emit.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  NFGas.Emit.xFant := ObterConteudo(ANode.Childrens.FindAnyNs('xFant'), tcStr);
  NFGas.Emit.ISUFEmit:= ObterConteudo(ANode.Childrens.Find('ISUFEmit'), tcStr);

  Ler_EmitEnderEmit(ANode.Childrens.FindAnyNs('enderEmit'));
end;

procedure TNFGasXmlReader.Ler_EmitEnderEmit(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.Emit.EnderEmit.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  NFGas.Emit.EnderEmit.nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  NFGas.Emit.EnderEmit.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  NFGas.Emit.EnderEmit.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  NFGas.Emit.EnderEmit.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  NFGas.Emit.EnderEmit.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  NFGas.Emit.EnderEmit.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  NFGas.Emit.EnderEmit.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  NFGas.Emit.EnderEmit.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  NFGas.Emit.EnderEmit.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);
  NFGas.Emit.EnderEmit.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  NFGas.Emit.EnderEmit.xPais := ObterConteudo(ANode.Childrens.FindAnyNs('xPais'), tcStr);
end;

procedure TNFGasXmlReader.Ler_Dest(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.Dest.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  NFGas.Dest.CNPJCPF := ObterCNPJCPF(ANode);

  if NFGas.Dest.CNPJCPF = '' then
  begin
    NFGas.Dest.idOutros := ObterConteudo(ANode.Childrens.FindAnyNs('idOutros'), tcStr);

    if NFGas.Dest.idOutros = '' then
      NFGas.Dest.idEstrangeiro := ObterConteudo(ANode.Childrens.FindAnyNs('idEstrangeiro'), tcStr);
  end;

  NFGas.Dest.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  NFGas.Dest.IM := ObterConteudo(ANode.Childrens.FindAnyNs('IM'), tcStr);
  NFGas.Dest.cNIS := ObterConteudo(ANode.Childrens.FindAnyNs('cNIS'), tcStr);
  NFGas.Dest.NB := ObterConteudo(ANode.Childrens.FindAnyNs('NB'), tcStr);
  NFGas.Dest.xNomeAdicional := ObterConteudo(ANode.Childrens.FindAnyNs('xNomeAdicional'), tcStr);

  Ler_DestEnderDest(ANode.Childrens.FindAnyNs('enderDest'));
end;

procedure TNFGasXmlReader.Ler_DestEnderDest(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.Dest.EnderDest.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  NFGas.Dest.EnderDest.nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  NFGas.Dest.EnderDest.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  NFGas.Dest.EnderDest.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  NFGas.Dest.EnderDest.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  NFGas.Dest.EnderDest.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  NFGas.Dest.EnderDest.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  NFGas.Dest.EnderDest.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  NFGas.Dest.EnderDest.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  NFGas.Dest.EnderDest.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);
  NFGas.Dest.EnderDest.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  NFGas.Dest.EnderDest.xPais := ObterConteudo(ANode.Childrens.FindAnyNs('xPais'), tcStr);
end;

procedure TNFGasXmlReader.Ler_Instalacao(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.Instalacao.idInstalacao := ObterConteudo(ANode.Childrens.FindAnyNs('idInstalacao'), tcStr);
  NFGas.Instalacao.idCodCliente := ObterConteudo(ANode.Childrens.FindAnyNs('idCodCliente'), tcStr);
  NFGas.Instalacao.tpInstalacao := StrToInstalacao(ObterConteudo(ANode.Childrens.FindAnyNs('tpInstalacao'), tcStr));
  NFGas.Instalacao.nContrato := ObterConteudo(ANode.Childrens.FindAnyNs('nContrato'), tcStr);
  NFGas.Instalacao.tpClasse := strToClasse(ObterConteudo(ANode.Childrens.FindAnyNs('tpClasse'), tcStr));
  NFGas.Instalacao.xClasse := ObterConteudo(ANode.Childrens.FindAnyNs('xClasse'), tcStr);
  NFGas.Instalacao.latGPS := ObterConteudo(ANode.Childrens.FindAnyNs('latGPS'), tcStr);
  NFGas.Instalacao.longGPS := ObterConteudo(ANode.Childrens.FindAnyNs('longGPS'), tcStr);
  NFGas.Instalacao.codRoteiroLeitura := ObterConteudo(ANode.Childrens.FindAnyNs('codRoteiroLeitura'), tcStr);
end;

procedure TNFGasXmlReader.Ler_gNF(const ANode: TACBrXmlNode);
var
  Compet: string;
  Ano: Word;
  Mes: Word;
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.gSub.gNF.CNPJ := ObterConteudo(ANode.Childrens.FindAnyNs('CNPJ'), tcStr);
  NFGas.gSub.gNF.serie := ObterConteudo(ANode.Childrens.FindAnyNs('serie'), tcStr);
  NFGas.gSub.gNF.nNF := ObterConteudo(ANode.Childrens.FindAnyNs('nNF'), tcInt);

  Compet := ObterConteudo(ANode.Childrens.FindAnyNs('CompetEmis'), tcStr);
  if Length(Compet) = 6 then
  begin
    Ano := StrToIntDef(Copy(Compet, 1, 4), 0);
    Mes := StrToIntDef(Copy(Compet, 5, 2), 0);

    if (Ano > 0) and (Mes >= 1) and (Mes <= 12) then
      NFGas.gSub.gNF.CompetEmis := EncodeDate(Ano, Mes, 1);
  end;

  Compet := ObterConteudo(ANode.Childrens.FindAnyNs('CompetApur'), tcStr);
  if Length(Compet) = 6 then
  begin
    Ano := StrToIntDef(Copy(Compet, 1, 4), 0);
    Mes := StrToIntDef(Copy(Compet, 5, 2), 0);

    if (Ano > 0) and (Mes >= 1) and (Mes <= 12) then
      NFGas.gSub.gNF.CompetApur := EncodeDate(Ano, Mes, 1);
  end;

  NFGas.gSub.gNF.hash115 := ObterConteudo(ANode.Childrens.FindAnyNs('hash115'), tcStr);
end;

procedure TNFGasXmlReader.Ler_gSub(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then
    Exit;

  NFGas.gSub.chNFGas := ObterConteudo(ANode.Childrens.FindAnyNs('chNFGas'), tcStr);
  NFGas.gSub.motSub := StrToMotSub(ObterConteudo(ANode.Childrens.FindAnyNs('motSub'), tcStr));

  Ler_gNF(ANode.Childrens.FindAnyNs('gNF'));
end;

procedure TNFGasXmlReader.Ler_gVolContrat(const ANode: TACBrXmlNode);
var
  Item: TgVolContratCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFGas.gVolContrat.New;

  Item.nContrat := StrToIntDef(ObterConteudoTag(ANode.Attributes.Items['nContrat']), 0);
  Item.tpVolContrat := StrToVolContrat(ObterConteudo(ANode.Childrens.FindAnyNs('tpVolContrat'), tcStr));
  Item.qUnidContrat := ObterConteudo(ANode.Childrens.FindAnyNs('qUnidContrat'), tcDe6);
end;

procedure TNFGasXmlReader.Ler_gMed(const ANode: TACBrXmlNode);
var
  Item: TgMedCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFGas.gMed.New;

  Item.nMed := StrToIntDef(ObterConteudoTag(ANode.Attributes.Items['nMed']), 0);
  Item.idEqp := ObterConteudo(ANode.Childrens.FindAnyNs('idEqp'), tcStr);
  Item.dMedAnt := ObterConteudo(ANode.Childrens.FindAnyNs('dMedAnt'), tcDat);
  Item.vMedAnt := ObterConteudo(ANode.Childrens.FindAnyNs('vMedAnt'), tcDe4);
  Item.dMedAtu := ObterConteudo(ANode.Childrens.FindAnyNs('dMedAtu'), tcDat);
  Item.vMedAtu := ObterConteudo(ANode.Childrens.FindAnyNs('vMedAtu'), tcDe4);
  Item.tpEqp := StrTotpEqp(ObterConteudo(ANode.Childrens.FindAnyNs('tpEqp'), tcStr));
  Item.tpMedidor := StrTotpMedidor(ObterConteudo(ANode.Childrens.FindAnyNs('tpMedidor'), tcStr));
end;

procedure TNFGasXmlReader.Ler_Det(const ANode: TACBrXmlNode);
var
  Item: TDetCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFGas.Det.New;

  Item.nItem := StrToIntDef(ObterConteudoTag(ANode.Attributes.Items['nItem']), 0);
  Item.chNFGasAnt := ObterConteudoTag(ANode.Attributes.Items['chNFGasAnt']);
  Item.nItemAnt := StrToIntDef(ObterConteudoTag(ANode.Attributes.Items['nItemAnt']), 0);

  Ler_DetgNormal(ANode.Childrens.FindAnyNs('gNormal'), Item.gNormal);
  Ler_DetgAgregadora(ANode.Childrens.FindAnyNs('gAgregadora'), Item.gAgregadora);
end;

procedure TNFGasXmlReader.Ler_DetgNormal(const ANode: TACBrXmlNode;
  gNormal: TgNormal);
var
  TarifNodes: TACBrXmlNodeArray;
  Index: Integer;
begin
  if not Assigned(ANode) then
    Exit;

  TarifNodes := ANode.Childrens.FindAll('gTarif');
  for Index := 0 to Length(TarifNodes) - 1 do
  begin
    Ler_gTarif(TarifNodes[Index], gNormal.gTarif);
  end;

  Ler_Prod(ANode.Childrens.FindAnyNs('prod'), gNormal.Prod);
  Ler_Imposto(ANode.Childrens.FindAnyNs('imposto'), gNormal.Imposto);
  Ler_gProcRef(ANode.Childrens.FindAnyNs('gProcRef'), gNormal.gProcRef);
  gNormal.infAdProd := ObterConteudo(ANode.Childrens.FindAnyNs('infAdProd'), tcStr);
end;

procedure TNFGasXmlReader.Ler_gTarif(const ANode: TACBrXmlNode; gTarif: TgTarifCollection);
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
  Item.vTarifAplic := ObterConteudo(ANode.Childrens.FindAnyNs('vTarifAplic'), tcDe8);
end;

procedure TNFGasXmlReader.Ler_Prod(const ANode: TACBrXmlNode; Prod: TProd);
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
  Prod.CFOP := ObterConteudo(ANode.Childrens.FindAnyNs('CFOP'), tcInt);
  Prod.uMed := StrTouMedItem(ObterConteudo(ANode.Childrens.FindAnyNs('uMed'), tcStr));
  Prod.qFaturada := ObterConteudo(ANode.Childrens.FindAnyNs('qFaturada'), tcDe4);
  Prod.vItem := ObterConteudo(ANode.Childrens.FindAnyNs('vItem'), tcDe10);
  Prod.fatorPCS := ObterConteudo(ANode.Childrens.FindAnyNs('fatorPCS'), tcDe4);
  Prod.fatorPTZ := ObterConteudo(ANode.Childrens.FindAnyNs('fatorPTZ'), tcDe4);
  Prod.fatorP := ObterConteudo(ANode.Childrens.FindAnyNs('fatorP'), tcDe4);
  Prod.fatorT := ObterConteudo(ANode.Childrens.FindAnyNs('fatorT'), tcDe4);
  Prod.vProd := ObterConteudo(ANode.Childrens.FindAnyNs('vProd'), tcDe10);

  Lvalor := ObterConteudo(ANode.Childrens.FindAnyNs('indDevolucao'), tcStr);

  if Lvalor <> '' then
    Prod.indDevolucao := StrToTIndicador(lValor);

  Ler_gPagAntecipadoProd(ANode.Childrens.FindAnyNs('gPagAntecipado'), Prod.gPagAntecipado);
end;

procedure TNFGasXmlReader.Ler_gMedicao(const ANode: TACBrXmlNode; gMedicao: TgMedicao);
begin
  if not Assigned(ANode) then
    Exit;

  gMedicao.nMed := ObterConteudo(ANode.Childrens.FindAnyNs('nMed'), tcInt);
  gMedicao.nContrat := ObterConteudo(ANode.Childrens.FindAnyNs('nContrat'), tcInt);

  Ler_gMedida(ANode.Childrens.FindAnyNs('gMedida'), gMedicao.gMedida);

  gMedicao.tpMotNaoLeitura := StrTotpMotNaoLeitura(ObterConteudo(ANode.Childrens.FindAnyNs('tpMotNaoLeitura'), tcStr));
  gMedicao.xMotNaoLeitura := ObterConteudo(ANode.Childrens.FindAnyNs('xMotNaoLeitura'), tcStr);
end;

procedure TNFGasXmlReader.Ler_gMedida(const ANode: TACBrXmlNode; gMedida: TgMedida);
begin
  if not Assigned(ANode) then
    Exit;

  gMedida.uMed := StrTouMed(ObterConteudo(ANode.Childrens.FindAnyNs('uMed'), tcStr));
  gMedida.vMed := ObterConteudo(ANode.Childrens.FindAnyNs('vMed'), tcDe4);
end;

procedure TNFGasXmlReader.Ler_DetgAgregadora(const ANode: TACBrXmlNode;
  gAgregadora: TgAgregadora);
begin
  if not Assigned(ANode) then
    Exit;

  gAgregadora.cClass := ObterConteudo(ANode.Childrens.FindAnyNs('cClass'), tcStr);
  gAgregadora.vTotDFe := ObterConteudo(ANode.Childrens.FindAnyNs('vTotDFe'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_Imposto(const ANode: TACBrXmlNode;
  Imposto: TImposto);
begin
  if not Assigned(ANode) then
    Exit;

  Imposto.orig := StrToOrig(ObterConteudo(ANode.Childrens.FindAnyNs('orig'), tcStr));

  Ler_ICMS(ANode, Imposto.ICMS);
  Ler_IBSCBS(ANode.Childrens.FindAnyNs('IBSCBS'), Imposto.IBSCBS);
  Ler_PIS(ANode.Childrens.FindAnyNs('PIS'), Imposto.PIS);
  Ler_COFINS(ANode.Childrens.FindAnyNs('COFINS'), Imposto.COFINS);
  Ler_retTrib(ANode.Childrens.FindAnyNs('retTrib'), Imposto.retTrib);
  Ler_TxReg(ANode.Childrens.FindAnyNs('TxReg'), Imposto.TxReg);
end;

procedure TNFGasXmlReader.Ler_ICMS(const ANode: TACBrXmlNode; ICMS: TICMS);
var
  ICMSNode: TACBrXmlNode;
  Ok: Boolean;
  Lvalor: string;
begin
  if not Assigned(ANode) then
    Exit;

  ICMSNode := ANode.Childrens.FindAnyNs('ICMS00');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS10');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS20');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS40');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS41');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS51');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS60');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS70');
  if not Assigned(ICMSNode) then ICMSNode := ANode.Childrens.FindAnyNs('ICMS90');

  if not Assigned(ICMSNode) then
    Exit;

  ICMS.CST := StrToCSTICMS(ObterConteudo(ICMSNode.Childrens.FindAnyNs('CST'), tcStr));
  ICMS.modBC := StrTomodBC(Ok, ObterConteudo(ICMSNode.Childrens.FindAnyNs('modBC'), tcStr));
  ICMS.pRedBC := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pRedBC'), tcDe2);
  ICMS.vBC := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBC'), tcDe2);
  ICMS.pICMS := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pICMS'), tcDe2);
  ICMS.vICMS := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vICMS'), tcDe2);
  ICMS.vICMSDeson := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vICMSDeson'), tcDe2);
  ICMS.motDesICMS := ObterConteudo(ICMSNode.Childrens.FindAnyNs('motDesICMS'), tcInt);
  ICMS.indDeduzDeson := StrToTIndicadorEx(ObterConteudo(ICMSNode.Childrens.FindAnyNs('indDeduzDeson'), tcStr));
  ICMS.cBenef := ObterConteudo(ICMSNode.Childrens.FindAnyNs('cBenef'), tcStr);
  ICMS.modBCST := StrTomodBCST(ok, ObterConteudo(ICMSNode.Childrens.FindAnyNs('modBCST'), tcStr));
  ICMS.pMVAST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pMVAST'), tcDe2);
  ICMS.pRedBCST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pRedBCST'), tcDe2);
  ICMS.vBCST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBCST'), tcDe2);
  ICMS.pICMSST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pICMSST'), tcDe2);
  ICMS.vICMSST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vICMSST'), tcDe2);
  ICMS.vBCFCP := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBCFCP'), tcDe2);
  ICMS.pFCPST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pFCPST'), tcDe2);
  ICMS.vFCPST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vFCPST'), tcDe2);
  ICMS.vBCFCPST := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBCFCPST'), tcDe2);
  ICMS.vBCSTRet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBCSTRet'), tcDe2);
  ICMS.pICMSSTRet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pICMSSTRet'), tcDe2);
  ICMS.vICMSSubstituto := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vICMSSubstituto'), tcDe2);
  ICMS.vICMSSTRet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vICMSSTRet'), tcDe2);
  ICMS.vBCFCPSTRet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBCFCPSTRet'), tcDe2);
  ICMS.pFCPSTRet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pFCPSTRet'), tcDe2);
  ICMS.vFCPSTRet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vFCPSTRet'), tcDe2);
  ICMS.pRedBCEfet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pRedBCEfet'), tcDe2);
  ICMS.vBCEfet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vBCEfet'), tcDe2);
  ICMS.pICMSEfet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pICMSEfet'), tcDe2);
  ICMS.vICMSEfet := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vICMSEfet'), tcDe2);
  ICMS.pFCP := ObterConteudo(ICMSNode.Childrens.FindAnyNs('pFCP'), tcDe4);
  ICMS.vFCP := ObterConteudo(ICMSNode.Childrens.FindAnyNs('vFCP'), tcDe2);

  Lvalor := ObterConteudo(ANode.Childrens.FindAnyNs('indSemCST'), tcStr);

  if Lvalor <> '' then
    ICMS.indSemCST := StrToTIndicador(lValor);
end;

procedure TNFGasXmlReader.Ler_PIS(const ANode: TACBrXmlNode; PIS: TPIS);
begin
  if not Assigned(ANode) then
    Exit;

  PIS.CST := StrToCSTPIS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
  PIS.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  PIS.pPIS := ObterConteudo(ANode.Childrens.FindAnyNs('pPIS'), tcDe4);
  PIS.vPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vPIS'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_COFINS(const ANode: TACBrXmlNode; COFINS: TCOFINS);
begin
  if not Assigned(ANode) then
    Exit;

  COFINS.CST := StrToCSTCOFINS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
  COFINS.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  COFINS.pCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('pCOFINS'), tcDe4);
  COFINS.vCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vCOFINS'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_RetTrib(const ANode: TACBrXmlNode; RetTrib: TRetTrib);
begin
  if not Assigned(ANode) then
    Exit;

  RetTrib.vRetPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetPIS'), tcDe2);
  RetTrib.vRetCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCofins'), tcDe2);
  RetTrib.vRetCSLL := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCSLL'), tcDe2);
  RetTrib.vIRRF := ObterConteudo(ANode.Childrens.FindAnyNs('vIRRF'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_TxReg(const ANode: TACBrXmlNode; TxReg: TTxReg);
begin
  if not Assigned(ANode) then
    Exit;

  TxReg.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  TxReg.pTaxa := ObterConteudo(ANode.Childrens.FindAnyNs('pTaxa'), tcDe4);
  TxReg.vTaxa := ObterConteudo(ANode.Childrens.FindAnyNs('vTaxa'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_gProcRef(const ANode: TACBrXmlNode; gProcRef: TgProcRef);
var
  ANodes: TACBrXmlNodeArray;
  Index: Integer;
  Lvalor: string;
begin
  if not Assigned(ANode) then
    Exit;

  gProcRef.vItem := ObterConteudo(ANode.Childrens.FindAnyNs('vItem'), tcDe8);
  gProcRef.qFaturada := ObterConteudo(ANode.Childrens.FindAnyNs('qFaturada'), tcDe4);
  gProcRef.vProd := ObterConteudo(ANode.Childrens.FindAnyNs('vProd'), tcDe8);

  Lvalor := ObterConteudo(ANode.Childrens.FindAnyNs('indDevolucao'), tcStr);

  if Lvalor <> '' then
    gProcRef.indDevolucao := StrToTIndicador(lValor);

  ANodes := ANode.Childrens.FindAllAnyNs('gProc');
  for Index := 0 to Length(ANodes) - 1 do
  begin
    Ler_gProc(ANodes[Index], gProcRef.gProc);
  end;
end;

procedure TNFGasXmlReader.Ler_gProc(const ANode: TACBrXmlNode; gProc: TgProcCollection);
var
  Item: TgProcCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := gProc.New;

  Item.tpProc := StrTotpProc(ObterConteudo(ANode.Childrens.FindAnyNs('tpProc'), tcStr));
  Item.nProcesso := ObterConteudo(ANode.Childrens.FindAnyNs('nProcesso'), tcStr);
end;

procedure TNFGasXmlReader.Ler_Total(const ANode: TACBrXmlNode; Total: TTotal);
begin
  if not Assigned(ANode) then
    Exit;

  Total.vProd := ObterConteudo(ANode.Childrens.FindAnyNs('vProd'), tcDe2);

  Ler_ICMSTot(ANode.Childrens.FindAnyNs('ICMSTot'), Total);
  Ler_vRetTribTot(ANode.Childrens.FindAnyNs('vRetTribTot'), Total);

  Total.vCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vCOFINS'), tcDe2);
  Total.vPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vPIS'), tcDe2);
  Total.vTxReg := ObterConteudo(ANode.Childrens.FindAnyNs('vTxReg'), tcDe2);
  Total.vNF := ObterConteudo(ANode.Childrens.FindAnyNs('vNF'), tcDe2);

  Ler_IBSCBSTot(ANode.Childrens.FindAnyNs('IBSCBSTot'), Total.IBSCBSTot);

  Total.vTotDFe := ObterConteudo(ANode.Childrens.FindAnyNs('vTotDFe'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_ICMSTot(const ANode: TACBrXmlNode; Total: TTotal);
begin
  if not Assigned(ANode) then
    Exit;

  Total.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  Total.vICMS := ObterConteudo(ANode.Childrens.FindAnyNs('vICMS'), tcDe2);
  Total.vICMSDeson := ObterConteudo(ANode.Childrens.FindAnyNs('vICMSDeson'), tcDe2);
  Total.vFCP := ObterConteudo(ANode.Childrens.FindAnyNs('vFCP'), tcDe2);
  Total.vBCST := ObterConteudo(ANode.Childrens.FindAnyNs('vBCST'), tcDe2);
  Total.vST := ObterConteudo(ANode.Childrens.FindAnyNs('vST'), tcDe2);
  Total.vFCPST := ObterConteudo(ANode.Childrens.FindAnyNs('vFCPST'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_vRetTribTot(const ANode: TACBrXmlNode;
  Total: TTotal);
begin
  if not Assigned(ANode) then
    Exit;

  Total.vRetPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetPIS'), tcDe2);
  Total.vRetCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCofins'), tcDe2);
  Total.vRetCSLL := ObterConteudo(ANode.Childrens.FindAnyNs('vRetCSLL'), tcDe2);
  Total.vIRRF := ObterConteudo(ANode.Childrens.FindAnyNs('vIRRF'), tcDe2);
end;

procedure TNFGasXmlReader.Ler_gFat(const ANode: TACBrXmlNode; gFat: TgFat);
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

  gFat.infAdFat := ObterConteudo(ANode.Childrens.FindAnyNs('infAdFat'), tcStr);
end;

procedure TNFGasXmlReader.Ler_gFatEnderCorresp(const ANode: TACBrXmlNode;
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

procedure TNFGasXmlReader.Ler_gFatgPIX(const ANode: TACBrXmlNode; gPIX: TgPIX);
begin
  if not Assigned(ANode) then
    Exit;

  gPIX.urlQRCodePIX := ObterConteudo(ANode.Childrens.FindAnyNs('urlQRCodePIX'), tcStr);
end;

procedure TNFGasXmlReader.Ler_gAgencia(const ANode: TACBrXmlNode; gAgencia: TgAgencia);
var
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then
    Exit;

  gAgencia.nomeAgenciaAtend := ObterConteudo(ANode.Childrens.FindAnyNs('nomeAgenciaAtend'), tcStr);
  gAgencia.enderAgenciaAtend := ObterConteudo(ANode.Childrens.FindAnyNs('enderAgenciaAtend'), tcStr);
  gAgencia.sitioAgenciaAtend := ObterConteudo(ANode.Childrens.FindAnyNs('sitioAgenciaAtend'), tcStr);
  gAgencia.infAdReg := ObterConteudo(ANode.Childrens.FindAnyNs('infAdReg'), tcStr);

  gAgencia.gHistCons.Clear;
  ANodes := ANode.Childrens.FindAll('gHistCons');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gHistCons(ANodes[i], gAgencia.gHistCons);
  end;
end;

procedure TNFGasXmlReader.Ler_gHistCons(const ANode: TACBrXmlNode; gHistCons: TgHistConsCollection);
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

procedure TNFGasXmlReader.Ler_gCons(const ANode: TACBrXmlNode; gCons: TgConsCollection);
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

  Item.uMed := StrTouMed(ObterConteudo(ANode.Childrens.FindAnyNs('uMed'), tcStr));
  Item.qtdDias := ObterConteudo(ANode.Childrens.FindAnyNs('qtdDias'), tcInt);
  Item.medDiaria := ObterConteudo(ANode.Childrens.FindAnyNs('medDiaria'), tcDe4);
  Item.consumo := ObterConteudo(ANode.Childrens.FindAnyNs('consumo'), tcDe4);
  Item.vFat := ObterConteudo(ANode.Childrens.FindAnyNs('vFat'), tcDe4);
end;

procedure TNFGasXmlReader.Ler_autXML(const ANode: TACBrXmlNode);
var
  Item: TautXMLCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFGas.autXML.New;

  Item.CNPJCPF := ObterCNPJCPF(ANode);
end;

procedure TNFGasXmlReader.Ler_InfAdic(const ANode: TACBrXmlNode; InfAdic: TInfAdic);
begin
  if not Assigned(ANode) then
    Exit;

  infAdic.infAdFisco := ObterConteudo(ANode.Childrens.FindAnyNs('infAdFisco'), tcStr);
  {Mudar para aceitar uma lista de até 5 ocorrencias}
  infAdic.infCpl := ObterConteudo(ANode.Childrens.FindAnyNs('infCpl'), tcStr);
end;

procedure TNFGasXmlReader.Ler_InfRespTec(const ANode: TACBrXmlNode; InfRespTec: TInfRespTec);
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

procedure TNFGasXmlReader.Ler_InfNFGasSupl(const ANode: TACBrXmlNode;
  InfNFGasSupl: TInfNFGasSupl);
begin
  if not Assigned(ANode) then
    Exit;

  InfNFGasSupl.qrCodNFGas := ObterConteudo(ANode.Childrens.Find('qrCodNFGas'), tcStr);
  InfNFGasSupl.qrCodNFGas := StringReplace(InfNFGasSupl.qrCodNFGas, '<![CDATA[', '', []);
  InfNFGasSupl.qrCodNFGas := StringReplace(InfNFGasSupl.qrCodNFGas, ']]>', '', []);
end;

end.
