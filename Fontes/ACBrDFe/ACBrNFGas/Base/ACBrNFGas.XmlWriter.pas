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

unit ACBrNFGas.XmlWriter;

interface

uses
  Classes, SysUtils, StrUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFeComum.Proc,
  ACBrDFeConsts,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrNFGas.Classes,
  ACBrDFe.RTC.Classes,
  ACBrDFe.RTC.XmlWriter,
  ACBrNFGas.Conversao;

type
  TNFGasXmlWriterOptions = class(TACBrXmlWriterOptions)
  private
    FAjustarTagNro: boolean;
    FGerarTagIPIparaNaoTributado: boolean;
    FNormatizarMunicipios: boolean;
    FGerarTagAssinatura: TACBrTagAssinatura;
    FPathArquivoMunicipios: string;
    FValidarInscricoes: boolean;
    FValidarListaServicos: boolean;
    FCamposFatObrigatorios: boolean;

  public
    property AjustarTagNro: boolean read FAjustarTagNro write FAjustarTagNro;
    property GerarTagIPIparaNaoTributado: boolean read FGerarTagIPIparaNaoTributado write FGerarTagIPIparaNaoTributado;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios;
    property GerarTagAssinatura: TACBrTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property ValidarInscricoes: boolean read FValidarInscricoes write FValidarInscricoes;
    property ValidarListaServicos: boolean read FValidarListaServicos write FValidarListaServicos;
    property CamposFatObrigatorios: boolean read FCamposFatObrigatorios write FCamposFatObrigatorios;
  end;

  TNFGasXmlWriter = class(TDFeRTCXmlWriter)
  protected
    function CreateOptions: TACBrXmlWriterOptions;override;
  private
    FNFGas: TNFGas;
    FChaveNFGas: string;
    FVersaoDF: TVersaoNFGas;
    FModeloDF: Integer;
    FtpAmb: TACBrTipoAmbiente;
    FtpEmis: TACBrTipoEmissao;
    FpGerarGrupoIBSCBSTot: Boolean;
    FIdCSRT: integer;
    FCSRT: string;

    function GetOpcoes: TNFGasXmlWriterOptions;
    procedure SetOpcoes(AValue: TNFGasXmlWriterOptions);

    function Gerar_InfNFGas: TACBrXmlNode;
    function Gerar_Ide: TACBrXmlNode;
    function Gerar_Emit: TACBrXmlNode;
    function Gerar_EmitEnderEmit: TACBrXmlNode;
    function Gerar_Dest: TACBrXmlNode;
    function Gerar_DestEnderDest: TACBrXmlNode;
    function Gerar_Instalacao: TACBrXmlNode;
    function Gerar_gSub: TACBrXmlNode;
    function Gerar_gNF: TACBrXmlNode;

    function Gerar_gVolContrat: TACBrXmlNodeArray;
    function Gerar_gMed: TACBrXmlNodeArray;

    function Gerar_det: TACBrXmlNodeArray;
    function Gerar_det_gNormal(gNormal: TgNormal): TACBrXmlNode;
    function Gerar_det_gTarif(gTarif: TgTarifCollection): TACBrXmlNodeArray;
    function Gerar_det_prod(prod: Tprod): TACBrXmlNode;
    function Gerar_det_prod_gMedicao(gMedicao: TgMedicao): TACBrXmlNode;
    function Gerar_det_prod_gMedida(gMedida: TgMedida): TACBrXmlNode;

    function Gerar_det_imposto(imposto: Timposto): TACBrXmlNode;
    function Gerar_det_imposto_PIS(PIS: TPIS): TACBrXmlNode;
    function Gerar_det_imposto_COFINS(COFINS: TCOFINS): TACBrXmlNode;
    function Gerar_det_imposto_retTrib(retTrib: TretTrib): TACBrXmlNode;
    function Gerar_det_imposto_TxReg(TxReg: TTxReg): TACBrXmlNode;

    function Gerar_det_gProcRef(gProcRef: TgProcRef): TACBrXmlNode;
    function Gerar_det_gProcRef_gProc(gProc: TgProcCollection): TACBrXmlNodeArray;

    function Gerar_det_gAgregadora(gAgregadora: TgAgregadora): TACBrXmlNode;

    function Gerar_Total(Total: TTotal): TACBrXmlNode;
    function Gerar_ICMSTot(Total: TTotal): TACBrXmlNode;
    function Gerar_vRetTribTot(Total: TTotal): TACBrXmlNode;

    function Gerar_gFat(gFat: TgFat): TACBrXmlNode;
    function Gerar_gFat_enderCorresp(enderCorresp: Tendereco): TACBrXmlNode;
    function Gerar_gFat_gPix(gPix: TgPix): TACBrXmlNode;

    function Gerar_gAgencia(gAgencia: TgAgencia): TACBrXmlNode;
    function Gerar_gAgencia_gHistCons(gHistCons: TgHistConsCollection): TACBrXmlNodeArray;
    function Gerar_gAgencia_gHistCons_gCons(gCons: TgConsCollection): TACBrXmlNodeArray;

    function Gerar_autXML(autXML: TautXMLCollection): TACBrXmlNodeArray;
    function Gerar_InfAdic(infAdic: TInfAdic): TACBrXmlNode;
    function Gerar_RespTec(infRespTec: TinfRespTec): TACBrXmlNode;

    function Gerar_ProcNFGas(procNFGas: TProcDFe): TACBrXmlNode;

    procedure AjustarMunicipioUF(out xUF: string; out xMun: string;
      out cMun: Integer; cPais: Integer; const vxUF, vxMun: string; vcMun: Integer);
  public
    constructor Create(AOwner: TNFGas); reintroduce;
    destructor Destroy; override;

    function GerarXml: Boolean; override;
    function ObterNomeArquivo: string;

    property Opcoes: TNFGasXmlWriterOptions read GetOpcoes write SetOpcoes;
    property NFGas: TNFGas read FNFGas write FNFGas;
    property VersaoDF: TVersaoNFGas read FVersaoDF write FVersaoDF;
    property ModeloDF: Integer read FModeloDF write FModeloDF;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property tpEmis: TACBrTipoEmissao read FtpEmis write FtpEmis;
    property IdCSRT: integer read FIdCSRT write FIdCSRT;
    property CSRT: string read FCSRT write FCSRT;
  end;

implementation

uses
  Math,
  ACBrNFGas.Consts,
  ACBrDFeUtil;

constructor TNFGasXmlWriter.Create(AOwner: TNFGas);
begin
  inherited Create;

  TNFGasXmlWriterOptions(Opcoes).AjustarTagNro := False;
  TNFGasXmlWriterOptions(Opcoes).GerarTagIPIparaNaoTributado := True;
  TNFGasXmlWriterOptions(Opcoes).NormatizarMunicipios := False;
  TNFGasXmlWriterOptions(Opcoes).PathArquivoMunicipios := '';
  TNFGasXmlWriterOptions(Opcoes).GerarTagAssinatura := taSomenteSeAssinada;
  TNFGasXmlWriterOptions(Opcoes).ValidarInscricoes := False;
  TNFGasXmlWriterOptions(Opcoes).ValidarListaServicos := False;
  TNFGasXmlWriterOptions(Opcoes).CamposFatObrigatorios := True;

  FNFGas := AOwner;
end;

destructor TNFGasXmlWriter.Destroy;
begin
  inherited Destroy;
end;

function TNFGasXmlWriter.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TNFGasXmlWriterOptions.Create;
end;

function TNFGasXmlWriter.GetOpcoes: TNFGasXmlWriterOptions;
begin
  Result := TNFGasXmlWriterOptions(FOpcoes);
end;

procedure TNFGasXmlWriter.SetOpcoes(AValue: TNFGasXmlWriterOptions);
begin
  FOpcoes := AValue;
end;

function TNFGasXmlWriter.ObterNomeArquivo: string;
begin
  Result := RemoverLiteralChave(FNFGas.infNFGas.ID) + '-NFGas.xml';
end;

function TNFGasXmlWriter.GerarXml: Boolean;
var
  Gerar: boolean;
  NFGasNode, xmlNode: TACBrXmlNode;
