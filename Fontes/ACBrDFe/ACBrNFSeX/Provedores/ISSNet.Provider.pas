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

{
  Só funcionou usando o HttpWinNet
}

{$I ACBr.inc}

unit ISSNet.Provider;

interface

uses
  SysUtils, Classes,
  ACBrConsts,
  ACBrXmlBase,
  ACBrNFSeXClass,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrXmlDocument,
  ACBrNFSeXProviderABRASFv1,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  PadraoNacional.Provider;

type
  TACBrNFSeXWebserviceISSNet = class(TACBrNFSeXWebserviceSoap11)
  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarSituacao(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSe(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderISSNet = class (TACBrNFSeProviderABRASFv1)
  protected
    FpNameSpaceCanc: string;

    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ValidarSchema(Response: TNFSeWebserviceResponse; aMetodo: TMetodo); override;

    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse;
      Params: TNFSeParamsResponse); override;
  end;

  TACBrNFSeXWebserviceISSNet204 = class(TACBrNFSeXWebserviceSoap11)

  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function ConsultarLinkNFSe(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderISSNet204 = class (TACBrNFSeProviderABRASFv2)
  public
    function NaturezaOperacaoDescricao(const t: TnfseNaturezaOperacao): string; override;
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure GerarMsgDadosConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaporRps(Response: TNFSeConsultaNFSeporRpsResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;

    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse;
      Params: TNFSeParamsResponse); override;

    procedure PrepararConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse); override;
    procedure GerarMsgDadosConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse); override;
  end;

  TACBrNFSeXWebserviceISSNetAPIPropria = class(TACBrNFSeXWebserviceSoap11)
  protected

  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: string): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function ConsultarLinkNFSe(const ACabecalho, AMSG: String): string; override;

    function EnviarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorChave(const ACabecalho, AMSG: string): string; override;
    function ConsultarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarDFe(const ACabecalho, AMSG: string): string; override;
    function ConsultarParam(const ACabecalho, AMSG: string): string; override;
    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderISSNetAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private

  protected
    procedure Configuracao; override;

    function GetCpfCnpj(const CpfCnpj: string): string;
    function GetInscMunic(const InscMunic: string): string;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function PreencherNotaRespostaConsultaLoteRps(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaLoteRpsResponse): Boolean;
    function PreencherNotaRespostaConsultaNFSe(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaNFSeResponse): Boolean;

    function VerificarAlerta(const ACodigo, AMensagem, ACorrecao: string): Boolean;
    function VerificarErro(const ACodigo, AMensagem, ACorrecao: string): Boolean;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetornoLote';
                                     const AMessageTag: string = 'MensagemRetorno'); override;

    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;
    function PrepararRpsParaLote(const aXml: string): string; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure GerarMsgDadosEmitir(Response: TNFSeEmiteResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    procedure GerarMsgDadosConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
    procedure GerarMsgDadosConsultaporRps(Response: TNFSeConsultaNFSeporRpsResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;

    procedure PrepararConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse); override;
    procedure GerarMsgDadosConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse); override;
    procedure GerarMsgDadosConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse); override;
    procedure GerarMsgDadosConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse); override;
    procedure GerarMsgDadosConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse); override;

    procedure PrepararEnviarEvento(Response: TNFSeEnviarEventoResponse); override;
    procedure TratarRetornoEnviarEvento(Response: TNFSeEnviarEventoResponse); override;
  public

  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.DateTime,
  ACBrUtil.FilesIO,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXConsts,
  ACBrNFSeXNotasFiscais,
  ISSNet.GravarXml,
  ISSNet.LerXml,
  StrUtils,
  DateUtils;

{ TACBrNFSeProviderISSNet }

procedure TACBrNFSeProviderISSNet.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    Identificador := '';
    {
    with TACBrNFSeX(FAOwner) do
    begin
      if Configuracoes.WebServices.AmbienteCodigo = 1 then
        CodIBGE := IntToStr(Configuracoes.Geral.CodigoMunicipio)
      else
        CodIBGE := '999';
    end;
    }
  end;

  with ConfigMsgDados do
  begin
    PrefixoTS := 'tc';

    XmlRps.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd';

    LoteRps.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_enviar_lote_rps_envio.xsd';

    ConsultarSituacao.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_situacao_lote_rps_envio.xsd';

    ConsultarLote.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_lote_rps_envio.xsd';

    ConsultarNFSeRps.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_rps_envio.xsd';

    ConsultarNFSe.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_envio.xsd';

    CancelarNFSe.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_envio.xsd';

    ConsultarLinkNFSe.xmlns := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_url_visualizacao_nfse_serie_envio.xsd';
  end;

  with ConfigAssinar do
  begin
    LoteRps := True;
    CancelarNFSe := True;
  end;

  SetNomeXSD('***');

  with ConfigSchemas do
  begin
    Recepcionar := 'servico_enviar_lote_rps_envio.xsd';
    ConsultarSituacao := 'servico_consultar_situacao_lote_rps_envio.xsd';
    ConsultarLote := 'servico_consultar_lote_rps_envio.xsd';
    ConsultarNFSeRps := 'servico_consultar_nfse_rps_envio.xsd';
    ConsultarNFSe := 'servico_consultar_nfse_envio.xsd';
    CancelarNFSe := 'servico_cancelar_nfse_envio.xsd';
    ConsultarLinkNFSe := 'servico_consultar_url_visualizacao_nfse_serie_envio.xsd';
  end;

  FpNameSpaceCanc := ' xmlns:ts="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_simples.xsd"' +
                     ' xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"' +
                     ' xmlns:p1="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_envio.xsd"';
end;

function TACBrNFSeProviderISSNet.CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_ISSNet.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSNet.CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_ISSNet.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSNet.CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceISSNet.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderISSNet.GerarMsgDadosCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  InfoCanc: TInfCancelamento;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  InfoCanc := Response.InfCancelamento;

  with Params do
  begin
    NameSpace := FpNameSpaceCanc;

    Response.ArquivoEnvio := '<Pedido' + NameSpace + '>' +
                           '<' + Prefixo2 + 'InfPedidoCancelamento' + IdAttr + '>' +
                             '<' + Prefixo2 + 'IdentificacaoNfse>' +
                               '<' + Prefixo2 + 'Numero>' +
                                 InfoCanc.NumeroNFSe +
                               '</' + Prefixo2 + 'Numero>' +
                               '<' + Prefixo2 + 'Cnpj>' +
                                 OnlyCPFCNPJAlphaNum(Emitente.CNPJ) +
                               '</' + Prefixo2 + 'Cnpj>' +
                               GetInscMunic(Emitente.InscMun, Prefixo2) +
                               '<' + Prefixo2 + 'CodigoMunicipio>' +
                                  ConfigGeral.CodIBGE +
                               '</' + Prefixo2 + 'CodigoMunicipio>' +
                             '</' + Prefixo2 + 'IdentificacaoNfse>' +
                             '<' + Prefixo2 + 'CodigoCancelamento>' +
                                InfoCanc.CodCancelamento +
                             '</' + Prefixo2 + 'CodigoCancelamento>' +
                             Motivo +
                           '</' + Prefixo2 + 'InfPedidoCancelamento>' +
                         '</Pedido>';
  end;
end;

procedure TACBrNFSeProviderISSNet.ValidarSchema(
  Response: TNFSeWebserviceResponse; aMetodo: TMetodo);
var
  xXml: string;
  i, j: Integer;
begin
  if aMetodo <> tmCancelarNFSe then
  begin
    xXml := Response.ArquivoEnvio;

    i := Pos('<tc:Cnpj>', xXml) -1;
    j := Pos('<tc:InscricaoMunicipal>', xXml);

    xXml := Copy(xXml, 1, i) +
            '<tc:CpfCnpj>' + Copy(xXml, i+1, j-i-1) + '</tc:CpfCnpj>' +
            Copy(xXml, j, Length(xXml));

    Response.ArquivoEnvio := xXml;

    inherited ValidarSchema(Response, aMetodo);
  end
  else
  begin
    xXml := Response.ArquivoEnvio;
    xXml := StringReplace(xXml, FpNameSpaceCanc, '', []);
    xXml := '<p1:CancelarNfseEnvio' + FpNameSpaceCanc + '>' +
              xXml +
            '</p1:CancelarNfseEnvio>';

    Response.ArquivoEnvio := xXml;
  end;
end;

{ TACBrNFSeXWebserviceISSNet }

function TACBrNFSeXWebserviceISSNet.Recepcionar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<RecepcionarLoteRps xmlns="http://www.issnetonline.com.br/webservice/nfd">';
  Request := Request + '<xml>' + XmlToStr(CUTF8DeclaracaoXML + AMSG) + '</xml>';
  Request := Request + '</RecepcionarLoteRps>';

  Result := Executar('http://www.issnetonline.com.br/webservice/nfd/RecepcionarLoteRps',
                     Request,
                     ['RecepcionarLoteRpsResult', 'EnviarLoteRpsResposta'], []);
end;

