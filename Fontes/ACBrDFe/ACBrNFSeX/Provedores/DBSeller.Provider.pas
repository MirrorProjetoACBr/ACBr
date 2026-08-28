{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
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

unit DBSeller.Provider;

interface

uses
  SysUtils, Classes,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXConsts,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv1,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  PadraoNacional.Provider;

type
  TACBrNFSeXWebserviceDBSeller = class(TACBrNFSeXWebserviceSoap11)
  private
    function GetNamespace: string;

  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarSituacao(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSe(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;

    property Namespace: string read GetNamespace;
  end;

  TACBrNFSeProviderDBSeller = class (TACBrNFSeProviderABRASFv1)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetorno';
                                     const AMessageTag: string = 'MensagemRetorno'); override;

  end;

  TACBrNFSeXWebserviceDBSeller204 = class(TACBrNFSeXWebserviceSoap11)
  private
    function GetNamespace: string;

  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;

    property Namespace: string read GetNamespace;
  end;

  TACBrNFSeProviderDBSeller204 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetorno';
                                     const AMessageTag: string = 'MensagemRetorno'); override;

    procedure GerarMsgDadosConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;

  public
    function tpDedRedToStr(const t: TtpDedRed): string; override;
    function StrTotpDedRed(out ok: Boolean; const s: string): TtpDedRed; override;
  end;

  TACBrNFSeXWebserviceDBSellerAPIPropria = class(TACBrNFSeXWebserviceMisto1)
  private
    function GetNamespace: string;

  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarSituacao(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSe(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    {
    function EnviarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorChave(const ACabecalho, AMSG: string): string; override;
    function ConsultarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarDFe(const ACabecalho, AMSG: string): string; override;
    function ConsultarParam(const ACabecalho, AMSG: string): string; override;
    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;
    }
    function TratarXmlRetornado(const aXML: string): string; override;

    property Namespace: string read GetNamespace;
  end;

  TACBrNFSeProviderDBSellerAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private

  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function VerificarAlerta(const ACodigo, AMensagem, ACorrecao: string): Boolean;
    function VerificarErro(const ACodigo, AMensagem, ACorrecao: string): Boolean;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetorno';
                                     const AMessageTag: string = 'MensagemRetorno'); override;

    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaSituacao(Response: TNFSeConsultaSituacaoResponse); override;
    procedure GerarMsgDadosConsultaSituacao(Response: TNFSeConsultaSituacaoResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaSituacao(Response: TNFSeConsultaSituacaoResponse); override;
    {

    procedure PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    procedure GerarMsgDadosConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    }
    procedure PrepararEnviarEvento(Response: TNFSeEnviarEventoResponse); override;
    procedure TratarRetornoEnviarEvento(Response: TNFSeEnviarEventoResponse); override;

  public

  end;

implementation

uses
  ACBrJSON,
  ACBrUtil.Base,
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrXmlBase,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXNotasFiscais,
  DBSeller.GravarXml,
  DBSeller.LerXml;

{ TACBrNFSeXWebserviceDBSeller }

function TACBrNFSeXWebserviceDBSeller.GetNamespace: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 1 then
    Result := 'producao'
  else
    Result := 'homologacao';

  Result := 'xmlns:e="' + BaseUrl + '/webservice/index/' + Result + '"';
end;

function TACBrNFSeXWebserviceDBSeller.Recepcionar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:RecepcionarLoteRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:RecepcionarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'EnviarLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller.ConsultarLote(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarLoteRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller.ConsultarSituacao(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarSituacaoLoteRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarSituacaoLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarSituacaoLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller.ConsultarNFSePorRps(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfsePorRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarNfsePorRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller.ConsultarNFSe(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfse>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarNfse>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:CancelarNfse>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:CancelarNfse>';

  Result := Executar('', Request,
                     ['return', 'CancelarNfseResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverPrefixosDesnecessarios(Result);
end;

{ TACBrNFSeProviderDBSeller }

procedure TACBrNFSeProviderDBSeller.Configuracao;
begin
  inherited Configuracao;

  ConfigGeral.Identificador := '';

  with ConfigAssinar do
  begin
    LoteRps := True;
    IncluirURI := False;
  end;
end;

function TACBrNFSeProviderDBSeller.CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_DBSeller.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderDBSeller.CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_DBSeller.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderDBSeller.CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceDBSeller.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderDBSeller.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse;
  const AListTag, AMessageTag: string);
var
  ANode: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;
  Mensagem: string;
begin
  ANode := RootNode.Childrens.FindAnyNs(AListTag);

  if (ANode = nil) then
  begin
    ANode := RootNode.Childrens.FindAnyNs('ErroWebServiceResposta');

    if ANode <> nil then
    begin
      Mensagem := ObterConteudoTag(ANode.Childrens.FindAnyNs('MensagemErro'), tcStr);

      if Mensagem <> '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoErro'), tcStr);
        AErro.Descricao := Mensagem;
        AErro.Correcao := '';
      end;
    end;
  end
  else
    inherited ProcessarMensagemErros(RootNode, Response, AListTag, AMessageTag);
end;

{ TACBrNFSeXWebserviceDBSeller204 }

function TACBrNFSeXWebserviceDBSeller204.GetNamespace: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 1 then
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Producao.NameSpace
  else
    Result := TACBrNFSeX(FPDFeOwner).Provider.ConfigWebServices.Homologacao.NameSpace;

  Result := 'xmlns:e="' + Result + '"';
end;

function TACBrNFSeXWebserviceDBSeller204.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:RecepcionarLoteRps>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:RecepcionarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'EnviarLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
//var
//  Request: string;
begin
  inherited RecepcionarSincrono(ACabecalho, AMSG);

// End-Point de envio síncrono não existe no ?WSDL
//  FPMsgOrig := AMSG;
//
//  Request := '<e:RecepcionarLoteRpsSincrono>';
//  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
//  Request := Request + '</e:RecepcionarLoteRpsSincrono>';
//
//  Result := Executar('', Request,
//                     ['return'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.GerarNFSe(const ACabecalho,
  AMSG: String): string;
//var
//  Request: string;
begin
  inherited GerarNFSe(ACabecalho, AMSG);

// End-Point de envio unitário não existe no ?WSDL
//  FPMsgOrig := AMSG;
//
//  Request := '<e:GerarNfse>';
//  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
//  Request := Request + '</e:GerarNfse>';
//
//  Result := Executar('', Request,
//                     ['return'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarLoteRps>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:ConsultarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfsePorFaixa>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:ConsultarNfsePorFaixa>';

  Result := Executar('', Request,
                     ['return'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfsePorRps>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:ConsultarNfsePorRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.ConsultarNFSeServicoPrestado(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfseServicoPrestado>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:ConsultarNfseServicoPrestado>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseServicoPrestadoResposta'],
                     [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfseServicoTomado>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:ConsultarNfseServicoTomado>';

  Result := Executar('', Request,
                     ['return'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.Cancelar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:CancelarNfse>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:CancelarNfse>';

  Result := Executar('', Request,
                     ['return', 'CancelarNfseResposta'],
                     [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:SubstituirNfse>';
  Request := Request + '<xml>' + XmlToStr(AMSG) + '</xml>';
  Request := Request + '</e:SubstituirNfse>';

  Result := Executar('', Request,
                     ['return'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSeller204.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverPrefixosDesnecessarios(Result);
end;

{ TACBrNFSeProviderDBSeller204 }

procedure TACBrNFSeProviderDBSeller204.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    Identificador := '';
    ConsultaPorFaixaPreencherNumNfseFinal := True;
    ModoEnvio := meLoteAssincrono;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.04';
    VersaoAtrib := '2.04';
    AtribVerLote := 'versao';
  end;

  ConfigMsgDados.GerarPrestadorLoteRps := True;

  ConfigAssinar.LoteRps := True;
  ConfigSchemas.Validar := False;
end;

function TACBrNFSeProviderDBSeller204.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_DBSeller204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderDBSeller204.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_DBSeller204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderDBSeller204.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceDBSeller204.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderDBSeller204.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse; const AListTag,
  AMessageTag: string);
var
  ANode: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;
  Mensagem: string;
begin
  ANode := RootNode.Childrens.FindAnyNs(AListTag);

  if (ANode = nil) then
  begin
    ANode := RootNode.Childrens.FindAnyNs('ErroWebServiceResposta');

    if ANode <> nil then
    begin
      Mensagem := ObterConteudoTag(ANode.Childrens.FindAnyNs('MensagemErro'), tcStr);

      if Mensagem <> '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoErro'), tcStr);
        AErro.Descricao := Mensagem;
        AErro.Correcao := '';
      end;
    end;
  end
  else
    inherited ProcessarMensagemErros(RootNode, Response, AListTag, AMessageTag);
end;

function TACBrNFSeProviderDBSeller204.StrTotpDedRed(out ok: Boolean;
  const s: string): TtpDedRed;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3', '4', '5', '6', '7', '8', '99'],
    [drMateriais, drSubEmpreitada, drServicos, drProducaoExt, drAlimentacao,
    drReembolso, drRepasseConsorciado, drRepassePlanoSaude, drOutrasDeducoes]);
end;

function TACBrNFSeProviderDBSeller204.tpDedRedToStr(const t: TtpDedRed): string;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3', '4', '5', '6', '7', '8', '99'],
    [drMateriais, drSubEmpreitada, drServicos, drProducaoExt, drAlimentacao,
    drReembolso, drRepasseConsorciado, drRepassePlanoSaude, drOutrasDeducoes]);
end;

procedure TACBrNFSeProviderDBSeller204.GerarMsgDadosConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<' + Prefixo + 'Prestador>' +
                  '<' + Prefixo2 + 'CpfCnpj>' +
                    GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                  '</' + Prefixo2 + 'CpfCnpj>' +
                  GetInscMunic(Emitente.InscMun, Prefixo2) +
                '</' + Prefixo + 'Prestador>';

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseServicoPrestadoEnvio' + NameSpace + '>' +
                               '<ConsultarNfseEnvio>' +
                                 Prestador +
                                 Xml +
                               '</ConsultarNfseEnvio>' +
                             '</' + Prefixo + 'ConsultarNfseServicoPrestadoEnvio>';
  end;
end;

{ TACBrNFSeXWebserviceDBSeller }

function TACBrNFSeXWebserviceDBSellerAPIPropria.GetNamespace: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 1 then
    Result := 'producao'
  else
    Result := 'homologacao';

  Result := 'xmlns:e="' + BaseUrl + '/webservice/index/' + Result + '"';
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.Recepcionar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<e:RecepcionarLoteRps>';
  Request := Request + '<xml><![CDATA[' + FPMsgOrig + ']]></xml>';
//  Request := Request + '<xml>' + XmlToStr(FPMsgOrig) + '</xml>';
  Request := Request + '</e:RecepcionarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'EnviarLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.ConsultarLote(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarLoteRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.ConsultarSituacao(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarSituacaoLoteRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarSituacaoLoteRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarSituacaoLoteRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.ConsultarNFSePorRps(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfsePorRps>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarNfsePorRps>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseRpsResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.ConsultarNFSe(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:ConsultarNfse>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:ConsultarNfse>';

  Result := Executar('', Request,
                     ['return', 'ConsultarNfseResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<e:CancelarNfse>';
  Request := Request + '<xml><![CDATA[' + AMSG + ']]></xml>';
  Request := Request + '</e:CancelarNfse>';

  Result := Executar('', Request,
                     ['return', 'CancelarNfseResposta'], [Namespace]);
end;

function TACBrNFSeXWebserviceDBSellerAPIPropria.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverPrefixosDesnecessarios(Result);
end;

{ TACBrNFSeProviderDBSellerAPIPropria }

procedure TACBrNFSeProviderDBSellerAPIPropria.Configuracao;
var
  VersaoDFe: string;
begin
  inherited Configuracao;

  VersaoDFe := VersaoNFSeToStr(TACBrNFSeX(FAOwner).Configuracoes.Geral.Versao);

  with ConfigGeral do
  begin
    Layout := loPadraoNacional;
    QuebradeLinha := '|';
    ConsultaLote := False;
    FormatoArqEnvio := tfaXml;
    FormatoArqRetorno := tfaXml;
    FormatoArqEnvioSoap := tfaXml;
    FormatoArqRetornoSoap := tfaXml;

    ServicosDisponibilizados.EnviarUnitario := True;
    ServicosDisponibilizados.EnviarEvento := True;
    ServicosDisponibilizados.ConsultarNfseChave := True;
    ServicosDisponibilizados.ConsultarRps := True;
    ServicosDisponibilizados.ConsultarEvento := True;
    ServicosDisponibilizados.ConsultarDFe := True;
    ServicosDisponibilizados.ConsultarParam := True;
    ServicosDisponibilizados.ObterDANFSE := True;

    Particularidades.AtendeReformaTributaria := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := VersaoDFe;
    VersaoAtrib := VersaoDFe;

    AtribVerLote := 'versao';
  end;

  SetXmlNameSpace('http://www.sped.fazenda.gov.br/nfse');

  with ConfigMsgDados do
  begin
    UsarNumLoteConsLote := False;

    DadosCabecalho := GetCabecalho('');

    XmlRps.InfElemento := 'infNFSe';
    XmlRps.DocElemento := 'NFSe';

    EnviarEvento.InfElemento := 'infPedReg';
    EnviarEvento.DocElemento := 'pedRegEvento';
  end;

  with ConfigAssinar do
  begin
    RpsGerarNFSe := False;
    EnviarEvento := False;
  end;

  SetNomeXSD('***');

  with ConfigSchemas do
  begin
    GerarNFSe := 'DPS_v' + VersaoDFe + '.xsd';
    ConsultarNFSe := 'DPS_v' + VersaoDFe + '.xsd';
    ConsultarNFSeRps := 'DPS_v' + VersaoDFe + '.xsd';
    EnviarEvento := 'pedRegEvento_v' + VersaoDFe + '.xsd';
    ConsultarEvento := 'DPS_v' + VersaoDFe + '.xsd';

    Validar := False;
  end;
end;

function TACBrNFSeProviderDBSellerAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_DBSellerAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderDBSellerAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_DBSellerAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderDBSellerAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmConsultarEvento, tmConsultarDFe, tmConsultarParam,
                 tmConsultarNFSePorChave, tmObterDANFSE] then
    AMimeType := 'application/json'
  else
    AMimeType := 'text/xml';

  if URL <> '' then
  begin
    URL := URL + Path;

    Result := TACBrNFSeXWebserviceDBSellerAPIPropria.Create(FAOwner, AMetodo,
      URL, Method, AMimeType);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderDBSellerAPIPropria.VerificarAlerta(
  const ACodigo, AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) > 0);
end;

function TACBrNFSeProviderDBSellerAPIPropria.VerificarErro(const ACodigo,
  AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) = 0);
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse; const AListTag,
  AMessageTag: string);
var
  I: Integer;
  ANode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
  AAlerta: TNFSeEventoCollectionItem;
  Codigo, Mensagem: string;

procedure ProcessarErro(ErrorNode: TACBrXmlNode; const ACodigo, AMensagem: string);
var
  Item: TNFSeEventoCollectionItem;
  Correcao: string;
begin
  Correcao := ObterConteudoTag(ErrorNode.Childrens.FindAnyNs('Correcao'), tcStr);

  if (ACodigo = '') and (AMensagem = '') then
    Exit;

  if VerificarAlerta(ACodigo, AMensagem, Correcao) then
    Item := Response.Alertas.New
  else if VerificarErro(ACodigo, AMensagem, Correcao) then
    Item := Response.Erros.New
  else
    Exit;

  Item.Codigo := ACodigo;
  Item.Descricao := AMensagem;
  Item.Correcao := Correcao;
end;

procedure ProcessarErros;
var
  I: Integer;
begin
  if Assigned(ANode) then
  begin
    ANodeArray := ANode.Childrens.FindAllAnyNs(AMessageTag);

    if Assigned(ANodeArray) then
    begin
      for I := Low(ANodeArray) to High(ANodeArray) do
      begin
        Codigo := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('Codigo'), tcStr);
        Mensagem := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('Mensagem'), tcStr);

        ProcessarErro(ANodeArray[I], Codigo, Mensagem);
      end;
    end
    else
    begin
      Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('Codigo'), tcStr);
      Mensagem := ObterConteudoTag(ANode.Childrens.FindAnyNs('Mensagem'), tcStr);

      ProcessarErro(ANode, Codigo, Mensagem);
    end;
  end;
end;

begin
  ANode := RootNode.Childrens.FindAnyNs(AListTag);

  if (ANode = nil) then
  begin
    ANode := RootNode.Childrens.FindAnyNs('ErroWebServiceResposta');

    if ANode <> nil then
    begin
      Mensagem := ObterConteudoTag(ANode.Childrens.FindAnyNs('MensagemErro'), tcStr);

      if Mensagem <> '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoErro'), tcStr);
        AErro.Descricao := Mensagem;
        AErro.Correcao := '';
      end;
    end;
  end
  else
  begin
    ANode := RootNode.Childrens.FindAnyNs(AListTag);

    ProcessarErros;

    ANode := RootNode.Childrens.FindAnyNs('ListaMensagemAlertaRetorno');

    if Assigned(ANode) then
    begin
      ANodeArray := ANode.Childrens.FindAllAnyNs(AMessageTag);

      if Assigned(ANodeArray) then
      begin
        for I := Low(ANodeArray) to High(ANodeArray) do
        begin
          Mensagem := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('Mensagem'), tcStr);

          if Mensagem <> '' then
          begin
            AAlerta := Response.Alertas.New;
            AAlerta.Codigo := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('Codigo'), tcStr);
            AAlerta.Descricao := Mensagem;
            AAlerta.Correcao := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('Correcao'), tcStr);
          end;
        end;
      end
      else
      begin
        Mensagem := ObterConteudoTag(ANode.Childrens.FindAnyNs('Mensagem'), tcStr);

        if Mensagem <> '' then
        begin
          AAlerta := Response.Alertas.New;
          AAlerta.Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('Codigo'), tcStr);
          AAlerta.Descricao := Mensagem;
          AAlerta.Correcao := ObterConteudoTag(ANode.Childrens.FindAnyNs('Correcao'), tcStr);
        end;
      end;
    end
    else
    begin
      Mensagem := ObterConteudoTag(RootNode.Childrens.FindAnyNs('MensagemErro'), tcStr);

      if Mensagem <> '' then
      begin
        AAlerta := Response.Alertas.New;
        AAlerta.Codigo := ObterConteudoTag(RootNode.Childrens.FindAnyNs('Codigo'), tcStr);
        AAlerta.Descricao := Mensagem;
        AAlerta.Correcao := ObterConteudoTag(RootNode.Childrens.FindAnyNs('Correcao'), tcStr);
      end;
    end;
  end;