begin
  Result := False;
  FpGerarGrupoIBSCBSTot := False;
  ModelosDFe := mdfNFGas;
  tpNFDebito := tdNenhum;

  ListaDeAlertas.Clear;

  {
    Os campos abaixo tem que ser os mesmos da configuração
  }
{
  NFGas.infNFGas.Versao := VersaoNFGasToDbl(VersaoDF);
  NFGas.Ide.modelo := ModeloDF;
  NFGas.Ide.tpAmb := tpAmb;
  NFGas.ide.tpEmis := tpEmis;
}
  FChaveNFGas := GerarChaveAcesso(NFGas.ide.cUF, NFGas.ide.dhEmi, NFGas.emit.CNPJ,
      NFGas.ide.serie, NFGas.ide.nNF, StrToInt(TipoEmissaoToStr(NFGas.ide.tpEmis)),
      NFGas.ide.cNF, NFGas.ide.modelo,
      StrToInt(SiteAutorizadorToStr(NFGas.Ide.nSiteAutoriz)));

  NFGas.infNFGas.ID := 'NFGas' + FChaveNFGas;
  NFGas.ide.cDV := ExtrairDigitoChaveAcesso(NFGas.infNFGas.ID);
  NFGas.Ide.cNF := ExtrairCodigoChaveAcesso(NFGas.infNFGas.ID);

  FDocument.Clear();
  NFGasNode := FDocument.CreateElement('NFGas', 'http://www.portalfiscal.inf.br/nfgas');

  if NFGas.procNFGas.nProt <> '' then
  begin
    xmlNode := FDocument.CreateElement('NFGasProc', 'http://www.portalfiscal.inf.br/nfgas');
    xmlNode.SetAttribute('versao', FloatToString(NFGas.infNFGas.Versao, '.', '#0.00'));
    xmlNode.AppendChild(NFGasNode);
    FDocument.Root := xmlNode;
  end
  else
  begin
    FDocument.Root := NFGasNode;
  end;

  xmlNode := Gerar_InfNFGas();
  NFGasNode.AppendChild(xmlNode);

  if NFGas.infNFGasSupl.qrCodNFGas <> '' then
  begin
    xmlNode := NFGasNode.AddChild('infNFGasSupl');
    xmlNode.AppendChild(AddNode(tcStr, '#318', 'qrCodNFGas', 50, 1000, 1,
       '<![CDATA[' + NFGas.infNFGasSupl.qrCodNFGas + ']]>', DSC_INFQRCODE, False));
  end;

  Gerar := (Opcoes.GerarTagAssinatura = taSempre) or
    (
      (Opcoes.GerarTagAssinatura = taSomenteSeAssinada) and
        (NFGas.signature.DigestValue <> '') and
        (NFGas.signature.SignatureValue <> '') and
        (NFGas.signature.X509Certificate <> '')
    ) or
    (
      (Opcoes.GerarTagAssinatura = taSomenteParaNaoAssinada) and
        (NFGas.signature.DigestValue = '') and
        (NFGas.signature.SignatureValue = '') and
        (NFGas.signature.X509Certificate = '')
    );

  if Gerar then
  begin
    NFGas.signature.URI := '#NFGas' + FChaveNFGas;
    xmlNode := GerarSignature(NFGas.signature);
    NFGasNode.AppendChild(xmlNode);
  end;

  if NFGas.procNFGas.nProt <> '' then
  begin
    xmlNode := Gerar_ProcNFGas(NFGas.procNFGas);
    FDocument.Root.AppendChild(xmlNode);
  end;
end;

function TNFGasXmlWriter.Gerar_InfNFGas: TACBrXmlNode;
var
  NodeArray: TACBrXmlNodeArray;
  I: Integer;
  NodeRespTec: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infNFGas');

  Result.SetAttribute('Id', 'NFGas' + FChaveNFGas);
  Result.SetAttribute('versao', FloatToString(NFGas.infNFGas.Versao, '.', '#0.00'));

  Result.AppendChild(Gerar_Ide);
  Result.AppendChild(Gerar_Emit);
  Result.AppendChild(Gerar_Dest);

  if Trim(NFGas.Instalacao.idInstalacao) <> '' then
    Result.AppendChild(Gerar_Instalacao);

  if (Trim(NFGas.gSub.chNFGas) <> '') or (Trim(NFGas.gSub.gNF.CNPJ) <> '') then
    Result.AppendChild(Gerar_gSub);

  NodeArray := Gerar_gVolContrat;
  for I := 0 to NFGas.gVolContrat.Count - 1 do
  begin
    Result.AppendChild(NodeArray[I]);
  end;

  NodeArray := Gerar_gMed;
  for I := 0 to NFGas.gMed.Count - 1 do
  begin
    Result.AppendChild(NodeArray[I]);
  end;

  NodeArray := Gerar_det;
  for I := 0 to NFGas.Det.Count - 1 do
  begin
    Result.AppendChild(NodeArray[I]);
  end;

  Result.AppendChild(Gerar_Total(NFGas.Total));
  Result.AppendChild(Gerar_pgtoVinc(NFGas.pgtoVinc));
  Result.AppendChild(Gerar_gFat(NFGas.gFat));
  Result.AppendChild(Gerar_gAgencia(NFGas.gAgencia));

  NodeArray := Gerar_autXML(NFGas.autXML);
  for I := 0 to NFGas.autXML.Count - 1 do
  begin
    Result.AppendChild(NodeArray[I]);
  end;

  Result.AppendChild(Gerar_InfAdic(NFGas.infAdic));

  NodeRespTec := Gerar_RespTec(NFGas.infRespTec);
  if Assigned(NodeRespTec) then
  begin
    Result.AppendChild(NodeRespTec);
  end;
end;

function TNFGasXmlWriter.Gerar_Ide: TACBrXmlNode;
var
  NodeCompraGov: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ide');

  Result.AppendChild(AddNode(tcInt, '#5', 'cUF', 2, 2, 1,
                                                       NFGas.Ide.cUF, DSC_CUF));
  Result.AppendChild(AddNode(tcStr, '#6', 'tpAmb', 1, 1, 1,
                                TipoAmbienteToStr(NFGas.Ide.tpAmb), DSC_TPAMB));
  Result.AppendChild(AddNode(tcInt, '#7', 'mod', 2, 2, 1,
                                                    NFGas.Ide.modelo, DSC_MOD));
  Result.AppendChild(AddNode(tcInt, '#8', 'serie', 1, 3, 1,
                                                   NFGas.Ide.serie, DSC_SERIE));
  Result.AppendChild(AddNode(tcInt, '#9', 'nNF', 1, 9, 1,
                                                       NFGas.Ide.nNF, DSC_NDF));
  Result.AppendChild(AddNode(tcInt, '#10', 'cNF', 7, 7, 1,
                                                       NFGas.Ide.cNF, DSC_CDF));
  Result.AppendChild(AddNode(tcInt, '#11', 'cDV', 1, 1, 1,
                                                       NFGas.Ide.cDV, DSC_CDV));

  Result.AppendChild(AddNode(tcStr, '#12', 'dhEmi', 25, 25, 1,
    DateTimeTodh(NFGas.Ide.dhEmi) + GetUTC(CodigoUFparaUF(NFGas.Ide.cUF), NFGas.Ide.dhEmi),
    DSC_DHEMI));

  Result.AppendChild(AddNode(tcStr, '#13', 'tpEmis', 1, 1, 1,
                               TipoEmissaoToStr(NFGas.Ide.tpEmis), DSC_TPEMIS));
  Result.AppendChild(AddNode(tcStr, '#14', 'nSiteAutoriz', 1, 1, 1,
               SiteAutorizadorToStr(NFGas.Ide.nSiteAutoriz), DSC_NSITEAUTORIZ));
  Result.AppendChild(AddNode(tcInt, '#15', 'cMunFG', 7, 7, 1,
                                                 NFGas.Ide.cMunFG, DSC_CMUNFG));
  Result.AppendChild(AddNode(tcStr, '#16', 'finNFGas', 1, 1, 1,
                                             NFGas.Ide.finNFGas, DSC_FINNFGAS));
  Result.AppendChild(AddNode(tcStr, '#17', 'tpFat', 1, 1, 1,
                                       tpFatToStr(NFGas.Ide.tpFat), DSC_TPFAT));
  Result.AppendChild(AddNode(tcStr, '#18', 'verProc', 1, 20, 1,
                                               NFGas.Ide.verProc, DSC_VERPROC));

  if (NFGas.Ide.dhCont > 0) or (Trim(NFGas.Ide.xJust) <> '') then
  begin
    Result.AppendChild(AddNode(tcStr, '#20', 'dhCont', 25, 25, 1,
      DateTimeTodh(NFGas.Ide.dhCont) + GetUTC(CodigoUFparaUF(NFGas.Ide.cUF), NFGas.Ide.dhCont),
      DSC_DHCONT));

    Result.AppendChild(AddNode(tcStr, '#21', 'xJust', 15, 255, 1,
                                                   NFGas.Ide.xJust, DSC_XJUST));
  end;

  NodeCompraGov := Gerar_gCompraGovReduzido(NFGas.Ide.gCompraGov);
  if Assigned(NodeCompraGov) then
  begin
    Result.AppendChild(NodeCompraGov);
  end;

  if NFGas.Ide.tpPagAnt <> tpaNenhum then
    Result.AppendChild(AddNode(tcStr, '#20a', 'tpPagAnt', 1, 1, 1,
                              tpPagAntToStr(NFGas.Ide.tpPagAnt), DSC_TPPAGANT));
end;

function TNFGasXmlWriter.Gerar_Emit: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('emit');

  Result.AppendChild(AddNode(tcStr, '#27', 'CNPJ', 14, 14, 1, NFGas.Emit.CNPJ, 'CNPJ do emitente'));
  Result.AppendChild(AddNode(tcStr, '#28', 'IE', 2, 14, 1, OnlyNumber(NFGas.Emit.IE), 'IE do emitente'));
  Result.AppendChild(AddNode(tcStr, '#29', 'xNome', 2, 60, 1, NFGas.Emit.xNome, 'Razão social do emitente'));
  Result.AppendChild(AddNode(tcStr, '#30', 'xFant', 1, 60, 0, NFGas.Emit.xFant, 'Nome fantasia do emitente'));

  Result.AppendChild(Gerar_EmitEnderEmit);

  Result.AppendChild(AddNode(tcStr, '#104', 'ISUFEmit', 8, 9, 0,
                                             NFGas.Emit.ISUFEmit, DSC_ISUFEMIT));
end;

function TNFGasXmlWriter.Gerar_EmitEnderEmit: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('enderEmit');

  Result.AppendChild(AddNode(tcStr, '#32', 'xLgr', 2, 60, 1, NFGas.Emit.EnderEmit.xLgr, 'Logradouro'));
  Result.AppendChild(AddNode(tcStr, '#33', 'nro', 1, 60, 1, NFGas.Emit.EnderEmit.nro, 'Número'));
  Result.AppendChild(AddNode(tcStr, '#34', 'xCpl', 1, 60, 0, NFGas.Emit.EnderEmit.xCpl, 'Complemento'));
  Result.AppendChild(AddNode(tcStr, '#35', 'xBairro', 2, 60, 1, NFGas.Emit.EnderEmit.xBairro, 'Bairro'));
  Result.AppendChild(AddNode(tcInt, '#36', 'cMun', 7, 7, 1, NFGas.Emit.EnderEmit.cMun, 'Código do município'));
  Result.AppendChild(AddNode(tcStr, '#37', 'xMun', 2, 60, 1, NFGas.Emit.EnderEmit.xMun, 'Município'));
  Result.AppendChild(AddNode(tcInt, '#38', 'CEP', 8, 8, 0, NFGas.Emit.EnderEmit.CEP, 'CEP'));
  Result.AppendChild(AddNode(tcStr, '#39', 'UF', 2, 2, 1, NFGas.Emit.EnderEmit.UF, 'UF'));
  Result.AppendChild(AddNode(tcStr, '#40', 'fone', 7, 12, 0, OnlyNumber(NFGas.Emit.EnderEmit.fone), 'Telefone'));
  Result.AppendChild(AddNode(tcStr, '#41', 'email', 1, 60, 0, NFGas.Emit.EnderEmit.email, 'Email'));
