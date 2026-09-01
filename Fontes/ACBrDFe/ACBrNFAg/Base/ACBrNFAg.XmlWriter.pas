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

unit ACBrNFAg.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrNFAg.Classes,
  ACBrNFAg.Conversao,
  ACBrDFe.RTC.XmlWriter;

type
  TNFAgXmlWriterOptions = class(TACBrXmlWriterOptions)
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

  TNFAgXmlWriter = class(TDFeRTCXmlWriter)
  private
    FNFAg: TNFAg;

    FChaveNFAg: string;

    FVersaoDF: TVersaoNFAg;
    FModeloDF: Integer;
    FtpAmb: TACBrTipoAmbiente;
    FtpEmis: TACBrTipoEmissao;
    FIdCSRT: integer;
    FCSRT: string;
    FpGerarGrupoIBSCBSTot: Boolean;

    function GerarInfNFAg: TACBrXmlNode;
    function GerarIde: TACBrXmlNode;

    function GerarEmit: TACBrXmlNode;
    function GerarEnderEmit: TACBrXmlNode;

    function GerarDest: TACBrXmlNode;
    function GerarEnderDest(var UF: string): TACBrXmlNode;

    function GerarLigacao: TACBrXmlNode;
    function GerargSub: TACBrXmlNode;
    function GerargMed: TACBrXmlNodeArray;

    function GerargFatConjunto: TACBrXmlNode;

    function GerarDet: TACBrXmlNodeArray;
    function GerargTarif(Idx: Integer): TACBrXmlNodeArray;
    function GerarProd(prod: TProd): TACBrXmlNode;
    function GerargMedicao(gMedicao: TgMedicao): TACBrXmlNode;
    function GerargMedida(gMedida: TgMedida): TACBrXmlNode;
    function GerarImposto(Imposto: TImposto): TACBrXmlNode;
    function GerarPIS(PIS: TPIS): TACBrXmlNode;
    function GerarCOFINS(COFINS: TCOFINS): TACBrXmlNode;
    function GerarRetTrib(RetTrib: TRetTrib): TACBrXmlNode;
    function GerarTFS(TFS: TTFS): TACBrXmlNode;
    function GerarTFU(TFU: TTFU): TACBrXmlNode;
    function GerargProcRef(gProcRef: TgProcRef): TACBrXmlNode;
    function GerargProc(gProc: TgProcCollection): TACBrXmlNodeArray;

    function GerarTotal: TACBrXmlNode;
    function GerarvRetTribTot: TACBrXmlNode;
    function GerargFat: TACBrXmlNode;
    function GerarEnderCorresp: TACBrXmlNode;
    function GerargPix: TACBrXmlNode;

    function GerargAgencia: TACBrXmlNode;
    function GerargHistCons: TACBrXmlNodeArray;
    function GerargCons(gCons: TgConsCollection): TACBrXmlNodeArray;

    function GerargQualiAgua(gQualiAgua: TgQualiAgua): TACBrXmlNode;
    function GerargAnalise(gAnalise: TgAnaliseCollection): TACBrXmlNodeArray;

    function GerarautXML: TACBrXmlNodeArray;
    function GerarInfAdic: TACBrXmlNode;
    function GerarInfPAA: TACBrXmlNode;
    function GerargRespTec: TACBrXmlNode;

    function Gerar_ProtNFAg: TACBrXmlNode;

    function GetOpcoes: TNFAgXmlWriterOptions;
    procedure SetOpcoes(AValue: TNFAgXmlWriterOptions);

    procedure AjustarMunicipioUF(out xUF: string; out xMun: string;
      out cMun: integer; cPais: integer; const vxUF, vxMun: string; vcMun: integer);
  protected
    function CreateOptions: TACBrXmlWriterOptions; override;

  public
    constructor Create(AOwner: TNFAg); reintroduce;
    destructor Destroy; override;

    function GerarXml: boolean; override;
    function ObterNomeArquivo: string; overload;

    property Opcoes: TNFAgXmlWriterOptions read GetOpcoes write SetOpcoes;
    property NFAg: TNFAg read FNFAg write FNFAg;

    property VersaoDF: TVersaoNFAg read FVersaoDF write FVersaoDF;
    property ModeloDF: Integer read FModeloDF write FModeloDF;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property tpEmis: TACBrTipoEmissao read FtpEmis write FtpEmis;
    property IdCSRT: integer read FIdCSRT write FIdCSRT;
    property CSRT: string read FCSRT write FCSRT;

  end;

implementation

uses
  variants,
  dateutils,
  StrUtils,
  Math,
  ACBrDFeConsts,
  ACBrNFAg.Consts,
  ACBrValidador,
  ACBrDFeUtil,
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.Strings;

constructor TNFAgXmlWriter.Create(AOwner: TNFAg);
begin
  inherited Create;

  TNFAgXmlWriterOptions(Opcoes).AjustarTagNro := False;
  TNFAgXmlWriterOptions(Opcoes).GerarTagIPIparaNaoTributado := True;
  TNFAgXmlWriterOptions(Opcoes).NormatizarMunicipios := False;
  TNFAgXmlWriterOptions(Opcoes).PathArquivoMunicipios := '';
  TNFAgXmlWriterOptions(Opcoes).GerarTagAssinatura := taSomenteSeAssinada;
  TNFAgXmlWriterOptions(Opcoes).ValidarInscricoes := False;
  TNFAgXmlWriterOptions(Opcoes).ValidarListaServicos := False;
  TNFAgXmlWriterOptions(Opcoes).CamposFatObrigatorios := True;

  FNFAg := AOwner;
end;

destructor TNFAgXmlWriter.Destroy;
begin
  inherited Destroy;
end;

function TNFAgXmlWriter.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TNFAgXmlWriterOptions.Create();
end;

function TNFAgXmlWriter.GetOpcoes: TNFAgXmlWriterOptions;
begin
  Result := TNFAgXmlWriterOptions(FOpcoes);
end;

procedure TNFAgXmlWriter.SetOpcoes(AValue: TNFAgXmlWriterOptions);
begin
  FOpcoes := AValue;
end;

procedure TNFAgXmlWriter.AjustarMunicipioUF(out xUF: string; out xMun: string;
  out cMun: integer; cPais: integer; const vxUF, vxMun: string; vcMun: integer);
var
  PaisBrasil: boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;
  cMun := IfThen(PaisBrasil, vcMun, CMUN_EXTERIOR);
  xMun := IfThen(PaisBrasil, vxMun, XMUN_EXTERIOR);
  xUF := IfThen(PaisBrasil, vxUF, UF_EXTERIOR);

  if Opcoes.NormatizarMunicipios then
    if ((EstaZerado(cMun)) and (xMun <> XMUN_EXTERIOR)) then
      cMun := ObterCodigoMunicipio(xMun, xUF, Opcoes.FPathArquivoMunicipios)
    else if ((EstaVazio(xMun)) and (cMun <> CMUN_EXTERIOR)) then
      xMun := ObterNomeMunicipio(cMun, xUF, Opcoes.FPathArquivoMunicipios);
end;

function TNFAgXmlWriter.ObterNomeArquivo: string;
begin
  Result := FChaveNFAg + '-NFAg.xml';
end;

function TNFAgXmlWriter.GerarXml: boolean;
var
  Gerar: boolean;
  NFAgNode, xmlNode: TACBrXmlNode;
