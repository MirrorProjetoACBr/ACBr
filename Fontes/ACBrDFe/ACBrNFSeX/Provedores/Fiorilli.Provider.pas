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

unit Fiorilli.Provider;

interface

uses
  SysUtils, Classes,
  ACBrUtil.FilesIO,
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
  TACBrNFSeXWebserviceFiorilli200 = class(TACBrNFSeXWebserviceSoap11)
  private
    function GetDadosUsuario: string;
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

    property DadosUsuario: string read GetDadosUsuario;
  end;

  TACBrNFSeProviderFiorilli200 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
  end;

  TACBrNFSeXWebserviceFiorilliAPIPropria = class(TACBrNFSeXWebserviceMisto1)
  protected

  public
    // Serviços que utilizam o WS Soap do provedor
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: string): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;

    // Serviços que utilizam a API Rest do Padrão Nacional
    function ConsultarNFSePorRps(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorChave(const ACabecalho, AMSG: string): string; override;
    //Confirmado que o envio de evento não deve ser feito pelo padrão nacional
    function EnviarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarEvento(const ACabecalho, AMSG: string): string; override;
    function ConsultarDFe(const ACabecalho, AMSG: string): string; override;
    function ConsultarParam(const ACabecalho, AMSG: string): string; override;
    function ObterDANFSE(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderFiorilliAPIPropria = class(TACBrNFSeProviderPadraoNacional)
  private
    FNaoAssinar: Boolean;

    function QuantidadeDeNotasValida(const AResponse: TNFSeEmiteResponse): Boolean; virtual;
    function DefineIdAttr: String; virtual;
    function GerarListaDPS(const AResponse: TNFSeEmiteResponse; const AIdAttr: String): String; virtual;
    procedure PreencherResponseEmitirComRetorno(const ARootNode: TACBrXMLNode; AResponse: TNFSeEmiteResponse);
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function VerificarAlerta(const ACodigo, AMensagem, ACorrecao: string): Boolean;
    function VerificarErro(const ACodigo, AMensagem, ACorrecao: string): Boolean;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = 'ListaMensagens';
                                     const AMessageTag: string = 'Mensagem'); override;

    function PrepararArquivoEnvio(const aXml: string; aMetodo: TMetodo): string; override;

    function PreencherNotaRespostaConsultaLoteRps(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaLoteRpsResponse): Boolean;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure GerarMsgDadosEmitir(Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    procedure TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;

    procedure PrepararEnviarEvento(Response: TNFSeEnviarEventoResponse); override;
    procedure TratarRetornoEnviarEvento(Response: TNFSeEnviarEventoResponse); override;
//  public
//    procedure EnviarEvento; override;
  end;

  TACBrNFSeXWebserviceFiorilliAPIPropria101 = class(TACBrNFSeXWebserviceFiorilliAPIPropria)
  public
    function ConsultarNFSePorRps(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorChave(const ACabecalho, AMSG: string): string; override;
  end;

  TACBrNFSeProviderFiorilliAPIPropria101 = class(TACBrNFSeProviderFiorilliAPIPropria)
  protected
    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    function PreencherNotaRespostaConsultaNFSeporRps(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaNFSeporRpsResponse): Boolean;

    function PreencherNotaRespostaConsultaNFSeporChave(Node, parentNode: TACBrXmlNode;
      Response: TNFSeConsultaNFSeResponse): Boolean;

//  public
    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
    procedure TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;

    procedure PrepararConsultaNFSeporChave(Response: TNFSeConsultaNFSeResponse); override;
    procedure TratarRetornoConsultaNFSeporChave(Response: TNFSeConsultaNFSeResponse); override;
  end;

implementation

uses
  synacode,
  ACBrCompress,
  ACBrDFe.Conversao,
  ACBrNFSeXConsts,
  ACBrDFeException,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.Base,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXNotasFiscais,
  Fiorilli.GravarXml,
  Fiorilli.LerXml,
  ACBrDFeSSL;

{ TACBrNFSeProviderFiorilli200 }

procedure TACBrNFSeProviderFiorilli200.Configuracao;
var
  NaoAssinar: Boolean;
begin
  inherited Configuracao;

  ConfigGeral.QuebradeLinha := '\s\n';
  ConfigGeral.ConsultaPorFaixaPreencherNumNfseFinal := true;

  ConfigGeral.Autenticacao.RequerLogin := True;

  NaoAssinar := ConfigGeral.Params.ParamTemValor('Assinar', 'NaoAssinar');

  if (ConfigAssinar.Assinaturas = taConfigProvedor) and not NaoAssinar then
  begin
    with ConfigAssinar do
    begin
      Rps := True;
      LoteRps := True;
      CancelarNFSe := True;
      RpsGerarNFSe := True;
      RpsSubstituirNFSe := True;
      SubstituirNFSe := True;
    end;
  end;
end;

function TACBrNFSeProviderFiorilli200.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_Fiorilli200.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderFiorilli200.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_Fiorilli200.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderFiorilli200.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
    Result := TACBrNFSeXWebserviceFiorilli200.Create(FAOwner, AMetodo, URL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrNFSeProviderFiorilli200.PrepararEmitir(
  Response: TNFSeEmiteResponse);
begin
  // O provedor Fiorilli exige que o numero do lote seja numerico e que não
  // não tenha zeros a esquerda.
  Response.NumeroLote := IntToStr(StrToIntDef(Trim(Response.NumeroLote), 0));

  inherited PrepararEmitir(Response);
end;

{ TACBrNFSeXWebserviceFiorilli200 }

function TACBrNFSeXWebserviceFiorilli200.GetDadosUsuario: string;
begin
  with TACBrNFSeX(FPDFeOwner).Configuracoes.Geral do
  begin
    Result := '<username>' + Emitente.WSUser + '</username>' +
              '<password>' + Emitente.WSSenha + '</password>';
  end;
end;

function TACBrNFSeXWebserviceFiorilli200.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:recepcionarLoteRps>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:recepcionarLoteRps>';

  Result := Executar('recepcionarLoteRps', Request,
                     ['EnviarLoteRpsResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:recepcionarLoteRpsSincrono>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:recepcionarLoteRpsSincrono>';

  Result := Executar('recepcionarLoteRpsSincrono', Request,
                     ['EnviarLoteRpsSincronoResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.GerarNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:gerarNfse>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:gerarNfse>';

  Result := Executar('gerarNfse', Request,
                     ['GerarNfseResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:consultarLoteRps>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:consultarLoteRps>';

  Result := Executar('consultarLoteRps', Request,
                     ['ConsultarLoteRpsResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:consultarNfsePorFaixa>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:consultarNfsePorFaixa>';

  Result := Executar('consultarNfsePorFaixa', Request,
                     ['ConsultarNfseFaixaResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:consultarNfsePorRps>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:consultarNfsePorRps>';

  Result := Executar('consultarNfsePorRps', Request,
                     ['ConsultarNfseRpsResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:consultarNfseServicoPrestado>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:consultarNfseServicoPrestado>';

  Result := Executar('consultarNfseServicoPrestado', Request,
                     ['ConsultarNfseServicoPrestadoResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:consultarNfseServicoTomado>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:consultarNfseServicoTomado>';

  Result := Executar('consultarNfseServicoTomado', Request,
                     ['ConsultarNfseServicoTomadoResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.Cancelar(const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:cancelarNfse>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:cancelarNfse>';

  Result := Executar('cancelarNfse', Request,
                     ['CancelarNfseResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := '<ws:substituirNfse>';
  Request := Request + AMSG;
  Request := Request + DadosUsuario;
  Request := Request + '</ws:substituirNfse>';

  Result := Executar('substituirNfse', Request,
                     ['SubstituirNfseResposta'],
                     ['xmlns:ws="http://ws.issweb.fiorilli.com.br/"']);
end;

function TACBrNFSeXWebserviceFiorilli200.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := ConverteANSItoUTF8(aXml);
  Result := RemoverDeclaracaoXML(Result);

  Result := inherited TratarXmlRetornado(Result);

  Result := StringReplace(Result, '&#xd;\s\n', '\s\n', [rfReplaceAll]);
  Result := StringReplace(Result, '&#xd;', '\s\n', [rfReplaceAll]);
  Result := StringReplace(Result, ''#$A'', '\s\n', [rfReplaceAll]);
  Result := ParseText(Result);
  Result := RemoverPrefixosDesnecessarios(Result);
  Result := RemoverCaracteresDesnecessarios(Result);
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
end;

{ TACBrNFSeProviderFiorilliAPIPropria }

procedure TACBrNFSeProviderFiorilliAPIPropria.Configuracao;
var
  VersaoDFe: string;
begin
  inherited Configuracao;

  VersaoDFe := VersaoNFSeToStr(TACBrNFSeX(FAOwner).Configuracoes.Geral.Versao);
  FNaoAssinar := (ConfigGeral.Params.ParamTemValor('Assinar', 'NaoAssinar')) or
                 (ConfigAssinar.Assinaturas = taNaoAssinar);

  with ConfigGeral do
  begin
    Layout := loPadraoNacional;
    QuebradeLinha := '|';
    ModoEnvio := meUnitario;
    ConsultaLote := False;
    FormatoArqEnvio := tfaXml;
    FormatoArqRetorno := tfaXml;
    FormatoArqEnvioSoap := tfaXml;
    FormatoArqRetornoSoap := tfaXml;

    ServicosDisponibilizados.EnviarLoteAssincrono := True;
    ServicosDisponibilizados.EnviarLoteSincrono := True;
    ServicosDisponibilizados.EnviarUnitario := True;
    ServicosDisponibilizados.ConsultarLote := True;
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

  SetXmlNameSpace('http://www.fiorilli.com.br/nfse-nacional');

  with ConfigMsgDados do
  begin
    UsarNumLoteConsLote := False;

    DadosCabecalho := GetCabecalho('');

    XmlRps.InfElemento := 'infDPS';
    XmlRps.DocElemento := 'DPS';
    xmlRps.xmlns := 'http://www.sped.fazenda.gov.br/nfse';

    EnviarEvento.InfElemento := 'infPedReg';
    EnviarEvento.DocElemento := 'pedRegEvento';
  end;

  with ConfigAssinar do
  begin
    Rps := True;
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

    Validar := False;
  end;
end;

function TACBrNFSeProviderFiorilliAPIPropria.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_FiorilliAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderFiorilliAPIPropria.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_FiorilliAPIPropria.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderFiorilliAPIPropria.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmGerar, tmRecepcionar, tmRecepcionarSincrono, tmConsultarLote,
                 tmEnviarEvento] then
    AMimeType := 'text/xml; charset=utf-8'
  else
    AMimeType := 'application/json';

  if URL <> '' then
  begin
    URL := URL + Path;

    Result := TACBrNFSeXWebserviceFiorilliAPIPropria.Create(FAOwner, AMetodo, URL,
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

function TACBrNFSeProviderFiorilliAPIPropria.DefineIdAttr: String;
begin
  if ConfigAssinar.IncluirURI then
    Result := ConfigGeral.Identificador
  else
    Result := 'ID';
end;
{
procedure TACBrNFSeProviderFiorilliAPIPropria.EnviarEvento;
begin
  inherited EnviarEvento;

  ConfigGeral.FormatoArqEnvio := tfaXml;
  ConfigGeral.FormatoArqRetorno := tfaXml;
  ConfigGeral.FormatoArqEnvioSoap := tfaXml;
  ConfigGeral.FormatoArqRetornoSoap := tfaXml;
  ConfigWebServices.VersaoAtrib := '1.00';
end;
}
function TACBrNFSeProviderFiorilliAPIPropria.GerarListaDPS(const AResponse: TNFSeEmiteResponse; const AIdAttr: String): String;
var
  Nota: TNotaFiscal;
  I: Integer;
begin
  for I := 0 to TACBrNFSeX(FAOwner).NotasFiscais.Count -1 do
  begin
    Nota := TACBrNFSeX(FAOwner).NotasFiscais.Items[I];

    Nota.GerarXML;

    Nota.XmlRps := ConverteXMLtoUTF8(Nota.XmlRps);
    Nota.XmlRps := ChangeLineBreak(Nota.XmlRps, '');


    if (not FNaoAssinar) and
       ((ConfigAssinar.Rps and (AResponse.ModoEnvio in [meLoteAssincrono, meLoteSincrono])) or
       (ConfigAssinar.RpsGerarNFSe and (AResponse.ModoEnvio in [meUnitario, meAutomatico]))) then
    begin
      Nota.XmlRps := FAOwner.SSL.Assinar(Nota.XmlRps,
                         ConfigMsgDados.XmlRps.DocElemento,
                         ConfigMsgDados.XmlRps.InfElemento, '', '', '', AIdAttr);
    end;

    SalvarXmlRps(Nota);

    Result := Result + RemoverDeclaracaoXML(Nota.XmlRps);
  end;
end;

procedure TACBrNFSeProviderFiorilliAPIPropria.GerarMsgDadosEmitir(
  Response: TNFSeEmiteResponse; Params: TNFSeParamsResponse);
var
  Emitente: TEmitenteConfNFSe;
begin
  if Response.ModoEnvio <> meUnitario then
  begin
    Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

    Response.ArquivoEnvio :=
      '<nfse:LoteDps xmlns:nfse="http://www.fiorilli.com.br/nfse-nacional">' +
        '<nfse:NumeroLote>' + Response.NumeroLote + '</nfse:NumeroLote>' +
        '<nfse:CNPJ>' + Emitente.CNPJ + '</nfse:CNPJ>' +
        '<nfse:IM>' + Emitente.InscMun + '</nfse:IM>' +
        '<nfse:QuantidadeDps>' +
           IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count) +
        '</nfse:QuantidadeDps>' +
        '<nfse:ListaDps>' + Response.ArquivoEnvio + '</nfse:ListaDps>' +
       '</nfse:LoteDps>';
  end;
end;

function TACBrNFSeProviderFiorilliAPIPropria.VerificarAlerta(
  const ACodigo, AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) > 0);
end;

function TACBrNFSeProviderFiorilliAPIPropria.VerificarErro(const ACodigo,
  AMensagem, ACorrecao: string): Boolean;
begin
  Result := ((AMensagem <> '') or (ACorrecao <> '')) and (Pos('L000', ACodigo) = 0);
end;

procedure TACBrNFSeProviderFiorilliAPIPropria.ProcessarMensagemErros(
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
  Correcao := Correcao + ' ' + ObterConteudoTag(ErrorNode.Childrens.FindAnyNs('IdDPS'), tcStr);

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

    if not Assigned(ANodeArray) then
      ANodeArray := ANode.Childrens.FindAllAnyNs('mensagem');

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

  ProcessarErros;

  ANode := RootNode.Childrens.FindAnyNs('ListaMensagemAlertaRetorno');

  if Assigned(ANode) then
  begin
    ANodeArray := ANode.Childrens.FindAllAnyNs(AMessageTag);

    if Assigned(ANodeArray) then
    begin
      for I := Low(ANodeArray) to High(ANodeArray) do
      begin
        Mensagem := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('mensagem'), tcStr);

        if Mensagem <> '' then
        begin
          AAlerta := Response.Alertas.New;
          AAlerta.Codigo := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('codigo'), tcStr);
          AAlerta.Descricao := Mensagem;
          AAlerta.Correcao := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('correcao'), tcStr);
        end;
      end;
    end
    else
    begin
      Mensagem := ObterConteudoTag(ANode.Childrens.FindAnyNs('mensagem'), tcStr);

      if Mensagem <> '' then
      begin
        AAlerta := Response.Alertas.New;
        AAlerta.Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('codigo'), tcStr);
        AAlerta.Descricao := Mensagem;
        AAlerta.Correcao := ObterConteudoTag(ANode.Childrens.FindAnyNs('correcao'), tcStr);
      end;
    end;
  end;
end;

function TACBrNFSeProviderFiorilliAPIPropria.QuantidadeDeNotasValida(const AResponse: TNFSeEmiteResponse): Boolean;
var
  AErro: TNFSeEventoCollectionItem;
begin
  Result := True;
  if TACBrNFSeX(FAOwner).NotasFiscais.Count <= 0 then
  begin
    AErro := AResponse.Erros.New;
    AErro.Codigo := Cod002;
    AErro.Descricao := ACBrStr(Desc002);
    Result := False;
  end;

  if TACBrNFSeX(FAOwner).NotasFiscais.Count > AResponse.MaxRps then
  begin
    AErro := AResponse.Erros.New;
    AErro.Codigo := Cod003;
    AErro.Descricao := ACBrStr('Conjunto de DPS transmitidos (máximo de ' +
                       IntToStr(AResponse.MaxRps) + ' DPS)' +
                       ' excedido. Quantidade atual: ' +
                       IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count));
    Result := False;
  end;
end;

function TACBrNFSeProviderFiorilliAPIPropria.PreencherNotaRespostaConsultaLoteRps(
  Node, parentNode: TACBrXmlNode;
  Response: TNFSeConsultaLoteRpsResponse): Boolean;
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
    if not Assigned(Node) then Exit;

    NumNFSe := ObterConteudoTag(Node.Childrens.FindAnyNs('nNFSe'), tcStr);
    CodVerif := OnlyNumber(ObterConteudoTag(Node.Attributes.Items['Id']));
    DataAut := ObterConteudoTag(Node.Childrens.FindAnyNs('dhProc'), tcDatHor);

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

procedure TACBrNFSeProviderFiorilliAPIPropria.PreencherResponseEmitirComRetorno(const ARootNode: TACBrXMLNode;
  AResponse: TNFSeEmiteResponse);
var
  ANode: TACBrXMLNode;
  AErro: TNFSeEventoCollectionItem;
  NFSeXml, CodVerif, NumNFSe, NumDps, SerieRps: string;
  DataAut: TDateTime;
  AResumo: TNFSeResumoCollectionItem;
  ANota: TNotaFiscal;
begin
  AResponse.Data := ObterConteudoTag(ARootNode.Childrens.FindAnyNs('DataRecebimento'), tcDatHor);
  AResponse.Protocolo := ObterConteudoTag(ARootNode.Childrens.FindAnyNs('protocolo'), tcStr);
  if AResponse.Protocolo = '' then
    AResponse.Protocolo :=
      ObterConteudoTag(ARootNode.Childrens.FindAnyNs('Protocolo'), tcStr);
  AResponse.Situacao := ObterConteudoTag(ARootNode.Childrens.FindAnyNs('Status'), tcStr);

  ANode := ARootNode.Childrens.FindAnyNs('NFSe');

  if not Assigned(ANode) then
  begin
    AErro := AResponse.Erros.New;
    AErro.Codigo := Cod203;
    AErro.Descricao := ACBrStr(Desc203);
    Exit;
  end;

  NFSeXml := ANode.OuterXml;
  ANode := ANode.Childrens.FindAnyNs('infNFSe');

  CodVerif := OnlyNumber(ObterConteudoTag(ANode.Attributes.Items['Id']));
  NumNFSe := ObterConteudoTag(ANode.Childrens.FindAnyNs('nNFSe'), tcStr);
  DataAut := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhProc'), tcDatHor);

  ANode := ANode.Childrens.FindAnyNs('DPS');
  ANode := ANode.Childrens.FindAnyNs('infDPS');

  NumDps := ObterConteudoTag(ANode.Childrens.FindAnyNs('nDPS'), tcStr);
  SerieRps := ObterConteudoTag(ANode.Childrens.FindAnyNs('serie'), tcStr);

  with AResponse do
  begin
    CodigoVerificacao := CodVerif;
    NumeroNota := NumNFSe;
    Data := DataAut;
    XmlRetorno := NFSeXml;
  end;

  AResumo := AResponse.Resumos.New;
  AResumo.NumeroNota := NumNFSe;
  AResumo.CodigoVerificacao := CodVerif;
  AResumo.NumeroRps := NumDps;
  AResumo.SerieRps := SerieRps;

  ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumDps);

  ANota := CarregarXmlNfse(ANota, NFSeXml);
  SalvarXmlNfse(ANota);

  AResumo.NomeArq := ANota.NomeArq;
end;

function TACBrNFSeProviderFiorilliAPIPropria.PrepararArquivoEnvio(
  const aXml: string; aMetodo: TMetodo): string;
begin
  Result := aXml;
  Method := 'POST';
  (*
  if aMetodo in [tmEnviarEvento] then
  begin
    Result := ChangeLineBreak(aXml, '');
    Result := EncodeBase64(GZipCompress(Result));

    Result := '{"pedidoRegistroEventoXmlGZipB64":"' + Result + '"}';
    Path := '/nfse/' + Chave + '/eventos';
    Method := 'POST';
  end
  else *)
    Result := ChangeLineBreak(aXml, '');
end;

procedure TACBrNFSeProviderFiorilliAPIPropria.PrepararEmitir(
  Response: TNFSeEmiteResponse);
var
  IdAttr, ListaDps: string;
  lSSLC14NMode: TSSLC14NMode;
  lParams: TNFSeParamsResponse;
begin
  if not(QuantidadeDeNotasValida(Response)) then Exit;

  ListaDps := '';

  IdAttr := DefineIdAttr;

  lSSLC14NMode := FAOwner.SSL.SSLC14NMode;
  try
    FAOwner.SSL.SSLC14NMode := cmC14N_EXCLUSIVE;
    ListaDps := GerarListaDPS(Response, IdAttr);
  finally
    FAOwner.SSL.SSLC14NMode := lSSLC14NMode;
  end;

  lParams := TNFSeParamsResponse.Create;
  try
    Response.ArquivoEnvio := ListaDps;
    GerarMsgDadosEmitir(Response, lParams);
  finally
    lParams.Free;
  end;

  Path := '';
  Method := 'POST';
end;

procedure TACBrNFSeProviderFiorilliAPIPropria.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrXmlDocument;
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

      PreencherResponseEmitirComRetorno(Document.Root, Response);
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

procedure TACBrNFSeProviderFiorilliAPIPropria.PrepararConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
  lProtocolo, lCNPJCPF, lIM: String;
  lEmitenteConfig: TEmitenteConfNFSe;
begin
  if EstaVazio(Response.Protocolo) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod101;
    AErro.Descricao := ACBrStr(Desc101);
    Exit;
  end;

  lEmitenteConfig := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if Length(lEmitenteConfig.CNPJ) = 14 then
    lCNPJCPF := '<fio:CNPJ>' + lEmitenteConfig.CNPJ + '</fio:CNPJ>'
  else
    lCNPJCPF := '<fio:CPF>' + lEmitenteConfig.CNPJ + '</fio:CPF>';

  lIM := '<fio:IM>' + lEmitenteConfig.InscMun + '</fio:IM>';

  lProtocolo := '<fio:Protocolo>' + Response.Protocolo + '</fio:Protocolo>';

  Response.ArquivoEnvio := '<fio:ConsultarLoteDpsEnvio xmlns:fio="http://www.fiorilli.com.br/nfse-nacional">'+
                lCNPJCPF + lIM + lProtocolo +
             '</fio:ConsultarLoteDpsEnvio>';

  Path := '';
  Method := 'POST';
end;

procedure TACBrNFSeProviderFiorilliAPIPropria.TratarRetornoConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXMLNodeArray;
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
        Exit;
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root;

      ProcessarMensagemErros(ANode, Response);

      Response.Situacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('Situacao'), tcStr);

      Response.Sucesso := (Response.Erros.Count = 0);

      if Response.Sucesso then
      begin
        ANode := Document.Root.Childrens.FindAnyNs('ListaNfse');

        if not Assigned(ANode) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod202;
          AErro.Descricao := ACBrStr(Desc202);
          Exit;
        end;

        ANodeArray := ANode.Childrens.FindAllAnyNs('NFSe');

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
          AuxNode := ANode.Childrens.FindAnyNs('infNFSe');

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

procedure TACBrNFSeProviderFiorilliAPIPropria.PrepararEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
begin
  ConfigMsgDados.EnviarEvento.xmlns := 'http://www.sped.fazenda.gov.br/nfse';
  ConfigWebServices.VersaoAtrib := '1.01';

  inherited PrepararEnviarEvento(Response);
end;

procedure TACBrNFSeProviderFiorilliAPIPropria.TratarRetornoEnviarEvento(
  Response: TNFSeEnviarEventoResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode: TACBrXmlNode;
//  ANodeArray: TACBrXMLNodeArray;
//  I: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        AErro := Response.Erros.New;
        AErro.Codigo := Cod201;
        AErro.Descricao := ACBrStr(Desc201);
        Exit;
      end;

      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root;

      ProcessarMensagemErros(ANode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      if Response.Sucesso then
      begin
        // Precisamos de um XML de retorno do provedor cujo evento de canelamento
        // foi processado com sucesso para finalizar a implementação.
        (*
        ANode := Document.Root.Childrens.FindAnyNs('ListaNfse');

        if not Assigned(ANode) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod202;
          AErro.Descricao := ACBrStr(Desc202);
          Exit;
        end;

        ANodeArray := ANode.Childrens.FindAllAnyNs('NFSe');

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
          AuxNode := ANode.Childrens.FindAnyNs('infNFSe');

          if AuxNode = nil then
          begin
            AErro := Response.Erros.New;
            AErro.Codigo := Cod203;
            AErro.Descricao := ACBrStr(Desc203);
            Exit;
          end
          else
          begin
            // Implementar
          end;
        end;
        *)
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

{ TACBrNFSeXWebserviceFiorilliAPIPropria }

function TACBrNFSeXWebserviceFiorilliAPIPropria.Recepcionar(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMSgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<fio:RecepcionarLoteDpsEnvio>' +
                FPMsgOrig +
             '</fio:RecepcionarLoteDpsEnvio>';

  Result := Executar('recepcionarLoteDps',
    Request, [], ['xmlns:fio="http://www.fiorilli.com.br/nfse-nacional"']);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.RecepcionarSincrono(
  const ACabecalho, AMSG: String): string;
var
  Request: string;
begin
  FPMSgOrig := RemoverDeclaracaoXML(AMSG);

  Request := '<fio:RecepcionarLoteDpsSincronoEnvio>' +
                FPMsgOrig +
             '</fio:RecepcionarLoteDpsSincronoEnvio>';

  Result := Executar('recepcionarLoteDpsSincrono',
    Request, [], ['xmlns:fio="http://www.fiorilli.com.br/nfse-nacional"']);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ConsultarDFe(const ACabecalho,
  AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ConsultarEvento(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ConsultarLote(const ACabecalho,
  AMSG: String): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := RemoverDeclaracaoXML(AMSG);

  Result := Executar('consultarLoteDps', Request, [], ['xmlns:fio="http://www.fiorilli.com.br/nfse-nacional"']);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ConsultarNFSePorChave(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ConsultarNFSePorRps(
  const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ConsultarParam(const ACabecalho,
  AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.GerarNFSe(const ACabecalho,
  AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := RemoverDeclaracaoXML(AMSG);

  Request := '<fio:RecepcionarDpsEnvio>' +
                Request +
             '</fio:RecepcionarDpsEnvio>';

  Result := Executar('recepcionarDPS',
    Request, [], ['xmlns:fio="http://www.fiorilli.com.br/nfse-nacional"']);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.EnviarEvento(const ACabecalho,
  AMSG: string): string;
var
  Emitente: TEmitenteConfNFSe;
  Request: string;
begin
  Emitente := TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente;

  FPMsgOrig := AMSG;

  Request := RemoverDeclaracaoXML(AMSG);
  Request := '<IM>' + Emitente.InscMun + '</IM>' + Request;

  Request := '<CancelarNFSeEnvio xmlns="http://www.fiorilli.com.br/nfse-nacional">' +
                Request +
             '</CancelarNFSeEnvio>';

  Result := Executar('cancelarNFSe',
    Request, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.ObterDANFSE(const ACabecalho,
  AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  if not StringIsPDF(Result) then
  begin
    Result := RemoverCaracteresDesnecessarios(Result);
    Result := ParseTextEx(Result);
    Result := RemoverDeclaracaoXML(Result);
    Result := RemoverIdentacao(Result);
    Result := RemoverPrefixosDesnecessarios(Result);
  end;
end;

{ TACBrNFSeProviderFiorilliAPIPropria101 }

function TACBrNFSeProviderFiorilliAPIPropria101.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_FiorilliAPIPropria101.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderFiorilliAPIPropria101.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_FiorilliAPIPropria101.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderFiorilliAPIPropria101.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if AMetodo in [tmGerar, tmRecepcionar, tmRecepcionarSincrono, tmConsultarLote,
                 tmConsultarNFSePorRps, tmConsultarNFSePorChave, tmEnviarEvento] then
    AMimeType := 'text/xml; charset=utf-8'
  else
    AMimeType := 'application/json';

  if URL <> '' then
  begin
    URL := URL + Path;

    Result := TACBrNFSeXWebserviceFiorilliAPIPropria101.Create(FAOwner, AMetodo, URL,
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

function TACBrNFSeProviderFiorilliAPIPropria101.PreencherNotaRespostaConsultaNFSeporRps(
  Node, parentNode: TACBrXmlNode;
  Response: TNFSeConsultaNFSeporRpsResponse): Boolean;
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
    if not Assigned(Node) then Exit;

    NumNFSe := ObterConteudoTag(Node.Childrens.FindAnyNs('nNFSe'), tcStr);
    CodVerif := OnlyNumber(ObterConteudoTag(Node.Attributes.Items['Id']));
    DataAut := ObterConteudoTag(Node.Childrens.FindAnyNs('dhProc'), tcDatHor);

    Node2 := Node.Childrens.FindAnyNs('DPS');

    if not Assigned(Node2) then Exit;

    Node := Node2.Childrens.FindAnyNs('infDPS');
    if not Assigned(Node) then Exit;

    NumRps := '';
    SerieRps := '';

    if Node <> nil then
    begin
      NumRps := ObterConteudoTag(Node.Childrens.FindAnyNs('nDPS'), tcStr);
      NumeroRps := StrToIntDef(NumRps, 0);
      SerieRps := ObterConteudoTag(Node.Childrens.FindAnyNs('serie'), tcStr);
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

function TACBrNFSeProviderFiorilliAPIPropria101.PreencherNotaRespostaConsultaNFSeporChave(
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
    if not Assigned(Node) then Exit;

    NumNFSe := ObterConteudoTag(Node.Childrens.FindAnyNs('nNFSe'), tcStr);
    CodVerif := OnlyNumber(ObterConteudoTag(Node.Attributes.Items['Id']));
    DataAut := ObterConteudoTag(Node.Childrens.FindAnyNs('dhProc'), tcDatHor);

    Node2 := Node.Childrens.FindAnyNs('DPS');

    if not Assigned(Node2) then Exit;

    Node := Node2.Childrens.FindAnyNs('infDPS');
    if not Assigned(Node) then Exit;

    NumRps := '';
    SerieRps := '';

    if Node <> nil then
    begin
      NumRps := ObterConteudoTag(Node.Childrens.FindAnyNs('nDPS'), tcStr);
      NumeroRps := StrToIntDef(NumRps, 0);
      SerieRps := ObterConteudoTag(Node.Childrens.FindAnyNs('serie'), tcStr);
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

procedure TACBrNFSeProviderFiorilliAPIPropria101.PrepararEmitir(
  Response: TNFSeEmiteResponse);
var
  IdAttr, ListaDps: string;
  lParams: TNFSeParamsResponse;
begin
  if not(QuantidadeDeNotasValida(Response)) then Exit;

  ListaDps := '';

  IdAttr := DefineIdAttr;

  ListaDPS := GerarListaDPS(Response, IdAttr);

  lParams := TNFSeParamsResponse.Create;
  try
    Response.ArquivoEnvio := ListaDps;
    GerarMsgDadosEmitir(Response, lParams);
  finally
    lParams.Free;
  end;

  Path := '';
  Method := 'POST';
end;

procedure TACBrNFSeProviderFiorilliAPIPropria101.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrXmlDocument;
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

      ProcessarMensagemErros(Document.Root, Response, 'ListaMensagens', 'mensagem');

      PreencherResponseEmitirComRetorno(Document.Root, Response);
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

procedure TACBrNFSeProviderFiorilliAPIPropria101.PrepararConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  AErro: TNFSeEventoCollectionItem;
  lNumeroDPS, lSerieDPS, lIdDps, lCNPJCPF, lIM: String;
  lEmitenteConfig: TEmitenteConfNFSe;
begin
  if EstaVazio(Response.idRps) and EstaVazio(Response.NumeroRps) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod126;
    AErro.Descricao := ACBrStr(Desc126);
    Exit;
  end
  else if EstaVazio(Response.NumeroRps) and EstaVazio(Response.SerieRps) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod102;
    AErro.Descricao := ACBrStr(Desc102);

    AErro := Response.Erros.New;
    AErro.Codigo := Cod103;
    AErro.Descricao := ACBrStr(Desc103);
    Exit;
  end;

  lEmitenteConfig := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if Length(lEmitenteConfig.CNPJ) = 14 then
    lCNPJCPF := '<fio:CNPJ>' + lEmitenteConfig.CNPJ + '</fio:CNPJ>'
  else
    lCNPJCPF := '<fio:CPF>' + lEmitenteConfig.CNPJ + '</fio:CPF>';

  lIM := '<fio:IM>' + lEmitenteConfig.InscMun + '</fio:IM>';

  if Response.NumeroRps <> '' then
    lNumeroDPS := '<fio:NumeroDPS>' + Response.NumeroRps + '</fio:NumeroDPS>';

  if Response.SerieRps <> '' then
    lSerieDPS := '<fio:SerieDPS>' + Response.SerieRps + '</fio:SerieDPS>';

  if Response.idRps <> '' then
    lIdDPS := '<fio:IdDPS>' + Response.idRps + '</fio:IdDPS>';

  if lIdDps <> '' then
    Response.ArquivoEnvio := lIM + lIdDps
  else
    Response.ArquivoEnvio := lCNPJCPF + lIM + lNumeroDPS + lSerieDPS;

  Response.ArquivoEnvio :=
    '<fio:ConsultarNfseEnvio xmlns:fio="http://www.fiorilli.com.br/nfse-nacional">' +
      Response.ArquivoEnvio +
    '</fio:ConsultarNfseEnvio>';

  Path := '';
  Method := 'POST';
end;

procedure TACBrNFSeProviderFiorilliAPIPropria101.TratarRetornoConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXMLNodeArray;
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

      ProcessarMensagemErros(Document.Root, Response, 'ListaMensagens', 'mensagem');

      Response.Sucesso := (Response.Erros.Count = 0);

      if Response.Sucesso then
      begin
        ANode := Document.Root.Childrens.FindAnyNs('ListaNFSe');

        if not Assigned(ANode) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod202;
          AErro.Descricao := ACBrStr(Desc202);
          Exit;
        end;

        ANodeArray := ANode.Childrens.FindAllAnyNs('NFSe');

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
          AuxNode := ANode.Childrens.FindAnyNs('infNFSe');

          if AuxNode = nil then
          begin
            AErro := Response.Erros.New;
            AErro.Codigo := Cod203;
            AErro.Descricao := ACBrStr(Desc203);
            Exit;
          end
          else
          begin
            if PreencherNotaRespostaConsultaNFSeporRps(AuxNode, ANode, Response) then
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

procedure TACBrNFSeProviderFiorilliAPIPropria101.PrepararConsultaNFSeporChave(
  Response: TNFSeConsultaNFSeResponse);
var
  AErro: TNFSeEventoCollectionItem;
  lChaveNFSe, lCNPJCPF, lIM: String;
  lEmitenteConfig: TEmitenteConfNFSe;
begin
  if EstaVazio(Response.InfConsultaNFSe.ChaveNFSe) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod118;
    AErro.Descricao := ACBrStr(Desc118);
    Exit;
  end;

  lEmitenteConfig := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if Length(lEmitenteConfig.CNPJ) = 14 then
    lCNPJCPF := '<fio:CNPJ>' + lEmitenteConfig.CNPJ + '</fio:CNPJ>'
  else
    lCNPJCPF := '<fio:CPF>' + lEmitenteConfig.CNPJ + '</fio:CPF>';

  lIM := '<fio:IM>' + lEmitenteConfig.InscMun + '</fio:IM>';

  if Response.InfConsultaNFSe.ChaveNFSe <> '' then
    lChaveNFSe := '<fio:ChaveNFSe>' + Response.InfConsultaNFSe.ChaveNFSe + '</fio:ChaveNFSe>';

  Response.ArquivoEnvio :=
    '<fio:ConsultarNfseEnvio xmlns:fio="http://www.fiorilli.com.br/nfse-nacional">'+
      lIM +
      lChaveNFSe +
    '</fio:ConsultarNfseEnvio>';

  Path := '';
  Method := 'POST';
end;

procedure TACBrNFSeProviderFiorilliAPIPropria101.TratarRetornoConsultaNFSeporChave(
  Response: TNFSeConsultaNFSeResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXMLNodeArray;
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

      ProcessarMensagemErros(Document.Root, Response, 'ListaMensagens', 'mensagem');

      Response.Sucesso := (Response.Erros.Count = 0);

      if Response.Sucesso then
      begin
        ANode := Document.Root.Childrens.FindAnyNs('ListaNFSe');

        if not Assigned(ANode) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod202;
          AErro.Descricao := ACBrStr(Desc202);
          Exit;
        end;

        ANodeArray := ANode.Childrens.FindAllAnyNs('NFSe');

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
          AuxNode := ANode.Childrens.FindAnyNs('infNFSe');

          if AuxNode = nil then
          begin
            AErro := Response.Erros.New;
            AErro.Codigo := Cod203;
            AErro.Descricao := ACBrStr(Desc203);
            Exit;
          end
          else
          begin
            if PreencherNotaRespostaConsultaNFSeporChave(AuxNode, ANode, Response) then
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

{ TACBrNFSeXWebserviceFiorilliAPIPropria101 }

function TACBrNFSeXWebserviceFiorilliAPIPropria101.ConsultarNFSePorChave(
  const ACabecalho, AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := RemoverDeclaracaoXML(AMSG);

  Result := Executar('consultarNfse', Request, [],
                    [{'xmlns:fio="http://www.fiorilli.com.br/nfse-nacional"'}]);
end;

function TACBrNFSeXWebserviceFiorilliAPIPropria101.ConsultarNFSePorRps(
  const ACabecalho, AMSG: string): string;
var
  Request: string;
begin
  FPMsgOrig := AMSG;

  Request := RemoverDeclaracaoXML(AMSG);

  Result := Executar('consultarNfse', Request, [],
                    [{'xmlns:fio="http://www.fiorilli.com.br/nfse-nacional"'}]);
end;

end.
