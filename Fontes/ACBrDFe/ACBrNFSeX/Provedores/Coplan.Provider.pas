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

unit Coplan.Provider;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  PadraoNacional.Provider;

type
  TACBrNFSeXWebserviceCoplan201 = class(TACBrNFSeXWebserviceSoap11)
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

  TACBrNFSeProviderCoplan201 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;
  end;

  TACBrNFSeXWebserviceCoplanAPIPropria = class(TACBrNFSeXWebserviceSoap11)
  private
    function GetNamespace: string;
  public
    function Recepcionar(const ACabecalho, AMSG: string): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: string): string; override;
    function GerarNFSe(const ACabecalho, AMSG: string): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: string): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;

    function ConsultarNFSePorChave(const ACabecalho, AMSG: string): string; override;
    function ConsultarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarDFe(const ACabecalho, AMSG: string): string; override;
    function ConsultarParam(const ACabecalho, AMSG: string): string; override;
    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;

    property Namespace: string read GetNamespace;
  end;

  TACBrNFSeProviderCoplanAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  protected
    procedure Configuracao; override;

    procedure LerCancelamento(const ANode: TACBrXmlNode;
      const Response: TNFSeWebServiceResponse); virtual;

    procedure LerSubstituicao(const ANode: TACBrXmlNode;
      const Response: TNFSeWebServiceResponse);

    function PreencherNotaRespostaConsultaLoteRps(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaLoteRpsResponse): Boolean;
    function PreencherNotaRespostaConsultaNFSe(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaNFSeResponse): Boolean;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function VerificarAlerta(const ACodigo, AMensagem, ACorrecao: string): Boolean;
    function VerificarErro(const ACodigo, AMensagem, ACorrecao: string): Boolean;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetorno';
                                     const AMessageTag: string = 'MensagemRetorno'); override;

    function PrepararRpsParaLote(const aXml: string): string; override;
    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure GerarMsgDadosEmitir(Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    procedure GerarMsgDadosConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
    procedure GerarMsgDadosConsultaporRps(Response: TNFSeConsultaNFSeporRpsResponse; Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;

    procedure PrepararConsultaNFSe(Response: TNFSeConsultaNFSeResponse); override;
    procedure GerarMsgDadosConsultaNFSe(Response: TNFSeConsultaNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSe(Response: TNFSeConsultaNFSeResponse); override;

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

    procedure PrepararCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;
    procedure GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse; Params: TNFSeParamsResponse); override;
    procedure TratarRetornoCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;

    procedure PrepararSubstituiNFSe(Response: TNFSeSubstituiNFSeResponse); override;
    procedure GerarMsgDadosSubstituiNFSe(Response: TNFSeSubstituiNFSeResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoSubstituiNFSe(Response: TNFSeSubstituiNFSeResponse); override;
  end;

implementation

uses
  ACBrUtil.FilesIO,
  ACBrDFeUtil,
  StrUtilsEx,
  synacode,
  ACBrUtil.Base,
  ACBrJSON,
  ACBrCompress,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrDFe.Conversao,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConsts,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXNotasFiscais,
  Coplan.GravarXml,
  Coplan.LerXml;

{ TACBrNFSeProviderCoplan201 }

procedure TACBrNFSeProviderCoplan201.Configuracao;
begin
  inherited Configuracao;

  ConfigGeral.ConsultaPorFaixaPreencherNumNfseFinal := True;

  with ConfigAssinar do
  begin
    Rps := True;
    LoteRps := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
    RpsSubstituirNFSe := True;
    SubstituirNFSe := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.01';
    VersaoAtrib := '2.01';
  end;

  ConfigMsgDados.DadosCabecalho := GetCabecalho('');
end;

function TACBrNFSeProviderCoplan201.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Coplan201.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderCoplan201.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Coplan201.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderCoplan201.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceCoplan201.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

{ TACBrNFSeXWebserviceCoplan201 }

function TACBrNFSeXWebserviceCoplan201.GetNamespace: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 1 then
    Result := 'Tributario_PRODUCAO_FULL'
  else
    Result := 'TributarioGx16New';

  Result := 'xmlns:trib1="' + Result + '"';
end;

function TACBrNFSeXWebserviceCoplan201.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.RECEPCIONARLOTERPS>';
  Request := Request + '<trib:Recepcionarloterpsrequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Recepcionarloterpsrequest>';
  Request := Request + '</trib:nfse_web_service.RECEPCIONARLOTERPS>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.RECEPCIONARLOTERPS', Request,
                     ['Recepcionarloterpsresponse', 'outputXML', 'EnviarLoteRpsResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.RECEPCIONARLOTERPSSINCRONO>';
  Request := Request + '<trib:Recepcionarloterpssincronorequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Recepcionarloterpssincronorequest>';
  Request := Request + '</trib:nfse_web_service.RECEPCIONARLOTERPSSINCRONO>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.RECEPCIONARLOTERPSSINCRONO', Request,
                     ['Recepcionarloterpssincronoresponse', 'outputXML', 'EnviarLoteRpsSincronoResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.GERARNFSE>';
  Request := Request + '<trib:Gerarnfserequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Gerarnfserequest>';
  Request := Request + '</trib:nfse_web_service.GERARNFSE>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.GERARNFSE', Request,
                     ['Gerarnfseresponse', 'outputXML', 'GerarNfseResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.CONSULTARLOTERPS>';
  Request := Request + '<trib:Consultarloterpsrequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarloterpsrequest>';
  Request := Request + '</trib:nfse_web_service.CONSULTARLOTERPS>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.CONSULTARLOTERPS', Request,
                     ['Consultarloterpsresponse', 'outputXML', 'ConsultarLoteRpsResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.CONSULTARNFSEFAIXA>';
  Request := Request + '<trib:Consultarnfseporfaixarequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseporfaixarequest>';
  Request := Request + '</trib:nfse_web_service.CONSULTARNFSEFAIXA>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.CONSULTARNFSEFAIXA', Request,
                     ['Consultarnfseporfaixaresponse', 'outputXML', 'ConsultarNfseFaixaResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
  {
    os campos <Codigo>, <Mensagem> e <Correcao> estão dentro do grupo:
       <ConsultarNfseFaixaResposta> em vez de <MensagemRetorno>
    Vai ser necessário estudar a melhor forma de resolver esse problema
  }
end;

function TACBrNFSeXWebserviceCoplan201.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.CONSULTARNFSEPORRPS>';
  Request := Request + '<trib:Consultarnfseporrpsrequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseporrpsrequest>';
  Request := Request + '</trib:nfse_web_service.CONSULTARNFSEPORRPS>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.CONSULTARNFSEPORRPS', Request,
                     ['Consultarnfseporrpsresponse', 'outputXML', 'ConsultarNfseRpsResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.CONSULTARNFSESERVICOPRESTADO>';
  Request := Request + '<trib:Consultarnfseservicoprestadorequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseservicoprestadorequest>';
  Request := Request + '</trib:nfse_web_service.CONSULTARNFSESERVICOPRESTADO>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.CONSULTARNFSESERVICOPRESTADO', Request,
                     ['Consultarnfseservicoprestadoresponse', 'outputXML', 'ConsultarNfseServicoPrestadoResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.CONSULTARNFSESERVICOTOMADO>';
  Request := Request + '<trib:Consultarnfseservicotomadorequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseservicotomadorequest>';
  Request := Request + '</trib:nfse_web_service.CONSULTARNFSESERVICOTOMADO>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.CONSULTARNFSESERVICOTOMADO', Request,
                     ['Consultarnfseservicotomadoresponse', 'outputXML', 'ConsultarNfseServicoTomadoResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.CANCELARNFSE>';
  Request := Request + '<trib:Cancelarnfserequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Cancelarnfserequest>';
  Request := Request + '</trib:nfse_web_service.CANCELARNFSE>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.CANCELARNFSE', Request,
                     ['Cancelarnfseresponse', 'outputXML', 'CancelarNfseResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web_service.SUBSTITUIRNFSE>';
  Request := Request + '<trib:Substituirnfserequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Substituirnfserequest>';
  Request := Request + '</trib:nfse_web_service.SUBSTITUIRNFSE>';

  Result := Executar('Tributarioaction/ANFSE_WEB_SERVICE.SUBSTITUIRNFSE', Request,
                     ['Substituirnfseresponse', 'outputXML', 'SubstituirNfseResposta'],
                     ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplan201.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverCDATA(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

{ TACBrNFSeProviderCoplanAPIPropria }

procedure TACBrNFSeProviderCoplanAPIPropria.Configuracao;
var
  VersaoDFe: string;
begin
  inherited Configuracao;

  VersaoDFe := VersaoNFSeToStr(TACBrNFSeX(FAOwner).Configuracoes.Geral.Versao);

  with ConfigGeral do
  begin
    Layout := loPadraoNacional;
    ModoEnvio := meUnitario;
    FormatoArqEnvio := tfaXml;
    FormatoArqRetorno := tfaXml;
    FormatoArqEnvioSoap := tfaXml;
    FormatoArqRetornoSoap := tfaXml;

    ServicosDisponibilizados.EnviarUnitario := True;
    ServicosDisponibilizados.EnviarLoteSincrono := True;
    ServicosDisponibilizados.ConsultarRps := True;

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
    GerarPrestadorLoteRps := True;
    DadosCabecalho := GetCabecalho('');

    XmlRps.InfElemento := 'infDPS';
    XmlRps.DocElemento := 'DPS';
    ConsultarLote.DocElemento := 'ConsultarLoteDpsEnvio';
    ConsultarNFSeRps.DocElemento := 'ConsultarNfseDpsEnvio';
    EnviarEvento.InfElemento := 'infPedReg';
    EnviarEvento.DocElemento := 'pedRegEvento';
    LoteRpsSincrono.InfElemento := 'LoteDps';
    LoteRpsSincrono.DocElemento := 'EnviarLoteDpsSincronoEnvio';
  end;

  with ConfigAssinar do
  begin
    RpsGerarNFSe := True;
    EnviarEvento := True;
    CancelarNFSe := True;
//    LoteRps := True;
//    LoteGerarNFSe := True;
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

procedure TACBrNFSeProviderCoplanAPIPropria.LerCancelamento(const ANode: TACBrXmlNode;
  const Response: TNFSeWebserviceResponse);
var
  AuxNode, ANodeNfseCancelamento: TACBrXmlNode;
begin
  ANodeNfseCancelamento := ANode.Childrens.FindAnyNs('NfseCancelamento');

  if ANodeNfseCancelamento <> nil then
  begin
    AuxNode := ANodeNfseCancelamento.Childrens.FindAnyNs('Confirmacao');

    if AuxNode = nil then
      AuxNode := ANodeNfseCancelamento.Childrens.FindAnyNs('ConfirmacaoCancelamento');

    if Assigned(AuxNode) then
    begin
      Response.DataCanc := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('DataHora'), tcDatHor);

      Response.SucessoCanc := Response.DataCanc > 0;
    end;

    Response.DescSituacao := '';

    if (Response.DataCanc > 0) and (Response.SucessoCanc) then
      Response.DescSituacao := 'Nota Cancelada';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.LerSubstituicao(const ANode: TACBrXmlNode;
  const Response: TNFSeWebServiceResponse);
var
  AuxNode, AuxNodeSubs: TACBrXmlNode;
begin
  AuxNode := ANode.Childrens.FindAnyNs('NfseSubstituicao');

  if AuxNode <> nil then
  begin
    AuxNodeSubs := AuxNode.Childrens.FindAnyNs('SubstituicaoNfse');

    if AuxNodeSubs <> nil then
      Response.NumNotaSubstituidora := ObterConteudoTag(AuxNodeSubs.Childrens.FindAnyNs('NfseSubstituidora'), tcStr);

    if Response.NumNotaSubstituidora <> '' then
      Response.DescSituacao := 'Nota Substituida';
  end;
end;

function TACBrNFSeProviderCoplanAPIPropria.PreencherNotaRespostaConsultaLoteRps(Node,
  parentNode: TACBrXmlNode; Response: TNFSeConsultaLoteRpsResponse): Boolean;
var
  NumNFSe, CodVerif, NumRps, SerieRps: String;
  DataAut: TDateTime;
  ANota: TNotaFiscal;
  AResumo: TNFSeResumoCollectionItem;
  Node2: TACBrXmlNode;
  NumeroRps: Integer;
begin
  Result := False;
  NumeroRps := 0;

  if Node <> nil then
  begin
    Node := Node.Childrens.FindAnyNs('InfNfse');

    if not Assigned(Node) then Exit;

    NumNFSe := ObterConteudoTag(Node.Childrens.FindAnyNs('Numero'), tcStr);
    CodVerif := ObterConteudoTag(Node.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
    DataAut := ObterConteudoTag(Node.Childrens.FindAnyNs('DataEmissao'), tcDatHor);

    Node2 := Node.Childrens.FindAnyNs('DeclaracaoPrestacaoServico');

    // Tem provedor que mudou a tag de <DeclaracaoPrestacaoServico>
    // para <Rps>
    if Node2 = nil then
      Node2 := Node.Childrens.FindAnyNs('Rps');

    if not Assigned(Node2) then Exit;

    Node := Node2.Childrens.FindAnyNs('InfDeclaracaoPrestacaoServico');
    if not Assigned(Node) then Exit;

    Node := Node.Childrens.FindAnyNs('Rps');

    NumRps := '';
    SerieRps := '';

    if Node <> nil then
    begin
      Node := Node.Childrens.FindAnyNs('IdentificacaoRps');

      if Node <> nil then
      begin
        NumRps := ObterConteudoTag(Node.Childrens.FindAnyNs('Numero'), tcStr);
        NumeroRps := StrToIntDef(NumRps, 0);
        SerieRps := ObterConteudoTag(Node.Childrens.FindAnyNs('Serie'), tcStr);
      end;
    end;

    AResumo := Response.Resumos.New;
    AResumo.NumeroNota := NumNFSe;
    AResumo.Data := DataAut;
    AResumo.CodigoVerificacao := CodVerif;
    AResumo.NumeroRps := NumRps;
    AResumo.SerieRps := SerieRps;

    Response.NumeroNota := NumNFSe;
    Response.CodigoVerificacao := CodVerif;
    Response.NumeroRps := NumRps;
    Response.SerieRps := SerieRps;

    if NumeroRps > 0 then
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
    else
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(NumNFSe);

    ANota := CarregarXmlNfse(ANota, parentNode.OuterXml);
    SalvarXmlNfse(ANota);

    AResumo.NomeArq := ANota.NomeArq;
    AResumo.Link := ANota.NFSe.Link;

    Response.Link := ANota.NFSe.Link;

    Result := True; // Processado com sucesso pois retornou a nota
  end;
end;

function TACBrNFSeProviderCoplanAPIPropria.PreencherNotaRespostaConsultaNFSe(
  Node, parentNode: TACBrXmlNode; Response: TNFSeConsultaNFSeResponse): Boolean;
var
  NumNFSe, CodVerif, NumRps, SerieRps: String;
  DataAut: TDateTime;
  ANota: TNotaFiscal;
  AResumo: TNFSeResumoCollectionItem;
  Node2: TACBrXmlNode;
  NumeroRps: Integer;
begin
  Result := False;
  NumeroRps := 0;

  if Node <> nil then
  begin
    Node := Node.Childrens.FindAnyNs('InfNfse');

    if not Assigned(Node) then Exit;

    NumNFSe := ObterConteudoTag(Node.Childrens.FindAnyNs('Numero'), tcStr);
    CodVerif := ObterConteudoTag(Node.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
    DataAut := ObterConteudoTag(Node.Childrens.FindAnyNs('DataEmissao'), tcDatHor);

    Node2 := Node.Childrens.FindAnyNs('DeclaracaoPrestacaoServico');

    // Tem provedor que mudou a tag de <DeclaracaoPrestacaoServico>
    // para <Rps>
    if Node2 = nil then
      Node2 := Node.Childrens.FindAnyNs('Rps');

    if not Assigned(Node2) then Exit;

    Node := Node2.Childrens.FindAnyNs('InfDeclaracaoPrestacaoServico');
    if not Assigned(Node) then Exit;

    Node := Node.Childrens.FindAnyNs('Rps');

    NumRps := '';
    SerieRps := '';

    if Node <> nil then
    begin
      Node := Node.Childrens.FindAnyNs('IdentificacaoRps');

      if Node <> nil then
      begin
        NumRps := ObterConteudoTag(Node.Childrens.FindAnyNs('Numero'), tcStr);
        NumeroRps := StrToIntDef(NumRps, 0);
        SerieRps := ObterConteudoTag(Node.Childrens.FindAnyNs('Serie'), tcStr);
      end;
    end;

    AResumo := Response.Resumos.New;
    AResumo.NumeroNota := NumNFSe;
    AResumo.Data := DataAut;
    AResumo.CodigoVerificacao := CodVerif;
    AResumo.NumeroRps := NumRps;
    AResumo.SerieRps := SerieRps;

    Response.NumeroNota := NumNFSe;
    Response.CodigoVerificacao := CodVerif;
    Response.NumeroRps := NumRps;
    Response.SerieRps := SerieRps;

    if NumeroRps > 0 then
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
    else
      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(NumNFSe);

    ANota := CarregarXmlNfse(ANota, parentNode.OuterXml);
    SalvarXmlNfse(ANota);

    AResumo.NomeArq := ANota.NomeArq;
    AResumo.Link := ANota.NFSe.Link;

    Response.Link := ANota.NFSe.Link;

    Result := True; // Processado com sucesso pois retornou a nota
  end;
end;

function TACBrNFSeProviderCoplanAPIPropria.CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_CoplanAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderCoplanAPIPropria.CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_CoplanAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderCoplanAPIPropria.CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice;
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
    Result := TACBrNFSeXWebserviceCoplanAPIPropria.Create(FAOwner, AMetodo, URL,
      Method, AMimeType);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderCoplanAPIPropria.VerificarAlerta(const ACodigo,
  AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) > 0);
end;

function TACBrNFSeProviderCoplanAPIPropria.VerificarErro(const ACodigo,
  AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) = 0);
end;

procedure TACBrNFSeProviderCoplanAPIPropria.ProcessarMensagemErros(
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

  if (ANode = nil) then
    ANode := RootNode.Childrens.FindAnyNs('MensagemRetorno');

  ProcessarErros;

  ANode := RootNode.Childrens.FindAnyNs('ListaMensagemRetornoLote');

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
  end;
end;

function TACBrNFSeProviderCoplanAPIPropria.PrepararRpsParaLote(
  const aXml: string): string;
var
  i: Integer;
  Prefixo: string;
begin
  i := Pos('>', aXml) + 1;

  if ConfigMsgDados.PrefixoTS = '' then
    Prefixo := ''
  else
    Prefixo := ConfigMsgDados.PrefixoTS + ':';

  Result := '<' + Prefixo + 'DPS>' + Copy(aXml, i, Length(aXml));
end;

function TACBrNFSeProviderCoplanAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararEmitir(
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

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosEmitir(Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    if Response.ModoEnvio in [meLoteAssincrono, meLoteSincrono, meTeste] then
    begin
      if ConfigMsgDados.GerarPrestadorLoteRps then
      begin
        Prestador := '<' + Prefixo2 + 'Prestador>' +
                       '<' + Prefixo2 + 'CpfCnpj>' +
                         GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                       '</' + Prefixo2 + 'CpfCnpj>' +
                       GetInscMunic(Emitente.InscMun, Prefixo2) +
                     '</' + Prefixo2 + 'Prestador>'
      end
      else
        Prestador := '<' + Prefixo2 + 'CpfCnpj>' +
                       GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                     '</' + Prefixo2 + 'CpfCnpj>' +
                     GetInscMunic(Emitente.InscMun, Prefixo2);

      Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + ' xmlns:ns2="http://www.w3.org/2000/09/xmldsig#">' +
                                 '<' + Prefixo + 'LoteDps' + NameSpace2 + IdAttr + Versao + '>' +
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

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  NumNFSe, CodVerif, NumDps, SerieRps, NFSeXml: string;
  DataAut: TDateTime;
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  AResumo: TNFSeResumoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  ANota: TNotaFiscal;
  I: Integer;
begin
  Document := TACBrXmlDocument.Create;
  NumDps := '';

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

      ProcessarMensagemErros(ANode, Response);

      with Response do
      begin
        Data := ObterConteudoTag(ANode.Childrens.FindAnyNs('DataRecebimento'), tcDat);
        Protocolo := ObterConteudoTag(ANode.Childrens.FindAnyNs('Protocolo'), tcStr);
      end;

      if Response.ModoEnvio in [meLoteSincrono, meUnitario] then
      begin
        // Retorno do EnviarLoteRpsSincrono e GerarNfse
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
          AuxNode := ANode.Childrens.FindAnyNs('NFSe');
          if not Assigned(AuxNode) then Exit;

          NFSeXml := AuxNode.OuterXml;
          AuxNode := AuxNode.Childrens.FindAnyNs('infNFSe');

          CodVerif := RemoverLiteralChave(ObterConteudoTag(AuxNode.Attributes.Items['Id']));
          NumNFSe := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nNFSe'), tcStr);
          DataAut := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhProc'), tcDatHor);

          AuxNode := AuxNode.Childrens.FindAnyNs('DPS');
          AuxNode := AuxNode.Childrens.FindAnyNs('infDPS');
          NumDps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nDPS'), tcStr);

          with Response do
          begin
            NumeroNota := NumNFSe;
            Data := DataAut;
            XmlRetorno := NFSeXml;
          end;

          AResumo := Response.Resumos.New;
          AResumo.NumeroNota := NumNFSe;
          AResumo.CodigoVerificacao := CodVerif;
          AResumo.NumeroRps := NumDps;
          AResumo.SerieRps := SerieRps;

          ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

          ANota := CarregarXmlNfse(ANota, NFSeXml);
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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse);
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

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador, NumeroLote: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador :='<' + Prefixo + 'Prestador>' +
                  '<' + Prefixo2 + 'CpfCnpj>' +
                    GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                  '</' + Prefixo2 + 'CpfCnpj>' +
                  GetInscMunic(Emitente.InscMun, Prefixo2) +
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

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse);
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

      if Response.Situacao = '' then
        Response.Situacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('SituacaoLoteRps'), tcStr);

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

        LerCancelamento(ANode, Response);

        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('Nfse');

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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse);
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
    aParams.TagEnvio := 'ConsultarNfseDpsEnvio';
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

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosConsultaporRps(Response: TNFSeConsultaNFSeporRpsResponse;
  Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;

  function GerarChaveDPS: string;
  var
    cMun, vSerie, vNumero, vCNPJ, tpInsc: string;
  begin
    {
    A regra de formação do identificador de 45 posições da DPS é:
    "DPS" + Cód.Mun (7) + Tipo de Inscrição Federal (1) +
    Inscrição Federal (14 - CPF completar com 000 à esquerda) + Série DPS (5)+ Núm. DPS (15)
    }
    cMun := Poem_Zeros(Emitente.DadosEmitente.CodigoMunicipio, 7);
    vCNPJ := OnlyCPFCNPJAlphaNum(Emitente.CNPJ);

    if Length(vCNPJ) = 11 then
	    tpInsc := '1'
    else
      tpInsc := '2';

    vCNPJ := PadLeft(vCNPJ, 14, '0');
    vSerie := Poem_Zeros(Response.SerieRps, 5);
    vNumero := Poem_Zeros(Response.NumeroRps, 15);

    Result := 'DPS' + cMun + tpInsc + vCNPJ + vSerie + vNumero;
  end;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Prestador := '<' + Prefixo + 'Prestador>' +
                   '<' + Prefixo2 + 'CpfCnpj>' +
                     GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                   '</' + Prefixo2 + 'CpfCnpj>' +
                   GetInscMunic(Emitente.InscMun, Prefixo2) +
                 '</' + Prefixo + 'Prestador>';

    Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                               '<' + Prefixo + 'IdentificacaoDPS>' +
                                 GerarChaveDPS +
                               '</' + Prefixo + 'IdentificacaoDPS>' +
                               Prestador +
                             '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;
  ANota: TNotaFiscal;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit
  end;

  Document := TACBrXmlDocument.Create;
  try
    try
      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root;

      ProcessarMensagemErros(ANode, Response);

      ANode := ANode.Childrens.FindAnyNs('CompNfse');
      if ANode <> nil then
      begin
        ANode := ANode.Childrens.FindAnyNs('NFSe');
        AuxNode := ANode.Childrens.FindAnyNs('infNFSe');

        Response.CodigoVerificacao := RemoverLiteralChave(ObterConteudoTag(AuxNode.Attributes.Items['Id']));
        Response.NumeroNota := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nNFSe'), tcStr);
        Response.Data := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhProc'), tcDatHor);

        AuxNode := AuxNode.Childrens.FindAnyNs('DPS');
        AuxNode := AuxNode.Childrens.FindAnyNs('infDPS');
        Response.NumeroRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nDPS'), tcStr);

        ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(Response.NumeroRps);

        ANota := CarregarXmlNfse(ANota, ANode.OuterXml);
        SalvarXmlNfse(ANota);
      end
      else
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod203;
        AErro.Descricao := ACBrStr(Desc203);
      end;
    except
      on E: Exception do
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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararConsultaNFSe(Response: TNFSeConsultaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  case Response.InfConsultaNFSe.tpConsulta of
    tcPorPeriodo,
    tcPorFaixa,
    tcPorNumero: Response.Metodo := tmConsultarNFSePorFaixa;
    tcServicoTomado: Response.Metodo := tmConsultarNFSeServicoTomado;
    tcServicoPrestado: Response.Metodo := tmConsultarNFSeServicoPrestado;
    tcPorChave: Response.Metodo := tmConsultarNFSePorChave;
  else
    Response.Metodo := tmConsultarNFSe;
  end;

  case Response.InfConsultaNFSe.tpConsulta of
    tcPorPeriodo,
    tcPorFaixa,
    tcPorNumero: PrepararConsultaNFSeporFaixa(Response);
    tcServicoPrestado: PrepararConsultaNFSeServicoPrestado(Response);
    tcServicoTomado: PrepararConsultaNFSeServicoTomado(Response);
    tcPorChave: PrepararConsultaNFSePorChave(Response);
  else
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod001;
      AErro.Descricao := ACBrStr(Desc001);
    end;
  end;

  Method := 'POST';

  if Response.InfConsultaNFSe.tpConsulta = tcPorChave then
    Method := 'GET';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosConsultaNFSe(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  case Response.InfConsultaNFSe.tpConsulta of
    tcPorPeriodo,
    tcPorFaixa: GerarMsgDadosConsultaNFSeporFaixa(Response, Params);
    tcServicoPrestado: GerarMsgDadosConsultaNFSeServicoPrestado(Response, Params);
    tcServicoTomado: GerarMsgDadosConsultaNFSeServicoTomado(Response, Params);
    tcPorChave: GerarMsgDadosConsultaNFSePorChave(Response, Params);
  else
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod001;
      AErro.Descricao := ACBrStr(Desc001);
    end;
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoConsultaNFSe(Response: TNFSeConsultaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
begin
  case Response.InfConsultaNFSe.tpConsulta of
    tcPorPeriodo,
    tcPorFaixa,
    tcPorNumero: TratarRetornoConsultaNFSeporFaixa(Response);
    tcServicoPrestado: TratarRetornoConsultaNFSeServicoPrestado(Response);
    tcServicoTomado: TratarRetornoConsultaNFSeServicoTomado(Response);
    tcPorChave: TratarRetornoConsultaNFSePorChave(Response);
  else
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod001;
      AErro.Descricao := ACBrStr(Desc001);
    end;
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse);
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

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosConsultaNFSeporFaixa(
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

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseEnvio' + NameSpace + '>' +
                           Prestador +
                           Xml +
                           '<' + Prefixo + 'Pagina>' +
                              IntToStr(Response.InfConsultaNFSe.Pagina) +
                           '</' + Prefixo + 'Pagina>' +
                         '</' + Prefixo + 'ConsultarNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoConsultaNFSeporFaixa(Response: TNFSeConsultaNFSeResponse);
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

        LerCancelamento(ANode, Response);

        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('Nfse');
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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararConsultaNFSeServicoPrestado(
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
                       '<' + PrefixoTS + 'CpfCnpj>' +
                          GetCpfCnpj(Response.InfConsultaNFSe.CNPJTomador, PrefixoTS) +
                       '</' + PrefixoTS + 'CpfCnpj>' +
                       GetInscMunic(Response.InfConsultaNFSe.IMTomador, PrefixoTS) +
                     '</' + Prefixo + 'Tomador>';
  end;

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJInter) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Intermediario>' +
                       '<' + PrefixoTS + 'CpfCnpj>' +
                          GetCpfCnpj(Response.InfConsultaNFSe.CNPJInter, PrefixoTS) +
                       '</' + PrefixoTS + 'CpfCnpj>' +
                       GetInscMunic(Response.InfConsultaNFSe.IMInter, PrefixoTS) +
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

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosConsultaNFSeServicoPrestado(
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

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseEnvio' + NameSpace + '>' +
                           Prestador +
                           Xml +
                           '<' + Prefixo + 'Pagina>' +
                              IntToStr(Response.InfConsultaNFSe.Pagina) +
                           '</' + Prefixo + 'Pagina>' +
                         '</' + Prefixo + 'ConsultarNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoConsultaNFSeServicoPrestado(
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

        LerCancelamento(ANode, Response);

        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('Nfse');
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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararConsultaNFSeServicoTomado(
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
                       '<' + PrefixoTS + 'CpfCnpj>' +
                          GetCpfCnpj(Response.InfConsultaNFSe.CNPJPrestador, PrefixoTS) +
                       '</' + PrefixoTS + 'CpfCnpj>' +
                       GetInscMunic(Response.InfConsultaNFSe.IMPrestador, PrefixoTS) +
                     '</' + Prefixo + 'Prestador>';
  end;

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJTomador) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Tomador>' +
                       '<' + PrefixoTS + 'CpfCnpj>' +
                          GetCpfCnpj(Response.InfConsultaNFSe.CNPJTomador, PrefixoTS) +
                       '</' + PrefixoTS + 'CpfCnpj>' +
                       GetInscMunic(Response.InfConsultaNFSe.IMTomador, PrefixoTS) +
                     '</' + Prefixo + 'Tomador>';
  end;

  if NaoEstaVAzio(Response.InfConsultaNFSe.CNPJInter) then
  begin
    XmlConsulta := XmlConsulta +
                     '<' + Prefixo + 'Intermediario>' +
                       '<' + PrefixoTS + 'CpfCnpj>' +
                          GetCpfCnpj(Response.InfConsultaNFSe.CNPJInter, PrefixoTS) +
                       '</' + PrefixoTS + 'CpfCnpj>' +
                       GetInscMunic(Response.InfConsultaNFSe.IMInter, PrefixoTS) +
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

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Consulente: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  with Params do
  begin
    Consulente :='<' + Prefixo + 'Consulente>' +
                   '<' + Prefixo2 + 'CpfCnpj>' +
                     GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                   '</' + Prefixo2 + 'CpfCnpj>' +
                   GetInscMunic(Emitente.InscMun, Prefixo2) +
                 '</' + Prefixo + 'Consulente>';

    Response.ArquivoEnvio := '<' + Prefixo + 'ConsultarNfseEnvio' + NameSpace + '>' +
                           Consulente +
                           Xml +
                           '<' + Prefixo + 'Pagina>' +
                              IntToStr(Response.InfConsultaNFSe.Pagina) +
                           '</' + Prefixo + 'Pagina>' +
                         '</' + Prefixo + 'ConsultarNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoConsultaNFSeServicoTomado(
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

        LerCancelamento(ANode, Response);

        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('Nfse');
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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararCancelaNFSe(Response: TNFSeCancelaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  Emitente: TEmitenteConfNFSe;
  InfoCanc: TInfCancelamento;
  IdAttr, NameSpace, NameSpaceCanc, xMotivo, xCodVerif, Prefixo, PrefixoTS,
  xSerie: string;
begin
  if EstaVazio(Response.InfCancelamento.NumeroNFSe) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod108;
    AErro.Descricao := ACBrStr(Desc108);
    Exit;
  end;

  if EstaVazio(Response.InfCancelamento.CodCancelamento) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod109;
    AErro.Descricao := ACBrStr(Desc109);
    Exit;
  end;

  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  InfoCanc := Response.InfCancelamento;
  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.CancelarNFSe.xmlns) then
  begin
    NameSpace := '';
    NameSpaceCanc := '';
  end
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.CancelarNFSe.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.CancelarNFSe.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;

    NameSpaceCanc := NameSpace;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.CancelarNFSe.xmlns) and
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

  IdAttr := DefinirIDCancelamento(OnlyCPFCNPJAlphaNum(Emitente.CNPJ),
                                  OnlyNumber(Emitente.InscMun),
                                  InfoCanc.NumeroNFSe);

  if ConfigGeral.CancPreencherSerieNfse then
  begin
    if EstaVazio(InfoCanc.SerieNFSe) then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod112;
      AErro.Descricao := ACBrStr(Desc112);
      Exit;
    end;

    xSerie := '<' + PrefixoTS + 'Serie>' +
                 Trim(InfoCanc.SerieNFSe) +
              '</' + PrefixoTS + 'Serie>';
  end
  else
    xSerie := '';

  if ConfigGeral.CancPreencherMotivo then
  begin
    if EstaVazio(InfoCanc.MotCancelamento) then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod110;
      AErro.Descricao := ACBrStr(Desc110);
      Exit;
    end;

    xMotivo := '<' + Prefixo + 'MotivoCancelamento>' +
                 Trim(InfoCanc.MotCancelamento) +
               '</' + Prefixo + 'MotivoCancelamento>';
  end
  else
    xMotivo := '';

  if ConfigGeral.CancPreencherCodVerificacao then
  begin
    if EstaVazio(InfoCanc.CodVerificacao) then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod117;
      AErro.Descricao := ACBrStr(Desc117);
      Exit;
    end;

    xCodVerif := '<' + Prefixo + 'CodigoVerificacao>' +
                   Trim(InfoCanc.CodVerificacao) +
                 '</' + Prefixo + 'CodigoVerificacao>';
  end
  else
    xCodVerif := '';

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := '';
    aParams.TagEnvio := '';
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := NameSpaceCanc;
    aParams.IdAttr := IdAttr;
    aParams.Versao := '';
    aParams.Serie := xSerie;
    aParams.Motivo := xMotivo;
    aParams.CodigoVerificacao := xCodVerif;

    GerarMsgDadosCancelaNFSe(Response, aParams);
  finally
    aParams.Free;
  end;

  Method := 'POST';
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosCancelaNFSe(Response: TNFSeCancelaNFSeResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  InfoCanc: TInfCancelamento;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  InfoCanc := Response.InfCancelamento;

  with Params do
  begin
    Response.ArquivoEnvio := '<' + Prefixo + 'CancelarNfseEnvio' + NameSpace + '>' +
                               '<' + Prefixo2 + 'Pedido>' +
                                 '<' + Prefixo2 + 'InfPedidoCancelamento' + IdAttr + NameSpace2 + '>' +
                                   '<' + Prefixo2 + 'IdentificacaoNfse>' +
                                     '<' + Prefixo2 + 'Numero>' +
                                       InfoCanc.NumeroNFSe +
                                     '</' + Prefixo2 + 'Numero>' +
                                     '<' + Prefixo2 + 'CpfCnpj>' +
                                       GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                                     '</' + Prefixo2 + 'CpfCnpj>' +
                                     GetInscMunic(Emitente.InscMun, Prefixo2) +
                                     '<' + Prefixo2 + 'CodigoMunicipio>' +
                                       IntToStr(InfoCanc.CodMunicipio) +
                                     '</' + Prefixo2 + 'CodigoMunicipio>' +
                                   '</' + Prefixo2 + 'IdentificacaoNfse>' +
                                   '<' + Prefixo2 + 'CodigoCancelamento>' +
                                     InfoCanc.CodCancelamento +
                                   '</' + Prefixo2 + 'CodigoCancelamento>' +
                                 '</' + Prefixo2 + 'InfPedidoCancelamento>' +
                               '</' + Prefixo2 + 'Pedido>' +
                             '</' + Prefixo + 'CancelarNfseEnvio>';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoCancelaNFSe(Response: TNFSeCancelaNFSeResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  Ret: TRetCancelamento;
  IdAttr, xCancelamento, xXMLNS, nomeArq: string;
  AErro: TNFSeEventoCollectionItem;
  Inicio, Fim: Integer;
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

      ANode := Document.Root.Childrens.FindAnyNs('RetCancelamento');

      if ANode = nil then
        ANode := Document.Root.Childrens.FindAnyNs('RetornoCancelamento');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod209;
        AErro.Descricao := ACBrStr(Desc209);
        Exit;
      end;

      ProcessarMensagemErros(ANode, Response);

      ANode := ANode.Childrens.FindAnyNs('NfseCancelamento');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod210;
        AErro.Descricao := ACBrStr(Desc210);
        Exit;
      end;

      AuxNode := ANode.Childrens.FindAnyNs('Confirmacao');

      if AuxNode = nil then
        AuxNode := ANode.Childrens.FindAnyNs('ConfirmacaoCancelamento');

      if AuxNode <> nil then
        ANode := AuxNode;

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod204;
        AErro.Descricao := ACBrStr(Desc204);
        Exit;
      end;

      Ret := Response.RetCancelamento;
      Ret.DataHora := ObterConteudoTag(ANode.Childrens.FindAnyNs('DataHora'), tcDatHor);

      if ConfigAssinar.IncluirURI then
        IdAttr := ConfigGeral.Identificador
      else
        IdAttr := 'ID';

      AuxNode := ANode.Childrens.FindAnyNs('Pedido');

      if AuxNode = nil then
        AuxNode := ANode.Childrens.FindAnyNs('PedidoCancelamento');

      if AuxNode <> nil then
        ANode := AuxNode;

      ANode := ANode.Childrens.FindAnyNs('InfPedidoCancelamento');
      if not Assigned(ANode) then Exit;

      Ret.Pedido.InfID.ID := ObterConteudoTag(ANode.Attributes.Items[IdAttr]);
      Ret.Pedido.CodigoCancelamento := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoCancelamento'), tcStr);

      ANode := ANode.Childrens.FindAnyNs('IdentificacaoNfse');
      if not Assigned(ANode) then Exit;

      with Ret.Pedido.IdentificacaoNfse do
      begin
        Numero := ObterConteudoTag(ANode.Childrens.FindAnyNs('Numero'), tcStr);

        AuxNode := ANode.Childrens.FindAnyNs('CpfCnpj');

        if AuxNode <> nil then
        begin
          Cnpj := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Cnpj'), tcStr);

          if Cnpj = '' then
            Cnpj := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Cpf'), tcStr);
        end
        else
          Cnpj := ObterConteudoTag(ANode.Childrens.FindAnyNs('Cnpj'), tcStr);

        InscricaoMunicipal := ObterConteudoTag(ANode.Childrens.FindAnyNs('InscricaoMunicipal'), tcStr);
        CodigoMunicipio := ObterConteudoTag(ANode.Childrens.FindAnyNs('CodigoMunicipio'), tcStr);
      end;

      if Ret.DataHora > 0 then
      begin
        Ret.Sucesso := 'Sim';
        Ret.Situacao := 'Cancelado';

        Inicio := Pos('CancelarNfseEnvio', Response.ArquivoEnvio) + 16;
        Fim := Pos('>', Response.ArquivoEnvio);

        if Inicio = Fim then
          xXMLNS := ''
        else
          xXMLNS := trim(Copy(Response.ArquivoEnvio, Inicio + 1, Fim - (Inicio + 1)));

        xCancelamento := '<Cancelamento ' + xXMLNS + '>' +
                            SeparaDados(Response.ArquivoEnvio, 'Pedido', True) +
                            SepararDados(Response.ArquivoRetorno, 'DataHora', True) +
                         '</Cancelamento>';

        nomeArq := '';
        SalvarXmlCancelamento(Ret.Pedido.InfID.ID + '-procCancNFSe', xCancelamento, nomeArq);
        Response.PathNome := nomeArq;
      end
      else
      begin
        Ret.Sucesso := '';
        Ret.Situacao := '';
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

procedure TACBrNFSeProviderCoplanAPIPropria.PrepararSubstituiNFSe(Response: TNFSeSubstituiNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  Nota: TNotaFiscal;
  IdAttr, xRps, NameSpace, NumRps, TagEnvio, Prefixo, PrefixoTS,
  IdAttrSig: string;
begin
  if EstaVazio(Response.PedCanc) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod107;
    AErro.Descricao := ACBrStr(Desc107);
    Exit;
  end;

  if TACBrNFSeX(FAOwner).NotasFiscais.Count <= 0 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod002;
    AErro.Descricao := ACBrStr(Desc002);
  end;

  if TACBrNFSeX(FAOwner).NotasFiscais.Count > 1 then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod003;
    AErro.Descricao := ACBrStr('Conjunto de RPS transmitidos (máximo de 1 RPS)' +
                       ' excedido. Quantidade atual: ' +
                       IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count));
  end;

  if Response.Erros.Count > 0 then Exit;

  Prefixo := '';
  PrefixoTS := '';

  if EstaVazio(ConfigMsgDados.SubstituirNFSe.xmlns) then
    NameSpace := ''
  else
  begin
    if ConfigMsgDados.Prefixo = '' then
      NameSpace := ' xmlns="' + ConfigMsgDados.SubstituirNFSe.xmlns + '"'
    else
    begin
      NameSpace := ' xmlns:' + ConfigMsgDados.Prefixo + '="' + ConfigMsgDados.SubstituirNFSe.xmlns + '"';
      Prefixo := ConfigMsgDados.Prefixo + ':';
    end;
  end;

  if ConfigMsgDados.XmlRps.xmlns <> '' then
  begin
    if (ConfigMsgDados.XmlRps.xmlns <> ConfigMsgDados.SubstituirNFSe.xmlns) and
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

  Nota := TACBrNFSeX(FAOwner).NotasFiscais.Items[0];

  if ConfigAssinar.IncluirURI then
    IdAttr := ConfigGeral.Identificador
  else
    IdAttr := 'ID';

  Nota.GerarXML;

  Nota.XmlRps := ConverteXMLtoUTF8(Nota.XmlRps);
  Nota.XmlRps := ChangeLineBreak(Nota.XmlRps, '');

  if ConfigAssinar.RpsSubstituirNFSe then
  begin
    IdAttrSig := SetIdSignatureValue(Nota.XmlRps,
               ConfigMsgDados.XmlRps.DocElemento, IdAttr);

    Nota.XmlRps := FAOwner.SSL.Assinar(Nota.XmlRps,
                                       PrefixoTS + ConfigMsgDados.XmlRps.DocElemento,
                                       ConfigMsgDados.XmlRps.InfElemento, '', '', '',
                                       IdAttr, IdAttrSig);
  end;

  SalvarXmlRps(Nota);

  NumRps := Nota.NFSe.IdentificacaoRps.Numero;

  xRps := RemoverDeclaracaoXML(Nota.XmlRps);
  xRps := PrepararRpsParaLote(xRps);

  if ConfigGeral.Identificador <> '' then
    IdAttr := ' ' + ConfigGeral.Identificador + '="Sub_' + OnlyNumber(NumRps) + '"'
  else
    IdAttr := '';

  {
    No serviço de Substituição de NFS-e temos o pedido de cancelamento de uma
    NFS-e mais o RPS que vai ser convertido na NFS-e substituta.

    A NFS-e substituta substitui a NFS-e Cancelada.

    (Response.PedCanc) contem o pedido de cancelamento da NFS-e existente.
    (xRps) contem o RPS que será convertido na NFS-e substituta.
  }

  TagEnvio := ConfigMsgDados.SubstituirNFSe.DocElemento;

  aParams := TNFSeParamsResponse.Create;
  try
    aParams.Clear;
    aParams.Xml := xRps;
    aParams.TagEnvio := TagEnvio;
    aParams.Prefixo := Prefixo;
    aParams.Prefixo2 := PrefixoTS;
    aParams.NameSpace := NameSpace;
    aParams.NameSpace2 := '';
    aParams.IdAttr := IdAttr;
    aParams.Versao := '';
    aParams.Serie := '';
    aParams.Motivo := '';
    aParams.CodigoVerificacao := '';

    GerarMsgDadosSubstituiNFSe(Response, aParams);
  finally
    aParams.Free;
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.GerarMsgDadosSubstituiNFSe(
  Response: TNFSeSubstituiNFSeResponse; Params: TNFSeParamsResponse);
begin
  with Params do
  begin
    Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                           '<' + Prefixo + 'SubstituicaoNfse' + IdAttr + '>' +
                             Response.PedCanc +
                             Xml +
                           '</' + Prefixo + 'SubstituicaoNfse>' +
                         '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderCoplanAPIPropria.TratarRetornoSubstituiNFSe(Response: TNFSeSubstituiNFSeResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode, ANodeSubstituida: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;

  function LocalizarNFSeRetorno(const RootNode: TACBrXmlNode): string;
  var
    ANode, AuxNode: TACBrXmlNode;
    NumNFSe: String;
    ANota: TNotaFiscal;
  begin
    Result := '';
    ANode := RootNode.Childrens.FindAnyNs('CompNfse');

    if not Assigned(ANode) then
    begin
      AErro := Response.Erros.New;
      AErro.Codigo := Cod203;
      AErro.Descricao := ACBrStr(Desc203);
      Exit;
    end;

    AuxNode := ANode.Childrens.FindAnyNs('Nfse');
    if not Assigned(AuxNode) then Exit;

    AuxNode := AuxNode.Childrens.FindAnyNs('InfNfse');
    if not Assigned(AuxNode) then Exit;

    AuxNode := AuxNode.Childrens.FindAnyNs('Numero');

    if AuxNode <> nil then
    begin
      NumNFSe := AuxNode.AsString;

      ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(NumNFSe);

      ANota := CarregarXmlNfse(ANota, ANode.OuterXml);
      SalvarXmlNfse(ANota);
      Result := NumNFSe;
    end;
  end;

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

      ANode := Document.Root.Childrens.FindAnyNs('RetSubstituicao');

      if not Assigned(ANode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod205;
        AErro.Descricao := ACBrStr(Desc205);
        Exit;
      end;

      ProcessarMensagemErros(ANode, Response);

      AuxNode := ANode.Childrens.FindAnyNs('NfseSubstituida');

      if not Assigned(AuxNode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod206;
        AErro.Descricao := ACBrStr(Desc206);
        Exit;
      end
      else
      begin
        Response.NumNotaSubstituida := LocalizarNFSeRetorno(AuxNode);

        ANodeSubstituida := AuxNode.Childrens.FindAnyNs('CompNfse');

        if not Assigned(ANodeSubstituida) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;

        ANodeSubstituida := ANodeSubstituida.Childrens.FindAnyNs('Nfse');
        if not Assigned(ANodeSubstituida) then Exit;

        ANodeSubstituida := ANodeSubstituida.Childrens.FindAnyNs('InfNfse');

        with Response do
        begin
          CodigoVerificacao := ObterConteudoTag(ANodeSubstituida.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
          Data := ObterConteudoTag(ANodeSubstituida.Childrens.FindAnyNs('DataEmissao'), tcDatHor);
        end;
      end;

      AuxNode := ANode.Childrens.FindAnyNs('NfseSubstituidora');

      if not Assigned(AuxNode) then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod207;
        AErro.Descricao := ACBrStr(Desc207);
        Exit;
      end
      else
      begin
        Response.NumNotaSubstituidora := LocalizarNFSeRetorno(AuxNode);
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

{ TACBrNFSeXWebserviceCoplanAPIPropria }

function TACBrNFSeXWebserviceCoplanAPIPropria.GetNamespace: string;
begin
  if FPConfiguracoes.WebServices.AmbienteCodigo = 1 then
    Result := 'Tributario_PRODUCAO_FULL' //'Tributario_PRD_Oficial'
  else
//    Result := 'TributarioGx16New';
//    Result := 'GX_KB_Tributario_Tributario';
    Result := 'Tributario_HOMOLOGACAO_FULL';

  Result := 'xmlns:trib1="' + Result + '"';
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.Recepcionar(const ACabecalho,
  AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web.RECEPCIONARLOTEDPS>';
  Request := Request + '<trib:Recepcionarlotedpsrequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Recepcionarlotedpsrequest>';
  Request := Request + '</trib:nfse_web.RECEPCIONARLOTEDPS>';

  Result := Executar('Tributarioaction/ANFSE_WEB.RECEPCIONARLOTEDPS', Request,
    ['Recepcionarlotedpsresponse', 'outputXML', 'EnviarLoteDpsResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.RecepcionarSincrono(const ACabecalho, AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web.RECEPCIONARLOTEDPSSINCRONO>';
  Request := Request + '<trib:Recepcionarlotedpssincronorequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Recepcionarlotedpssincronorequest>';
  Request := Request + '</trib:nfse_web.RECEPCIONARLOTEDPSSINCRONO>';

  Result := Executar('Tributarioaction/ANFSE_WEB.RECEPCIONARLOTEDPSSINCRONO', Request,
    ['Recepcionarlotedpssincronoresponse', 'outputXML', 'EnviarLoteDpsSincronoResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.GerarNFSe(const ACabecalho, AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_web.GERARNFSE>';
  Request := Request + '<trib:Gerarnfserequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Gerarnfserequest>';
  Request := Request + '</trib:nfse_web.GERARNFSE>';

  Result := Executar('Tributarioaction/ANFSE_WEB.GERARNFSE', Request,
    ['Gerarnfseresponse', 'outputXML', 'GerarNfseResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.CONSULTARLOTEDPS>';
  Request := Request + '<trib:Consultarlotedpsrequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarlotedpsrequest>';
  Request := Request + '</trib:nfse_ws.CONSULTARLOTEDPS>';

  Result := Executar('Tributarioaction/ANFSE_WS.CONSULTARLOTEDPS', Request,
    ['Consultarlotedpsresponse', 'outputXML', 'ConsultarLoteDpsResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarNFSePorRps(const ACabecalho, AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.CONSULTARNFSEPORDPS>';
  Request := Request + '<trib:Consultarnfsepordpsrequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfsepordpsrequest>';
  Request := Request + '</trib:nfse_ws.CONSULTARNFSEPORDPS>';

  Result := Executar('Tributarioaction/ANFSE_WS.CONSULTARNFSEPORDPS', Request,
    ['Consultarnfsepordpsresponse', 'outputXML', 'ConsultarNfseRpsResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarNFSePorFaixa(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.CONSULTARNFSEFAIXA>';
  Request := Request + '<trib:Consultarnfseporfaixarequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseporfaixarequest>';
  Request := Request + '</trib:nfse_ws.CONSULTARNFSEFAIXA>';

  Result := Executar('Tributarioaction/ANFSE_WS.CONSULTARNFSEFAIXA', Request,
    ['Consultarnfseporfaixaresponse', 'outputXML', 'ConsultarNfseProFaixaResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarNFSeServicoPrestado(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.CONSULTARNFSESERVICOPRESTADO>';
  Request := Request + '<trib:Consultarnfseservicoprestadorequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) +  '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseservicoprestadorequest>';
  Request := Request + '</trib:nfse_ws.CONSULTARNFSESERVICOPRESTADO>';

  Result := Executar('Tributarioaction/ANFSE_WS.CONSULTARNFSESERVICOPRESTADO', Request,
    ['Consultarnfseservicoprestadoresponse', 'outputXML', 'ConsultarNfseServicoPrestadoResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarNFSeServicoTomado(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.CONSULTARNFSESERVICOTOMADO>';
  Request := Request + '<trib:Consultarnfseservicotomadorequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Consultarnfseservicotomadorequest>';
  Request := Request + '</trib:nfse_ws.CONSULTARNFSESERVICOTOMADO>';

  Result := Executar('Tributarioaction/ANFSE_WS.CONSULTARNFSESERVICOTOMADO', Request,
    ['Consultarnfseservicotomadoresponse', 'outputXML', 'ConsultarNfseServicoTomadoResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.Cancelar(const ACabecalho, AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.CANCELARNFSE>';
  Request := Request + '<trib:Cancelarnfserequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Cancelarnfserequest>';
  Request := Request + '</trib:nfse_ws.CANCELARNFSE>';

  Result := Executar('Tributarioaction/ANFSE_WEB.CANCELARNFSE', Request,
    ['Cancelarnfseresponse', 'outputXML', 'CancelarNfseResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<trib:nfse_ws.SUBSTITUIRNFSE>';
  Request := Request + '<trib:Substituirnfserequest>';
  Request := Request + '<trib1:nfseCabecMsg>' + IncluirCDATA(ACabecalho) + '</trib1:nfseCabecMsg>';
  Request := Request + '<trib1:nfseDadosMsg>' + IncluirCDATA(AMSG) + '</trib1:nfseDadosMsg>';
  Request := Request + '</trib:Substituirnfserequest>';
  Request := Request + '</trib:nfse_ws.SUBSTITUIRNFSE>';

  Result := Executar('Tributarioaction/ANFSE_WEB.SUBSTITUIRNFSE', Request,
    ['Substituirnfseresponse', 'outputXML', 'SubstituirNfseResposta'],
    ['xmlns:trib="Tributario"', NameSpace]);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarNFSePorChave(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarDFe(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarEvento(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ConsultarParam(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.ObterDANFSE(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceCoplanAPIPropria.TratarXmlRetornado(const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := RemoverDeclaracaoXML(Result, True);
  Result := RemoverCDATA(Result);
  Result := RemoverIdentacao(Result);
  Result := FaststringReplace(Result, 'GX_KB_Tributario_Tributario', '', [rfReplaceAll]);
end;

end.