begin
  Result := False;
  FpGerarGrupoIBSCBSTot := False;
  ModelosDFe := mdfNFAg;
  tpNFDebito := tdNenhum;

  ListaDeAlertas.Clear;

  {
    Os campos abaixo tem que ser os mesmos da configuração
  }
{
  NFAg.infNFAg.Versao := VersaoNFAgToDbl(VersaoDF);
  NFAg.Ide.modelo := ModeloDF;
  NFAg.Ide.tpAmb := tpAmb;
  NFAg.ide.tpEmis := tpEmis;
}
  FChaveNFAg := GerarChaveAcesso(NFAg.ide.cUF, NFAg.ide.dhEmi, NFAg.emit.CNPJ,
      NFAg.ide.serie, NFAg.ide.nNF, StrToInt(TipoEmissaoToStr(NFAg.ide.tpEmis)),
      NFAg.ide.cNF, NFAg.ide.modelo,
      StrToInt(SiteAutorizadorToStr(NFAg.Ide.nSiteAutoriz)));

  NFAg.infNFAg.ID := 'NFAG' + FChaveNFAg;
  NFAg.ide.cDV := ExtrairDigitoChaveAcesso(NFAg.infNFAg.ID);
  NFAg.Ide.cNF := ExtrairCodigoChaveAcesso(NFAg.infNFAg.ID);

  FDocument.Clear();
  NFAgNode := FDocument.CreateElement('NFAg', 'http://www.portalfiscal.inf.br/nfag');

  if NFAg.procNFAg.nProt <> '' then
  begin
    xmlNode := FDocument.CreateElement('NFAgProc', 'http://www.portalfiscal.inf.br/nfag');
    xmlNode.SetAttribute('versao', FloatToString(NFAg.infNFAg.Versao, '.', '#0.00'));
    xmlNode.AppendChild(NFAgNode);
    FDocument.Root := xmlNode;
  end
  else
  begin
    FDocument.Root := NFAgNode;
  end;

  xmlNode := GerarInfNFAg();
  NFAgNode.AppendChild(xmlNode);

  if NFAg.infNFAgSupl.qrCodNFAg <> '' then
  begin
    xmlNode := NFAgNode.AddChild('infNFAgSupl');
    xmlNode.AppendChild(AddNode(tcStr, '#318', 'qrCodNFAg', 50, 1000, 1,
       '<![CDATA[' + NFAg.infNFAgSupl.qrCodNFAg + ']]>', DSC_INFQRCODE, False));
  end;

  if Opcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := True;
    if Opcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((NFAg.signature.DigestValue <> '') and
                (NFAg.signature.SignatureValue <> '') and
                (NFAg.signature.X509Certificate <> ''));

    if Opcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
       Gerar := ((NFAg.signature.DigestValue = '') and
                 (NFAg.signature.SignatureValue = '') and
                 (NFAg.signature.X509Certificate = ''));
    if Gerar then
    begin
      FNFAg.signature.URI := '#NFAG' + FChaveNFAg;
      xmlNode := GerarSignature(FNFAg.signature);
      NFAgNode.AppendChild(xmlNode);
    end;
  end;

  if NFAg.procNFAg.nProt <> '' then
  begin
    xmlNode := Gerar_ProtNFAg;
    FDocument.Root.AppendChild(xmlNode);
  end;
end;

function TNFAgXmlWriter.GerarInfNFAg: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: integer;
begin
  Result := FDocument.CreateElement('infNFAg');
  Result.SetAttribute('Id', 'NFAG' + FChaveNFAg);
  Result.SetAttribute('versao', FloatToString(NFAg.infNFAg.Versao, '.', '#0.00'));

  Result.AppendChild(GerarIde);
  Result.AppendChild(GerarEmit);
  Result.AppendChild(GerarDest);
  Result.AppendChild(GerarLigacao);
  Result.AppendChild(GerargSub);

  nodeArray := GerargMed;
  for i := 0 to NFAg.gMed.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(GerargFatConjunto);

  nodeArray := GerarDet;
  for i := 0 to NFAg.Det.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(GerarTotal);
  Result.AppendChild(Gerar_pgtoVinc(NFAg.pgtoVinc));
  Result.AppendChild(GerargFat);
  Result.AppendChild(GerargAgencia);
  Result.AppendChild(GerargQualiAgua(NFAg.gQualiAgua));

  nodeArray := GerarautXML;
  for i := 0 to NFAg.autXML.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;

  Result.AppendChild(GerarInfAdic);
  Result.AppendChild(GerarInfPAA);
  Result.AppendChild(GerargRespTec);
end;

function TNFAgXmlWriter.GerarIde: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ide');

  Result.AppendChild(AddNode(tcInt, '#5', 'cUF', 2, 2, 1, NFAg.ide.cUF, DSC_CUF));

  if not ValidarCodigoUF(NFAg.ide.cUF) then
    wAlerta('#5', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#6', 'tpAmb  ', 1, 1, 1,
                                 TipoAmbienteToStr(NFAg.Ide.tpAmb), DSC_TPAMB));

  Result.AppendChild(AddNode(tcInt, '#7', 'mod', 2, 2, 1,
                                                     NFAg.ide.modelo, DSC_MOD));

  Result.AppendChild(AddNode(tcInt, '#8', 'serie', 1, 3, 1,
                                                    NFAg.ide.serie, DSC_SERIE));

  Result.AppendChild(AddNode(tcInt, '#9', 'nNF', 1, 9, 1, NFAg.ide.nNF, DSC_NDF));

  Result.AppendChild(AddNode(tcInt, '#10', 'cNF', 7, 7, 1,
                                                        NFAg.Ide.cNF, DSC_CDF));

  Result.AppendChild(AddNode(tcInt, '#11', 'cDV', 1, 1, 1, NFAg.Ide.cDV, DSC_CDV));

  Result.AppendChild(AddNode(tcStr, '#12', 'dhEmi', 25, 25, 1,
    DateTimeTodh(NFAg.ide.dhEmi) + GetUTC(CodigoUFparaUF(NFAg.ide.cUF), NFAg.ide.dhEmi),
    DSC_DEMI));

  Result.AppendChild(AddNode(tcStr, '#13', 'tpEmis', 1, 1, 1,
                                TipoEmissaoToStr(NFAg.Ide.tpEmis), DSC_TPEMIS));

  Result.AppendChild(AddNode(tcStr, '#13a', 'nSiteAutoriz', 1, 1, 1,
                SiteAutorizadorToStr(NFAg.Ide.nSiteAutoriz), DSC_NSITEAUTORIZ));

  Result.AppendChild(AddNode(tcInt, '#14', 'cMunFG ', 7, 7, 1,
                                                  NFAg.ide.cMunFG, DSC_CMUNFG));

  if not ValidarMunicipio(NFAg.ide.cMunFG) then
    wAlerta('#14', 'cMunFG', DSC_CMUNFG, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#15', 'finNFAg', 1, 1, 1,
                                  finNFAgToStr(NFAg.Ide.finNFAg), DSC_FINNFAg));

  Result.AppendChild(AddNode(tcStr, '#16', 'tpFat', 1, 1, 1,
                                        tpFatToStr(NFAg.Ide.tpFat), DSC_TPFAT));

  Result.AppendChild(AddNode(tcStr, '#17', 'verProc', 1, 20, 1,
                                                NFAg.Ide.verProc, DSC_VERPROC));

  if (NFAg.Ide.dhCont > 0) or (NFAg.Ide.xJust <> '') then
  begin
    Result.AppendChild(AddNode(tcStr, '#18', 'dhCont', 25, 25,
      1, DateTimeTodh(NFAg.ide.dhCont) + GetUTC(CodigoUFparaUF(NFAg.ide.cUF),
      NFAg.ide.dhCont), DSC_DHCONT));

    Result.AppendChild(AddNode(tcStr, '#19', 'xJust', 15, 256, 1,
                                                NFAg.ide.xJust, DSC_XJUSTCONT));
  end;

  // Reforma Tributária
  Result.AppendChild(Gerar_gCompraGovReduzido(NFAg.Ide.gCompraGov));

  Result.AppendChild(AddNode(tcStr, '#20', 'tpPagAnt', 1, 1, 0,
                               tpPagAntToStr(NFAg.Ide.tpPagAnt), DSC_TPPAGANT));