function TACBrNFSeXWebserviceISSNet.ConsultarLote(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarLoteRps xmlns="http://www.issnetonline.com.br/webservice/nfd">';
  Request := Request + '<xml>' + XmlToStr(CUTF8DeclaracaoXML + AMSG) + '</xml>';
  Request := Request + '</ConsultarLoteRps>';

  Result := Executar('http://www.issnetonline.com.br/webservice/nfd/ConsultarLoteRps',
                     Request,
                     ['ConsultarLoteRpsResult', 'ConsultarLoteRpsResposta'], []);
end;

function TACBrNFSeXWebserviceISSNet.ConsultarSituacao(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultaSituacaoLoteRPS xmlns="http://www.issnetonline.com.br/webservice/nfd">';
  Request := Request + '<xml>' + XmlToStr(CUTF8DeclaracaoXML + AMSG) + '</xml>';
  Request := Request + '</ConsultaSituacaoLoteRPS>';

  Result := Executar('http://www.issnetonline.com.br/webservice/nfd/ConsultaSituacaoLoteRPS',
                     Request,
                     ['ConsultaSituacaoLoteRPSResult', 'ConsultarSituacaoLoteRpsResposta'], []);
end;

function TACBrNFSeXWebserviceISSNet.ConsultarNFSePorRps(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarNFSePorRPS xmlns="http://www.issnetonline.com.br/webservice/nfd">';
  Request := Request + '<xml>' + XmlToStr(CUTF8DeclaracaoXML + AMSG) + '</xml>';
  Request := Request + '</ConsultarNFSePorRPS>';

  Result := Executar('http://www.issnetonline.com.br/webservice/nfd/ConsultarNFSePorRPS',
                     Request,
                     ['ConsultarNFSePorRPSResult', 'ConsultarNfseRpsResposta'], []);
end;

function TACBrNFSeXWebserviceISSNet.ConsultarNFSe(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ConsultarNfse xmlns="http://www.issnetonline.com.br/webservice/nfd">';
  Request := Request + '<xml>' + XmlToStr(CUTF8DeclaracaoXML + AMSG) + '</xml>';
  Request := Request + '</ConsultarNfse>';

  Result := Executar('http://www.issnetonline.com.br/webservice/nfd/ConsultarNfse',
                     Request,
                     ['ConsultarNfseResult', 'ConsultarNfseResposta'], []);
end;

function TACBrNFSeXWebserviceISSNet.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<CancelarNfse xmlns="http://www.issnetonline.com.br/webservice/nfd">';
  Request := Request + '<xml>' + XmlToStr(CUTF8DeclaracaoXML + AMSG) + '</xml>';
  Request := Request + '</CancelarNfse>';

  Result := Executar('http://www.issnetonline.com.br/webservice/nfd/CancelarNfse',
                     Request,
                     ['CancelarNfseResult', 'CancelarNfseResposta'], []);
end;

function TACBrNFSeXWebserviceISSNet.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverIdentacao(Result);
  Result := RemoverPrefixosDesnecessarios(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

{ TACBrNFSeXWebserviceISSNet204 }

function TACBrNFSeXWebserviceISSNet204.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:RecepcionarLoteRps>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:RecepcionarLoteRps>';

  Result := Executar('http://nfse.abrasf.org.br/RecepcionarLoteRps', Request,
//                     ['outputXML', 'EnviarLoteRpsResposta'],
                     ['EnviarLoteRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:RecepcionarLoteRpsSincrono>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:RecepcionarLoteRpsSincrono>';

  Result := Executar('http://nfse.abrasf.org.br/RecepcionarLoteRpsSincrono', Request,
//                     ['outputXML', 'EnviarLoteRpsSincronoResposta'],
                     ['EnviarLoteRpsSincronoResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:GerarNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:GerarNfse>';

  Result := Executar('http://nfse.abrasf.org.br/GerarNfse', Request,
//                     ['outputXML', 'GerarNfseResposta'],
                     ['GerarNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeProviderISSNet204.NaturezaOperacaoDescricao(
  const t: TnfseNaturezaOperacao): string;
begin
  case t of
    no1 : Result := '1 - Exigível';
    no2 : Result := '2 - Não Incidência';
    no4 : Result := '4 - Exportação';
    no5 : Result := '5 - Imunidade';
    no6 : Result := '6 - Exigibilidade Suspensa por Decisão Judicial';
    no7 : Result := '7 - Exigibilidade Suspensa por Processo Administrativo';
  else
    Result := inherited NaturezaOperacaoDescricao(t);
  end;
end;

function TACBrNFSeXWebserviceISSNet204.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarLoteRps>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarLoteRps>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarLoteRps', Request,
//                     ['outputXML', 'ConsultarLoteRpsResposta'],
                     ['ConsultarLoteRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfsePorFaixa>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfsePorFaixa>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfsePorFaixa', Request,
//                     ['outputXML', 'ConsultarNfseFaixaResposta'],
                     ['ConsultarNfseFaixaResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfsePorRps>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfsePorRps>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfsePorRps', Request,
//                     ['outputXML', 'ConsultarNfsePorRpsResposta'],
                     ['ConsultarNfseRpsResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfseServicoPrestado>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseServicoPrestado>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfseServicoPrestado', Request,
//                     ['outputXML', 'ConsultarNfseServicoPrestadoResposta'],
                     ['ConsultarNfseServicoPrestadoResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarNfseServicoTomado>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseServicoTomado>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarNfseServicoTomado', Request,
//                     ['outputXML', 'ConsultarNfseServicoTomadoResposta'],
                     ['ConsultarNfseServicoTomadoResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.ConsultarLinkNFSe(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:ConsultarUrlNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarUrlNfse>';

  Result := Executar('http://nfse.abrasf.org.br/ConsultarUrlNfse', Request,
                     ['ConsultarUrlNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.Cancelar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:CancelarNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:CancelarNfse>';

  Result := Executar('http://nfse.abrasf.org.br/CancelarNfse', Request,
//                     ['outputXML', 'CancelarNfseResposta'],
                     ['CancelarNfseResposta'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<nfse:SubstituirNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + AMSG + '</nfseDadosMsg>';
  Request := Request + '</nfse:SubstituirNfse>';

  Result := Executar('http://nfse.abrasf.org.br/SubstituirNfse', Request,
//                     ['outputXML', 'SubstituirNfseResposta'],
                     ['SubstituirNfseResult'],
                     ['xmlns:nfse="http://nfse.abrasf.org.br"']);
end;

function TACBrNFSeXWebserviceISSNet204.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
  Result := RemoverIdentacao(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

{ TACBrNFSeProviderISSNet204 }

procedure TACBrNFSeProviderISSNet204.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    QuebradeLinha := '\s\n';
    ConsultaPorFaixaPreencherNumNfseFinal := True;

    ServicosDisponibilizados.ConsultarLinkNfse := True;
  end;

  with ConfigAssinar do
  begin
    Rps := True;
    LoteRps := True;
    ConsultarNFSeRps := True;
    ConsultarNFSePorFaixa := True;
    ConsultarNFSeServicoPrestado := True;
    ConsultarNFSeServicoTomado := True;
    ConsultarLinkNFSe := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
    SubstituirNFSe := True;

    IncluirURI := False;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.04';
    VersaoAtrib := '1.00';
  end;

  with ConfigMsgDados do
  begin
    DadosCabecalho := GetCabecalho('');
    GerarPrestadorLoteRps := True;
  end;
end;

function TACBrNFSeProviderISSNet204.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_ISSNet204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSNet204.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_ISSNet204.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSNet204.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceISSNet204.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador, NumeroLote: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador := '<Prestador>' +
                   '<CpfCnpj>' +
                     GetCpfCnpj(Emitente.CNPJ) +
                   '</CpfCnpj>' +
                   GetInscMunic(Emitente.InscMun) +
                 '</Prestador>' +
                 '<Protocolo>' +
                   Response.Protocolo +
                 '</Protocolo>';

    if ConfigMsgDados.UsarNumLoteConsLote then
      NumeroLote := '<NumeroLote>' +
                      Response.NumeroLote +
                    '</NumeroLote>';

    Response.ArquivoEnvio := '<' + TagEnvio + NameSpace + '>' +
                                 Prestador +
                                 NumeroLote +
                             '</' + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosConsultaporRps(
  Response: TNFSeConsultaNFSeporRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<Prestador>' +
                  '<CpfCnpj>' +
                    GetCpfCnpj(Emitente.CNPJ) +
                  '</CpfCnpj>' +
                  GetInscMunic(Emitente.InscMun) +
                '</Prestador>';

    Response.ArquivoEnvio := '<' + TagEnvio + NameSpace + '>' +
                               '<Pedido>' +
                                 '<IdentificacaoRps>' +
                                   '<Numero>' +
                                     Response.NumeroRps +
                                   '</Numero>' +
                                   '<Serie>' +
                                     Response.SerieRps +
                                   '</Serie>' +
                                   '<Tipo>' +
                                     Response.TipoRps +
                                   '</Tipo>' +
                                 '</IdentificacaoRps>' +
                                 Prestador +
                               '</Pedido>' +
                             '</' + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosConsultaNFSeporFaixa(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<Prestador>' +
                  '<CpfCnpj>' +
                    GetCpfCnpj(Emitente.CNPJ) +
                  '</CpfCnpj>' +
                  GetInscMunic(Emitente.InscMun) +
                '</Prestador>';

    Response.ArquivoEnvio := '<ConsultarNfseFaixaEnvio' + NameSpace + '>' +
                               '<Pedido>' +
                                 Prestador +
                                 Xml +
                                 '<Pagina>' +
                                    IntToStr(Response.InfConsultaNFSe.Pagina) +
                                 '</Pagina>' +
                               '</Pedido>' +
                             '</ConsultarNfseFaixaEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<Prestador>' +
                  '<CpfCnpj>' +
                    GetCpfCnpj(Emitente.CNPJ) +
                  '</CpfCnpj>' +
                  GetInscMunic(Emitente.InscMun) +
                '</Prestador>';

    Response.ArquivoEnvio := '<ConsultarNfseServicoPrestadoEnvio' + NameSpace + '>' +
                               '<Pedido>' +
                                 Prestador +
                                 Xml +
                                 '<Pagina>' +
                                    IntToStr(Response.InfConsultaNFSe.Pagina) +
                                 '</Pagina>' +
                               '</Pedido>' +
                             '</ConsultarNfseServicoPrestadoEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Consulente: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Consulente :='<Consulente>' +
                   '<CpfCnpj>' +
                     GetCpfCnpj(Emitente.CNPJ) +
                   '</CpfCnpj>' +
                   GetInscMunic(Emitente.InscMun) +
                 '</Consulente>';

    Response.ArquivoEnvio := '<ConsultarNfseServicoTomadoEnvio' + NameSpace + '>' +
                               '<Pedido>' +
                                 Consulente +
                                 Xml +
                                 '<Pagina>' +
                                    IntToStr(Response.InfConsultaNFSe.Pagina) +
                                 '</Pagina>' +
                               '</Pedido>' +
                             '</ConsultarNfseServicoTomadoEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  InfoCanc: TInfCancelamento;
  xCodMun: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  InfoCanc := Response.InfCancelamento;

  with TACBrNFSeX(FAOwner) do
  begin
    if Configuracoes.WebServices.AmbienteCodigo = 1 then
      xCodMun := IntToStr(Configuracoes.Geral.CodigoMunicipio)
    else
      xCodMun := '5002704';
  end;

  with Params do
  begin
    Response.ArquivoEnvio := '<CancelarNfseEnvio' + NameSpace + '>' +
                               '<Pedido>' +
                                 '<InfPedidoCancelamento' + IdAttr + NameSpace2 + '>' +
                                   '<IdentificacaoNfse>' +
                                     '<Numero>' +
                                        InfoCanc.NumeroNFSe +
                                     '</Numero>' +
                                     Serie +
                                     '<CpfCnpj>' +
                                       GetCpfCnpj(Emitente.CNPJ) +
                                     '</CpfCnpj>' +
                                     GetInscMunic(Emitente.InscMun) +
                                     '<CodigoMunicipio>' +
                                       xCodMun +
                                     '</CodigoMunicipio>' +
                                     CodigoVerificacao +
                                   '</IdentificacaoNfse>' +
                                   '<CodigoCancelamento>' +
                                      InfoCanc.CodCancelamento +
                                   '</CodigoCancelamento>' +
                                   Motivo +
                                 '</InfPedidoCancelamento>' +
                               '</Pedido>' +
                             '</CancelarNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.PrepararConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
  Emitente: TEmitenteConfNFSe;
  aParams: TNFSeParamsResponse;
  NameSpace, TagEnvio, Prefixo: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if EstaVazio(Emitente.CNPJ) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod130;
    AErro.Descricao := ACBrStr(Desc130);
    Exit;
  end;

  if EstaVazio(Emitente.InscMun) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod129;
    AErro.Descricao := ACBrStr(Desc129);
    Exit;
  end;

  if EstaVazio(Response.InfConsultaLinkNFSe.NumeroNFSe) then
  begin
    // Obrigatoriamente NumeroNFSe ou 1 dos grupos, somente 1, deve ser enviado
    if ((Response.InfConsultaLinkNFSe.NumeroRps = 0) and
        (Response.InfConsultaLinkNFSe.Competencia = 0) and
        (Response.InfConsultaLinkNFSe.DtEmissao = 0)) then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod108;
      AErro.Descricao := ACBrStr(Desc108);
      Exit;
    end

    else if Response.InfConsultaLinkNFSe.NumeroRps <> 0 then
    begin
      if EstaVazio(Response.InfConsultaLinkNFSe.SerieRps) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod103;
        AErro.Descricao := ACBrStr(Desc103);
        Exit;
      end;

      if EstaVazio(Response.InfConsultaLinkNFSe.TipoRps) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod104;
        AErro.Descricao := ACBrStr(Desc104);
        Exit;
      end;
    end;
  end;

  if Response.InfConsultaLinkNFSe.Pagina = 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod132;
    AErro.Descricao := ACBrStr(Desc132);
    Exit;
  end;

  if EstaVazio(ConfigMsgDados.ConsultarLinkNFSe.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarLinkNFSe.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarLinkNFSe.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  TagEnvio := ConfigMsgDados.ConsultarLinkNFSe.DocElemento;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := '';
    aParams.TagEnvio := TagEnvio;
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := '';
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaLinkNFSe(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNet204.GerarMsgDadosConsultaLinkNFSe(
  Response: TNFSeConsultaLinkNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  DataFinal: TDateTime;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  DataFinal := EndOfTheMonth(Response.InfConsultaLinkNFSe.Competencia);
  if DataFinal <> 0 then
  begin
    if DataFinal > Date then
      DataFinal := Date;
  end;

  with Params do
  begin
    Response.ArquivoEnvio := '<ConsultarUrlNfseEnvio' + NameSpace + '>' +
                               '<Pedido>' +
                                 '<Prestador>' +
                                   '<CpfCnpj>' +
                                     GetCpfCnpj(Emitente.CNPJ) +
                                   '</CpfCnpj>' +
                                   GetInscMunic(Emitente.InscMun) +
                                 '</Prestador>' +
                               IfThen(not EstaVazio(Response.InfConsultaLinkNFSe.NumeroNFSe),
                                    '<NumeroNfse>' + Response.InfConsultaLinkNFSe.NumeroNFSe + '</NumeroNfse>',
                               IfThen(Response.InfConsultaLinkNFSe.NumeroRps <> 0,
                                 '<IdentificacaoRps>' +
                                   '<Numero>' + IntToStr(Response.InfConsultaLinkNFSe.NumeroRps) + '</Numero>' +
                                   '<Serie>' + Response.InfConsultaLinkNFSe.SerieRps + '</Serie>' +
                                   '<Tipo>' + Response.InfConsultaLinkNFSe.TipoRps + '</Tipo>' +
                                 '</IdentificacaoRps>',
                               IfThen(Response.InfConsultaLinkNFSe.DtEmissao <> 0,
                                 '<PeriodoEmissao>' +
                                   '<DataInicial>' + FormatDateTime('yyyy-mm-dd', Response.InfConsultaLinkNFSe.DtEmissao) + '</DataInicial>' +
                                   '<DataFinal>' + FormatDateTime('yyyy-mm-dd', Response.InfConsultaLinkNFSe.DtEmissao) + '</DataFinal>' +
                                 '</PeriodoEmissao>',
                                 IfThen(Response.InfConsultaLinkNFSe.Competencia <> 0,
                                   '<PeriodoCompetencia>' +
                                     '<DataInicial>' + FormatDateTime('yyyy-mm-dd', StartOfTheMonth(Response.InfConsultaLinkNFSe.Competencia)) + '</DataInicial>' +
                                     '<DataFinal>' + FormatDateTime('yyyy-mm-dd', DataFinal) + '</DataFinal>' +
                                   '</PeriodoCompetencia>', '')))) +
                                 '<Pagina>' + IntToStr(Response.InfConsultaLinkNFSe.Pagina) + '</Pagina>' +
                               '</Pedido>' +
                             '</ConsultarUrlNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNet204.TratarRetornoConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AResumo: TNFSeResumoCollectionItem;
  I: Integer;
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

      ANode := Document.Root;
      if ANode <> nil then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('ListaLinks');

        Response.Sucesso := Assigned(AuxNode);
      end
      else
        AuxNode := nil;

      if not Response.Sucesso then
        ProcessarMensagemErros(Document.Root, Response, 'ListaMensagemRetorno', 'MensagemRetorno')
      else
      begin
        if not Assigned(AuxNode) then Exit;

        ANodeArray := AuxNode.Childrens.FindAllAnyNs('Links');

        if not Assigned(ANodeArray) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;

        for I := Low(ANodeArray) to High(ANodeArray) do
        begin
          ANode := ANodeArray[I];
          AuxNode := ANode.Childrens.FindAnyNs('IdentificacaoNfse');
          if not Assigned(AuxNode) then Exit;

          AResumo := Response.Resumos.New;
          AResumo.NumeroNota := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Numero'), tcStr);

          AuxNode := ANode.Childrens.FindAnyNs('IdentificacaoRps');

          AResumo.NumeroRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Numero'), tcStr);
          AResumo.SerieRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Serie'), tcStr);

          AResumo.Link := ObterConteudoTag(ANode.Childrens.FindAnyNs('UrlVisualizacaoNfse'), tcStr);
          AResumo.LinkVerificacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('UrlVerificaAutenticidade'), tcStr);

          // Grava o primeiro retorno no Response
          if AResumo.Link <> '' then
          begin
            Response.NumeroNota := AResumo.NumeroNota;
            Response.NumeroRps := AResumo.NumeroRps;
            Response.SerieRps := AResumo.SerieRps;
            Response.Link := AResumo.Link;
            Response.LinkVerificacao := AResumo.LinkVerificacao;
          end;
        end;
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
    FreeAndNil(Document);
  end;
end;

{ TACBrNFSeXWebserviceISSNetAPIPropria }

function TACBrNFSeXWebserviceISSNetAPIPropria.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := RemoverUTF8Bom(aXML);

  if not StringIsPDF(Result) then
  begin
    Result := inherited TratarXmlRetornado(Result);

    Result := RemoverCaracteresDesnecessarios(Result);
    Result := ParseText(Result);
    Result := RemoverDeclaracaoXML(Result);
    Result := RemoverIdentacao(Result);
    Result := RemoverPrefixosDesnecessarios(Result);
    Result := StringReplace(Result, '<br>', ' ', [rfReplaceAll, rfIgnoreCase]);
  end;
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:RecepcionarLoteDps>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:RecepcionarLoteDps>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/RecepcionarLoteDps', Request,
    ['EnviarLoteDpsResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.RecepcionarSincrono(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:RecepcionarLoteDpsSincrono>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:RecepcionarLoteDpsSincrono>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/RecepcionarLoteDpsSincrono', Request,
    ['EnviarLoteDpsSincronoResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.GerarNFSe(const ACabecalho,
  AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:GerarNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:GerarNfse>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/GerarNfse', Request,
    ['GerarNfseResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:ConsultarLoteDps>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarLoteDps>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/ConsultarLoteDps', Request,
    ['ConsultarLoteDpsResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarNFSePorRps(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:ConsultarNfseDps>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseDps>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/ConsultarNfseDps', Request,
    ['ConsultarNfseDpsResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarNFSePorFaixa(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:ConsultarNfsePorFaixa>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfsePorFaixa>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/ConsultarNfsePorFaixa', Request,
    ['ConsultarNfsePorFaixaResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarNFSeServicoPrestado(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:ConsultarNfseServicoPrestado>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseServicoPrestado>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/ConsultarNfseServicoPrestado', Request,
    ['ConsultarNfseServicoPrestadoResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarNFSeServicoTomado(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:ConsultarNfseServicoTomado>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarNfseServicoTomado>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/ConsultarNfseServicoTomado', Request,
    ['ConsultarNfseServicoTomadoResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarLinkNFSe(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:ConsultarUrlNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:ConsultarUrlNfse>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/ConsultarUrlNfse', Request,
    ['ConsultarUrlNfseResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.EnviarEvento(const ACabecalho,
  AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  FPMsgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<nfse:CancelarNfse>';
  Request := Request + '<nfseCabecMsg>' + ACabecalho + '</nfseCabecMsg>';
  Request := Request + '<nfseDadosMsg>' + FPMsgOrig + '</nfseDadosMsg>';
  Request := Request + '</nfse:CancelarNfse>';

  Result := Executar('http://www.sped.fazenda.gov.br/nfse/CancelarNfse', Request,
    ['CancelarNfseResposta'], ['xmlns:nfse="http://www.sped.fazenda.gov.br/nfse"']);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarNFSePorChave(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarDFe(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarEvento(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ConsultarParam(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceISSNetAPIPropria.ObterDANFSE(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

{ TACBrNFSeProviderPadraoNacionalAPIPropria }

procedure TACBrNFSeProviderISSNetAPIPropria.Configuracao;
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
    ServicosDisponibilizados.EnviarLoteSincrono := True;
    ServicosDisponibilizados.EnviarLoteAssincrono := True;
    {
    ServicosDisponibilizados.ConsultarNfseChave := True;
    ServicosDisponibilizados.ConsultarRps := True;
    ServicosDisponibilizados.EnviarEvento := True;
    ServicosDisponibilizados.ConsultarEvento := True;
    ServicosDisponibilizados.ConsultarDFe := True;
    ServicosDisponibilizados.ConsultarParam := True;
    ServicosDisponibilizados.ObterDANFSE := True;
    }
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

    LoteRpsSincrono.DocElemento := 'EnviarLoteDpsSincronoEnvio';
    LoteRpsSincrono.InfElemento := 'LoteDps';

    LoteRps.DocElemento := 'EnviarLoteDpsEnvio';
    LoteRps.InfElemento := 'LoteDps';

    ConsultarLote.DocElemento := 'ConsultarLoteDpsEnvio';
    ConsultarNFSeRps.DocElemento := 'ConsultarNfseDpsEnvio';
    ConsultarNFSe.DocElemento := 'ConsultarNfseEnvio';
    ConsultarNFSePorFaixa.DocElemento := 'ConsultarNfseFaixaEnvio';
    ConsultarNFSeServicoPrestado.DocElemento := 'ConsultarNfseServicoPrestadoEnvio';
    ConsultarNFSeServicoTomado.DocElemento := 'ConsultarNfseServicoTomadoEnvio';
    CancelarNFSe.InfElemento := 'InfPedidoCancelamento';
    CancelarNFSe.DocElemento := 'Pedido';
  end;

  with ConfigAssinar do
  begin
    Rps := True;
    LoteRps := True;
    RpsGerarNFSe := True;
    EnviarEvento := True;
  end;

  SetNomeXSD('schema_v101-ISSNet.xsd');
end;

function TACBrNFSeProviderISSNetAPIPropria.GetCpfCnpj(
  const CpfCnpj: string): string;
var
  xCpfCnpj: string;
begin
  Result := '';
  xCpfCnpj := OnlyCPFCNPJAlphaNum(CpfCnpj);

  if xCpfCnpj <> '' then
  begin
    if Length(xCpfCnpj) = 14 then
      Result := '<CNPJ>' + xCpfCnpj + '</CNPJ>'
    else
      Result := '<CPF>' + xCpfCnpj + '</CPF>';
  end;
end;

function TACBrNFSeProviderISSNetAPIPropria.GetInscMunic(
  const InscMunic: string): string;
begin
  Result := '';

  if NaoEstaVazio(InscMunic) then
    Result := '<IM>' + InscMunic + '</IM>';
end;

function TACBrNFSeProviderISSNetAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_ISSNetAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSNetAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_ISSNetAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSNetAPIPropria.PreencherNotaRespostaConsultaLoteRps(Node,
  parentNode: TACBrXmlNode; Response: TNFSeConsultaLoteRpsResponse): Boolean;
var
  NumNFSe, CodVerif, NumRps, SerieRps: String;
  DataAut: TDateTime;
  ANota: TNotaFiscal;
  AResumo: TNFSeResumoCollectionItem;
  AuxNode, InfoNode: TACBrXmlNode;
begin
  Result := False;

  if Node <> nil then
  begin
    InfoNode := Node.Childrens.FindAnyNs('infNFSe');

    if not Assigned(InfoNode) then Exit;

    NumNFSe := ObterConteudoTag(InfoNode.Childrens.FindAnyNs('nNFSe'), tcStr);
//      CodVerif := ObterConteudoTag(InfoNode.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
    DataAut := ObterConteudoTag(InfoNode.Childrens.FindAnyNs('dhProc'), tcDatHor);

    with Response do
    begin
      NumeroNota := NumNFSe;
      CodigoVerificacao := CodVerif;
      Data := DataAut;
    end;

    NumRps := '';
    SerieRps := '';

    AuxNode := InfoNode.Childrens.FindAnyNs('DPS');

    if AuxNode <> nil then
    begin
      AuxNode := AuxNode.Childrens.FindAnyNs('infDPS');
      if not Assigned(AuxNode) then
      begin
        NumRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nDPS'), tcStr);
        SerieRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('serie'), tcStr);
      end;
    end;

    if NumRps <> '' then
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
    else
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(NumNFSe);

    Response.NumeroNota := NumNFSe;
    Response.CodigoVerificacao := CodVerif;
    Response.Data := DataAut;
    Response.NumeroRps := NumRps;
    Response.SerieRps := SerieRps;

    AResumo := Response.Resumos.New;
    AResumo.NumeroNota := NumNFSe;
    AResumo.CodigoVerificacao := CodVerif;
    AResumo.NumeroRps := NumRps;
    AResumo.SerieRps := SerieRps;

    ANota := CarregarXmlNfse(ANota, Node.OuterXml);
    SalvarXmlNfse(ANota);

    AResumo.NomeArq := ANota.NomeArq;

    Result := True; // Processado com sucesso pois retornou a nota
  end;
end;

function TACBrNFSeProviderISSNetAPIPropria.PreencherNotaRespostaConsultaNFSe(
  Node, parentNode: TACBrXmlNode; Response: TNFSeConsultaNFSeResponse): Boolean;
var
  NumNFSe, CodVerif, NumRps, SerieRps: String;
  DataAut: TDateTime;
  ANota: TNotaFiscal;
  AResumo: TNFSeResumoCollectionItem;
  NFSeNode: TACBrXmlNode;
begin
  Result := False;

  if Node <> nil then
  begin
    NFSeNode := Node;
    Node := Node.Childrens.FindAnyNs('infNFSe');

    if not Assigned(Node) then Exit;

    NumNFSe := ObterConteudoTag(Node.Childrens.FindAnyNs('nNFSe'), tcStr);
//      CodVerif := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
    DataAut := ObterConteudoTag(Node.Childrens.FindAnyNs('dhProc'), tcDatHor);

    with Response do
    begin
      NumeroNota := NumNFSe;
      CodigoVerificacao := CodVerif;
      Data := DataAut;
    end;

    Node := Node.Childrens.FindAnyNs('DPS');

    NumRps := '';
    SerieRps := '';

    if Node <> nil then
    begin
      Node := Node.Childrens.FindAnyNs('infDPS');
      if not Assigned(Node) then Exit;

      NumRps := ObterConteudoTag(Node.Childrens.FindAnyNs('nDPS'), tcStr);
      SerieRps := ObterConteudoTag(Node.Childrens.FindAnyNs('serie'), tcStr);
    end;

    if NumRps <> '' then
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
    else
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(Response.NumeroNota);

    AResumo := Response.Resumos.New;
    AResumo.NumeroNota := NumNFSe;
    AResumo.CodigoVerificacao := CodVerif;
    AResumo.NumeroRps := NumRps;
    AResumo.SerieRps := SerieRps;

    Response.NumeroNota := NumNFSe;
    Response.CodigoVerificacao := CodVerif;
    Response.NumeroRps := NumRps;
    Response.SerieRps := SerieRps;

    ANota := CarregarXmlNfse(ANota, NFSeNode.OuterXml);
    SalvarXmlNfse(ANota);

    AResumo.NomeArq := ANota.NomeArq;

    Result := True; // Processado com sucesso pois retornou a nota
  end;
end;

function TACBrNFSeProviderISSNetAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if not (AMetodo in [tmConsultarEvento, tmConsultarDFe,
             tmConsultarParam, tmConsultarNFSePorChave, tmObterDANFSE]) then
  begin
    Path := '';
    Method := 'POST';
    AMimeType := 'text/xml';
  end
  else
    AMimeType := 'application/json';

  if URL <> '' then
  begin
    URL := URL + Path;

    Result := TACBrNFSeXWebserviceISSNetAPIPropria.Create(FAOwner, AMetodo,
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

function TACBrNFSeProviderISSNetAPIPropria.VerificarAlerta(
  const ACodigo, AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) > 0);
end;

function TACBrNFSeProviderISSNetAPIPropria.VerificarErro(const ACodigo,
  AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) = 0);
end;

procedure TACBrNFSeProviderISSNetAPIPropria.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse; const AListTag,
  AMessageTag: string);
var
  I: Integer;
  ANode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
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

  if not Assigned(ANode) then
  begin
    ANode := RootNode.Childrens.FindAnyNs('ListaMensagemRetorno');
  end;

  ProcessarErros;

  ANode := RootNode.Childrens.FindAnyNs('ListaMensagemAlertaRetornoLote');

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
  end;
end;

function TACBrNFSeProviderISSNetAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;

  if aMetodo in [tmGerar, tmEnviarEvento] then
    Result := ChangeLineBreak(aXml, '');
end;

function TACBrNFSeProviderISSNetAPIPropria.PrepararRpsParaLote(
  const aXml: string): string;
begin
//  Result := aXml;
  Result := '<DPS versao="1.01">' + SeparaDados(aXml, 'DPS') + '</DPS>';
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararEmitir(
  Response: TNFSeEmiteResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  Nota: TNotaFiscal;
  Versao, IdAttr, NameSpace, NameSpaceLote, ListaRps, xRps, IdAttrSig,
  TagEnvio, Prefixo, PrefixoTS: string;
  I: Integer;
begin
  if EstaVazio(Response.NumeroLote) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod111;
    AErro.Descricao := ACBrStr(Desc111);
  end;

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
    AErro.Descricao := ACBrStr('Conjunto de RPS transmitidos (máximo de ' +
                       IntToStr(Response.MaxRps) + ' RPS)' +
                       ' excedido. Quantidade atual: ' +
                       IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count));
  end;

  if (TACBrNFSeX(FAOwner).NotasFiscais.Count < Response.MinRps) and
     (Response.ModoEnvio <> meUnitario) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod005;
    AErro.Descricao := ACBrStr('Conjunto de RPS transmitidos (mínimo de ' +
                       IntToStr(Response.MinRps) + ' RPS)' +
                       '. Quantidade atual: ' +
                       IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count));
  end;

  if Response.Erros.Count > 0 then Exit;

  ListaRps := '';
  Prefixo := '';
  PrefixoTS := '';

  case Response.ModoEnvio of
    meLoteSincrono:
    begin
      TagEnvio := ConfigMsgDados.LoteRpsSincrono.DocElemento;

      if EstaVazio(ConfigMsgDados.LoteRpsSincrono.xmlns) then
        NameSpace := ''
      else
      begin
        if ConfigMsgDados.Prefixo = '' then
          NameSpace := ' xmlns="' + ConfigMsgDados.LoteRpsSincrono.xmlns + '"'
        else
        begin
          NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' +
                                   ConfigMsgDados.LoteRpsSincrono.xmlns + '"';
          Prefixo := ConfigMsgDados.Prefixo + ':';
        end;
      end;
    end;

    meUnitario:
    begin
      TagEnvio := ConfigMsgDados.GerarNFSe.DocElemento;

      if EstaVazio(ConfigMsgDados.GerarNFSe.xmlns) then
        NameSpace := ''
      else
      begin
        if ConfigMsgDados.Prefixo = '' then
          NameSpace := ' xmlns="' + ConfigMsgDados.GerarNFSe.xmlns + '"'
        else
        begin
          NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' +
                                   ConfigMsgDados.GerarNFSe.xmlns + '"';
          Prefixo := ConfigMsgDados.Prefixo + ':';
        end;
      end;
    end;
  else
    begin
      TagEnvio := ConfigMsgDados.LoteRps.DocElemento;

      if EstaVazio(ConfigMsgDados.LoteRps.xmlns) then
        NameSpace := ''
      else
      begin
        if ConfigMsgDados.Prefixo = '' then
          NameSpace := ' xmlns="' + ConfigMsgDados.LoteRps.xmlns + '"'
        else
        begin
          NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' +
                                   ConfigMsgDados.LoteRps.xmlns + '"';
          Prefixo := ConfigMsgDados.Prefixo + ':';
        end;
      end;
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.LoteRps.xmlns) and
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

    if (ConfigAssinar.Rps and (Response.ModoEnvio in [meLoteAssincrono, meLoteSincrono, meTeste])) or
       (ConfigAssinar.RpsGerarNFSe and (Response.ModoEnvio = meUnitario)) then
    begin
      IdAttrSig := SetIdSignatureValue(Nota.XmlRps,
                                     ConfigMsgDados.XmlRps.DocElemento, IdAttr);

      Nota.XmlRps := FAOwner.SSL.Assinar(Nota.XmlRps,
                                         PrefixoTS + ConfigMsgDados.XmlRps.DocElemento,
                                         ConfigMsgDados.XmlRps.InfElemento, '', '', '',
                                         IdAttr, IdAttrSig);
    end;

    SalvarXmlRps(Nota);

    xRps := RemoverDeclaracaoXML(Nota.XmlRps);
    xRps := PrepararRpsParaLote(xRps);

    ListaRps := ListaRps + xRps;
  end;

  if ConfigMsgDados.GerarNSLoteRps then
    NameSpaceLote := NameSpace
  else
    NameSpaceLote := '';

  if ConfigWebServices.AtribVerLote <> '' then
    Versao := ' ' + ConfigWebServices.AtribVerLote + '="' +
              ConfigWebServices.VersaoDados + '"'
  else
    Versao := '';

  IdAttr := DefinirIDLote(Response.NumeroLote);

  ListaRps := ChangeLineBreak(ListaRps, '');

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := ListaRps;
    aParams.TagEnvio := TagEnvio;
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := NameSpaceLote;
    aParams.IdAttr := IdAttr;
    aParams.Versao := Versao;

    GerarMsgDadosEmitir(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosEmitir(
  Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    if Response.ModoEnvio in [meLoteAssincrono, meLoteSincrono, meTeste] then
    begin
      Prestador := '<' + Prefixo2 + 'Prestador>' +
                     GetCpfCnpj(Emitente.CNPJ) +
                     GetInscMunic(Emitente.InscMun) +
                   '</' + Prefixo2 + 'Prestador>';

      Response.ArquivoEnvio :=
             '<' + Prefixo + TagEnvio + NameSpace + '>' +
               '<' + Prefixo + 'LoteDps' + NameSpace2 + IdAttr  + Versao + '>' +
                 '<' + Prefixo2 + 'NumeroLote>' +
                    Response.NumeroLote +
                 '</' + Prefixo2 + 'NumeroLote>' +
                 Prestador +
                 '<' + Prefixo2 + 'QuantidadeDps>' +
                    IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count) +
                 '</' + Prefixo2 + 'QuantidadeDps>' +
                 '<' + Prefixo2 + 'ListaDps>' +
                    Xml +
                 '</' + Prefixo2 + 'ListaDps>' +
               '</' + Prefixo + 'LoteDps>' +
             '</' + Prefixo + TagEnvio + '>';
    end
    else
      Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                                  Xml +
                               '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  NumNFSe, CodVerif, NumRps, SerieRps: string;
  DataAut: TDateTime;
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  AResumo: TNFSeResumoCollectionItem;
  ANode, AuxNode, AuxNode2: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  ANota: TNotaFiscal;
  I: Integer;
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
      ProcessarMensagemErros(Document.Root, Response, 'ListaMensagemRetornoLote');

      ANode := Document.Root;

      Response.Data := ObterConteudoTag(ANode.Childrens.FindAnyNs('DataRecebimento'), tcDatHor);
      Response.Protocolo := ObterConteudoTag(ANode.Childrens.FindAnyNs('Protocolo'), tcStr);
      Response.Situacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('status'), tcStr);

      if Response.ModoEnvio in [meLoteSincrono, meUnitario] then
      begin
        // Retorno do EnviarLoteRpsSincrono e GerarNfse
        ANode := ANode.Childrens.FindAnyNs('ListaNfse');

        if not Assigned(ANode) then
        begin
          if Response.Erros.Count = 0 then
          begin
            AErro := Response.Erros.New;
            AErro.Codigo := Cod202;
            AErro.Descricao := ACBrStr(Desc202);
          end;
          Exit;
        end;

        ProcessarMensagemErros(ANode, Response);

        ANodeArray := ANode.Childrens.FindAllAnyNs('CompNfse');

        if not Assigned(ANodeArray) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;

        for I := Low(ANodeArray) to High(ANodeArray) do
        begin
          ANode := ANodeArray[I];
          AuxNode2 := ANode.Childrens.FindAnyNs('NFSe');
          if not Assigned(AuxNode2) then Exit;

          AuxNode := AuxNode2.Childrens.FindAnyNs('infNFSe');

          if not Assigned(AuxNode) then Exit;

          NumNFSe := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nNFSe'), tcStr);
          DataAut := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhProc'), tcDatHor);

          CodVerif := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nDFSe'), tcStr);
          if CodVerif = '' then
             CodVerif := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('cVerif'), tcStr);

          NumRps := '';
          SerieRps := '';

          // Busca os dados do DPS (RPS) para vincular a nota no componente
          AuxNode2 := AuxNode.Childrens.FindAnyNs('DPS');
          if Assigned(AuxNode2) then
          begin
            AuxNode2 := AuxNode2.Childrens.FindAnyNs('infDPS');
            if Assigned(AuxNode2) then
            begin
              NumRps   := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('nDPS'), tcStr);
              SerieRps := ObterConteudoTag(AuxNode2.Childrens.FindAnyNs('serie'), tcStr);
            end;
          end;

          // Localiza a nota na coleção de NotasFiscais para atualizar
          if NumRps <> '' then
            ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
          else
            ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(NumNFSe);

          with Response do
          begin
            NumeroNota := NumNFSe;
            CodigoVerificacao := CodVerif;
            Data := DataAut;
          end;

          AResumo := Response.Resumos.New;
          AResumo.NumeroNota := NumNFSe;
          AResumo.CodigoVerificacao := CodVerif;
          AResumo.NumeroRps := NumRps;
          AResumo.SerieRps := SerieRps;

          AuxNode2 := ANode.Childrens.FindAnyNs('NFSe');
          ANota := CarregarXmlNfse(ANota, AuxNode2.OuterXml);
          SalvarXmlNfse(ANota);

          AResumo.NomeArq := ANota.NomeArq;
        end;
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  NameSpace, TagEnvio, Prefixo, PrefixoTS: string;
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

  if EstaVazio(ConfigMsgDados.ConsultarLote.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarLote.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarLote.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarLote.xmlns) and
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

  TagEnvio := ConfigMsgDados.ConsultarLote.DocElemento;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := '';
    aParams.TagEnvio := TagEnvio;
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaLoteRps(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador, NumeroLote: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador := '<' + Prefixo + 'Prestador>' +
                   GetCpfCnpj(Emitente.CNPJ) +
                   GetInscMunic(Emitente.InscMun) +
                 '</' + Prefixo + 'Prestador>' +
                 '<' + Prefixo + 'Protocolo>' +
                   Response.Protocolo +
                 '</' + Prefixo + 'Protocolo>';

    if ConfigMsgDados.UsarNumLoteConsLote then
      NumeroLote := '<' + Prefixo + 'NumeroLote>' +
                      Response.NumeroLote +
                    '</' + Prefixo + 'NumeroLote>';

    Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                               Prestador +
                               NumeroLote +
                             '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
  I: Integer;
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

      Response.Situacao := '3'; // Processado com Falhas

      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root;

      ProcessarMensagemErros(ANode, Response);

      Response.Situacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('Situacao'), tcStr);

      ANode := ANode.Childrens.FindAnyNs('ListaNfse');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod202;
        AErro.Descricao := ACBrStr(Desc202);
        Exit;
      end;

      ProcessarMensagemErros(ANode, Response);

      ANodeArray := ANode.Childrens.FindAllAnyNs('CompNfse');

      if not Assigned(ANodeArray) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for I := Low(ANodeArray) to High(ANodeArray) do
      begin
        ANode := ANodeArray[I];

//        LerCancelamento(ANode, Response);

//        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('NFSe');

        if AuxNode = nil then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end
        else
        begin
          if PreencherNotaRespostaConsultaLoteRps(AuxNode, ANode, Response) then
            Response.Situacao := '4' // Processado com sucesso pois retornou a nota
          else
          begin
            AErro := Response.Erros.New;
            AErro.Codigo := Cod203;
            AErro.Descricao := ACBrStr(Desc203);
            Exit;
          end;
        end;
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  NameSpace, TagEnvio, Prefixo, PrefixoTS: string;
begin
  if EstaVazio(Response.NumeroRps) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod102;
    AErro.Descricao := ACBrStr(Desc102);
    Exit;
  end;

  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.ConsultarNFSeRps.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSeRps.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarNFSeRps.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarNFSeRps.xmlns) and
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

  TagEnvio := ConfigMsgDados.ConsultarNFSeRps.DocElemento;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := '';
    aParams.TagEnvio := TagEnvio;
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaporRps(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosConsultaporRps(
  Response: TNFSeConsultaNFSeporRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<' + Prefixo + 'Prestador>' +
                  GetCpfCnpj(Emitente.CNPJ) +
                  GetInscMunic(Emitente.InscMun) +
                '</' + Prefixo + 'Prestador>';

    Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                           '<' + Prefixo + 'IdentificacaoDps>' +
                             '<' + Prefixo2 + 'NumDPS>' +
                               Response.NumeroRps +
                             '</' + Prefixo2 + 'NumDPS>' +
                             '<' + Prefixo2 + 'SerieDPS>' +
                               Response.SerieRps +
                             '</' + Prefixo2 + 'SerieDPS>' +
                           '</' + Prefixo + 'IdentificacaoDps>' +
                           Prestador +
                         '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;
  ANota: TNotaFiscal;
  NumNFSe, NumRps, SerieRps: String;
  DataAut: TDateTime;
  AResumo: TNFSeResumoCollectionItem;
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

      ANode := Document.Root.Childrens.FindAnyNs('ListaNfse');

      if ANode = nil then
        ANode := Document.Root.Childrens.FindAnyNs('CompNfse')
      else
        ANode := ANode.Childrens.FindAnyNs('CompNfse');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

//      LerCancelamento(ANode, Response);

//      LerSubstituicao(ANode, Response);

      AuxNode := ANode.Childrens.FindAnyNs('NFSe');

      if AuxNode <> nil then
      begin
        AuxNode := AuxNode.Childrens.FindAnyNs('infNFSe');

        if not Assigned(AuxNode) then Exit;

        NumNFSe := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nNFSe'), tcStr);
  //      CodVerif := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
        DataAut := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        with Response do
        begin
          NumeroNota := NumNFSe;
//          CodigoVerificacao := CodVerif;
          Data := DataAut;
        end;

        AuxNode := AuxNode.Childrens.FindAnyNs('DPS');

        if AuxNode <> nil then
        begin
          AuxNode := AuxNode.Childrens.FindAnyNs('infDPS');
          if not Assigned(AuxNode) then Exit;

          NumRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nDPS'), tcStr);
          SerieRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('serie'), tcStr);
        end;

        if NumRps <> '' then
          ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
        else
          ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(Response.NumeroNota);

        AResumo := Response.Resumos.New;
        AResumo.NumeroNota := NumNFSe;
//        AResumo.CodigoVerificacao := CodVerif;
        AResumo.NumeroRps := NumRps;
        AResumo.SerieRps := SerieRps;

        AuxNode := ANode.Childrens.FindAnyNs('NFSe');
        ANota := CarregarXmlNfse(ANota, AuxNode.OuterXml);
        SalvarXmlNfse(ANota);

        AResumo.NomeArq := ANota.NomeArq;
      end
      else
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse);
var
  aParams: TNFSeParamsResponse;
  XmlConsulta, xNumFinal, NameSpace, Prefixo, PrefixoTS: string;
begin
  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.ConsultarNFSePorFaixa.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSePorFaixa.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarNFSePorFaixa.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarNFSePorFaixa.xmlns) and
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

  Response.Metodo := tmConsultarNFSePorFaixa;

  if (OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) <> OnlyNumber(Response.InfConsultaNFSe.NumeroFinNFSe)) or
     ConfigGeral.ConsultaPorFaixaPreencherNumNfseFinal then
    xNumFinal := '<' + PrefixoTS + 'NumeroNfseFinal>' +
                    OnlyNumber(Response.InfConsultaNFSe.NumeroFinNFSe) +
                 '</' + PrefixoTS + 'NumeroNfseFinal>'
  else
    xNumFinal := '';

  XmlConsulta := '<' + Prefixo + 'Faixa>' +
                   '<' + PrefixoTS + 'NumeroNfseInicial>' +
                      OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) +
                   '</' + PrefixoTS + 'NumeroNfseInicial>' +
                   xNumFinal +
                 '</' + Prefixo + 'Faixa>';

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := XmlConsulta;
    aParams.TagEnvio := '';
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaNFSeporFaixa(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosConsultaNFSeporFaixa(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<' + Prefixo + 'Prestador>' +
                  GetCpfCnpj(Emitente.CNPJ) +
                  GetInscMunic(Emitente.InscMun) +
                '</' + Prefixo + 'Prestador>';

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseFaixaEnvio' + NameSpace + '>' +
                           Prestador +
                           Xml +
                           '<' + Prefixo + 'Pagina>' +
                              IntToStr(Response.InfConsultaNFSe.Pagina) +
                           '</' + Prefixo + 'Pagina>' +
                         '</' + Prefixo + 'ConsultarNfseFaixaEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
  I: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      TACBrNFSeX(FAOwner).NotasFiscais.Clear;

      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ProcessarMensagemErros(Document.Root, Response);

      ANode := Document.Root.Childrens.FindAnyNs('ListaNfse');
      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod202;
        AErro.Descricao := ACBrStr(Desc202);
        Exit;
      end;

      ProcessarMensagemErros(ANode, Response);

      ANodeArray := ANode.Childrens.FindAllAnyNs('CompNfse');

      if not Assigned(ANodeArray) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for I := Low(ANodeArray) to High(ANodeArray) do
      begin
        ANode := ANodeArray[I];

//        LerCancelamento(ANode, Response);

//        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('NFSe');
        if not Assigned(AuxNode) then Exit;

        if not PreencherNotaRespostaConsultaNFSe(AuxNode, ANode, Response) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse);
var
  aParams: TNFSeParamsResponse;
  XmlConsulta, NameSpace, Prefixo, PrefixoTS, TagPeriodo: string;
begin
  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.ConsultarNFSeServicoPrestado.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSeServicoPrestado.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarNFSeServicoPrestado.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarNFSeServicoPrestado.xmlns) and
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

  Response.Metodo := tmConsultarNFSeServicoPrestado;

  if OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) <> '' then
    XmlConsulta := '<' + Prefixo + 'NumeroNfse>' +
                      OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) +
                   '</' + Prefixo + 'NumeroNfse>'
  else
    XmlConsulta := '';

  if Response.InfConsultaNFSe.tpPeriodo = tpEmissao then
    TagPeriodo := 'PeriodoEmissao'
  else
    TagPeriodo := 'PeriodoCompetencia';

  if (Response.InfConsultaNFSe.DataInicial > 0) and (Response.InfConsultaNFSe.DataFinal > 0) then
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + TagPeriodo + '>' +
                       '<' + Prefixo + 'DataInicial>' +
                          FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataInicial) +
                       '</' + Prefixo + 'DataInicial>' +
                       '<' + Prefixo + 'DataFinal>' +
                          FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataFinal) +
                       '</' + Prefixo + 'DataFinal>' +
                     '</' + Prefixo + TagPeriodo + '>';

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJTomador) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Tomador>' +
                       GetCpfCnpj(Response.InfConsultaNFSe.CNPJTomador) +
                       GetInscMunic(Response.InfConsultaNFSe.IMTomador) +
                     '</' + Prefixo + 'Tomador>';
  end;

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJInter) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Intermediario>' +
                       GetCpfCnpj(Response.InfConsultaNFSe.CNPJInter) +
                       GetInscMunic(Response.InfConsultaNFSe.IMInter) +
                     '</' + Prefixo + 'Intermediario>';
  end;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := XmlConsulta;
    aParams.TagEnvio := '';
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaNFSeServicoPrestado(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<' + Prefixo + 'Prestador>' +
                  GetCpfCnpj(Emitente.CNPJ) +
                  GetInscMunic(Emitente.InscMun) +
                '</' + Prefixo + 'Prestador>';

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseServicoPrestadoEnvio' + NameSpace + '>' +
                           Prestador +
                           Xml +
                           '<' + Prefixo + 'Pagina>' +
                              IntToStr(Response.InfConsultaNFSe.Pagina) +
                           '</' + Prefixo + 'Pagina>' +
                         '</' + Prefixo + 'ConsultarNfseServicoPrestadoEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
  I: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      TACBrNFSeX(FAOwner).NotasFiscais.Clear;

      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ProcessarMensagemErros(Document.Root, Response);

      ANode := Document.Root.Childrens.FindAnyNs('ListaNfse');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod202;
        AErro.Descricao := ACBrStr(Desc202);
        Exit;
      end;

      ProcessarMensagemErros(ANode, Response);

      ANodeArray := ANode.Childrens.FindAllAnyNs('CompNfse');

      if not Assigned(ANodeArray) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for I := Low(ANodeArray) to High(ANodeArray) do
      begin
        ANode := ANodeArray[I];

//        LerCancelamento(ANode, Response);

//        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('NFSe');
        if not Assigned(AuxNode) then Exit;

        if not PreencherNotaRespostaConsultaNFSe(AuxNode, ANode, Response) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse);
var
  aParams: TNFSeParamsResponse;
  XmlConsulta, NameSpace, Prefixo, PrefixoTS, TagPeriodo: string;
begin
  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.ConsultarNFSeServicoTomado.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSeServicoTomado.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarNFSeServicoTomado.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.ConsultarNFSeServicoTomado.xmlns) and
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

  Response.Metodo := tmConsultarNFSeServicoTomado;

  if OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) <> '' then
    XmlConsulta := '<' + Prefixo + 'NumeroNfse>' +
                      OnlyNumber(Response.InfConsultaNFSe.NumeroIniNFSe) +
                   '</' + Prefixo + 'NumeroNfse>'
  else
    XmlConsulta := '';

  if Response.InfConsultaNFSe.tpPeriodo = tpEmissao then
    TagPeriodo := 'PeriodoEmissao'
  else
    TagPeriodo := 'PeriodoCompetencia';

  if (Response.InfConsultaNFSe.DataInicial > 0) and (Response.InfConsultaNFSe.DataFinal > 0) then
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + TagPeriodo + '>' +
                       '<' + Prefixo + 'DataInicial>' +
                          FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataInicial) +
                       '</' + Prefixo + 'DataInicial>' +
                       '<' + Prefixo + 'DataFinal>' +
                          FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataFinal) +
                       '</' + Prefixo + 'DataFinal>' +
                     '</' + Prefixo + TagPeriodo + '>';

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJPrestador) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Prestador>' +
                       GetCpfCnpj(Response.InfConsultaNFSe.CNPJPrestador) +
                       GetInscMunic(Response.InfConsultaNFSe.IMPrestador) +
                     '</' + Prefixo + 'Prestador>';
  end;

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJTomador) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Tomador>' +
                       GetCpfCnpj(Response.InfConsultaNFSe.CNPJTomador) +
                       GetInscMunic(Response.InfConsultaNFSe.IMTomador) +
                     '</' + Prefixo + 'Tomador>';
  end;

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJInter) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Intermediario>' +
                       GetCpfCnpj(Response.InfConsultaNFSe.CNPJInter) +
                       GetInscMunic(Response.InfConsultaNFSe.IMInter) +
                     '</' + Prefixo + 'Intermediario>';
  end;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := XmlConsulta;
    aParams.TagEnvio := '';
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaNFSeServicoTomado(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Consulente: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Consulente :='<' + Prefixo + 'Consulente>' +
                   GetCpfCnpj(Emitente.CNPJ) +
                   GetInscMunic(Emitente.InscMun) +
                 '</' + Prefixo + 'Consulente>';

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseServicoTomadoEnvio' + NameSpace + '>' +
                           Consulente +
                           Xml +
                           '<' + Prefixo + 'Pagina>' +
                              IntToStr(Response.InfConsultaNFSe.Pagina) +
                           '</' + Prefixo + 'Pagina>' +
                         '</' + Prefixo + 'ConsultarNfseServicoTomadoEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
  I: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      TACBrNFSeX(FAOwner).NotasFiscais.Clear;

      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root;

      ProcessarMensagemErros(ANode, Response);

      ANode := ANode.Childrens.FindAnyNs('ListaNfse');

      if ANode = nil then
        ANode := Document.Root
      else
        ProcessarMensagemErros(ANode, Response);

      ANodeArray := ANode.Childrens.FindAllAnyNs('CompNfse');

      if not Assigned(ANodeArray) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for I := Low(ANodeArray) to High(ANodeArray) do
      begin
        ANode := ANodeArray[I];

//        LerCancelamento(ANode, Response);

//        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('NFSe');
        if not Assigned(AuxNode) then Exit;

        if not PreencherNotaRespostaConsultaNFSe(AuxNode, ANode, Response) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
  Emitente: TEmitenteConfNFSe;
  aParams: TNFSeParamsResponse;
  NameSpace, TagEnvio, Prefixo: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if EstaVazio(Emitente.CNPJ) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod130;
    AErro.Descricao := ACBrStr(Desc130);
    Exit;
  end;

  if EstaVazio(Emitente.InscMun) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod129;
    AErro.Descricao := ACBrStr(Desc129);
    Exit;
  end;

  if EstaVazio(Response.InfConsultaLinkNFSe.NumeroNFSe) then
  begin
    // Obrigatoriamente NumeroNFSe ou 1 dos grupos, somente 1, deve ser enviado
    if ((Response.InfConsultaLinkNFSe.NumeroRps = 0) and
        (Response.InfConsultaLinkNFSe.Competencia = 0) and
        (Response.InfConsultaLinkNFSe.DtEmissao = 0)) then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod108;
      AErro.Descricao := ACBrStr(Desc108);
      Exit;
    end

    else if Response.InfConsultaLinkNFSe.NumeroRps <> 0 then
    begin
      if EstaVazio(Response.InfConsultaLinkNFSe.SerieRps) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod103;
        AErro.Descricao := ACBrStr(Desc103);
        Exit;
      end;

      if EstaVazio(Response.InfConsultaLinkNFSe.TipoRps) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod104;
        AErro.Descricao := ACBrStr(Desc104);
        Exit;
      end;
    end;
  end;

  if Response.InfConsultaLinkNFSe.Pagina = 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod132;
    AErro.Descricao := ACBrStr(Desc132);
    Exit;
  end;

  if EstaVazio(ConfigMsgDados.ConsultarLinkNFSe.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.ConsultarLinkNFSe.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.ConsultarLinkNFSe.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  TagEnvio := ConfigMsgDados.ConsultarLinkNFSe.DocElemento;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := '';
    aParams.TagEnvio := TagEnvio;
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := '';
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := '';
    aParams.Versao := '';

    GerarMsgDadosConsultaLinkNFSe(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.GerarMsgDadosConsultaLinkNFSe(
  Response: TNFSeConsultaLinkNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  DataFinal: TDateTime;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  DataFinal := EndOfTheMonth(Response.InfConsultaLinkNFSe.Competencia);
  if DataFinal <> 0 then
  begin
    if DataFinal > Date then
      DataFinal := Date;
  end;

  with Params do
  begin
    Response.ArquivoEnvio := '<ConsultarUrlNfseEnvio' + NameSpace + '>' +
                               '<Prestador>' +
                                 GetCpfCnpj(Emitente.CNPJ) +
                                 GetInscMunic(Emitente.InscMun) +
                               '</Prestador>' +
                             IfThen(not EstaVazio(Response.InfConsultaLinkNFSe.NumeroNFSe),
                                  '<NumeroNfse>' + Response.InfConsultaLinkNFSe.NumeroNFSe + '</NumeroNfse>',
                             IfThen(Response.InfConsultaLinkNFSe.DtEmissao <> 0,
                               '<PeriodoEmissao>' +
                                 '<DataInicial>' + FormatDateTime('yyyy-mm-dd', Response.InfConsultaLinkNFSe.DtEmissao) + '</DataInicial>' +
                                 '<DataFinal>' + FormatDateTime('yyyy-mm-dd', Response.InfConsultaLinkNFSe.DtEmissao) + '</DataFinal>' +
                               '</PeriodoEmissao>',
                               IfThen(Response.InfConsultaLinkNFSe.Competencia <> 0,
                                 '<PeriodoCompetencia>' +
                                   '<DataInicial>' + FormatDateTime('yyyy-mm-dd', StartOfTheMonth(Response.InfConsultaLinkNFSe.Competencia)) + '</DataInicial>' +
                                   '<DataFinal>' + FormatDateTime('yyyy-mm-dd', DataFinal) + '</DataFinal>' +
                                 '</PeriodoCompetencia>', ''))) +
                               '<Pagina>' + IntToStr(Response.InfConsultaLinkNFSe.Pagina) + '</Pagina>' +
                             '</ConsultarUrlNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoConsultaLinkNFSe(Response: TNFSeConsultaLinkNFSeResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AResumo: TNFSeResumoCollectionItem;
  I: Integer;
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

      ANode := Document.Root;
      if ANode <> nil then
      begin
        AuxNode := ANode.Childrens.FindAnyNs('ListaLinks');

        Response.Sucesso := Assigned(AuxNode);
      end
      else
        AuxNode := nil;

      if not Response.Sucesso then
        ProcessarMensagemErros(Document.Root, Response, 'ListaMensagemRetorno', 'MensagemRetorno')
      else
      begin
        if not Assigned(AuxNode) then Exit;

        ANodeArray := AuxNode.Childrens.FindAllAnyNs('Links');

        if not Assigned(ANodeArray) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;

        for I := Low(ANodeArray) to High(ANodeArray) do
        begin
          ANode := ANodeArray[I];
          AuxNode := ANode.Childrens.FindAnyNs('IdentificacaoNfse');
          if not Assigned(AuxNode) then Exit;

          AResumo := Response.Resumos.New;
          AResumo.NumeroNota := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nDFSe'), tcStr);

          AuxNode := ANode.Childrens.FindAnyNs('IdentificacaoDps');

          AResumo.NumeroRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('NumDPS'), tcStr);
          AResumo.SerieRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('SerieDPS'), tcStr);

          AResumo.Link := ObterConteudoTag(ANode.Childrens.FindAnyNs('UrlVisualizacaoNfse'), tcStr);
          AResumo.LinkVerificacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('UrlVerificaAutenticidade'), tcStr);

          // Grava o primeiro retorno no Response
          if AResumo.Link <> '' then
          begin
            Response.NumeroNota := AResumo.NumeroNota;
            Response.NumeroRps := AResumo.NumeroRps;
            Response.SerieRps := AResumo.SerieRps;
            Response.Link := AResumo.Link;
            Response.LinkVerificacao := AResumo.LinkVerificacao;
          end;
        end;
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
    FreeAndNil(Document);
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.PrepararEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  AErro: TNFSeEventoCollectionItem;
  xEvento, xUF, xAutorEvento, IdAttr, xCamposEvento, nomeArq, CnpjCpf: string;
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

    IdAttr := 'Id="' + 'PRE' + ID + '"';

    case tpEvento of
      teCancelamento:
        xCamposEvento := '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>';

      teCancelamentoSubstituicao:
        xCamposEvento := '<cMotivo>' + Formatfloat('00', cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>' +
                         '<chSubstituta>' + chSubstituta + '</chSubstituta>';

      teAnaliseParaCancelamento:
        xCamposEvento := '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>';

      teRejeicaoPrestador:
        xCamposEvento := '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>';

      teRejeicaoTomador:
        xCamposEvento := '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>';

      teRejeicaoIntermediario:
        xCamposEvento := '<cMotivo>' + IntToStr(cMotivo) + '</cMotivo>' +
                         '<xMotivo>' + xMotivo + '</xMotivo>';
    else
      // teConfirmacaoPrestador, teConfirmacaoTomador,
      // ConfirmacaoIntermediario
      xCamposEvento := '';
    end;

    xEvento := '<CancelarNfseEnvio xmlns="' + ConfigMsgDados.EnviarEvento.xmlns + '">' +
                 '<pedRegEvento versao="' + ConfigWebServices.VersaoAtrib + '">' +
                   '<infPedReg ' + IdAttr + '>' +
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
                 '</pedRegEvento>' +
               '</CancelarNfseEnvio>';

    xEvento := ConverteXMLtoUTF8(xEvento);
    xEvento := ChangeLineBreak(xEvento, '');

    Response.ArquivoEnvio := xEvento;
    Chave := chNFSe;

    nomeArq := '';
    SalvarXmlEvento(ID + '-pedRegEvento', Response.ArquivoEnvio, nomeArq, dhEvento);
    Response.PathNome := nomeArq;
  end;
end;

procedure TACBrNFSeProviderISSNetAPIPropria.TratarRetornoEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  IdAttr, nomeArq: string;
  AErro: TNFSeEventoCollectionItem;
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

      ANode := Document.Root.Childrens.FindAnyNs('Evento');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod211;
        AErro.Descricao := ACBrStr(Desc211);
        Exit;
      end;

      AuxNode := ANode.Childrens.FindAnyNs('infEvento');

      if not Assigned(AuxNode) then Exit;

      Response.idEvento := ObterConteudoTag(ANode.Attributes.Items[IdAttr]);
      Response.DataCanc := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);
      Response.NumeroNota := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDFe'), tcStr);

      if Response.DataCanc > 0 then
      begin
        Response.Sucesso := True;
        Response.Situacao := 'Cancelado';
        nomeArq := '';
        SalvarXmlCancelamento(Response.idEvento + '-procCancNFSe',
          Document.Root.OuterXml, nomeArq);
        Response.PathNome := nomeArq;
      end
      else
      begin
        Response.Sucesso := False;
        Response.Situacao := '';
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
    FreeAndNil(Document);
  end;
end;

end.
