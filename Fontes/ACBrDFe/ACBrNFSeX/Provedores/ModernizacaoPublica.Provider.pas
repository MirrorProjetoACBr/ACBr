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

unit ModernizacaoPublica.Provider;

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
  PadraoNacional.Provider,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse,
  ACBrJson,
  ACBrBase,
  synacode;

type
  TACBrNFSeXWebserviceModernizacaoPublica202 = class(TACBrNFSeXWebserviceSoap11)
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
  end;

  TACBrNFSeProviderModernizacaoPublica202 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetorno';
                                     const AMessageTag: string = 'Erro'); override;
  end;

  TACBrNFSeXWebserviceModernizacaoPublicaAPIPropria = class(TACBrNFSeXWebserviceMisto1)
  protected
    procedure SetHeaders(aHeaderReq: THTTPHeader); override;
  public

    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderModernizacaoPublicaAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private

  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
    procedure GerarMsgDadosConsultaporRps(Response: TNFSeConsultaNFSeporRpsResponse;
      Params: TNFSeParamsResponse); override;
    procedure TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;

    procedure ProcessarMensagemDeErros(LJson: TACBrJSONObject;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'Erros'); override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagemRetorno';
                                     const AMessageTag: string = 'Erro'); override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrDFeUtil,
  ACBrUtil.Base,
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeException,
  ACBrNFSeX,
  ACBrNFSeXConsts,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXNotasFiscais,
  ModernizacaoPublica.GravarXml,
  ModernizacaoPublica.LerXml;

{ TACBrNFSeProviderModernizacaoPublica202 }

procedure TACBrNFSeProviderModernizacaoPublica202.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    UseCertificateHTTP := False;
    CancPreencherMotivo := True;
  end;

  with ConfigAssinar do
  begin
    Rps := True;
    LoteRps := True;
    CancelarNFSe := True;
    RpsGerarNFSe := True;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.02';
    VersaoAtrib := '2.02';
  end;

  ConfigMsgDados.DadosCabecalho := GetCabecalho('');

  SetNomeXSD('nfse_v202.xsd');
end;

function TACBrNFSeProviderModernizacaoPublica202.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_ModernizacaoPublica202.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderModernizacaoPublica202.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_ModernizacaoPublica202.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderModernizacaoPublica202.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceModernizacaoPublica202.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderModernizacaoPublica202.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse;
  const AListTag, AMessageTag: string);
var
  I: Integer;
  ANode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
begin
  ANode := RootNode.Childrens.FindAnyNs(AListTag);

  if (ANode = nil) then
    ANode := RootNode;

  ANodeArray := ANode.Childrens.FindAllAnyNs('Erro');
  if not Assigned(ANodeArray) then Exit;

  for I := Low(ANodeArray) to High(ANodeArray) do
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('ErroID'), tcStr);
    AErro.Descricao := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('ErroMensagem'), tcStr);
    AErro.Correcao := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('ErroSolucao'), tcStr);
  end;
end;

{ TACBrNFSeXWebserviceModernizacaoPublica202 }