end;

function TNFAgXmlWriter.GerarEmit: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('emit');

  Result.AppendChild(AddNode(tcStr, '#20', 'CNPJ', 14, 14, 1,
                                                     NFAg.Emit.CNPJ, DSC_CNPJ));

  if NFAg.Emit.IE = 'ISENTO' then
    Result.AppendChild(AddNode(tcStr, '#21', 'IE', 2, 14, 1, NFAg.Emit.IE, DSC_IE))
  else
    Result.AppendChild(AddNode(tcStr, '#21', 'IE', 2, 14, 1,
                                             OnlyNumber(NFAg.Emit.IE), DSC_IE));

  if (Opcoes.ValidarInscricoes) then
  begin
    if Length(NFAg.Emit.IE) = 0 then
      wAlerta('#21', 'IE', DSC_IE, ERR_MSG_VAZIO)
    else
    begin
      if not ValidarIE(NFAg.Emit.IE, CodigoUFparaUF(NFAg.Ide.cUF)) then
        wAlerta('#21', 'IE', DSC_IE, ERR_MSG_INVALIDO);
    end;
  end;

  Result.AppendChild(AddNode(tcStr, '#22', 'xNome', 2, 60, 1,
                                                   NFAg.Emit.xNome, DSC_XNOME));

  Result.AppendChild(AddNode(tcStr, '#23', 'xFant', 1, 60, 0,
                                                   NFAg.Emit.xFant, DSC_XFANT));

  Result.AppendChild(GerarEnderEmit);

  Result.AppendChild(AddNode(tcStr, '#24', 'ISUFEmit', 8, 9, 0,
                                             NFAg.Emit.ISUFEmit, DSC_ISUFEMIT));
end;

function TNFAgXmlWriter.GerarEnderEmit: TACBrXmlNode;
var
  cMun: integer;
  xMun, xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL, NFAg.Emit.enderEmit.UF,
    NFAg.Emit.enderEmit.xMun, NFAg.Emit.EnderEmit.cMun);

  Result := FDocument.CreateElement('enderEmit');

  Result.AppendChild(AddNode(tcStr, '#25', 'xLgr', 2, 60, 1,
                                           NFAg.Emit.enderEmit.xLgr, DSC_XLGR));

  Result.AppendChild(AddNode(tcStr, '#26', 'nro', 1, 60, 1,
    ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, NFAg.Emit.enderEmit.nro), DSC_NRO));

  Result.AppendChild(AddNode(tcStr, '#27', 'xCpl', 1, 60, 0,
                                           NFAg.Emit.enderEmit.xCpl, DSC_XCPL));

  Result.AppendChild(AddNode(tcStr, '#28', 'xBairro', 2, 60, 1,
                                     NFAg.Emit.enderEmit.xBairro, DSC_XBAIRRO));

  Result.AppendChild(AddNode(tcInt, '#29', 'cMun', 7, 7, 1, cMun, DSC_CMUN));

  if not ValidarMunicipio(cMun) then
    wAlerta('#29', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#30', 'xMun', 2, 60, 1, xMun, DSC_XMUN));

  Result.AppendChild(AddNode(tcInt, '#31', 'CEP', 8, 8, 1,
                                             NFAg.Emit.enderEmit.CEP, DSC_CEP));

  Result.AppendChild(AddNode(tcStr, '#32', 'UF', 2, 2, 1, xUF, DSC_UF));

  if not ValidarUF(xUF) then
    wAlerta('#32', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#33', 'fone', 7, 12, 0,
                               OnlyNumber(NFAg.Emit.enderEmit.fone), DSC_FONE));

  Result.AppendChild(AddNode(tcStr, '#34', 'email', 1, 60, 0,
                                         NFAg.Emit.enderEmit.email, DSC_EMAIL));
end;

function TNFAgXmlWriter.GerarDest: TACBrXmlNode;
var
  UF: string;
const
  HOM_NOME_DEST = 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';
begin
  UF := '';
  Result := FDocument.CreateElement('dest');

  if NFAg.Ide.tpAmb = taProducao then
    Result.AppendChild(AddNode(tcStr, '#36', 'xNome', 2, 60, 1,
                                                    NFAg.Dest.xNome, DSC_XNOME))
  else
    Result.AppendChild(AddNode(tcStr, '#36', 'xNome', 2, 60, 1,
                                                     HOM_NOME_DEST, DSC_XNOME));

  if NFAg.Dest.idOutros <> '' then
    Result.AppendChild(AddNode(tcStr, '#39', 'idOutros', 2, 20, 1,
                                                NFAg.Dest.idOutros, DSC_IDESTR))
  else
    Result.AppendChild(AddNodeCNPJCPF('#37', '#38', NFAg.Dest.CNPJCPF));

  if (NFAg.Dest.IE <> '') then
  begin
    // Inscrição Estadual
    if NFAg.Dest.IE = '' then
      Result.AppendChild(AddNode(tcStr, '#41', 'IE', 0, 14, 1, '', DSC_IE))
    else
    if NFAg.Dest.IE = 'ISENTO' then
      Result.AppendChild(AddNode(tcStr, '#41', 'IE', 0, 14, 1,
                                                          NFAg.Dest.IE, DSC_IE))
    else if trim(NFAg.Dest.IE) <> '' then
      Result.AppendChild(AddNode(tcStr, '#41', 'IE', 0, 14, 1,
                                             OnlyNumber(NFAg.Dest.IE), DSC_IE));

    if (Opcoes.ValidarInscricoes) and (NFAg.Dest.IE <> '') and
       (NFAg.Dest.IE <> 'ISENTO') then
      if not ValidarIE(NFAg.Dest.IE, UF) then
        wAlerta('#41', 'IE', DSC_IE, ERR_MSG_INVALIDO);
  end;

  Result.AppendChild(AddNode(tcStr, '#42', 'IM', 1, 15, 0, NFAg.Dest.IM, DSC_IM));

  if NFAg.Dest.cNIS <> '' then
    Result.AppendChild(AddNode(tcStr, '#43', 'cNIS', 15, 15, 1,
                                                      NFAg.Dest.cNIS, DSC_CNIS))
  else
  if NFAg.Dest.NB <> '' then
    Result.AppendChild(AddNode(tcStr, '#43b', 'NB', 10, 10, 1,
                                                         NFAg.Dest.NB, DSC_NB));

  Result.AppendChild(AddNode(tcStr, '#44', 'xNomeAdicional', 2, 60, 0,
                                          NFAg.Dest.xNomeAdicional, DSC_XNOME));

  Result.AppendChild(GerarEnderDest(UF));
end;

function TNFAgXmlWriter.GerarEnderDest(var UF: string): TACBrXmlNode;
var
  cMun: integer;
  xMun, xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL, NFAg.Dest.enderDest.UF,
    NFAg.Dest.enderDest.xMun, NFAg.Dest.enderDest.cMun);

  UF := xUF;
  Result := FDocument.CreateElement('enderDest');

  Result.AppendChild(AddNode(tcStr, '#46', 'xLgr', 2, 60, 1,
                                           NFAg.Dest.enderDest.xLgr, DSC_XLGR));

  Result.AppendChild(AddNode(tcStr, '#47', 'nro', 01, 60, 1,
    ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, NFAg.Dest.enderDest.nro), DSC_NRO));

  Result.AppendChild(AddNode(tcStr, '#48', 'xCpl', 1, 60, 0,
                                           NFAg.Dest.enderDest.xCpl, DSC_XCPL));

  Result.AppendChild(AddNode(tcStr, '#49', 'xBairro', 1, 60, 1,
                                     NFAg.Dest.enderDest.xBairro, DSC_XBAIRRO));

  Result.AppendChild(AddNode(tcInt, '#50', 'cMun', 7, 7, 1, cMun, DSC_CMUN));

  if not ValidarMunicipio(cMun) then
    wAlerta('#50', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#51', 'xMun', 2, 60, 1, xMun, DSC_XMUN));

  Result.AppendChild(AddNode(tcInt, '#52', 'CEP', 8, 8, 1,
                                             NFAg.Dest.enderDest.CEP, DSC_CEP));

  Result.AppendChild(AddNode(tcStr, '#53', 'UF', 2, 2, 1, xUF, DSC_UF));

  if not ValidarUF(xUF) then
    wAlerta('#53', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#54', 'fone', 7, 12, 0,
                               OnlyNumber(NFAg.Dest.enderDest.fone), DSC_FONE));

  Result.AppendChild(AddNode(tcStr, '#55', 'email', 01, 60, 0,
                                         NFAg.Dest.EnderDest.Email, DSC_EMAIL));
