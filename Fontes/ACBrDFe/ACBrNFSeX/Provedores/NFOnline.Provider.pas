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
  ACBrXmlDocument,
  ACBrDFe.Conversao,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderABRASFv2,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse;

type
  TACBrNFSeXWebserviceNFOnline203 = class(TACBrNFSeXWebserviceMulti1)
  protected
    function DefinirMsgEnvio(const Message, SoapAction, SoapHeader: string;
                           namespace: array of string): string; override;
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

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = '';
                                     const AMessageTag: string = 'mensagem'); override;

    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;
  end;

implementation

uses
  synacode,
  ACBrCompress,
  ACBrJSON,
  ACBrNFSeX,
  ACBrNFSeXNotasFiscais,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXConsts,
  ACBrUtil.XMLHTML,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeException,
  NFOnline.GravarXml,
  NFOnline.LerXml;

{ TACBrNFSeProviderNFOnline203 }

procedure TACBrNFSeProviderNFOnline203.Configuracao;
begin
  inherited Configuracao;

  with ConfigGeral do
  begin
//    UseCertificateHTTP := True;
//    UseAuthorizationHeader := False;
    NumMaxRpsGerar  := 1;
    NumMaxRpsEnviar := 50;
    FormatoArqEnvioSoap := tfaTxt;
    FormatoArqRetornoSoap := tfaJson;
    FormatoArqRetorno := tfaJson;

//    TabServicosExt := False;
//    Identificador := 'Id';
//    QuebradeLinha := ';';

    // meLoteAssincrono, meLoteSincrono ou meUnitario
    ModoEnvio := meLoteAssincrono;
    {
    ConsultaSitLote := False;
    ConsultaLote := True;
    ConsultaNFSe := True;

    ConsultaPorFaixa := True;
    ConsultaPorFaixaPreencherNumNfseFinal := False;

    CancPreencherMotivo := False;
    CancPreencherSerieNfse := False;
    CancPreencherCodVerificacao := False;
    }
    Autenticacao.RequerCertificado := False;
    Autenticacao.RequerLogin := True;
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
  URL, AMimeType, Method: string;
begin
  URL := GetWebServiceURL(AMetodo);
  AMimeType := 'application/x-www-form-urlencoded';
  Method := 'POST';

  if URL <> '' then
  begin
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

procedure TACBrNFSeProviderNFOnline203.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse; const AListTag,
  AMessageTag: string);
var
  I: Integer;
  ANode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  AErro: TNFSeEventoCollectionItem;
  AAlerta: TNFSeEventoCollectionItem;
  aMsg, Codigo: string;
begin
  ANode := RootNode.Childrens.FindAnyNs(AListTag);

  if (ANode = nil) then
    ANode := RootNode;

  ANodeArray := ANode.Childrens.FindAllAnyNs(AMessageTag);

  if not Assigned(ANodeArray) then Exit;

  for I := Low(ANodeArray) to High(ANodeArray) do
  begin
    aMsg := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('Mensagem'), tcStr);
    Codigo := ObterConteudoTag(ANodeArray[I].Childrens.FindAnyNs('codigo'), tcStr);

    if aMsg = '' then
    begin
      aMsg := Codigo;

      if Length(aMsg) > 5 then
      begin
        if Copy(aMsg, 1, 9) = 'XSD Error' then
        begin
          Codigo := OnlyNumber(Copy(aMsg, 11, 5));
          aMsg := Trim(Copy(aMsg, 16, Length(aMsg)));
        end
        else
        begin
          Codigo := Trim(Copy(aMsg, 1, 5));

          if OnlyNumber(Codigo) = Codigo then
            aMsg := Trim(Copy(aMsg, 8, Length(aMsg)))
          else
          begin
            if (ObterConteudoTag(ANode.Childrens.FindAnyNs('situacao_codigo_nfse'), tcStr) = '1') then
              Codigo := '00000';
          end;
        end;
      end;
    end;

    if (Codigo = '00000') or
       (Codigo = '00001') then
    begin
      AAlerta := Response.Alertas.New;
      AAlerta.Codigo := Codigo;
      AAlerta.Descricao := aMsg;
      AAlerta.Correcao := '';
    end
    else
    begin
      AErro := Response.Erros.New;

      AErro.Codigo := Codigo;
      AErro.Descricao := aMsg;
      AErro.Correcao := '';
    end;
  end;
end;