end;

function TNFGasXmlWriter.Gerar_Dest: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('dest');

  Result.AppendChild(AddNode(tcStr, '#43', 'xNome', 2, 60, 1, NFGas.Dest.xNome, 'Nome do destinatário'));

  if Trim(NFGas.Dest.idOutros) <> '' then
  begin
    Result.AppendChild(AddNode(tcStr, '#46', 'idOutros', 2, 20, 1, NFGas.Dest.idOutros, 'Identificador do destinatario outros'));
  end
  else
  begin
    Result.AppendChild(AddNodeCNPJCPF('#44', '#45', NFGas.Dest.CNPJCPF));
  end;

  Result.AppendChild(AddNode(tcStr, '#47', 'IE', 0, 14, 0, NFGas.Dest.IE, 'IE do destinatário'));
  Result.AppendChild(AddNode(tcStr, '#48', 'IM', 1, 15, 0, NFGas.Dest.IM, 'IM do destinatario'));

  if Trim(NFGas.Dest.cNIS) <> '' then
  begin
    Result.AppendChild(AddNode(tcStr, '#49', 'cNIS', 1, 15, 0, NFGas.Dest.cNIS, 'Numero da identificacao social'));
  end
  else if Trim(NFGas.Dest.NB) <> '' then
  begin
    Result.AppendChild(AddNode(tcStr, '#50', 'NB', 1, 10, 0, NFGas.Dest.NB, 'Numero do beneficio'));
  end;

  Result.AppendChild(AddNode(tcStr, '#51', 'xNomeAdicional', 2, 60, 0, NFGas.Dest.xNomeAdicional, 'Nome adicional do destinatario'));

  Result.AppendChild(Gerar_DestEnderDest);
end;

function TNFGasXmlWriter.Gerar_DestEnderDest: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('enderDest');

  Result.AppendChild(AddNode(tcStr, '#53', 'xLgr', 2, 60, 1, NFGas.Dest.EnderDest.xLgr, 'Logradouro'));
  Result.AppendChild(AddNode(tcStr, '#54', 'nro', 1, 60, 1, NFGas.Dest.EnderDest.nro, 'Número'));
  Result.AppendChild(AddNode(tcStr, '#55', 'xCpl', 1, 60, 0, NFGas.Dest.EnderDest.xCpl, 'Complemento'));
  Result.AppendChild(AddNode(tcStr, '#56', 'xBairro', 1, 60, 1, NFGas.Dest.EnderDest.xBairro, 'Bairro'));
  Result.AppendChild(AddNode(tcInt, '#57', 'cMun', 7, 7, 1, NFGas.Dest.EnderDest.cMun, 'Código do município'));
  Result.AppendChild(AddNode(tcStr, '#58', 'xMun', 2, 60, 1, NFGas.Dest.EnderDest.xMun, 'Município'));
  Result.AppendChild(AddNode(tcInt, '#59', 'CEP', 8, 8, 0, NFGas.Dest.EnderDest.CEP, 'CEP'));
  Result.AppendChild(AddNode(tcStr, '#60', 'UF', 2, 2, 1, NFGas.Dest.EnderDest.UF, 'UF'));
  Result.AppendChild(AddNode(tcStr, '#61', 'fone', 7, 12, 0, OnlyNumber(NFGas.Dest.EnderDest.fone), 'Telefone'));
  Result.AppendChild(AddNode(tcStr, '#62', 'email', 1, 60, 0, NFGas.Dest.EnderDest.email, 'Email'));
end;

function TNFGasXmlWriter.Gerar_Instalacao: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('instalacao');

  Result.AppendChild(AddNode(tcStr, '#64', 'idInstalacao', 1, 15, 1, NFGas.Instalacao.idInstalacao, 'Identificacao da instalacao'));
  Result.AppendChild(AddNode(tcStr, '#65', 'idCodCliente', 2, 20, 0, NFGas.Instalacao.idCodCliente, 'Codigo do cliente'));
  Result.AppendChild(AddNode(tcStr, '#66', 'tpInstalacao', 1, 1, 1, InstalacaoToStr(NFGas.Instalacao.tpInstalacao), 'Tipo da instalacao'));
  Result.AppendChild(AddNode(tcStr, '#67', 'nContrato', 1, 20, 0, NFGas.Instalacao.nContrato, 'Numero do contrato'));
  Result.AppendChild(AddNode(tcStr, '#68', 'tpClasse', 2, 2, 1, ClasseToStr(NFGas.Instalacao.tpClasse), 'Classe de consumo'));
  Result.AppendChild(AddNode(tcStr, '#69', 'xClasse', 1, 200, 0, NFGas.Instalacao.xClasse, 'Detalhamento da classe'));

  if (Trim(NFGas.Instalacao.latGPS) <> '') and (Trim(NFGas.Instalacao.longGPS) <> '') then
  begin
    Result.AppendChild(AddNode(tcStr, '#71', 'latGPS', 2, 15, 1, NFGas.Instalacao.latGPS, 'Latitude'));
    Result.AppendChild(AddNode(tcStr, '#72', 'longGPS', 2, 15, 1, NFGas.Instalacao.longGPS, 'Longitude'));
  end;

  Result.AppendChild(AddNode(tcStr, '#73', 'codRoteiroLeitura', 2, 100, 0, NFGas.Instalacao.codRoteiroLeitura, 'Roteiro de leitura'));
end;

function TNFGasXmlWriter.Gerar_gSub: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gSub');

  if Trim(NFGas.gSub.chNFGas) <> '' then
    Result.AppendChild(AddNode(tcStr, '#75', 'chNFGas', 44, 44, 1, NFGas.gSub.chNFGas, 'Chave da NFGas referenciada'))
  else
    Result.AppendChild(Gerar_gNF);

  Result.AppendChild(AddNode(tcStr, '#83', 'motSub', 2, 2, 1,
                     MotSubToStr(NFGas.gSub.motSub), 'Motivo da substituicao'));
end;

function TNFGasXmlWriter.Gerar_gNF: TACBrXmlNode;
var
  CompetEmis: string;
  CompetApur: string;
begin
  CompetEmis := '';
  CompetApur := '';

  if NFGas.gSub.gNF.CompetEmis > 0 then
  begin
    CompetEmis := FormatDateTime('yyyymm', NFGas.gSub.gNF.CompetEmis);
  end;

  if NFGas.gSub.gNF.CompetApur > 0 then
  begin
    CompetApur := FormatDateTime('yyyymm', NFGas.gSub.gNF.CompetApur);
  end;

  Result := FDocument.CreateElement('gNF');

  Result.AppendChild(AddNode(tcStr, '#77', 'CNPJ', 14, 14, 1, NFGas.gSub.gNF.CNPJ, 'CNPJ do emitente referenciado'));
  Result.AppendChild(AddNode(tcStr, '#78', 'serie', 1, 3, 1, NFGas.gSub.gNF.serie, 'Serie da NF referenciada'));
  Result.AppendChild(AddNode(tcInt, '#79', 'nNF', 1, 9, 1, NFGas.gSub.gNF.nNF, 'Numero da NF referenciada'));
  Result.AppendChild(AddNode(tcStr, '#80', 'CompetEmis', 6, 6, 1, CompetEmis, 'Competencia da emissao'));
  Result.AppendChild(AddNode(tcStr, '#81', 'CompetApur', 6, 6, 1, CompetApur, 'Competencia da apuracao'));
  Result.AppendChild(AddNode(tcStr, '#82', 'hash115', 32, 32, 0, NFGas.gSub.gNF.hash115, 'Hash do convenio 115'));
end;

function TNFGasXmlWriter.Gerar_gVolContrat: TACBrXmlNodeArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, NFGas.gVolContrat.Count);

  for I := 0 to NFGas.gVolContrat.Count - 1 do
  begin
    Result[I] := FDocument.CreateElement('gVolContrat');

    Result[I].SetAttribute('nContrat', FormatFloat('00', NFGas.gVolContrat[I].nContrat));
    Result[I].AppendChild(AddNode(tcStr, '#86', 'tpVolContrat', 1, 1, 1, VolContratToStr(NFGas.gVolContrat[I].tpVolContrat), 'Tipo do volume contratado'));
    Result[I].AppendChild(AddNode(tcDe6, '#87', 'qUnidContrat', 1, 15, 1, NFGas.gVolContrat[I].qUnidContrat, 'Quantidade contratada'));
  end;

  if NFGas.gVolContrat.Count > 20 then
    wAlerta('#85', 'gVolContrat', '', ERR_MSG_MAIOR_MAXIMO + '20');
end;