end;

function TNFAgXmlWriter.GerarLigacao: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ligacao');

  Result.AppendChild(AddNode(tcStr, '#57', 'idLigacao', 1, 20, 1,
                                        NFAg.ligacao.idLigacao, DSC_IDLIGACAO));

  Result.AppendChild(AddNode(tcStr, '#58', 'idCodCliente', 2, 20, 0,
                                  NFAg.ligacao.idCodCliente, DSC_IDCODCLIENTE));

  Result.AppendChild(AddNode(tcStr, '#59', 'tpLigacao', 1, 1, 1,
                        tpLigacaoToStr(NFAg.ligacao.tpLigacao), DSC_TPLIGACAO));

  Result.AppendChild(AddNode(tcStr, '#66', 'latGPS', 2, 10, 1,
                                              NFAg.ligacao.latGPS, DSC_LATGPS));

  Result.AppendChild(AddNode(tcStr, '#67', 'longGPS', 2, 10, 1,
                                            NFAg.ligacao.longGPS, DSC_LONGGPS));

  Result.AppendChild(AddNode(tcStr, '#68', 'codRoteiroLeitura', 2, 100, 0,
                        NFAg.ligacao.codRoteiroLeitura, DSC_CODROTEIROLEITURA));
end;

function TNFAgXmlWriter.GerargSub: TACBrXmlNode;
begin
  Result := nil;

  if (NFAg.gSub.chNFAg <> '') then
  begin
    Result := FDocument.CreateElement('gSub');

    Result.AppendChild(AddNode(tcStr, '#70', 'chNFAg', 44, 44, 1,
                                                 NFAg.gSub.chNFAg, DSC_CHNFAg));

    if not ValidarChave(NFAg.gSub.chNFAg) then
      wAlerta('#70', 'chNFAg', DSC_CHNFAg, ERR_MSG_INVALIDO);

    Result.AppendChild(AddNode(tcStr, '#78', 'motSub', 2, 2, 1,
                                    motSubToStr(NFAg.gSub.motSub), DSC_MOTSUB));
  end;
end;