procedure TACBrNFSeProviderNFOnline203.TratarRetornoEmitir(
  Response: TNFSeEmiteResponse);
var
  Document: TACBrXmlDocument;
  AErro: TNFSeEventoCollectionItem;
  AResumo: TNFSeResumoCollectionItem;
  ANode, AuxNode: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  NumRps: String;
  ANota: TNotaFiscal;
  I: Integer;
  NotaCompleta: Boolean;
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

      NotaCompleta := (Pos('<nfse>', Response.ArquivoRetorno) > 0);

      Document.LoadFromXml(Response.ArquivoRetorno);

      ANode := Document.Root;

      ProcessarMensagemErros(ANode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      if NotaCompleta then
      begin
        ANodeArray := ANode.Childrens.FindAllAnyNs('nfse');
        if not Assigned(ANodeArray) and (Response.Sucesso) then
        begin
          AErro := Response.Erros.New;
          AErro.Codigo := Cod203;
          AErro.Descricao := ACBrStr(Desc203);
          Exit;
        end;

        for I := Low(ANodeArray) to High(ANodeArray) do
        begin
          ANode := ANodeArray[I];
          AuxNode := ANode.Childrens.FindAnyNs('rps');

          NumRps := '';
          if AuxNode <> nil then
            NumRps := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nro_recibo_provisorio'), tcStr);

          with Response do
          begin
            AuxNode := ANode.Childrens.FindAnyNs('nf');

            NumeroNota := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('numero_nfse'), tcStr);
            SerieNota := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('serie_nfse'), tcStr);
            Data := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('data_nfse'), tcDatVcto);
            Data := Data + ObterConteudoTag(AuxNode.Childrens.FindAnyNs('hora_nfse'), tcHor);
            Link := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('link_nfse'), tcStr);
            Link := StringReplace(Link, '&amp;', '&', [rfReplaceAll]);
            Protocolo := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('cod_verificador_autenticidade'), tcStr);
            CodigoVerificacao := Protocolo;
            Situacao := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('situacao_codigo_nfse'), tcStr);
            DescSituacao := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('situacao_descricao_nfse'), tcStr);
          end;

          AResumo := Response.Resumos.New;
          AResumo.NumeroNota := Response.NumeroNota;
          AResumo.SerieNota := Response.SerieNota;
          AResumo.Data := Response.Data;
          AResumo.Link := Response.Link;
          AResumo.Protocolo := Response.Protocolo;
          AResumo.CodigoVerificacao := Response.CodigoVerificacao;
          AResumo.Situacao := Response.Situacao;
          AResumo.DescSituacao := Response.DescSituacao;

          if NumRps <> '' then
            ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(NumRps)
          else
            ANota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(Response.NumeroNota);

          ANota := CarregarXmlNfse(ANota, ANode.OuterXml);
          SalvarXmlNfse(ANota);
        end;
      end
      else
      begin
        with Response do
        begin
          NumeroNota := ObterConteudoTag(ANode.Childrens.FindAnyNs('numero_nfse'), tcStr);
          SerieNota := ObterConteudoTag(ANode.Childrens.FindAnyNs('serie_nfse'), tcStr);
          Data := ObterConteudoTag(ANode.Childrens.FindAnyNs('data_nfse'), tcDatVcto);
          Data := Data + ObterConteudoTag(ANode.Childrens.FindAnyNs('hora_nfse'), tcHor);
          Situacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('situacao_codigo_nfse'), tcStr);
          DescSituacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('situacao_descricao_nfse'), tcStr);
          Link := ObterConteudoTag(ANode.Childrens.FindAnyNs('link_nfse'), tcStr);
          Link := StringReplace(Link, '&amp;', '&', [rfReplaceAll]);
          Protocolo := ObterConteudoTag(ANode.Childrens.FindAnyNs('cod_verificador_autenticidade'), tcStr);
          CodigoVerificacao := Protocolo;
        end;

        AResumo := Response.Resumos.New;
        AResumo.NumeroNota := Response.NumeroNota;
        AResumo.SerieNota := Response.SerieNota;
        AResumo.Data := Response.Data;
        AResumo.Link := Response.Link;
        AResumo.Protocolo := Response.Protocolo;
        AResumo.CodigoVerificacao := Response.CodigoVerificacao;
        AResumo.Situacao := Response.Situacao;
        AResumo.DescSituacao := Response.DescSituacao;

//        MontarXMLNFSe(ANode, Response, AResumo);
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