end;

function TACBrNFSeProviderDBSellerAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;

  if aMetodo in [tmGerar, tmEnviarEvento] then
    Result := ChangeLineBreak(aXml, '');
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.PrepararEmitir(
  Response: TNFSeEmiteResponse);
var
  AErro: TNFSeEventoCollectionItem;
  Nota: TNotaFiscal;
  IdAttr, ListaDps: string;
  I: Integer;
begin
  if TACBrNFSeX(FAOwner).NotasFiscais.Count <= 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod002;
    AErro.Descricao := ACBrStr(Desc002);
  end;

  if TACBrNFSeX(FAOwner).NotasFiscais.Count > Response.MaxRps then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod003;
    AErro.Descricao := ACBrStr('Conjunto de DPS transmitidos (máximo de ' +
                       IntToStr(Response.MaxRps) + ' DPS)' +
                       ' excedido. Quantidade atual: ' +
                       IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count));
  end;

  if Response.Erros.Count > 0 then Exit;

  ListaDps := '';

  if ConfigAssinar.IncluirURI then
    IdAttr := ConfigGeral.Identificador
  else
    IdAttr := 'ID';

  for I := 0 to TACBrNFSeX(FAOwner).NotasFiscais.Count -1 do
  begin
    Nota := TACBrNFSeX(FAOwner).NotasFiscais.Items[I];

    Nota.GerarXML;

    Nota.XmlRps := ConverteXMLtoUTF8(Nota.XmlRps);
    Nota.XmlRps := ChangeLineBreak(Nota.XmlRps, '');

    Response.ArquivoEnvio := Nota.XmlRps;
    SalvarXmlRps(Nota);

    ListaDps := ListaDps + Nota.XmlRps;
  end;