function TNFAgXmlWriter.GerargMed: TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, NFAg.gMed.Count);

  for i := 0 to NFAg.gMed.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gMed');

    Result[i].SetAttribute('nMed', FormatFloat('00', NFAg.gMed[i].nMed));

    if (NFAg.gMed[i].nMed > 20) then
      wAlerta('#87', 'nMed', DSC_NCONTRAT, ERR_MSG_MAIOR);

    if (NFAg.gMed[i].nMed < 1) then
      wAlerta('#87', 'nMed', DSC_NCONTRAT, ERR_MSG_MENOR);

    Result[i].AppendChild(AddNode(tcStr, '#88', 'idMedidor', 2, 20, 1,
     NFAg.gMed[i].idMedidor, DSC_IDMEDIDOR));

    Result[i].AppendChild(AddNode(tcDat, '#89', 'dMedAnt', 10, 10, 1,
     NFAg.gMed[i].dMedAnt, DSC_DMEDANT));

    Result[i].AppendChild(AddNode(tcDat, '#90', 'dMedAtu', 10, 10, 1,
     NFAg.gMed[i].dMedAtu, DSC_DMEDATU));
  end;

  if NFAg.gMed.Count > 99 then
    wAlerta('#086', 'gMed', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

function TNFAgXmlWriter.GerargFatConjunto: TACBrXmlNode;
begin
  Result := nil;

  if (NFAg.gFatConjunto.chNFAgFat <> '') then
  begin
    Result := FDocument.CreateElement('gFatConjunto');

    Result.AppendChild(AddNode(tcStr, '#80', 'chNFAgFat', 44, 44, 1,
                                   NFAg.gFatConjunto.chNFAgFat, DSC_CHNFAGFAT));

    if not ValidarChave(NFAg.gFatConjunto.chNFAgFat) then
      wAlerta('#080', 'chNFAgFat', DSC_CHNFAGFAT, ERR_MSG_INVALIDO);
  end;
end;

function TNFAgXmlWriter.GerarDet: TACBrXmlNodeArray;
var
  i, j: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  SetLength(Result, NFAg.Det.Count);

  for i := 0 to NFAg.Det.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('det');

    Result[i].SetAttribute('nItem', IntToStr(NFAg.Det[i].nItem));

    if NFAg.Det[i].chNFAgAnt <> '' then
      Result[i].SetAttribute('chNFAgAnt', NFAg.Det[i].chNFAgAnt);

    if NFAg.Det[i].nItemAnt > 0 then
    Result[i].SetAttribute('nItemAnt', IntToStr(NFAg.Det[i].nItemAnt));

    nodeArray := GerargTarif(i);
    for j := 0 to NFAg.Det[i].gTarif.Count - 1 do
    begin
      Result[i].AppendChild(nodeArray[j]);
    end;

    Result[i].AppendChild(GerarProd(NFAg.Det[i].Prod));
    Result[i].AppendChild(GerarImposto(NFAg.Det[i].Imposto));
    Result[i].AppendChild(GerargProcRef(NFAg.Det[i].gProcRef));

    Result[i].AppendChild(AddNode(tcStr, '#84', 'infAdProd', 1, 500, 0,
                                          NFAg.Det[i].infAdProd, DSC_TPPOSTAR));
  end;

  if NFAg.Det.Count > 990 then
    wAlerta('108', 'det', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

function TNFAgXmlWriter.GerargTarif(Idx: Integer): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, NFAg.Det[Idx].gTarif.Count);

  for i := 0 to NFAg.Det[Idx].gTarif.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gTarif');

    Result[i].AppendChild(AddNode(tcDat, '#127', 'dIniTarif', 10, 10, 1,
                             NFAg.Det[Idx].gTarif[i].dIniTarif, DSC_DINITARIF));

    Result[i].AppendChild(AddNode(tcDat, '#128', 'dFimTarif', 10, 10, 0,
                             NFAg.Det[Idx].gTarif[i].dFimTarif, DSC_DFIMTARIF));

    Result[i].AppendChild(AddNode(tcStr, '#130', 'nAto', 4, 4, 1,
                                       NFAg.Det[Idx].gTarif[i].nAto, DSC_NATO));

    Result[i].AppendChild(AddNode(tcInt, '#131', 'anoAto', 4, 4, 1,
                                   NFAg.Det[Idx].gTarif[i].anoAto, DSC_ANOATO));

    Result[i].AppendChild(AddNode(tcStr, '#132', 'tpFaixaCons', 1, 1, 0,
       tpFaixaConsToStr(NFAg.Det[Idx].gTarif[i].tpFaixaCons), DSC_TPFAIXACONS));
  end;

  if NFAg.Det[Idx].gTarif.Count > 6 then
    wAlerta('126', 'gTarif', '', ERR_MSG_MAIOR_MAXIMO + '6');
end;

function TNFAgXmlWriter.GerarProd(prod: TProd): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('prod');

  Result.AppendChild(AddNode(tcStr, '#146', 'indOrigemQtd', 1, 1, 1,
                       indOrigemQtdToStr(Prod.indOrigemQtd), DSC_INDORIGEMQTD));

  if Prod.gMedicao.nMed > 0 then
    Result.AppendChild(GerargMedicao(Prod.gMedicao));

  Result.AppendChild(AddNode(tcStr, '#162', 'cProd', 1, 60, 1,
                                                        Prod.cProd, DSC_CPROD));

  Result.AppendChild(AddNode(tcStr, '#163', 'xProd', 1, 120, 1,
                                                        Prod.xProd, DSC_XPROD));

  Result.AppendChild(AddNode(tcInt, '#164', 'cClass', 7, 7, 1,
                                                      Prod.cClass, DSC_CCLASS));

  Result.AppendChild(AddNode(tcStr, '#146', 'tpCategoria', 2, 2, 1,
                          tpCategoriaToStr(Prod.tpCategoria), DSC_TPCATEGORIA));

  Result.AppendChild(AddNode(tcStr, '#163', 'xCategoria', 1, 200, 0,
                                              Prod.xCategoria, DSC_XCATEGORIA));

  Result.AppendChild(AddNode(tcStr, '#163', 'qEconomias', 1, 5, 0,
                                              Prod.qEconomias, DSC_QECONOMIAS));

  Result.AppendChild(AddNode(tcStr, '#166', 'uMed', 1, 1, 1,
                                            uMedFatToStr(Prod.uMed), DSC_UMED));

  if Frac(Prod.qFaturada) > 0 then
    Result.AppendChild(AddNode(tcDe4, '#167', 'qFaturada', 1, 15, 1,
                                                 Prod.qFaturada, DSC_QFATURADA))
  else
    Result.AppendChild(AddNode(tcInt, '#167', 'qFaturada', 1, 15, 1,
                                                Prod.qFaturada, DSC_QFATURADA));

  // pode ter 2 ou 10 casas decimais
  Result.AppendChild(AddNode(tcDe2, '#168', 'vItem', 1, 15, 1,
                                                        Prod.vItem, DSC_VITEM));

  if Frac(Prod.fatorPoluicao) > 0 then
    Result.AppendChild(AddNode(tcDe4, '#167', 'fatorPoluicao', 1, 15, 1,
                                         Prod.fatorPoluicao, DSC_FATORPOLUICAO))
  else
    Result.AppendChild(AddNode(tcInt, '#167', 'fatorPoluicao', 1, 15, 1,
                                        Prod.fatorPoluicao, DSC_FATORPOLUICAO));

  // pode ter 2 ou 10 casas decimais
  Result.AppendChild(AddNode(tcDe2, '#169', 'vProd', 1, 15, 1,
                                                        Prod.vProd, DSC_VPROD));

  if Prod.indDevolucao = tiSim then
    Result.AppendChild(AddNode(tcStr, '#170', 'indDevolucao', 1, 1, 1, '1', ''));

  if Prod.gPagAntecipado.chDFePagAnt <> '' then
    Result.AppendChild(Gerar_gPagAntecipadoProd(Prod.gPagAntecipado));
end;

function TNFAgXmlWriter.GerargMedicao(gMedicao: TgMedicao): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMedicao');

  Result.AppendChild(AddNode(tcInt, '#148', 'nMed', 2, 2, 1,
                                                      gMedicao.nMed, DSC_NMED));

  if (gMedicao.gMedida.vMedAnt > 0) or
     (gMedicao.gMedida.vMedAtu > 0) then
    Result.AppendChild(GerargMedida(gMedicao.gMedida))
  else
    Result.AppendChild(AddNode(tcInt, '#161', 'tpMotNaoLeitura', 1, 1, 1,
          tpMotNaoLeituraToStr(gMedicao.tpMotNaoLeitura), DSC_TPMOTNAOLEITURA));
end;

function TNFAgXmlWriter.GerargMedida(gMedida: TgMedida): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gMedida');

  Result.AppendChild(AddNode(tcStr, '#151', 'tpGrMed', 2, 2, 1,
                                   tpGrMedToStr(gMedida.tpGrMed), DSC_TPGRMED));

  Result.AppendChild(AddNode(tcStr, '#152', 'nUnidConsumo', 15, 15, 0,
                                           gMedida.nUnidConsumo, DSC_NUNIDCONSUMO));

  Result.AppendChild(AddNode(tcDe2, '#154', 'vUnidConsumo', 1, 15, 0,
                                       gMedida.vUnidConsumo, DSC_VUNIDCONSUMO));

  Result.AppendChild(AddNode(tcStr, '#153', 'uMed', 1, 1, 1,
                                         uMedFatToStr(gMedida.uMed), DSC_UMED));

  Result.AppendChild(AddNode(tcDe2, '#154', 'vMedAnt', 1, 15, 1,
                                                 gMedida.vMedAnt, DSC_VMEDANT));

  Result.AppendChild(AddNode(tcDe2, '#155', 'vMedAtu', 1, 15, 1,
                                                 gMedida.vMedAtu, DSC_VMEDATU));

  Result.AppendChild(AddNode(tcDe2, '#156', 'vConst', 1, 15, 1,
                                                   gMedida.vConst, DSC_VCONST));

  Result.AppendChild(AddNode(tcDe2, '#157', 'vMed', 1, 15, 1,
                                                       gMedida.vMed, DSC_VMED));
end;

function TNFAgXmlWriter.GerarImposto(Imposto: TImposto): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('imposto');

  // Reforma Tributária
  Result.AppendChild(Gerar_IBSCBS(Imposto.IBSCBS));

  Result.AppendChild(GerarPIS(Imposto.PIS));
  Result.AppendChild(GerarCOFINS(Imposto.COFINS));
  Result.AppendChild(GerarRetTrib(Imposto.RetTrib));
  Result.AppendChild(GerarTFS(Imposto.TFS));
  Result.AppendChild(GerarTFU(Imposto.TFU));
end;

function TNFAgXmlWriter.GerarPIS(PIS: TPIS): TACBrXmlNode;
begin
  Result := nil;

  if (PIS.vBC > 0) or (PIS.pPIS > 0) or (PIS.vPIS > 0) then
  begin
    Result := FDocument.CreateElement('PIS');

    Result.AppendChild(AddNode(tcStr, '#211', 'CST', 2, 2, 1,
                                                CSTPISToStr(PIS.CST), DSC_CST));

    Result.AppendChild(AddNode(tcDe2, '#212', 'vBC', 1, 15, 1, PIS.vBC, DSC_VBC));

    Result.AppendChild(AddNode(tcDe2, '#213', 'pPIS', 1, 5, 1,
                                                           PIS.pPIS, DSC_PPIS));

    Result.AppendChild(AddNode(tcDe2, '#214', 'vPIS', 1, 15, 1,
                                                           PIS.vPIS, DSC_VPIS));
  end;
end;

function TNFAgXmlWriter.GerarCOFINS(COFINS: TCOFINS): TACBrXmlNode;
begin
  Result := nil;

  if (COFINS.vBC > 0) or (COFINS.pCOFINS > 0) or (COFINS.vCOFINS > 0) then
  begin
    Result := FDocument.CreateElement('COFINS');

    Result.AppendChild(AddNode(tcStr, '#220', 'CST', 2, 2, 1,
                                          CSTCOFINSToStr(COFINS.CST), DSC_CST));

    Result.AppendChild(AddNode(tcDe2, '#221', 'vBC', 1, 15, 1,
                                                          COFINS.vBC, DSC_VBC));

    Result.AppendChild(AddNode(tcDe2, '#222', 'pCOFINS', 1, 5, 1,
                                                  COFINS.pCOFINS, DSC_PCOFINS));

    Result.AppendChild(AddNode(tcDe2, '#223', 'vCOFINS', 1, 15, 1,
                                                  COFINS.vCOFINS, DSC_VCOFINS));
  end;
end;

function TNFAgXmlWriter.GerarRetTrib(RetTrib: TRetTrib): TACBrXmlNode;
begin
  Result := nil;

  if (retTrib.vRetPIS > 0) or (retTrib.vRetCOFINS > 0) or (retTrib.vRetCSLL > 0) or
     (retTrib.vBCIRRF > 0) or (retTrib.vIRRF > 0) then
  begin
    Result := FDocument.CreateElement('retTrib');

    Result.AppendChild(AddNode(tcDe2, '#229', 'vRetPIS', 1, 15, 1,
                                                 retTrib.vRetPIS, DSC_VRETPIS));

    Result.AppendChild(AddNode(tcDe2, '#230', 'vRetCOFINS', 1, 15, 1,
                                           retTrib.vRetCOFINS, DSC_VRETCOFINS));

    Result.AppendChild(AddNode(tcDe2, '#231', 'vRetCSLL', 1, 15, 1,
                                               retTrib.vRetCSLL, DSC_VRETCSLL));

    Result.AppendChild(AddNode(tcDe2, '#232', 'vBCIRRF', 1, 15, 1,
                                                 retTrib.vBCIRRF, DSC_VBCIRRF));

    Result.AppendChild(AddNode(tcDe2, '#233', 'vIRRF', 1, 15, 1,
                                                     retTrib.vIRRF, DSC_VIRRF));
  end;
end;

function TNFAgXmlWriter.GerarTFS(TFS: TTFS): TACBrXmlNode;
begin
  Result := nil;

  if (TFS.vBCTFS > 0) or (TFS.pTFS > 0) or (TFS.vTFS > 0) then
  begin
    Result := FDocument.CreateElement('TFS');

    Result.AppendChild(AddNode(tcDe2, '#229', 'vBCTFS', 1, 15, 1,
                                                       TFS.vBCTFS, DSC_VBCTFS));

    Result.AppendChild(AddNode(tcDe2, '#230', 'pTFS', 1, 5, 1,
                                                           TFS.pTFS, DSC_PTFS));

    Result.AppendChild(AddNode(tcDe2, '#231', 'vTFS', 1, 15, 1,
                                                           TFS.vTFS, DSC_VTFS));
  end;
end;

function TNFAgXmlWriter.GerarTFU(TFU: TTFU): TACBrXmlNode;
begin
  Result := nil;

  if (TFU.vBCTFU > 0) or (TFU.pTFU > 0) or (TFU.vTFU > 0) then
  begin
    Result := FDocument.CreateElement('TFU');

    Result.AppendChild(AddNode(tcDe2, '#229', 'vBCTFU', 1, 15, 1,
                                                       TFU.vBCTFU, DSC_VBCTFU));

    Result.AppendChild(AddNode(tcDe2, '#230', 'pTFU', 1, 5, 1,
                                                           TFU.pTFU, DSC_PTFU));

    Result.AppendChild(AddNode(tcDe2, '#231', 'vTFU', 1, 15, 1,
                                                           TFU.vTFU, DSC_VTFU));
  end;
end;

function TNFAgXmlWriter.GerargProcRef(gProcRef: TgProcRef): TACBrXmlNode;
var
  i: integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;

  if gProcRef.vItem > 0 then
  begin
    Result := FDocument.CreateElement('gProcRef');

    // pode ter 2 ou 6 casas decimais
    Result.AppendChild(AddNode(tcDe2, '#235', 'vItem', 1, 15, 1,
                                                    gProcRef.vItem, DSC_VITEM));

    if Frac(gProcRef.qFaturada) > 0 then
      Result.AppendChild(AddNode(tcDe4, '#236', 'qFaturada', 1, 15, 1,
                                             gProcRef.qFaturada, DSC_QFATURADA))
    else
      Result.AppendChild(AddNode(tcInt, '#236', 'qFaturada', 1, 15, 1,
                                            gProcRef.qFaturada, DSC_QFATURADA));

    // pode ter 2 ou 6 casas decimais
    Result.AppendChild(AddNode(tcDe2, '#237', 'vProd', 1, 15, 1,
                                                    gProcRef.vProd, DSC_VPROD));

    if gProcRef.indDevolucao = tiSim then
      Result.AppendChild(AddNode(tcStr, '#238', 'indDevolucao', 1, 1, 1, '1', ''));

    nodeArray := GerargProc(gProcRef.gProc);
    for i := 0 to gProcRef.gProc.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFAgXmlWriter.GerargProc(gProc: TgProcCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, gProc.Count);

  for i := 0 to gProc.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gProc');

    Result[i].AppendChild(AddNode(tcStr, '#245', 'tpProc', 1, 1, 1,
                                     tpProcToStr(gProc[i].tpProc), DSC_TPPROC));

    Result[i].AppendChild(AddNode(tcStr, '#246', 'nProcesso', 1, 60, 1,
                                            gProc[i].nProcesso, DSC_NPROCESSO));
  end;

  if gProc.Count > 10 then
    wAlerta('#244', 'gProc', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFAgXmlWriter.GerarTotal: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('total');

  Result.AppendChild(AddNode(tcDe2, '#254', 'vProd', 1, 15, 1,
                                                  NFAg.Total.vProd, DSC_VPROD));

  Result.AppendChild(GerarvRetTribTot);

  Result.AppendChild(AddNode(tcDe2, '#268', 'vCOFINS', 1, 15, 1,
                                              NFAg.Total.vCOFINS, DSC_VCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#270', 'vPIS', 1, 15, 1,
                                                    NFAg.Total.vPIS, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#271', 'vTFS', 1, 15, 1,
                                                    NFAg.Total.vTFS, DSC_VTFS));

  Result.AppendChild(AddNode(tcDe2, '#271', 'vTFU', 1, 15, 1,
                                                    NFAg.Total.vTFU, DSC_VTFU));

  Result.AppendChild(AddNode(tcDe2, '#271', 'vNF', 1, 15, 1,
                                                      NFAg.Total.vNF, DSC_VDF));

  // Reforma Tributária
  Result.AppendChild(Gerar_IBSCBSTot(NFAg.Total.IBSCBSTot));

  Result.AppendChild(AddNode(tcDe2, '#250', 'vTotDFe', 1, 15, 0,
                                              NFAg.Total.vTotDFe, DSC_VTOTDFE));
end;

function TNFAgXmlWriter.GerarvRetTribTot: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('vRetTribTot');

  Result.AppendChild(AddNode(tcDe2, '#264', 'vRetPIS', 1, 15, 1,
                                              NFAg.Total.vRetPIS, DSC_VRETPIS));

  Result.AppendChild(AddNode(tcDe2, '#265', 'vRetCofins', 1, 15, 1,
                                        NFAg.Total.vRetCofins, DSC_VRETCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#266', 'vRetCSLL', 1, 15, 1,
                                            NFAg.Total.vRetCSLL, DSC_VRETCSLL));

  Result.AppendChild(AddNode(tcDe2, '#267', 'vIRRF', 1, 15, 1,
                                                  NFAg.Total.vIRRF, DSC_VIRRF));
end;

function TNFAgXmlWriter.GerargFat: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gFat');

  Result.AppendChild(AddNode(tcStr, '#274', 'CompetFat', 6, 6, 1,
                 FormatDateTime('yyyymm', NFAg.gFat.CompetFat), DSC_COMPETFAT));

  Result.AppendChild(AddNode(tcDat, '#275', 'dVencFat', 10, 10, 1,
                                                NFAg.gFat.dVencFat, DSC_DVENC));

  Result.AppendChild(AddNode(tcDat, '#276', 'dApresFat', 10, 10, 0,
                                           NFAg.gFat.dApresFat, DSC_DAPRESFAT));

  Result.AppendChild(AddNode(tcDat, '#277', 'dProxLeitura', 10, 10, 1,
                                     NFAg.gFat.dProxLeitura, DSC_DPROXLEITURA));

  Result.AppendChild(AddNode(tcStr, '#278', 'nFat', 1, 20, 0,
                                                     NFAg.gFat.nFat, DSC_NFAT));

  Result.AppendChild(AddNode(tcStr, '#279', 'codBarras', 1, 48, 1,
                                           NFAg.gFat.codBarras, DSC_CODBARRAS));

  if NFAg.gFat.codDebAuto <> '' then
    Result.AppendChild(AddNode(tcStr, '#280', 'codDebAuto', 1, 20, 1,
                                          NFAg.gFat.codDebAuto, DSC_CODDEBAUTO))
  else
  begin
    Result.AppendChild(AddNode(tcStr, '#281', 'codBanco', 3, 5, 1,
                                             NFAg.gFat.codBanco, DSC_CODBANCO));

    Result.AppendChild(AddNode(tcStr, '#282', 'codAgencia', 1, 10, 1,
                                         NFAg.gFat.codAgencia, DSC_CODAGENCIA));
  end;

  if NFAg.gFat.enderCorresp.xLgr <> '' then
                                          Result.AppendChild(GerarEnderCorresp);

  if NFAg.gFat.gPIX.urlQRCodePIX <> '' then
                                                  Result.AppendChild(GerargPix);
end;

function TNFAgXmlWriter.GerarEnderCorresp: TACBrXmlNode;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL, NFAg.gFat.enderCorresp.UF,
    NFAg.gFat.enderCorresp.xMun, NFAg.gFat.enderCorresp.cMun);

  Result := FDocument.CreateElement('enderCorresp');

  Result.AppendChild(AddNode(tcStr, '#284', 'xLgr', 2, 60, 1,
                                        NFAg.gFat.enderCorresp.xLgr, DSC_XLGR));

  Result.AppendChild(AddNode(tcStr, '#285', 'nro', 1, 60, 1,
    ExecutarAjusteTagNro(Opcoes.FAjustarTagNro, NFAg.gFat.enderCorresp.nro), DSC_NRO));

  Result.AppendChild(AddNode(tcStr, '#286', 'xCpl', 1, 60, 0,
                                        NFAg.gFat.enderCorresp.xCpl, DSC_XCPL));

  Result.AppendChild(AddNode(tcStr, '#287', 'xBairro', 2, 60, 1,
                                  NFAg.gFat.enderCorresp.xBairro, DSC_XBAIRRO));

  Result.AppendChild(AddNode(tcInt, '#288', 'cMun', 7, 7, 1, cMun, DSC_CMUN));

  if not ValidarMunicipio(cMun) then
    wAlerta('#288', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#289', 'xMun', 2, 60, 1, xMun, DSC_XMUN));

  Result.AppendChild(AddNode(tcInt, '#290', 'CEP', 8, 8, 1,
                                          NFAg.gFat.enderCorresp.CEP, DSC_CEP));

  Result.AppendChild(AddNode(tcStr, '#291', 'UF', 2, 2, 1, xUF, DSC_UF));

  if not ValidarUF(xUF) then
    wAlerta('#291', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, '#292', 'fone', 7, 12, 0,
                            OnlyNumber(NFAg.gFat.enderCorresp.fone), DSC_FONE));

  Result.AppendChild(AddNode(tcStr, '#293', 'email', 1, 60, 0,
                                      NFAg.gFat.enderCorresp.email, DSC_EMAIL));
end;

function TNFAgXmlWriter.GerargPix: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gPIX');

  Result.AppendChild(AddNode(tcStr, '#295', 'urlQRCodePIX', 2, 2000, 1,
                                        NFAg.gFat.gPIX.urlQRCodePIX, DSC_XLGR));
end;

function TNFAgXmlWriter.GerargAgencia: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := FDocument.CreateElement('gAgencia');

  Result.AppendChild(AddNode(tcStr, '#295', 'econ', 2, 10, 0,
                                                 NFAg.gAgencia.econ, DSC_ECON));

  Result.AppendChild(AddNode(tcStr, '#295', 'econAcumulada', 2, 10, 0,
                               NFAg.gAgencia.econAcumulada, DSC_ECONACUMULADA));

  Result.AppendChild(AddNode(tcStr, '#295', 'sPrestador', 2, 10, 0,
                                     NFAg.gAgencia.sPrestador, DSC_SPRESTADOR));

  Result.AppendChild(AddNode(tcDat, '#276', 'dEmissSelo', 10, 10, 0,
                                     NFAg.gAgencia.dEmissSelo, DSC_DEMISSSELO));

  Result.AppendChild(AddNode(tcStr, '#295', 'sRegulador', 2, 10, 0,
                                     NFAg.gAgencia.sRegulador, DSC_SREGULADOR));

  Result.AppendChild(AddNode(tcStr, '#295', 'nAgenciaAtend', 2, 20, 1,
                               NFAg.gAgencia.nAgenciaAtend, DSC_NAGENCIAATEND));

  Result.AppendChild(AddNode(tcStr, '#295', 'enderAgenciaAtend', 2, 200, 1,
                       NFAg.gAgencia.enderAgenciaAtend, DSC_ENDERAGENCIAATEND));

  nodeArray := GerargHistCons;
  for i := 0 to NFAg.gAgencia.gHistCons.Count - 1 do
  begin
    Result.AppendChild(nodeArray[i]);
  end;
end;

function TNFAgXmlWriter.GerargHistCons: TACBrXmlNodeArray;
var
  i, j: Integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;
  SetLength(Result, NFAg.gAgencia.gHistCons.Count);

  for i := 0 to NFAg.gAgencia.gHistCons.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gHistCons');

    Result[i].AppendChild(AddNode(tcStr, '#83', 'xHistorico', 2, 60, 1,
                        NFAg.gAgencia.gHistCons[i].xHistorico, DSC_XHISTORICO));

    nodeArray := GerargCons(NFAg.gAgencia.gHistCons[i].gCons);
    for j := 0 to NFAg.gAgencia.gHistCons[i].gCons.Count - 1 do
    begin
      Result[i].AppendChild(nodeArray[j]);
    end;

    Result[i].AppendChild(AddNode(tcDe2, '#85', 'medMensal', 1, 15, 1,
                          NFAg.gAgencia.gHistCons[i].medMensal, DSC_MEDMENSAL));
  end;

  if NFAg.gAgencia.gHistCons.Count > 5 then
    wAlerta('#81', 'gHistCons', '', ERR_MSG_MAIOR_MAXIMO + '5');
end;

function TNFAgXmlWriter.GerargCons(gCons: TgConsCollection): TACBrXmlNodeArray;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, gCons.Count);

  for i := 0 to gCons.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gCons');

    Result[i].AppendChild(AddNode(tcStr, '#300', 'CompetFat', 6, 6, 1,
                  FormatDateTime('yyyymm', gCons[i].CompetFat), DSC_COMPETFAT));

    Result[i].AppendChild(AddNode(tcStr, '#302', 'uMed', 1, 1, 1,
                                        uMedFatToStr(gCons[i].uMed), DSC_UMED));

    Result[i].AppendChild(AddNode(tcStr, '#303', 'qtdDias', 5, 5, 1,
                                                   gCons[i].qtdDias, DSC_QTDE));

    Result[i].AppendChild(AddNode(tcDe4, '#301', 'medDiaria', 1, 15, 0,
                                            gCons[i].medDiaria, DSC_MEDDIARIA));

    Result[i].AppendChild(AddNode(tcDe2, '#301', 'consumo', 1, 15, 0,
                                                gCons[i].consumo, DSC_CONSUMO));

    Result[i].AppendChild(AddNode(tcDe2, '#301', 'volFat', 1, 15, 1,
                                                  gCons[i].volFat, DSC_VOLFAT));
  end;

  if gCons.Count > 20 then
    wAlerta('#81', 'gCons', '', ERR_MSG_MAIOR_MAXIMO + '13');