{ TACBrNFSeXWebserviceNFOnline203 }

function TACBrNFSeXWebserviceNFOnline203.DefinirMsgEnvio(const Message,
  SoapAction, SoapHeader: string; namespace: array of string): string;
var
  UsuarioWeb, SenhaWeb: string;
begin
  UsuarioWeb := Trim(TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente.WSUser);

  if UsuarioWeb = '' then
    GerarException(ACBrStr('O provedor ' + TConfiguracoesNFSe(FPConfiguracoes).Geral.xProvedor +
      ' necessita que a propriedade: Configuracoes.Geral.Emitente.WSUser seja informada.'));

  SenhaWeb := Trim(TConfiguracoesNFSe(FPConfiguracoes).Geral.Emitente.WSSenha);

  if SenhaWeb = '' then
    GerarException(ACBrStr('O provedor ' + TConfiguracoesNFSe(FPConfiguracoes).Geral.xProvedor +
      ' necessita que a propriedade: Configuracoes.Geral.Emitente.WSSenha seja informada.'));

  Result := '--' + FPBound + sLineBreak +
            'Content-Disposition: form-data; name=' +
            AnsiQuotedStr( 'login', '"') + sLineBreak + sLineBreak + UsuarioWeb + sLineBreak +
            '--' + FPBound + sLineBreak +
            'Content-Disposition: form-data; name=' +
            AnsiQuotedStr( 'senha', '"') + sLineBreak + sLineBreak + SenhaWeb + sLineBreak +
            '--' + FPBound + sLineBreak +
            'Content-Disposition: form-data; name=' +
            AnsiQuotedStr('arquivo', '"' ) + '; ' + 'filename=' +
            AnsiQuotedStr(GerarPrefixoArquivo + '-' + FPArqEnv + '.xml', '"') + sLineBreak +
            'Content-Type:  multipart/form-data' + sLineBreak + sLineBreak + Message + sLineBreak +
            '--' + FPBound + '--' + sLineBreak;

  FPHttpClient := FPDFeOwner.SSL.SSLHttpClass;

  FPHttpClient.Clear;
end;

function TACBrNFSeXWebserviceNFOnline203.Recepcionar(const ACabecalho,
  AMSG: String): string;
begin
  FPMsgOrig := AMSG;

  Result := Executar('', FPMsgOrig, [], []);
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
var
  jDocument{, JSonErro}: TACBrJSONObject;
  Codigo, Mensagem, Xml: string;
begin
//  Result := inherited TratarXmlRetornado(aXML);

//  Result := ParseText(Result);
  if not StringIsPDF(aXML) then
  begin
    Xml := ConverteANSItoUTF8(aXML);
    Xml := RemoverDeclaracaoXML(Xml);

    if (Pos('{"', Xml) > 0) and (Pos('":"', Xml) > 0) then
    begin
      jDocument := TACBrJSONObject.Parse(Xml);
//      JSonErro := jDocument.AsJSONObject['retorno'];

//      if not Assigned(JSonErro) then Exit;

//      Codigo := Poem_Zeros(JSonErro.AsString['code'], 5);
//      Mensagem := ACBrStr(JSonErro.AsString['msg']);

      Codigo := ACBrStr(jDocument.AsString['status']);
      Mensagem := ACBrStr(jDocument.AsString['detalhes']);

      Result := '<retorno>' +
                  '<mensagem>' +
                    '<codigo>' + Codigo + '</codigo>' +
                    '<Mensagem>' + Mensagem + '</Mensagem>' +
                    '<Correcao>' + '</Correcao>' +
                  '</mensagem>' +
                '</retorno>';

      Result := ParseText(Result);
    end
    else
    begin
      Result := inherited TratarXmlRetornado(Xml);

      if not StringIsXML(Result) then
      begin
        Result := '<retorno>' +
                    '<mensagem>' +
                      '<codigo>' + '</codigo>' +
                      '<Mensagem>' + Result + '</Mensagem>' +
                      '<Correcao>' + '</Correcao>' +
                    '</mensagem>' +
                  '</retorno>';
      end;

      Result := ParseText(Result);
      Result := RemoverDeclaracaoXML(Result);
      Result := RemoverIdentacao(Result);
      Result := RemoverCaracteresDesnecessarios(Result);
      Result := Trim(StringReplace(Result, '&', '&amp;', [rfReplaceAll]));
    end;
  end;
end;

end.
