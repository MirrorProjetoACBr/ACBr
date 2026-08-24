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

unit NFOnline.Provider;
{
  Trocar todas as ocorrencias de "NFOnline" pelo nome do provedor
}

interface

uses
  SysUtils, Classes,
  ACBrXmlBase,
  ACBrBase,
  ACBrDFe.Conversao,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase;

type
  TACBrNFSeXWebserviceNFOnline203 = class(TACBrNFSeXWebserviceRest)
  protected
    procedure SetHeaders(aHeaderReq: THTTPHeader); override;

  public
    function Recepcionar(const ACabecalho, AMSG: String): string; override;
    {
    function RecepcionarSincrono(const ACabecalho, AMSG: String): string; override;
    function GerarNFSe(const ACabecalho, AMSG: String): string; override;
    function ConsultarLote(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSePorFaixa(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: String): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: String): string; override;
    function Cancelar(const ACabecalho, AMSG: String): string; override;
    function SubstituirNFSe(const ACabecalho, AMSG: String): string; override;
    }

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderNFOnline203 = class (TACBrNFSeProviderABRASFv2)
  protected
    procedure Configuracao; override;

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;
  end;

implementation

uses
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrUtil.XMLHTML,
  ACBrDFeException,
  NFOnline.GravarXml,
  NFOnline.LerXml;

{ TACBrNFSeProviderNFOnline203 }

procedure TACBrNFSeProviderNFOnline203.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
    UseCertificateHTTP := True;
    UseAuthorizationHeader := False;
    NumMaxRpsGerar  := 1;
    NumMaxRpsEnviar := 50;

    TabServicosExt := False;
    Identificador := 'Id';
    QuebradeLinha := ';';

    // meLoteAssincrono, meLoteSincrono ou meUnitario
    ModoEnvio := meLoteAssincrono;

    ConsultaSitLote := False;
    ConsultaLote := True;
    ConsultaNFSe := True;

    ConsultaPorFaixa := True;
    ConsultaPorFaixaPreencherNumNfseFinal := False;

    CancPreencherMotivo := False;
    CancPreencherSerieNfse := False;
    CancPreencherCodVerificacao := False;
  end;

  with ConfigWebServices do
  begin
    VersaoDados := '2.03';
    VersaoAtrib := '2.03';
    AtribVerLote := 'versao';
  end;

  SetXmlNameSpace('http://www.abrasf.org.br/nfse.xsd');

  SetNomeXSD('nfse.xsd');

  with ConfigSchemas do
  begin
    Validar := False;
  end;
end;

function TACBrNFSeProviderNFOnline203.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_NFOnline203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderNFOnline203.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_NFOnline203.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderNFOnline203.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  URL, AMimeType, Method, Params: string;
  Emitente: TEmitenteConfNFSe;
begin
  URL := GetWebServiceURL(AMetodo);
  AMimeType := 'application/xml';
  Method := 'POST';
  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;
  Params := '?Login=' + Emitente.WSUser +
            '&Senha=' + Emitente.WSSenha +
            '&Assincrono=' + 'N';

  if URL <> '' then
  begin
     URL := URL + Params;
    Result := TACBrNFSeXWebserviceNFOnline203.Create(FAOwner, AMetodo, URL, Method, AMimeType);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

{ TACBrNFSeXWebserviceNFOnline203 }

procedure TACBrNFSeXWebserviceNFOnline203.SetHeaders(aHeaderReq: THTTPHeader);
var
  Auth: string;
  Emitente: TEmitenteConfNFSe;
begin
  Emitente := TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente;
  {
  aHeaderReq.AddHeader('login', Emitente.WSUser);
  aHeaderReq.AddHeader('senha', Emitente.WSSenha);
  aHeaderReq.AddHeader('assincrono', 'S');
  }
end;

function TACBrNFSeXWebserviceNFOnline203.Recepcionar(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;
{
function TACBrNFSeXWebserviceNFOnline203.RecepcionarSincrono(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.GerarNFSe(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.ConsultarLote(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.ConsultarNFSePorFaixa(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.ConsultarNFSePorRps(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.ConsultarNFSeServicoPrestado(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.ConsultarNFSeServicoTomado(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.Cancelar(const ACabecalho, AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;

function TACBrNFSeXWebserviceNFOnline203.SubstituirNFSe(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', AMSG, [], []);
end;
}
function TACBrNFSeXWebserviceNFOnline203.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
end;

end.