end;

function TNFAgXmlWriter.GerargQualiAgua(gQualiAgua: TgQualiAgua): TACBrXmlNode;
var
  i: integer;
  nodeArray: TACBrXmlNodeArray;
begin
  Result := nil;

  if (gQualiAgua.CompetAnalise > 0) then
  begin
    Result := FDocument.CreateElement('gQualiAgua');

    Result.AppendChild(AddNode(tcStr, '#300', 'CompetAnalise', 6, 6, 1,
        FormatDateTime('yyyymm', gQualiAgua.CompetAnalise), DSC_COMPETANALISE));

    nodeArray := GerargAnalise(gQualiAgua.gAnalise);
    for i := 0 to gQualiAgua.gAnalise.Count - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;

    Result.AppendChild(AddNode(tcStr, '#309', 'Conclusao', 2, 50, 0,
                                          gQualiAgua.Conclusao, DSC_CONCLUSAO));

    Result.AppendChild(AddNode(tcStr, '#309', 'cProcesso', 2, 50, 0,
                                          gQualiAgua.cProcesso, DSC_CPROCESSO));

    Result.AppendChild(AddNode(tcStr, '#309', 'SistemaAbast', 2, 50, 0,
                                    gQualiAgua.SistemaAbast, DSC_SISTEMAABAST));
  end;