function TACBrNFSeXWebserviceModernizacaoPublica202.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:RecepcionarLoteRps>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:RecepcionarLoteRps>';

  Result := Executar('', Request,
                     ['RecepcionarLoteRpsReturn', 'EnviarLoteRpsResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:RecepcionarLoteRpsSincrono>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:RecepcionarLoteRpsSincrono>';

  Result := Executar('', Request,
                     ['RecepcionarLoteRpsSincronoReturn', 'EnviarLoteRpsSincronoResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:GerarNfse>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:GerarNfse>';

  Result := Executar('', Request,
                     ['GerarNfseReturn', 'GerarNfseResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:ConsultarLoteRps>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:ConsultarLoteRps>';

  Result := Executar('', Request,
                     ['ConsultarLoteRpsReturn', 'ConsultarLoteRpsResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:ConsultarNfsePorFaixa>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:ConsultarNfsePorFaixa>';

  Result := Executar('', Request,
                     ['ConsultarNfsePorFaixaReturn', 'ConsultarNfseFaixaResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:ConsultarNfsePorRps>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:ConsultarNfsePorRps>';

  Result := Executar('', Request,
                     ['ConsultarNfsePorRpsReturn', 'ConsultarNfseRpsResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:ConsultarNfseServicoPrestado>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:ConsultarNfseServicoPrestado>';

  Result := Executar('', Request,
                     ['ConsultarNfseServicoPrestadoReturn', 'ConsultarNfseServicoPrestadoResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:ConsultarNfseServicoTomado>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:ConsultarNfseServicoTomado>';

  Result := Executar('', Request,
                     ['ConsultarNfseServicoTomadoReturn', 'ConsultarNfseServicoTomadoResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:CancelarNfse>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:CancelarNfse>';

  Result := Executar('', Request,
                     ['CancelarNfseReturn', 'CancelarNfseResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<def:SubstituirNfse>';
  Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
  Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
  Request := Request + '</def:SubstituirNfse>';

  Result := Executar('', Request,
                     ['SubstituirNfseReturn', 'SubstituirNfseResposta'],
                     ['xmlns:def="http://DefaultNamespace"']);
end;

function TACBrNFSeXWebserviceModernizacaoPublica202.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
  Result := RemoverIdentacao(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
end;

{ TACBrNFSeProviderModernizacaoPublicaAPIPropria }

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.Configuracao;
begin
  inherited Configuracao;

  ConfigGeral.Autenticacao.RequerLogin := True;
end;

function TACBrNFSeProviderModernizacaoPublicaAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_ModernizacaoPublicaAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderModernizacaoPublicaAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_ModernizacaoPublicaAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderModernizacaoPublicaAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmConsultarNFSePorRps] then
    AMimeType := 'text/xml; charset=utf-8'
  else
    AMimeType := 'application/json';

  if URL <> '' then
  begin
    Result := TACBrNFSeXWebserviceModernizacaoPublicaAPIPropria.Create(FAOwner,
      AMetodo, URL, Method, AMimeType);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderModernizacaoPublicaAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;

  if aMetodo in [tmGerar, tmEnviarEvento] then
  begin
    Result := ChangeLineBreak(aXml, '');

    Method := 'POST';
  end;
end;

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.PrepararEmitir(
  Response: TNFSeEmiteResponse);
var
  VersaoDFe: string;
begin
  VersaoDFe := VersaoNFSeToStr(TACBrNFSeX(FAOwner).Configuracoes.Geral.Versao);

  with ConfigGeral do
  begin
    Layout := loPadraoNacional;
    QuebradeLinha := '\n';
    ModoEnvio := meUnitario;
    ConsultaLote := False;
    FormatoArqEnvio := tfaJson;
    FormatoArqRetorno := tfaJson;
    FormatoArqEnvioSoap := tfaJson;
    FormatoArqRetornoSoap := tfaJson;

    ServicosDisponibilizados.EnviarUnitario := True;
    ServicosDisponibilizados.ConsultarNfseChave := True;
    ServicosDisponibilizados.ConsultarRps := True;
    ServicosDisponibilizados.EnviarEvento := True;
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

    XmlRps.InfElemento := 'infDPS';
    XmlRps.DocElemento := 'DPS';

    EnviarEvento.InfElemento := 'infPedReg';
    EnviarEvento.DocElemento := 'pedRegEvento';
  end;

  with ConfigAssinar do
  begin
    RpsGerarNFSe := True;
    EnviarEvento := True;
  end;

  SetNomeXSD('***');

  with ConfigSchemas do
  begin
    GerarNFSe := 'DPS_v' + VersaoDFe + '.xsd';
    ConsultarNFSe := 'DPS_v' + VersaoDFe + '.xsd';
    ConsultarNFSeRps := 'DPS_v' + VersaoDFe + '.xsd';
    EnviarEvento := 'pedRegEvento_v' + VersaoDFe + '.xsd';
    ConsultarEvento := 'DPS_v' + VersaoDFe + '.xsd';
  end;

  inherited PrepararEmitir(Response);
end;

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrJSONObject;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml: string;
  DocumentXml: TACBrXmlDocument;
  ANode: TACBrXmlNode;
  NumNFSe, NumDps, CodVerif: string;
  DataAut: TDateTime;
  ANota: TNotaFiscal;
begin
  if Response.ArquivoRetorno = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit;
  end;

  Document := TACBrJsonObject.Parse(Response.ArquivoRetorno);
  try
    try
      ProcessarMensagemDeErros(Document, Response);
      Response.Sucesso := (Response.Erros.Count = 0);
      Response.Data := Document.AsISODateTime['dataHoraProcessamento'];

      Response.Link := Document.AsString['chave_acesso'];
      if Response.Link = '' then
        Response.Link := Document.AsString['chaveAcesso'];
      Response.CodigoVerificacao := Response.Link;

      NFSeXml := Document.AsString['xml'];
      NFSeXml := TrocaEscapeporConchete(NFSeXml);

      if NFSeXml <> '' then
      begin
        try
          DocumentXml := TACBrXmlDocument.Create;
          try
            DocumentXml.LoadFromXml(NFSeXml);

            ANode := DocumentXml.Root.Childrens.FindAnyNs('infNFSe');

            CodVerif := RemoverLiteralChave(ObterConteudoTag(ANode.Attributes.Items['Id']));
            NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
            DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

            ANode := ANode.Childrens.FindAnyNs('DPS');
            ANode := ANode.Childrens.FindAnyNs('infDPS');
            NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);

            Response.NumeroNota := NumNFSe;
            Response.Data := DataAut;
            Response.XmlRetorno := NFSeXml;

            ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);
            ANota := CarregarXmlNfse(ANota, DocumentXml.Root.OuterXml);

            SalvarXmlNfse(ANota);
          finally
            FreeAndNil(DocumentXml);
          end;
        except
          // XML parse failed (encoding issue) - data already set via string ops
        end;
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

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.PrepararConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
  aParams: TNFSeParamsResponse;
  NameSpace, TagEnvio, Prefixo, PrefixoTS: string;
const
  NameSpaceABRASF = 'http://www.abrasf.org.br/nfse.xsd';
begin
//  if ConfigGeral.Params.ParamTemValor('ServicosAPIPropria', 'ConsultarNFSeRps') then
//  begin
    // Configuração
    ConfigGeral.FormatoArqEnvio := tfaXml;
    ConfigGeral.FormatoArqRetorno := tfaXml;
    ConfigGeral.FormatoArqEnvioSoap := tfaXml;
    ConfigGeral.FormatoArqRetornoSoap := tfaXml;

    with ConfigWebServices do
    begin
      VersaoDados := '3.02';
      VersaoAtrib := '3.02';
    end;

    SetXmlNameSpace(NameSpace);
    ConfigMsgDados.DadosCabecalho := GetCabecalho('');

    SetNomeXSD('nfse_v202.xsd');

    // Montagem da consulta
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

    Method := 'POST';
//  end
//  else
//    inherited PrepararConsultaNFSeporRps(Response);
end;

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.GerarMsgDadosConsultaporRps(
  Response: TNFSeConsultaNFSeporRpsResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
  Prestador: string;
begin
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if Response.TipoRps = '' then
    Response.TipoRps := '1';

  with Params do
  begin
    Prestador :='<' + Prefixo + 'Prestador>' +
                  '<' + Prefixo2 + 'CpfCnpj>' +
                    GetCpfCnpj(Emitente.CNPJ, Prefixo2) +
                  '</' + Prefixo2 + 'CpfCnpj>' +
                  GetInscMunic(Emitente.InscMun, Prefixo2) +
                '</' + Prefixo + 'Prestador>';

    Response.ArquivoEnvio := '<' + Prefixo + TagEnvio + NameSpace + '>' +
                           '<' + Prefixo + 'IdentificacaoRps>' +
                             '<' + Prefixo2 + 'Numero>' +
                               Response.NumeroRps +
                             '</' + Prefixo2 + 'Numero>' +
                             '<' + Prefixo2 + 'Serie>' +
                               Response.SerieRps +
                             '</' + Prefixo2 + 'Serie>' +
                             '<' + Prefixo2 + 'Tipo>' +
                               Response.TipoRps +
                             '</' + Prefixo2 + 'Tipo>' +
                           '</' + Prefixo + 'IdentificacaoRps>' +
                           Prestador +
                         '</' + Prefixo + TagEnvio + '>';
  end;
end;

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.TratarRetornoConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  Document: TACBrXmlDocument;
  ANode, AuxNode, AuxNode2: TACBrXmlNode;
  AErro: TNFSeEventoCollectionItem;
  ANota: TNotaFiscal;
  NumNFSe, NumRps: String;
begin
//  if ConfigGeral.Params.ParamTemValor('ServicosAPIPropria', 'ConsultarNFSeRps') then
//  begin
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

//        LerCancelamento(ANode, Response);

//        LerSubstituicao(ANode, Response);

        AuxNode := ANode.Childrens.FindAnyNs('Nfse');

        if AuxNode <> nil then
        begin
          AuxNode := AuxNode.Childrens.FindAnyNs('InfNfse');
          if not Assigned(AuxNode) then Exit;

          NumNFSe := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Numero'), tcStr);

          with Response do
          begin
            NumeroNota := NumNFSe;
            CodigoVerificacao := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
            Data := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('DataEmissao'), tcDat);
          end;

          ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(NumNFSe);

          if ANota = nil then
          begin
            AuxNode2 := AuxNode.Childrens.FindAnyNs('DeclaracaoPrestacaoServico');

            // Tem provedor que mudou a tag de <DeclaracaoPrestacaoServico>
            // para <Rps>
            if AuxNode2 = nil then
              AuxNode2 := AuxNode.Childrens.FindAnyNs('Rps');
            if not Assigned(AuxNode2) then Exit;

            AuxNode := AuxNode2.Childrens.FindAnyNs('InfDeclaracaoPrestacaoServico');
            if not Assigned(AuxNode) then Exit;

            AuxNode := AuxNode.Childrens.FindAnyNs('Rps');

            if AuxNode <> nil then
            begin
              Response.Status := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Status'), tcInt);

              AuxNode := AuxNode.Childrens.FindAnyNs('IdentificacaoRps');
              if not Assigned(AuxNode) then Exit;

              NumRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('Numero'), tcStr);

              ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps);
            end;
          end;

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
//  end
//  else
//    inherited TratarRetornoConsultaNFSeporRps(Response);
end;

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.ProcessarMensagemDeErros(
  LJson: TACBrJSONObject; Response: TNFSeWebserviceResponse;
  const AListTag: string);
var
  JSonLista: TACBrJSONArray;
  JSon: TACBrJSONObject;
  AItem: TNFSeEventoCollectionItem;
  Codigo: string;

  procedure AdicionaCollectionItem(JSonItem: TACBrJSONObject; Collection: TNFSeEventoCollection);
  var
    AItem: TNFSeEventoCollectionItem;
    Codigo: string;
  begin
    Codigo := JSonItem.AsString['Codigo'];

    if Codigo <> '' then
    begin
      AItem := Collection.New;
      AItem.Codigo := Codigo;
      AItem.Descricao := JSonItem.AsString['Descricao'];
      AItem.Correcao := JSonItem.AsString['Complemento'];
    end
    else
    begin
      Codigo := JSonItem.AsString['codigo'];

      if Codigo <> '' then
      begin
        AItem := Collection.New;
        AItem.Codigo := Codigo;
        AItem.Descricao := JSonItem.AsString['descricao'];
        AItem.Correcao := JSonItem.AsString['complemento'];
      end;
    end;
  end;

  procedure LerListaErrosAlertas(jsLista: TACBrJSONArray; Collection: TNFSeEventoCollection);
  var
    i: Integer;
  begin
    for i := 0 to jsLista.Count-1 do
    begin
      JSon := jsLista.ItemAsJSONObject[i];

      AdicionaCollectionItem(JSon, Collection);
    end;
  end;

  procedure VerificaSeObjetoOuArray(aNome: string; Collection: TNFSeEventoCollection);
  begin
    // Verifica se no retorno contem um objeto ou array
    if LJson.IsJSONArray(aNome) then
    begin
      JSonLista := LJson.AsJSONArray[aNome];

      if JSonLista.Count > 0 then
        LerListaErrosAlertas(JSonLista, Collection);
    end
    else
    begin
      if LJson.IsJSONObject(aNome) then
      begin
        JSon := LJson.AsJSONObject[aNome];

        if JSon <> nil then
          AdicionaCollectionItem(JSon, Collection);
      end
      else
      begin
        Codigo := LJson.AsString[aNome];

        if Codigo <> '' then
        begin
          AItem := Collection.New;
          AItem.Codigo := Codigo;
          AItem.Descricao := LJson.AsString['mensagem'];
          AItem.Correcao := '';
        end;
      end;
    end;
  end;
begin
  // Verifica se no retorno contem a lista de Erros
  VerificaSeObjetoOuArray(AListTag, Response.Erros);
  // Verifica se no retorno contem a lista de erros
  VerificaSeObjetoOuArray('erros', Response.Erros);
  // Verifica se no retorno contem a lista de erro
  VerificaSeObjetoOuArray('erro', Response.Erros);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('Alertas', Response.Alertas);
  // Verifica se no retorno contem a lista de Alertas
  VerificaSeObjetoOuArray('alertas', Response.Alertas);
end;

procedure TACBrNFSeProviderModernizacaoPublicaAPIPropria.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse; const AListTag,
  AMessageTag: string);
var
  I: Integer;
  ANode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
begin
  ANode := RootNode.Childrens.FindAnyNs(AListTag);

  if (ANode = nil) then
    ANode := RootNode;

  ANodeArray := ANode.Childrens.FindAllAnyNs('Erro');
  if not Assigned(ANodeArray) then Exit;

  for I := Low(ANodeArray) to High(ANodeArray) do
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('ErroID'), tcStr);
    AErro.Descricao := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('ErroMensagem'), tcStr);
    AErro.Correcao := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('ErroSolucao'), tcStr);
  end;
end;

{ TACBrNFSeXWebserviceModernizacaoPublicaAPIPropria }

procedure TACBrNFSeXWebserviceModernizacaoPublicaAPIPropria.SetHeaders(
  aHeaderReq: THTTPHeader);
var
  Auth: string;
begin
  // Necessário para emitir em Produção
  with TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente do
    Auth := 'Basic ' + string(EncodeBase64(AnsiString(WSUser + ':' +
      AnsiString(WSSenha))));

  aHeaderReq.AddHeader('Authorization', Auth);
end;

function TACBrNFSeXWebserviceModernizacaoPublicaAPIPropria.ConsultarNFSePorRps(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
//  if TACBrNFSeX(FPDFeOwner).Provider.ConfigGeral.Params.ParamTemValor('ServicosAPIPropria', 'ConsultarNFSeRps') then
//  begin
    FPMsgOrig := AMSG;

    Request := '<def:ConsultarNfsePorRps>';
    Request := Request + '<Nfsecabecmsg>' + XmlToStr(ACabecalho) + '</Nfsecabecmsg>';
    Request := Request + '<Nfsedadosmsg>' + XmlToStr(AMSG) + '</Nfsedadosmsg>';
    Request := Request + '</def:ConsultarNfsePorRps>';

    Result := Executar('', Request,
                       ['ConsultarNfsePorRpsReturn', 'ConsultarNfseRpsResposta'],
                       ['xmlns:def="http://DefaultNamespace"']);
//  end
//  else
//    Result := inherited ConsultarNFSePorRps(ACabecalho, AMSG);
end;

function TACBrNFSeXWebserviceModernizacaoPublicaAPIPropria.TratarXmlRetornado(
  const aXML: string): string;
var
  lJSON, lErroJSON: TACBrJSONObject;
  lJSONArray: TACBrJSONArray;
begin
  Result := AnsiToNativeString(aXML);

  if not StringIsPDF(Result) then
  begin
    if StringIsJSON(Result) then
    begin
      if Pos('"sucesso":"false"', Result) > 0 then
      begin
        lJSON := TACBrJsonObject.Parse(Result);

//        lJSON := TACBrJSONObject.Create;
        try
          Result := lJSON.AsString['mensagem'];
        finally
          FreeAndNil(lJSON);
//          lJSON.Free;
        end;
      end;
    end;

    if not StringIsJSON(Result) then
    begin
      if TACBrNFSeX(FPDFeOwner).Provider.ConfigGeral.Params.ParamTemValor('ServicosAPIPropria', 'ConsultarNFSeRps') then
      begin
        Result := inherited TratarXmlRetornado(aXML);

        Result := ParseText(Result);
        Result := RemoverDeclaracaoXML(Result);
        Result := RemoverIdentacao(Result);
        Result := RemoverCaracteresDesnecessarios(Result);
      end
      else
      begin
        lJSON := TACBrJSONObject.Create;
        try
          lJSONArray := TACBrJSONArray.Create;
          try
            lErroJSON := TACBrJSONObject.Create;
            try
              lJSON.AddPair('tipoAmbiente', EmptyStr);
              lJSON.AddPair('versaoAplicativo', EmptyStr);
              lJSON.AddPair('dataHoraProcessamento', EmptyStr);
              lJSON.AddPair('idDps', EmptyStr);
              lJSON.AddPair('chaveAcesso', EmptyStr);
              lJSON.AddPair('nfseXmlGZipB64', EmptyStr);

              lErroJSON.AddPair('mensagem', EmptyStr);
              lErroJSON.AddPair('codigo', 'E9999');
              lErroJSON.AddPair('descricao', Result);
              lErroJSON.AddPair('complemento', EmptyStr);

              lJSONArray.AddElementJSON(lErroJSON);
              lJSON.AddPair('erros', lJSONArray, False);

              Result := lJSON.ToJSON;
            finally
              //lErroJSON.Free;
            end;
          finally
            //lJSONArray.Free;
          end;
        finally
          lJSON.Free;
        end;
      end;
    end
  end;
end;

end.