//  if TACBrNFSeX(FAOwner).NotasFiscais.Count > 1 then
//    Response.ArquivoEnvio := '<Lote>' + ListaDps + '</Lote>'
//  else
    Response.ArquivoEnvio := ListaDps;

  Path := '';
  Method := 'POST';
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  {
  DocJson, JSon: TACBrJSONObject;
  JSonLista: TACBrJSONArray;
  ANode, AuxNode: TACBrXmlNode;
  ANota: TNotaFiscal;
  resposta: string;
  i: Integer;
  }
begin
  Document := TACBrXmlDocument.Create;
  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ProcessarMensagemErros(Document.Root, Response);
      (*
      ANode := Document.Root.Childrens.FindAnyNs('outputXML');

      if Assigned(ANode) then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('GerarNfseResposta');

        if Assigned(AuxNode) then
        begin
          ProcessarMensagemErros(AuxNode, Response);

          Response.Data := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhRecebimento'), tcDatHor);
          Response.Protocolo := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('protocolo'), tcStr);
          Response.Situacao := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('status'), tcStr);
        end;
      end;

      if Assigned(ANode) then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('NFSe');

        if Assigned(AuxNode) then
        begin
          ANota := TACBrNFSeX(FAOwner).NotasFiscais.Items[0];
          ANota := CarregarXmlNfse(ANota, AuxNode.OuterXml);
          SalvarXmlNfse(ANota);
        end;
      end;

      ANode := Document.Root.Childrens.FindAnyNs('respostaADN');

      if Assigned(ANode) then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('RespostaADN');

        if Assigned(AuxNode) then
        begin
          resposta := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('resposta'), tcStr);
          // o conteudo da variável resposta é um Json

          DocJson := TACBrJsonObject.Parse(resposta);

          try
            Response.Data := DocJson.AsISODateTime['DataHoraProcessamento'];
            try
              JSonLista := DocJson.AsJSONArray['Lote'];

              for i := 0 to JSonLista.Count-1 do
              begin
                JSon := JSonLista.ItemAsJSONObject[i];

                Response.Link := JSon.AsString['ChaveAcesso'];
              end;
            except
              on E:Exception do
              begin
                AErro := Response.Erros.New;
                AErro.Codigo := Cod999;
                AErro.Descricao := ACBrStr(Desc999 + E.Message);
              end;
            end;
          finally
            FreeAndNil(DocJson);
          end;
        end;
      end;
      *)
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.PrepararConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  NameSpace, Prefixo, PrefixoTS: string;
begin
  if EstaVazio(Response.Protocolo) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod101;
    AErro.Descricao := ACBrStr(Desc101);
    Exit;
  end;

  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.ConsultarSituacao.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarSituacao.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarSituacao.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarSituacao.xmlns) and
       ((ConfigMsgDados.Prefixo <> '') or (ConfigMsgDados.PrefixoTS <> '')) then
    begin
      if ConfigMsgDados.PrefixoTS = '' then
        NameSpace := NameSpace + ' xmlns="' + ConfigMsgDados.XmlRps.xmlns + '"'
      else
      begin
        NameSpace := NameSpace+ ' xmlns:' + ConfigMsgDados.PrefixoTS + '="' +
                                            ConfigMsgDados.XmlRps.xmlns + '"';
        PrefixoTS := ConfigMsgDados.PrefixoTS + ':';
      end;
    end
    else
    begin
      if ConfigMsgDados.PrefixoTS <> '' then
        PrefixoTS := ConfigMsgDados.PrefixoTS + ':';
    end;
  end;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := '';
    aParams.TagEnvio := '';
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaSituacao(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.GerarMsgDadosConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarSituacaoLoteRpsEnvio' + {NameSpace +} '>' +
                           '<' + Prefixo + 'Prestador>' +
                             '<' + Prefixo2 + 'Cnpj>' +
                               OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                             '</' + Prefixo2 + 'Cnpj>' +
                             GetInscMunic(Emitente.InscMun, Prefixo2) +
                           '</' + Prefixo + 'Prestador>' +
                           '<' + Prefixo + 'Protocolo>' +
                             Response.Protocolo +
                           '</' + Prefixo + 'Protocolo>' +
                         '</' + Prefixo + 'ConsultarSituacaoLoteRpsEnvio>';
  end;
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.TratarRetornoConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  Ok: Boolean;
  Situacao: TSituacaoLoteRps;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ProcessarMensagemErros(Document.Root, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      Response.NumeroLote := ObterConteudoTag(Document.Root.Childrens.FindAnyNs('NumeroLote'), tcStr);
      Response.Situacao := ObterConteudoTag(Document.Root.Childrens.FindAnyNs('Situacao'), tcStr);

      if not Response.Sucesso then
        Response.Situacao := '3';

      Situacao := TACBrNFSeX(FAOwner).Provider.StrToSituacaoLoteRps(Ok, Response.Situacao);
      Response.DescSituacao := TACBrNFSeX(FAOwner).Provider.SituacaoLoteRpsToDescr(Situacao);
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.PrepararEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  AErro: TNFSeEventoCollectionItem;
  xEvento, xUF, xAutorEvento, IdAttrPRE, IdAttrEVT, xCamposEvento, nomeArq,
  CnpjCpf, NumNFSe: string;
begin
  with Response.InfEvento.pedRegEvento do
  begin
    if chNFSe = '' then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod004;
      AErro.Descricao := ACBrStr(Desc004);
    end;

    if Response.Erros.Count > 0 then Exit;

    xUF := TACBrNFSeX(FAOwner).Configuracoes.WebServices.UF;

    CnpjCpf := OnlyCPFCNPJAlphaNum(TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente.CNPJ);
    if Length(CnpjCpf) < 14 then
    begin
      xAutorEvento := '<CPFAutor>' +
                        CnpjCpf +
                      '</CPFAutor>';
    end
    else
    begin
      xAutorEvento := '<CNPJAutor>' +
                        CnpjCpf +
                      '</CNPJAutor>';
    end;


    ID := chNFSe + OnlyNumber(tpEventoToStr(tpEvento));

    IdAttrPRE := 'Id="' + 'PRE' + ID + '"';

    ID := chNFSe + OnlyNumber(tpEventoToStr(tpEvento)) +
              FormatFloat('000', nPedRegEvento);

    IdAttrEVT := 'Id="' + 'EVT' + ID + '"';

    case tpEvento of
      teCancelamento,
      teAnaliseParaCancelamento:
        xCamposEvento := '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>';


      teCancelamentoSubstituicao:
        xCamposEvento := '<cMotivo>' + Formatfloat('00', cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>' +
                         '<chSubstituta>' + chSubstituta + '</chSubstituta>';

      teRejeicaoPrestador,
      teRejeicaoTomador,
      teRejeicaoIntermediario:
        xCamposEvento := '<infRej>' +
                           '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                           '<xMotivo>' + xMotivo + '</xMotivo>' +
                         '</infRej>';
    else
      // teConfirmacaoPrestador, teConfirmacaoTomador,
      // ConfirmacaoIntermediario
      xCamposEvento := '';
    end;

    //NumNFSe := Copy(chNFSe, 24, 13);
    NumNFSe := trim(IntTostr(StrToInt(Copy(chNFSe, 28, 9)))) ;

    xEvento := '<pedRegEvento versao="' + ConfigWebServices.VersaoAtrib + '">' +

                 '<infPedReg ' + IdAttrPRE + '>' +
                   '<tpAmb>' + IntToStr(tpAmb) + '</tpAmb>' +
                   '<verAplic>' + verAplic + '</verAplic>' +
                   '<dhEvento>' +
                     FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', dhEvento) +
                     GetUTC(xUF, dhEvento) +
                   '</dhEvento>' +
                   xAutorEvento +
                   '<chNFSe>' + chNFSe + '</chNFSe>' +
                   '<' + tpEventoToStr(tpEvento) + '>' +
                     '<xDesc>' + tpEventoToDesc(tpEvento) + '</xDesc>' +
                     xCamposEvento +
                   '</' + tpEventoToStr(tpEvento) + '>' +
                 '</infPedReg>' +
               '</pedRegEvento>';

    xEvento := '<evento xmlns="' + ConfigMsgDados.EnviarEvento.xmlns +
                           '" versao="' + ConfigWebServices.VersaoAtrib + '">' +
                 '<infEvento ' + IdAttrEVT + '>' +
                   '<verAplic>' + verAplic + '</verAplic>' +
                   '<ambGer>' + '1' + '</ambGer>' +
                   '<nSeqEvento>' + '1' + '</nSeqEvento>' +
                   '<dhProc>' +
                     FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', dhEvento) +
                     GetUTC(xUF, dhEvento) +
                   '</dhProc>' +
                   '<nDFSe>' + NumNFSe + '</nDFSe>' +
                    xEvento +
                 '</infEvento>' +
               '</evento>';

    xEvento := ConverteXMLtoUTF8(xEvento);
    xEvento := ChangeLineBreak(xEvento, '');

    Response.ArquivoEnvio := xEvento;

    nomeArq := '';
    SalvarXmlEvento(ID + '-pedRegEvento', Response.ArquivoEnvio, nomeArq, dhEvento);
    Response.PathNome := nomeArq;
    Path := '';
    Method := 'POST';
  end;
end;

procedure TACBrNFSeProviderDBSellerAPIPropria.TratarRetornoEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  Document{, DocumentXml}: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  resposta{, IDEvento, nomeArq}: string;
//  Ok: Boolean;
  DocJson, JSon: TACBrJSONObject;
  JSonLista: TACBrJSONArray;
  i: Integer;
begin
  Document := TACBrXmlDocument.Create;
  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root.Childrens.FindAnyNs('outputXML');

      if Assigned(ANode) then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('CancelarNfseResposta');

        if Assigned(AuxNode) then
        begin
          ProcessarMensagemErros(AuxNode, Response);

          Response.Data := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhRecebimento'), tcDatHor);
          Response.Protocolo := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('protocolo'), tcStr);
          Response.Situacao := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('status'), tcStr);
        end;
      end;

      ANode := Document.Root.Childrens.FindAnyNs('respostaADN');

      if Assigned(ANode) then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('RespostaADN');

        if Assigned(AuxNode) then
        begin
          resposta := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('resposta'), tcStr);
          // o conteudo da variável resposta é um Json

          DocJson := TACBrJsonObject.Parse(resposta);

          try
            Response.Data := DocJson.AsISODateTime['DataHoraProcessamento'];
            try
              JSonLista := DocJson.AsJSONArray['Lote'];

              for i := 0 to JSonLista.Count-1 do
              begin
                JSon := JSonLista.ItemAsJSONObject[i];

                Response.Link := JSon.AsString['ChaveAcesso'];
              end;
            except
              on E:Exception do
              begin
                AErro := Response.Erros.New;
                AErro.Codigo := Cod999;
                AErro.Descricao := ACBrStr(Desc999 + E.Message);
              end;
            end;
          finally
            FreeAndNil(DocJson);
          end;
        end;
      end;
  // Existe o elemento outputXML/GerarNfseResposta e o respostaADN
  // acredito que no elemento outputXML temos um retorno do webservice do provedor
  // no elemento respostaADN temos um retorno da API do Padrão Nacional.
      (*
      respostaADN := ObterConteudoTag(Document.Root.Childrens.FindAnyNs('respostaADN'), tcStr);

      if respostaADN <> '' then
      begin
        DocumentXml := TACBrXmlDocument.Create;

        try
          try
            if respostaADN = '' then
            begin
              AErro := Response.Erros.New;
              AErro.Codigo := Cod211;
              AErro.Descricao := ACBrStr(Desc211);
              Exit
            end;

            DocumentXml.LoadFromXml(respostaADN);

            ANode := DocumentXml.Root.Childrens.FindAnyNs('infEvento');

            IDEvento := RemoverLiteralChave(ObterConteudoTag(ANode.Attributes.Items['Id']));

            Response.nSeqEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('nSeqEvento'), tcInt);
            Response.Data := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

            ANode := ANode.Childrens.FindAnyNs('pedRegEvento');
            ANode := ANode.Childrens.FindAnyNs('infPedReg');

            if IDEvento = '' then
              IDEvento := RemoverLiteralChave(ObterConteudoTag(ANode.Attributes.Items['Id']));

            Response.idNota := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFSe'), tcStr);
            Response.idEvento := IDEvento;
            Response.tpEvento := StrTotpEvento(Ok, Copy(IDEvento, 51, 6));
            Response.XmlRetorno := respostaADN;

            case Response.tpEvento of
              teCancelamento:
                begin
                  Response.SucessoCanc := True;
                  Response.DescSituacao := 'Nota Cancelada';
                end
            else
              begin
                Response.SucessoCanc := False;
                Response.DescSituacao := '';
              end;
            end;

            nomeArq := '';
            SalvarXmlEvento(IDEvento + '-procEveNFSe', respostaADN, nomeArq);
            Response.PathNome := nomeArq;
          except
            on E:Exception do
            begin
              AErro := Response.Erros.New;
              AErro.Codigo := Cod999;
              AErro.Descricao := ACBrStr(Desc999 + E.Message);
            end;
          end;
        finally
          FreeAndNil(DocumentXml);
        end;
      end;
      *)
    except
      on E:Exception do
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod999;
        AErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

end.