function TNFGasXmlWriter.Gerar_gMed: TACBrXmlNodeArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, NFGas.gMed.Count);

  for I := 0 to NFGas.gMed.Count - 1 do
  begin
    Result[I] := FDocument.CreateElement('gMed');

    Result[I].SetAttribute('nMed', FormatFloat('00', NFGas.gMed[I].nMed));
    Result[I].AppendChild(AddNode(tcStr, '#90', 'idEqp', 2, 20, 1, NFGas.gMed[I].idEqp, 'Identificacao do equipamento'));
    Result[I].AppendChild(AddNode(tcDat, '#91', 'dMedAnt', 10, 10, 1, NFGas.gMed[I].dMedAnt, 'Data da leitura anterior'));
    Result[I].AppendChild(AddNode(tcDe4, '#92', 'vMedAnt', 1, 15, 1, NFGas.gMed[I].vMedAnt, 'Valor da leitura anterior'));
    Result[I].AppendChild(AddNode(tcDat, '#93', 'dMedAtu', 10, 10, 1, NFGas.gMed[I].dMedAtu, 'Data da leitura atual'));
    Result[I].AppendChild(AddNode(tcDe4, '#94', 'vMedAtu', 1, 15, 1, NFGas.gMed[I].vMedAtu, 'Valor da leitura atual'));
    Result[I].AppendChild(AddNode(tcStr, '#95', 'tpEqp', 1, 1, 1, tpEqpToStr(NFGas.gMed[I].tpEqp), 'Tipo do equipamento'));
    Result[I].AppendChild(AddNode(tcStr, '#96', 'tpMedidor', 1, 1, 0, tpMedidorToStr(NFGas.gMed[I].tpMedidor), 'Tipo do medidor'));
  end;

  if NFGas.gMed.Count > 99 then
    wAlerta('#85', 'gMed', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFGasXmlWriter.Gerar_det: TACBrXmlNodeArray;
var
  I: Integer;
begin
  Result := nil;
  SetLength(Result, NFGas.Det.Count);

  for I := 0 to NFGas.Det.Count - 1 do
  begin
    Result[I] := FDocument.CreateElement('det');
    Result[I].SetAttribute('nItem', FormatFloat('###0', NFGas.Det[I].nItem));

    if Trim(NFGas.Det[I].chNFGasAnt) <> '' then
      Result[I].SetAttribute('chNFGasAnt', NFGas.Det[I].chNFGasAnt);

    if NFGas.Det[I].nItemAnt > 0 then
      Result[I].SetAttribute('nItemAnt', FormatFloat('###0', NFGas.Det[I].nItemAnt));

    if (Trim(NFGas.Det[I].gAgregadora.cClass) <> '') or
       (NFGas.Det[I].gAgregadora.vTotDFe > 0) then
      Result[I].AppendChild(Gerar_det_gAgregadora(NFGas.Det[i].gAgregadora))
    else
      Result[I].AppendChild(Gerar_det_gNormal(NFGas.Det[i].gNormal))
  end;

  if NFGas.Det.Count > 990 then
    wAlerta('#85', 'Det', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

function TNFGasXmlWriter.Gerar_det_gNormal(gNormal: TgNormal): TACBrXmlNode;
var
  NodeArray: TACBrXmlNodeArray;
  I: Integer;
begin
  Result := FDocument.CreateElement('gNormal');

  NodeArray := Gerar_det_gTarif(gNormal.gTarif);
  for I := 0 to gNormal.gTarif.Count - 1 do
  begin
    Result.AppendChild(NodeArray[I]);
  end;

  Result.AppendChild(Gerar_det_prod(gNormal.Prod));
  Result.AppendChild(Gerar_det_imposto(gNormal.Imposto));
  Result.AppendChild(Gerar_det_gProcRef(gNormal.gProcRef));

  if Trim(gNormal.infAdProd) <> '' then
    Result.AppendChild(AddNode(tcStr, '#343', 'infAdProd', 1, 500, 0, gNormal.infAdProd, 'Informacoes adicionais do produto'));
end;

function TNFGasXmlWriter.Gerar_det_gTarif(gTarif: TgTarifCollection): TACBrXmlNodeArray;
var
  I: Integer;
begin
  Result := nil;

  SetLength(Result, gTarif.Count);

  for I := 0 to gTarif.Count - 1 do
  begin
    Result[I] := FDocument.CreateElement('gTarif');

    Result[I].AppendChild(AddNode(tcDat, '#103', 'dIniTarif', 10, 10, 1,
      gTarif[I].dIniTarif, 'Data de inicio da aplicacao da tarifa'));

    Result[I].AppendChild(AddNode(tcDat, '#104', 'dFimTarif', 10, 10, 0,
        gTarif[I].dFimTarif, 'Data de fim da aplicacao da tarifa'));

    Result[I].AppendChild(AddNode(tcStr, '#105', 'nAto', 4, 4, 1,
      gTarif[I].nAto, 'Numero do ato'));
    Result[I].AppendChild(AddNode(tcInt, '#106', 'anoAto', 4, 4, 1,
      gTarif[I].anoAto, 'Ano do ato'));
    Result[I].AppendChild(AddNode(tcStr, '#107', 'tpFaixaCons', 1, 1, 1,
         tpFaixaConsToStr(gTarif[I].tpFaixaCons), 'Faixa prevista de consumo'));
    Result[I].AppendChild(AddNode(tcDe8, '#108', 'vTarifAplic', 1, 17, 1,
      gTarif[I].vTarifAplic, 'Valor da tarifa aplicada'));
  end;

  if gTarif.Count > 6 then
    wAlerta('#102', 'gTarif', '', ERR_MSG_MAIOR_MAXIMO + '6');
end;

function TNFGasXmlWriter.Gerar_det_prod(prod: Tprod): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('prod');

  Result.AppendChild(AddNode(tcStr, '#110', 'indOrigemQtd', 1, 1, 1, prod.indOrigemQtd, 'Indicador da origem da quantidade faturada'));

  if (prod.gMedicao.nMed > 0) and (prod.gMedicao.gMedida.vMed > 0) then
    Result.AppendChild(Gerar_det_prod_gMedicao(prod.gMedicao));

  Result.AppendChild(AddNode(tcStr, '#119', 'cProd', 1, 60, 1, prod.cProd, 'Código do produto'));
  Result.AppendChild(AddNode(tcStr, '#120', 'xProd', 1, 120, 1, prod.xProd, 'Descrição do produto'));
  Result.AppendChild(AddNode(tcStr, '#121', 'cClass', 1, 20, 0, prod.cClass, 'Classificação do item'));
  Result.AppendChild(AddNode(tcInt, '#122', 'CFOP', 4, 4, 0, prod.CFOP, 'CFOP'));
  Result.AppendChild(AddNode(tcStr, '#123', 'uMed', 1, 3, 1, uMedItemToStr(prod.uMed), 'Unidade de medida'));
  Result.AppendChild(AddNode(tcDe4, '#124', 'qFaturada', 1, 15, 1, prod.qFaturada, 'Quantidade faturada'));
  Result.AppendChild(AddNode(tcDe8, '#125', 'vItem', 1, 15, 1, prod.vItem, 'Valor unitário do item'));
  Result.AppendChild(AddNode(tcDe4, '#126', 'fatorPCS', 1, 15, 0, prod.fatorPCS, 'Fator de poder calorífico'));
  Result.AppendChild(AddNode(tcDe4, '#127', 'fatorPTZ', 1, 15, 0, prod.fatorPTZ, 'Fator de correção'));
  Result.AppendChild(AddNode(tcDe4, '#128', 'fatorP', 1, 15, 0, prod.fatorP, 'Fator de correção de pressão'));
  Result.AppendChild(AddNode(tcDe4, '#129', 'fatorT', 1, 15, 0, prod.fatorT, 'Fator de correção de temperatura'));
  Result.AppendChild(AddNode(tcDe8, '#130', 'vProd', 1, 15, 1, prod.vProd, 'Valor do produto'));

  if prod.indDevolucao = tiSim then
    Result.AppendChild(AddNode(tcStr, '#131', 'indDevolucao', 1, 1, 1, '1', 'Indicador de devolução do valor do item'));

  if prod.gPagAntecipado.chDFePagAnt <> '' then
    Result.AppendChild(Gerar_gPagAntecipadoProd(prod.gPagAntecipado));
end;

function TNFGasXmlWriter.Gerar_det_prod_gMedicao(gMedicao: TgMedicao): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMedicao');

  Result.AppendChild(AddNode(tcStr, '#112', 'nMed', 2, 2, 1,
    FormatFloat('00', gMedicao.nMed), 'Referência para a medição ao qual se refere o item'));

  Result.AppendChild(AddNode(tcStr, '#113', 'nContrat', 2, 2, 0,
      FormatFloat('00', gMedicao.nContrat), 'Referência para o grupo de demanda contratada ao qual se refere o item'));

  if gMedicao.gMedida.vMed > 0 then
  begin
    Result.AppendChild(Gerar_det_prod_gMedida(gMedicao.gMedida));
  end
  else
  begin
    Result.AppendChild(AddNode(tcStr, '#117', 'tpMotNaoLeitura', 1, 1, 1,
      gMedicao.tpMotNaoLeitura, 'Tipo motivo da não leitura'));

    Result.AppendChild(AddNode(tcStr, '#118', 'xMotNaoLeitura', 1, 200, 0,
        gMedicao.xMotNaoLeitura, 'Detalhamento do motivo da não leitura'));
  end;
end;

function TNFGasXmlWriter.Gerar_det_prod_gMedida(gMedida: TgMedida): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMedida');

  Result.AppendChild(AddNode(tcStr, '#115', 'uMed', 1, 1, 1,
                          uMedToStr(gMedida.uMed), 'Unidade básica de medida'));
  Result.AppendChild(AddNode(tcDe4, '#116', 'vMed', 1, 15, 1,
                                             gMedida.vMed, 'Valor da medição'));
end;

function TNFGasXmlWriter.Gerar_det_imposto(imposto: Timposto): TACBrXmlNode;

  function ICMS00(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS00');

    Result.AppendChild(AddNode(tcStr, '#135', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    Result.AppendChild(AddNode(tcDe2, '#136', 'vBC', 1, 15, 1, imposto.ICMS.vBC, 'Base de cálculo do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#137', 'pICMS', 1, 7, 1, imposto.ICMS.pICMS, 'Alíquota do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#138', 'vICMS', 1, 15, 1, imposto.ICMS.vICMS, 'Valor do ICMS'));

    if (imposto.ICMS.pFCP > 0) or (imposto.ICMS.vFCP > 0) then
    begin
      Result.AppendChild(AddNode(tcDe4, '#140', 'pFCP', 1, 7, 0, imposto.ICMS.pFCP, 'Percentual do FCP'));
      Result.AppendChild(AddNode(tcDe2, '#141', 'vFCP', 1, 15, 0, imposto.ICMS.vFCP, 'Valor do FCP'));
    end;
  end;

  function ICMS10(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS10');

    Result.AppendChild(AddNode(tcStr, '#143', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    Result.AppendChild(AddNode(tcDe2, '#144', 'vBCST', 1, 15, 1, imposto.ICMS.vBCST, 'Base de cálculo do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#145', 'pICMSST', 1, 7, 1, imposto.ICMS.pICMSST, 'Alíquota do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#146', 'vICMSST', 1, 15, 1, imposto.ICMS.vICMSST, 'Valor do ICMS'));

    if (imposto.ICMS.pFCPST > 0) or (imposto.ICMS.vFCPST > 0) then
    begin
      Result.AppendChild(AddNode(tcDe4, '#148', 'pFCPST', 1, 7, 0, imposto.ICMS.pFCPST, 'Percentual do FCP'));
      Result.AppendChild(AddNode(tcDe2, '#149', 'vFCPST', 1, 15, 0, imposto.ICMS.vFCPST, 'Valor do FCP'));
    end;
  end;

  function ICMS20(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS20');

    Result.AppendChild(AddNode(tcStr, '#151', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    Result.AppendChild(AddNode(tcDe2, '#152', 'pRedBC', 1, 5, 0, imposto.ICMS.pRedBC, 'Percentual de redução da base de cálculo'));
    Result.AppendChild(AddNode(tcDe2, '#153', 'vBC', 1, 15, 1, imposto.ICMS.vBC, 'Base de cálculo do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#154', 'pICMS', 1, 7, 1, imposto.ICMS.pICMS, 'Alíquota do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#155', 'vICMS', 1, 15, 1, imposto.ICMS.vICMS, 'Valor do ICMS'));

    if imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#157', 'vICMSDeson', 1, 15, 0, imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcStr, '#158', 'cBenef', 8, 10, 0, imposto.ICMS.cBenef, 'Código de Benefício Fiscal na UF'));
    end;

    if (imposto.ICMS.pFCP > 0) or (imposto.ICMS.vFCP > 0) then
    begin
      Result.AppendChild(AddNode(tcDe4, '#160', 'pFCP', 1, 7, 0, imposto.ICMS.pFCP, 'Percentual do FCP'));
      Result.AppendChild(AddNode(tcDe2, '#161', 'vFCP', 1, 15, 0, imposto.ICMS.vFCP, 'Valor do FCP'));
    end;
  end;

  function ICMS40(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS40');

    Result.AppendChild(AddNode(tcStr, '#163', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    if imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#157', 'vICMSDeson', 1, 15, 0, imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcStr, '#158', 'cBenef', 8, 10, 0, imposto.ICMS.cBenef, 'Código de Benefício Fiscal na UF'));
    end;
  end;

  function ICMS51(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS51');

    Result.AppendChild(AddNode(tcStr, '#168', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    if imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#170', 'vICMSDeson', 1, 15, 0, imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcStr, '#171', 'cBenef', 8, 10, 0, imposto.ICMS.cBenef, 'Código de Benefício Fiscal na UF'));
    end;
  end;

  function ICMS60(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS60');

    Result.AppendChild(AddNode(tcStr, '#173', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    if (imposto.ICMS.vBCSTRet > 0) or (imposto.ICMS.pICMSSTRet > 0) or
       (imposto.ICMS.vICMSSubstituto > 0) or (imposto.ICMS.vICMSSTRet > 0) or
       (imposto.ICMS.vBCFCPSTRet > 0) or (imposto.ICMS.pFCPSTRet > 0) or
       (imposto.ICMS.vFCPSTRet > 0) then
    begin
      Result.AppendChild(AddNode(tcDe2, '#174', 'vBCSTRet', 1, 15, 0, imposto.ICMS.vBCSTRet, 'Valor da BC do ICMS ST retido anteriormente'));
      Result.AppendChild(AddNode(tcDe2, '#175', 'pICMSSTRet', 1, 7, 0, imposto.ICMS.pICMSSTRet, 'Aliquota suportada pelo consumidor final'));

      Result.AppendChild(AddNode(tcDe2, '#176', 'vICMSSubstituto', 1, 15, 0, imposto.ICMS.vICMSSubstituto, 'Valor do ICMS próprio do substituto'));

      Result.AppendChild(AddNode(tcDe2, '#177', 'vICMSSTRet', 1, 15, 0, imposto.ICMS.vICMSSTRet, 'Valor do ICMS ST retido anteriormente'));

      if (imposto.ICMS.vBCFCPSTRet > 0) or (imposto.ICMS.pFCPSTRet > 0) or
         (imposto.ICMS.vFCPSTRet > 0) then
      begin
        Result.AppendChild(AddNode(tcDe2, '#179', 'vBCFCPSTRet', 1, 15, 0, imposto.ICMS.vBCFCPSTRet, 'Base de cálculo do FCP ST retido anteriormente'));
        Result.AppendChild(AddNode(tcDe2, '#180', 'pFCPSTRet', 1, 7, 0, imposto.ICMS.pFCPSTRet, 'Percentual do FCP ST retido anteriormente'));
        Result.AppendChild(AddNode(tcDe2, '#181', 'vFCPSTRet', 1, 15, 0, imposto.ICMS.vFCPSTRet, 'Valor do FCP ST retido anteriormente'));
      end;
    end
    else
    begin
      if (imposto.ICMS.pRedBCEfet > 0) or (imposto.ICMS.vBCEfet > 0) or
         (imposto.ICMS.pICMSEfet > 0) or (imposto.ICMS.vICMSEfet > 0) then
      begin
        Result.AppendChild(AddNode(tcDe2, '#182', 'pRedBCEfet', 1, 7, 1, imposto.ICMS.pRedBCEfet, 'Percentual de redução da base de cálculo efetiva'));
        Result.AppendChild(AddNode(tcDe2, '#183', 'vBCEfet', 1, 15, 1, imposto.ICMS.vBCEfet, 'Valor da base de cálculo efetiva'));
        Result.AppendChild(AddNode(tcDe2, '#184', 'pICMSEfet', 1, 7, 1, imposto.ICMS.pICMSEfet, 'Aliquota do ICMS efetiva'));
        Result.AppendChild(AddNode(tcDe2, '#185', 'vICMSEfet', 1, 15, 1, imposto.ICMS.vICMSEfet, 'Valor do ICMS efetivo'));
      end;
    end;

    if imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#170', 'vICMSDeson', 1, 15, 0, imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcStr, '#171', 'cBenef', 8, 10, 0, imposto.ICMS.cBenef, 'Código de Benefício Fiscal na UF'));
    end;
  end;

  function ICMS70(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS70');

    Result.AppendChild(AddNode(tcStr, '#190', 'CST', 2, 2, 1, CSTICMSToStr(imposto.ICMS.CST), 'Código da situação tributária'));

    Result.AppendChild(AddNode(tcStr, '#191', 'modBC', 1, 1, 1, modbctostr(imposto.ICMS.modBC), 'Modalidade de determinação da BC do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#192', 'pRedBC', 1, 5, 1, imposto.ICMS.pRedBC, 'Percentual de redução da base de cálculo'));
    Result.AppendChild(AddNode(tcDe2, '#193', 'vBC', 1, 15, 1, imposto.ICMS.vBC, 'Base de cálculo do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#194', 'pICMS', 1, 7, 1, imposto.ICMS.pICMS, 'Alíquota do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#195', 'vICMS', 1, 15, 1, imposto.ICMS.vICMS, 'Valor do ICMS'));

    if (imposto.ICMS.vBCFCP > 0) or
       (imposto.ICMS.pFCP > 0) or
       (imposto.ICMS.vFCP > 0) then
    begin
      Result.AppendChild(AddNode(tcDe2, '#197', 'vBCFCP', 1, 15, 0, imposto.ICMS.vBCFCP, 'Valor da Base de cálculo do FCP'));
      Result.AppendChild(AddNode(tcDe4, '#198', 'pFCP', 1, 7, 0, imposto.ICMS.pFCP, 'Percentual do FCP'));
      Result.AppendChild(AddNode(tcDe2, '#199', 'vFCP', 1, 15, 0, imposto.ICMS.vFCP, 'Valor do FCP'));
    end;

    Result.AppendChild(AddNode(tcStr, '#200', 'modBCST', 1, 1, 1, imposto.ICMS.modBCST, 'Modalidade de determinação da BC do ICMS ST'));

    if imposto.ICMS.pMVAST > 0 then
      Result.AppendChild(AddNode(tcDe2, '#201', 'pMVAST', 1, 7, 0, imposto.ICMS.pMVAST, 'Percentual da Margem de Valor Adicionado ICMS ST'));

    if imposto.ICMS.pRedBCST > 0 then
      Result.AppendChild(AddNode(tcDe2, '#202', 'pRedBCST', 1, 7, 0, imposto.ICMS.pRedBCST, 'Percentual de redução da BC ICMS ST'));

    Result.AppendChild(AddNode(tcDe2, '#203', 'vBCST', 1, 15, 1, imposto.ICMS.vBCST, 'Valor da BC do ICMS ST'));
    Result.AppendChild(AddNode(tcDe2, '#204', 'pICMSST', 1, 7, 1, imposto.ICMS.pICMSST, 'Alíquota do ICMS ST'));
    Result.AppendChild(AddNode(tcDe2, '#205', 'vICMSST', 1, 15, 1, imposto.ICMS.vICMSST, 'Valor do ICMS ST'));

    if (imposto.ICMS.vBCFCPST > 0) or
       (imposto.ICMS.pFCPST > 0) or
       (imposto.ICMS.vFCPST > 0) then
    begin
      Result.AppendChild(AddNode(tcDe2, '#207', 'vBCFCPST', 1, 15, 0, imposto.ICMS.vBCFCPST, 'Valor da Base de cálculo do FCP retido por substituição tributária'));
      Result.AppendChild(AddNode(tcDe2, '#208', 'pFCPST', 1, 7, 0, imposto.ICMS.pFCPST, 'Percentual de FCP retido por substituição tributária'));
      Result.AppendChild(AddNode(tcDe2, '#209', 'vFCPST', 1, 15, 0, imposto.ICMS.vFCPST, 'Valor do FCP retido por substituição tributária'));
    end;

    if imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#211', 'vICMSDeson', 1, 15, 0, imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcInt, '#212', 'motDesICMS', 1, 2, 0, imposto.ICMS.motDesICMS, 'Motivo da desoneração do ICMS'));

      if imposto.ICMS.indDeduzDeson = tieSim then
        Result.AppendChild(AddNode(tcStr, '#213', 'indDeduzDeson', 1, 1, 0, TIndicadorExToStr(imposto.ICMS.indDeduzDeson), 'Indicador de dedução do ICMS desonerado'));
    end;

    if imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#157', 'vICMSDeson', 1, 15, 0, imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcStr, '#158', 'cBenef', 8, 10, 0, imposto.ICMS.cBenef, 'Código de Benefício Fiscal na UF'));
    end;
  end;

  function ICMS90(ICMS: TICMS): TACBrXmlNode;
  begin
    Result := FDocument.CreateElement('ICMS90');

    Result.AppendChild(AddNode(tcStr, '#218', 'CST', 2, 2, 1, CSTICMSToStr(Imposto.ICMS.CST), 'Código da situação tributária'));
    Result.AppendChild(AddNode(tcDe2, '#220', 'vBC', 1, 15, 0, Imposto.ICMS.vBC, 'Base de cálculo do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#221', 'pICMS', 1, 7, 0, Imposto.ICMS.pICMS, 'Alíquota do ICMS'));
    Result.AppendChild(AddNode(tcDe2, '#222', 'vICMS', 1, 15, 0, Imposto.ICMS.vICMS, 'Valor do ICMS'));

    if Imposto.ICMS.vICMSDeson > 0 then
    begin
      Result.AppendChild(AddNode(tcDe2, '#224', 'vICMSDeson', 1, 15, 0, Imposto.ICMS.vICMSDeson, 'Valor do ICMS desonerado'));
      Result.AppendChild(AddNode(tcStr, '#225', 'cBenef', 8, 10, 0, Imposto.ICMS.cBenef, 'Código de Benefício Fiscal na UF'));
    end;

    if (Imposto.ICMS.pFCP > 0) or
       (Imposto.ICMS.vFCP > 0) then
    begin
      Result.AppendChild(AddNode(tcDe4, '#227', 'pFCP', 1, 7, 0, Imposto.ICMS.pFCP, 'Percentual do FCP'));
      Result.AppendChild(AddNode(tcDe2, '#228', 'vFCP', 1, 15, 0, Imposto.ICMS.vFCP, 'Valor do FCP'));
    end;
  end;
begin
  Result := FDocument.CreateElement('imposto');

  if imposto.indSemCST = tiSim then
    Result.AppendChild(AddNode(tcStr, '#229', 'indSemCST', 1, 1, 0, TIndicadorToStr(imposto.indSemCST), 'Indicador sem CST'))
  else //if Trim(NFGas.Det[ADet].ICMS.CST) <> '' then
  begin
    Result.AppendChild(AddNode(tcStr, '#133', 'orig', 1, 1, 1, imposto.Orig, 'Origem'));

    case imposto.ICMS.CST of
      cst00: Result.AppendChild(ICMS00(imposto.ICMS));
      cst10: Result.AppendChild(ICMS10(imposto.ICMS));
      cst20: Result.AppendChild(ICMS20(imposto.ICMS));
      cst40,
      cst41: Result.AppendChild(ICMS40(imposto.ICMS));
      cst51: Result.AppendChild(ICMS51(imposto.ICMS));
      cst60: Result.AppendChild(ICMS60(imposto.ICMS));
      cst70: Result.AppendChild(ICMS70(imposto.ICMS));
      cst90: Result.AppendChild(ICMS90(imposto.ICMS));
    else
      begin
        Result := nil;
        wAlerta('#132', 'ICMS', CSTICMSToStr(Imposto.ICMS.CST),
          'CST de ICMS nao suportado pelo leiaute atual da NFGas.');
      end;
    end;
  end;

  Result.AppendChild(Gerar_IBSCBS(imposto.IBSCBS));
  Result.AppendChild(Gerar_det_imposto_PIS(imposto.PIS));
  Result.AppendChild(Gerar_det_imposto_COFINS(imposto.COFINS));
  Result.AppendChild(Gerar_det_imposto_retTrib(imposto.retTrib));
  Result.AppendChild(Gerar_det_imposto_TxReg(imposto.TxReg));
end;

function TNFGasXmlWriter.Gerar_det_imposto_PIS(PIS: TPIS): TACBrXmlNode;
begin
  Result := nil;

  if (PIS.vBC = 0) and (PIS.pPIS = 0) and (PIS.vPIS = 0) then
    Exit;

  Result := FDocument.CreateElement('PIS');

  Result.AppendChild(AddNode(tcStr, '#317', 'CST', 2, 2, 1, CSTPISToStr(PIS.CST), 'Codigo da situacao tributaria do PIS'));
  Result.AppendChild(AddNode(tcDe2, '#318', 'vBC', 1, 15, 1, PIS.vBC, 'Base de calculo do PIS'));
  Result.AppendChild(AddNode(tcDe4, '#319', 'pPIS', 1, 7, 1, PIS.pPIS, 'Aliquota do PIS'));
  Result.AppendChild(AddNode(tcDe2, '#320', 'vPIS', 1, 15, 1, PIS.vPIS, 'Valor do PIS'));
end;

function TNFGasXmlWriter.Gerar_det_imposto_COFINS(COFINS: TCOFINS): TACBrXmlNode;
begin
  Result := nil;

  if (COFINS.vBC = 0) and (COFINS.pCOFINS = 0) and (COFINS.vCOFINS = 0) then
    Exit;

  Result := FDocument.CreateElement('COFINS');

  Result.AppendChild(AddNode(tcStr, '#322', 'CST', 2, 2, 1, CSTCOFINSToStr(COFINS.CST), 'Codigo da situacao tributaria da COFINS'));
  Result.AppendChild(AddNode(tcDe2, '#323', 'vBC', 1, 15, 1, COFINS.vBC, 'Base de calculo da COFINS'));
  Result.AppendChild(AddNode(tcDe4, '#324', 'pCOFINS', 1, 7, 1, COFINS.pCOFINS, 'Aliquota da COFINS'));
  Result.AppendChild(AddNode(tcDe2, '#325', 'vCOFINS', 1, 15, 1, COFINS.vCOFINS, 'Valor da COFINS'));
end;

function TNFGasXmlWriter.Gerar_det_imposto_retTrib(retTrib: TretTrib): TACBrXmlNode;
begin
  Result := nil;

  if (RetTrib.vRetPIS = 0) and (RetTrib.vRetCOFINS = 0) and (RetTrib.vRetCSLL = 0) and
     (RetTrib.vIRRF = 0) then
    Exit;

  Result := FDocument.CreateElement('retTrib');

  Result.AppendChild(AddNode(tcDe2, '#327', 'vRetPIS', 1, 15, 1, RetTrib.vRetPIS, 'Valor do PIS retido'));
  Result.AppendChild(AddNode(tcDe2, '#328', 'vRetCofins', 1, 15, 1, RetTrib.vRetCOFINS, 'Valor da COFINS retida'));
  Result.AppendChild(AddNode(tcDe2, '#329', 'vRetCSLL', 1, 15, 1, RetTrib.vRetCSLL, 'Valor da CSLL retida'));
  Result.AppendChild(AddNode(tcDe2, '#330', 'vIRRF', 1, 15, 1, RetTrib.vIRRF, 'Valor do IRRF retido'));
end;

function TNFGasXmlWriter.Gerar_det_imposto_TxReg(TxReg: TTxReg): TACBrXmlNode;
begin
  Result := nil;

  if (TxReg.vBC = 0) and (TxReg.pTaxa = 0) and (TxReg.vTaxa = 0) then
    Exit;

  Result := FDocument.CreateElement('TxReg');

  Result.AppendChild(AddNode(tcDe2, '#332', 'vBC', 1, 15, 1, TxReg.vBC, 'Base de calculo da taxa regulatoria'));
  Result.AppendChild(AddNode(tcDe4, '#333', 'pTaxa', 1, 7, 1, TxReg.pTaxa, 'Aliquota da taxa regulatoria'));
  Result.AppendChild(AddNode(tcDe2, '#334', 'vTaxa', 1, 15, 1, TxReg.vTaxa, 'Valor da taxa regulatoria'));
end;

function TNFGasXmlWriter.Gerar_det_gProcRef(gProcRef: TgProcRef): TACBrXmlNode;
var
  I: Integer;
  ProcNodes: TACBrXmlNodeArray;
begin
  Result := nil;

  if (gProcRef.vItem = 0) and (gProcRef.qFaturada = 0) and (gProcRef.vProd = 0) and
     (gProcRef.indDevolucao = tiNao) and (gProcRef.gProc.Count = 0) then
    Exit;

  Result := FDocument.CreateElement('gProcRef');

  Result.AppendChild(AddNode(tcDe8, '#336', 'vItem', 1, 15, 1,
    gProcRef.vItem, 'Valor unitario do item sem influencia da decisao'));

  if Frac(gProcRef.qFaturada) > 0 then
  begin
    Result.AppendChild(AddNode(tcDe4, '#337', 'qFaturada', 1, 15, 1,
      gProcRef.qFaturada, 'Quantidade faturada sem influencia da decisao'));
  end
  else
  begin
    Result.AppendChild(AddNode(tcInt, '#337', 'qFaturada', 1, 15, 1,
      gProcRef.qFaturada, 'Quantidade faturada sem influencia da decisao'));
  end;

  Result.AppendChild(AddNode(tcDe8, '#338', 'vProd', 1, 15, 1,
    gProcRef.vProd, 'Valor total do item sem influencia da decisao'));

  if gProcRef.indDevolucao = tiSim then
  begin
    Result.AppendChild(AddNode(tcStr, '#339', 'indDevolucao', 1, 1, 1, '1',
      'Indicador de devolucao do valor do item'));
  end;

  ProcNodes := Gerar_det_gProcRef_gProc(gProcRef.gProc);
  for I := 0 to Length(ProcNodes) - 1 do
  begin
    Result.AppendChild(ProcNodes[I]);
  end;
end;

function TNFGasXmlWriter.Gerar_det_gProcRef_gProc(gProc: TgProcCollection): TACBrXmlNodeArray;
var
  I: Integer;
begin
  Result := nil;

  SetLength(Result, gProc.Count);

  for I := 0 to gProc.Count - 1 do
  begin
    Result[I] := FDocument.CreateElement('gProc');

    Result[I].AppendChild(AddNode(tcStr, '#341', 'tpProc', 1, 1, 1,
      gProc[I].tpProc, 'Tipo do processo'));
    Result[I].AppendChild(AddNode(tcStr, '#342', 'nProcesso', 1, 60, 1,
      gProc[I].nProcesso, 'Numero do processo'));
  end;

  if gProc.Count > 10 then
    wAlerta('#340', 'gProc', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFGasXmlWriter.Gerar_det_gAgregadora(gAgregadora: TgAgregadora): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gAgregadora');

  Result.AppendChild(AddNode(tcStr, '#345', 'cClass', 7, 7, 1,
    gAgregadora.cClass, 'Codigo de classificacao da nota agregada'));

  Result.AppendChild(AddNode(tcDe2, '#346', 'vTotDFe', 1, 15, 1,
    gAgregadora.vTotDFe, 'Valor total do documento fiscal da nota agregada'));
end;

function TNFGasXmlWriter.Gerar_Total(Total: TTotal): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('total');

  Result.AppendChild(AddNode(tcDe2, '#254', 'vProd', 1, 15, 1,
                                                       Total.vProd, DSC_VPROD));

  Result.AppendChild(Gerar_ICMSTot(Total));
  Result.AppendChild(Gerar_vRetTribTot(Total));

  Result.AppendChild(AddNode(tcDe2, '#268', 'vCOFINS', 1, 15, 1,
                                                   Total.vCOFINS, DSC_VCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#270', 'vPIS', 1, 15, 1,
                                                         Total.vPIS, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#271', 'vTxReg', 1, 15, 1,
                                                       Total.vTxReg, DSC_VTFS));

  Result.AppendChild(AddNode(tcDe2, '#271', 'vNF', 1, 15, 1,
                                                          Total.vNF, DSC_VTFU));

  // Reforma Tributária
  Result.AppendChild(Gerar_IBSCBSTot(Total.IBSCBSTot));

  Result.AppendChild(AddNode(tcDe2, '#250', 'vTotDFe', 1, 15, 0,
                                                   Total.vTotDFe, DSC_VTOTDFE));
end;

function TNFGasXmlWriter.Gerar_ICMSTot(Total: TTotal): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ICMSTot');

  Result.AppendChild(AddNode(tcDe2, 'W03', 'vBC', 01, 15, 1, Total.vBC, DSC_VBC));
  Result.AppendChild(AddNode(tcDe2, 'W04', 'vICMS', 01, 15, 1, Total.vICMS, DSC_VICMS));
  Result.AppendChild(AddNode(tcDe2, 'W04a', 'vICMSDeson', 01, 15, 1, Total.vICMSDeson, DSC_VICMSDESON));
  Result.AppendChild(AddNode(tcDe2, 'W04h', 'vFCP', 01, 15, 1, Total.vFCP, DSC_VFCP));
  Result.AppendChild(AddNode(tcDe2, 'W05', 'vBCST', 01, 15, 1, Total.vBCST, DSC_VBCST));
  Result.AppendChild(AddNode(tcDe2, 'W06', 'vST', 01, 15, 1, Total.vST, DSC_VST));
  Result.AppendChild(AddNode(tcDe2, 'W06a', 'vFCPST', 01, 15, 1, Total.vFCPST, DSC_VFCPST));
end;

function TNFGasXmlWriter.Gerar_vRetTribTot(Total: TTotal): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('vRetTribTot');

  Result.AppendChild(AddNode(tcDe2, '#264', 'vRetPIS', 1, 15, 1,
                                                   Total.vRetPIS, DSC_VRETPIS));

  Result.AppendChild(AddNode(tcDe2, '#265', 'vRetCofins', 1, 15, 1,
                                             Total.vRetCofins, DSC_VRETCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#266', 'vRetCSLL', 1, 15, 1,
                                                 Total.vRetCSLL, DSC_VRETCSLL));

  Result.AppendChild(AddNode(tcDe2, '#267', 'vIRRF', 1, 15, 1,
                                                       Total.vIRRF, DSC_VIRRF));
end;

function TNFGasXmlWriter.Gerar_gFat(gFat: TgFat): TACBrXmlNode;
begin
  Result := nil;

  if gFat.dVencFat <= 0 then
    Exit;

  Result := FDocument.CreateElement('gFat');

  Result.AppendChild(AddNode(tcStr, '#387', 'CompetFat', 6, 6, 1, FormatDateTime('yyyymm', gFat.CompetFat), 'Competência da fatura'));
  Result.AppendChild(AddNode(tcDat, '#388', 'dVencFat', 10, 10, 1, gFat.dVencFat, 'Data de vencimento da fatura'));
  Result.AppendChild(AddNode(tcDat, '#389', 'dApresFat', 10, 10, 0, gFat.dApresFat, 'Data de apresentação da fatura'));
  Result.AppendChild(AddNode(tcDat, '#390', 'dProxLeitura', 10, 10, 1, gFat.dProxLeitura, 'Data prevista da próxima leitura'));
  Result.AppendChild(AddNode(tcStr, '#391', 'nFat', 1, 20, 0, gFat.nFat, 'Número da fatura'));
  Result.AppendChild(AddNode(tcStr, '#392', 'codBarras', 1, 48, 1, gFat.codBarras, 'Código de barras'));

  if Trim(gFat.codDebAuto) <> '' then
  begin
    Result.AppendChild(AddNode(tcStr, '#393', 'codDebAuto', 1, 20, 0, gFat.codDebAuto, 'Código de débito automático'));
  end
  else if (Trim(gFat.codBanco) <> '') and
          (Trim(gFat.codAgencia) <> '') then
  begin
    Result.AppendChild(AddNode(tcStr, '#394', 'codBanco', 3, 5, 0, gFat.codBanco, 'Código do banco'));
    Result.AppendChild(AddNode(tcStr, '#395', 'codAgencia', 1, 10, 0, gFat.codAgencia, 'Código da agência'));
  end
  else if (Trim(gFat.codBanco) <> '') or
          (Trim(gFat.codAgencia) <> '') then
  begin
    wAlerta('#394', 'gFat', '', 'codBanco e codAgencia devem ser informados em conjunto.');
  end;

  if Trim(gFat.enderCorresp.xLgr) <> '' then
  begin
    Result.AppendChild(Gerar_gFat_enderCorresp(gFat.enderCorresp));
  end;

  if Trim(gFat.gPIX.urlQRCodePIX) <> '' then
  begin
    Result.AppendChild(Gerar_gFat_gPix(gFat.gPIX));
  end;

  Result.AppendChild(AddNode(tcStr, '#409', 'infAdFat', 1, 5000, 0, gFat.infAdFat, 'Informacoes adicionais de faturamento'));
end;

function TNFGasXmlWriter.Gerar_gFat_enderCorresp(enderCorresp: Tendereco): TACBrXmlNode;
var
  CodigoMunicipio: Integer;
  Municipio: string;
  UF: string;
begin
  AjustarMunicipioUF(UF, Municipio, CodigoMunicipio, CODIGO_BRASIL,
    enderCorresp.UF, enderCorresp.xMun, enderCorresp.cMun);

  Result := FDocument.CreateElement('enderCorresp');

  Result.AppendChild(AddNode(tcStr, '#397', 'xLgr', 2, 60, 1, enderCorresp.xLgr, 'Logradouro'));
  Result.AppendChild(AddNode(tcStr, '#398', 'nro', 1, 60, 1, enderCorresp.nro, 'Número'));
  Result.AppendChild(AddNode(tcStr, '#399', 'xCpl', 1, 60, 0, enderCorresp.xCpl, 'Complemento'));
  Result.AppendChild(AddNode(tcStr, '#400', 'xBairro', 2, 60, 1, enderCorresp.xBairro, 'Bairro'));
  Result.AppendChild(AddNode(tcInt, '#401', 'cMun', 7, 7, 1, CodigoMunicipio, 'Código do município'));
  Result.AppendChild(AddNode(tcStr, '#402', 'xMun', 2, 60, 1, Municipio, 'Município'));
  Result.AppendChild(AddNode(tcInt, '#403', 'CEP', 8, 8, 1, enderCorresp.CEP, 'CEP'));
  Result.AppendChild(AddNode(tcStr, '#404', 'UF', 2, 2, 1, UF, 'UF'));
  Result.AppendChild(AddNode(tcStr, '#405', 'fone', 7, 12, 0, OnlyNumber(enderCorresp.fone), 'Telefone'));
  Result.AppendChild(AddNode(tcStr, '#406', 'email', 1, 60, 0, enderCorresp.email, 'Email'));
end;

function TNFGasXmlWriter.Gerar_gFat_gPix(gPix: TgPix): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gPIX');

  Result.AppendChild(AddNode(tcStr, '#408', 'urlQRCodePIX', 2, 2000, 1,
                                       gPIX.urlQRCodePIX, 'URL do QRCode PIX'));
end;

function TNFGasXmlWriter.Gerar_gAgencia(gAgencia: TgAgencia): TACBrXmlNode;
var
  HistIndex: Integer;
  NodeHistConsArray: TACBrXmlNodeArray;
begin
  Result := nil;

  if (Trim(gAgencia.nomeAgenciaAtend) = '') and (Trim(gAgencia.enderAgenciaAtend) = '') and
     (Trim(gAgencia.sitioAgenciaAtend) = '') and (Trim(gAgencia.infAdReg) = '') and
     (gAgencia.gHistCons.Count = 0) then
  begin
    Exit;
  end;

  Result := FDocument.CreateElement('gAgencia');

  Result.AppendChild(AddNode(tcStr, '#411', 'nomeAgenciaAtend', 2, 60, 0, gAgencia.nomeAgenciaAtend, 'Nome da agência responsável pelo atendimento'));
  Result.AppendChild(AddNode(tcStr, '#412', 'enderAgenciaAtend', 2, 200, 0, gAgencia.enderAgenciaAtend, 'Endereço da agência responsável pelo atendimento'));
  Result.AppendChild(AddNode(tcStr, '#413', 'sitioAgenciaAtend', 2, 200, 0, gAgencia.sitioAgenciaAtend, 'Sítio eletrônico da agência'));

  NodeHistConsArray := Gerar_gAgencia_gHistCons(gAgencia.gHistCons);
  for HistIndex := 0 to Length(NodeHistConsArray) - 1 do
  begin
    if Assigned(NodeHistConsArray[HistIndex]) then
      Result.AppendChild(NodeHistConsArray[HistIndex]);
  end;

  Result.AppendChild(AddNode(tcStr, '#424', 'infAdReg', 1, 5000, 0, gAgencia.infAdReg, 'Informacoes adicionais de interesse das agencias reguladoras'));
end;

function TNFGasXmlWriter.Gerar_gAgencia_gHistCons(gHistCons: TgHistConsCollection): TACBrXmlNodeArray;
var
  i, j: Integer;
  NodeConsArray: TACBrXmlNodeArray;
begin
  Result := nil;

  SetLength(Result, gHistCons.Count);

  for i := 0 to gHistCons.Count - 1 do
  begin
    if (Trim(gHistCons[i].xHistorico) = '') and
       (gHistCons[i].medMensal = 0) and
       (gHistCons[i].gCons.Count = 0) then
      Continue;

    Result[i] := FDocument.CreateElement('gHistCons');

    Result[i].AppendChild(AddNode(tcStr, '#415', 'xHistorico', 2, 60, 1, gHistCons[i].xHistorico, 'Nome do histórico'));

    NodeConsArray := Gerar_gAgencia_gHistCons_gCons(gHistCons[i].gCons);
    for j := 0 to Length(NodeConsArray) - 1 do
    begin
      if Assigned(NodeConsArray[j]) then
        Result[i].AppendChild(NodeConsArray[j]);
    end;

    Result[i].AppendChild(AddNode(tcDe4, '#423', 'medMensal', 1, 13, 1, gHistCons[i].medMensal, 'Média mensal de consumo'));
  end;

  if gHistCons.Count > 5 then
    wAlerta('#414', 'gHistCons', '', ERR_MSG_MAIOR_MAXIMO + '5');
end;

function TNFGasXmlWriter.Gerar_gAgencia_gHistCons_gCons(gCons: TgConsCollection): TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;

  SetLength(Result, gCons.Count);

  for i := 0 to gCons.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gCons');

    Result[i].AppendChild(AddNode(tcStr, '#387', 'CompetFat', 6, 6, 1, FormatDateTime('yyyymm', gCons[i].CompetFat), 'Competência do faturamento'));
    Result[i].AppendChild(AddNode(tcStr, '#418', 'uMed', 1, 3, 1, uMedToStr(gCons[i].uMed), 'Unidade básica de medida'));
    Result[i].AppendChild(AddNode(tcInt, '#419', 'qtdDias', 1, 3, 1, gCons[i].qtdDias, 'Quantidade de dias de medição'));
    Result[i].AppendChild(AddNode(tcDe4, '#420', 'medDiaria', 1, 13, 0, gCons[i].medDiaria, 'Média diária'));
    Result[i].AppendChild(AddNode(tcDe4, '#421', 'consumo', 1, 13, 0, gCons[i].consumo, 'Consumo no mês'));
    Result[i].AppendChild(AddNode(tcDe4, '#422', 'vFat', 1, 13, 1, gCons[i].vFat, 'Valor faturado'));
  end;

  if gCons.Count > 13 then
    wAlerta('#416', 'gCons', '', ERR_MSG_MAIOR_MAXIMO + '13');
end;

function TNFGasXmlWriter.Gerar_autXML(autXML: TautXMLCollection): TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, autXML.Count);

  for i := 0 to autXML.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('autXML');
    Result[i].AppendChild(AddNodeCNPJCPF('#426', '#427', autXML[i].CNPJCPF));
  end;

  if autXML.Count > 10 then
  begin
    wAlerta('#425', 'autXML', '', ERR_MSG_MAIOR_MAXIMO + '10');
  end;
end;

function TNFGasXmlWriter.Gerar_InfAdic(infAdic: TInfAdic): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infAdic');

  Result.AppendChild(AddNode(tcStr, '#429', 'infAdFisco', 1, 2000, 0, infAdic.infAdFisco, 'Informação adicional ao fisco'));
  { Alterar para ser uma lista com até 5 ocorrências}
  Result.AppendChild(AddNode(tcStr, '#430', 'infCpl', 1, 3000, 0, infAdic.infCpl, 'Informação complementar'));
end;

function TNFGasXmlWriter.Gerar_RespTec(infRespTec: TinfRespTec): TACBrXmlNode;
begin
  Result := nil;

  if (infRespTec.CNPJ <> '') then
  begin
    Result := FDocument.CreateElement('gRespTec');

    Result.AppendChild(AddNodeCNPJ('#311', infRespTec.CNPJ, CODIGO_BRASIL, True));

    Result.AppendChild(AddNode(tcStr, '#312', 'xContato', 2, 60, 1,
      infRespTec.xContato, DSC_XCONTATO));

    Result.AppendChild(AddNode(tcStr, '#313', 'email', 6, 60, 1,
      infRespTec.email, DSC_EMAIL));

    Result.AppendChild(AddNode(tcStr, '#314', 'fone', 7, 12, 1,
      infRespTec.fone, DSC_FONE));

    if (idCSRT <> 0) and (CSRT <> '') then
    begin
      Result.AppendChild(AddNode(tcInt, '#315', 'idCSRT', 3, 3, 1,
         idCSRT, DSC_IDCSRT));

      Result.AppendChild(AddNode(tcStr, '#316', 'hashCSRT', 28, 28, 1,
        CalcularHashCSRT(CSRT, FChaveNFGas), DSC_HASHCSRT));
    end;
  end;
end;

function TNFGasXmlWriter.Gerar_ProcNFGas(procNFGas: TProcDFe): TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('protNFGas');

  Result.SetAttribute('versao', FloatToString(NFGas.infNFGas.Versao, '.', '#0.00'));

  xmlNode := Result.AddChild('infProt');

  xmlNode.AddChild('tpAmb').Content := TipoAmbienteToStr(procNFGas.tpAmb);

  xmlNode.AddChild('verAplic').Content := procNFGas.verAplic;

  xmlNode.AddChild('chNFGas').Content := procNFGas.chDFe;

  xmlNode.AddChild('dhRecbto').Content :=
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', procNFGas.dhRecbto) +
    GetUTC(CodigoUFparaUF(FNFGas.Ide.cUF), procNFGas.dhRecbto);

  xmlNode.AddChild('nProt').Content := procNFGas.nProt;

  xmlNode.AddChild('digVal').Content := procNFGas.digVal;

  xmlNode.AddChild('cStat').Content := IntToStr(procNFGas.cStat);

  xmlNode.AddChild('xMotivo').Content := procNFGas.xMotivo;
end;

procedure TNFGasXmlWriter.AjustarMunicipioUF(out xUF: string; out xMun: string;
  out cMun: Integer; cPais: Integer; const vxUF, vxMun: string; vcMun: Integer);
var
  PaisBrasil: Boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;

  if PaisBrasil then
  begin
    cMun := vcMun;
    xMun := vxMun;
    xUF := vxUF;
  end
  else
  begin
    cMun := CMUN_EXTERIOR;
    xMun := XMUN_EXTERIOR;
    xUF := UF_EXTERIOR;
  end;

  if Opcoes.NormatizarMunicipios then
  begin
    if (cMun = 0) and (xMun <> XMUN_EXTERIOR) then
    begin
      cMun := ObterCodigoMunicipio(xMun, xUF, Opcoes.PathArquivoMunicipios);
    end
    else if (xMun = '') and (cMun <> CMUN_EXTERIOR) then
    begin
      xMun := ObterNomeMunicipio(cMun, xUF, Opcoes.PathArquivoMunicipios);
    end;
  end;
end;

end.