end;

function TNFAgXmlWriter.GerargAnalise(
  gAnalise: TgAnaliseCollection): TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, gAnalise.Count);

  for i := 0 to gAnalise.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('gAnalise');

    Result[i].AppendChild(AddNode(tcStr, '#308', 'xItemAnalisado', 2, 60, 1,
                               gAnalise[i].xItemAnalisado, DSC_XITEMANALISADO));

    Result[i].AppendChild(AddNode(tcStr, '#308', 'nAmostraMinima', 4, 4, 0,
                               gAnalise[i].nAmostraMinima, DSC_NAMOSTRAMINIMA));

    Result[i].AppendChild(AddNode(tcStr, '#308', 'nAmostraAnalisada', 4, 4, 0,
                         gAnalise[i].nAmostraAnalisada, DSC_NAMOSTRAANALISADA));

    Result[i].AppendChild(AddNode(tcStr, '#308', 'nAmostraFPadrao', 4, 4, 0,
                             gAnalise[i].nAmostraFPadrao, DSC_NAMOSTRAFPADRAO));

    Result[i].AppendChild(AddNode(tcStr, '#308', 'nAmostraDPadrao', 4, 4, 0,
                             gAnalise[i].nAmostraDPadrao, DSC_NAMOSTRADPADRAO));

    Result[i].AppendChild(AddNode(tcStr, '#308', 'nMediaMensal', 2, 60, 0,
                                  gAnalise[i].nMediaMensal, DSC_NMEDIDAMENSAL));

    Result[i].AppendChild(AddNode(tcStr, '#308', 'xValorReferencia', 2, 60, 0,
                           gAnalise[i].xValorReferencia, DSC_xVALORREFERENCIA));
  end;

  if gAnalise.Count > 10 then
    wAlerta('#304', 'gAnalise', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFAgXmlWriter.GerarautXML: TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, NFAg.autXML.Count);

  for i := 0 to NFAg.autXML.Count - 1 do
  begin
    Result[i] := FDocument.CreateElement('autXML');

    Result[i].AppendChild(AddNodeCNPJCPF('#305', '#306', NFAg.autXML[i].CNPJCPF));
  end;

  if NFAg.autXML.Count > 10 then
    wAlerta('#304', 'autXML', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFAgXmlWriter.GerarInfAdic: TACBrXmlNode;
begin
  Result := nil;

  if (trim(NFAg.InfAdic.infAdFisco) <> '') or (trim(NFAg.InfAdic.infCpl) <> '') then
  begin
    Result := FDocument.CreateElement('infAdic');

    Result.AppendChild(AddNode(tcStr, '#308', 'infAdFisco', 1, 2000, 0,
      NFAg.InfAdic.infAdFisco, DSC_INFADFISCO));

    Result.AppendChild(AddNode(tcStr, '#309', 'infCpl', 1, 5000, 0,
      NFAg.InfAdic.infCpl, DSC_INFCPL));
  end;
end;

function TNFAgXmlWriter.GerarInfPAA: TACBrXmlNode;
begin
  Result := nil;

  if (NFAg.infPAA.CNPJPAA <> '') then
  begin
    Result := FDocument.CreateElement('infPAA');

    Result.AppendChild(AddNode(tcStr, '#309', 'CNPJPAA', 14, 14, 1,
                                             NFAg.infPAA.CNPJPAA, DSC_CNPJPAA));
  end;
end;

function TNFAgXmlWriter.GerargRespTec: TACBrXmlNode;
begin
  Result := nil;

  if (NFAg.infRespTec.CNPJ <> '') then
  begin
    Result := FDocument.CreateElement('gRespTec');

    Result.AppendChild(AddNodeCNPJ('#311', NFAg.infRespTec.CNPJ, CODIGO_BRASIL, True));

    Result.AppendChild(AddNode(tcStr, '#312', 'xContato', 2, 60, 1,
      NFAg.infRespTec.xContato, DSC_XCONTATO));

    Result.AppendChild(AddNode(tcStr, '#313', 'email', 6, 60, 1,
      NFAg.infRespTec.email, DSC_EMAIL));

    Result.AppendChild(AddNode(tcStr, '#314', 'fone', 7, 12, 1,
      NFAg.infRespTec.fone, DSC_FONE));

    if (idCSRT <> 0) and (CSRT <> '') then
    begin
      Result.AppendChild(AddNode(tcInt, '#315', 'idCSRT', 3, 3, 1,
         idCSRT, DSC_IDCSRT));

      Result.AppendChild(AddNode(tcStr, '#316', 'hashCSRT', 28, 28, 1,
        CalcularHashCSRT(CSRT, FChaveNFAg), DSC_HASHCSRT));
    end;
  end;
end;

function TNFAgXmlWriter.Gerar_ProtNFAg: TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('protNFAg');

  Result.SetAttribute('versao', FloatToString(NFAg.infNFAg.Versao, '.', '#0.00'));

  xmlNode := Result.AddChild('infProt');

  xmlNode.AddChild('tpAmb').Content := TipoAmbienteToStr(NFAg.procNFAg.tpAmb);

  xmlNode.AddChild('verAplic').Content := NFAg.procNFAg.verAplic;

  xmlNode.AddChild('chNFAg').Content := NFAg.procNFAg.chDFe;

  xmlNode.AddChild('dhRecbto').Content :=
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', NFAg.procNFAg.dhRecbto) +
    GetUTC(CodigoUFparaUF(FNFAg.Ide.cUF), NFAg.procNFAg.dhRecbto);

  xmlNode.AddChild('nProt').Content := NFAg.procNFAg.nProt;

  xmlNode.AddChild('digVal').Content := NFAg.procNFAg.digVal;

  xmlNode.AddChild('cStat').Content := IntToStr(NFAg.procNFAg.cStat);

  xmlNode.AddChild('xMotivo').Content := NFAg.procNFAg.xMotivo;
end;

end.
