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

unit ISSSaoPaulo.Provider;

interface

uses
  SysUtils,
  Classes,
  Variants,
  ACBrBase,
  ACBrDFeSSL,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXNotasFiscais,
  ACBrNFSeXClass,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml,
  ACBrNFSeXLerXml,
  ACBrNFSeXProviderProprio,
  ACBrNFSeXWebserviceBase,
  ACBrNFSeXWebservicesResponse;

type
  TACBrNFSeXWebserviceISSSaoPaulo = class(TACBrNFSeXWebserviceSoap11)
  public
    function Recepcionar(const ACabecalho, AMSG: string): string; override;
    function RecepcionarSincrono(const ACabecalho, AMSG: string): string; override;
    function GerarNFSe(const ACabecalho, AMSG: string): string; override;
    function TesteEnvio(const ACabecalho, AMSG: string): string; override;
    function ConsultarSituacao(const ACabecalho, AMSG: string): string; override;
    function ConsultarLote(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSePorRps(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSe(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSeServicoPrestado(const ACabecalho, AMSG: string): string; override;
    function ConsultarNFSeServicoTomado(const ACabecalho, AMSG: string): string; override;
    function Cancelar(const ACabecalho, AMSG: string): string; override;

    function TratarXmlRetornado(const aXML: string): string; override;
  end;

  TACBrNFSeProviderISSSaoPaulo = class(TACBrNFSeProviderProprio)
  private
    FPVersaoDFe: string;
  protected
    procedure Configuracao; override;

    procedure AssinaturaAdicional(Nota: TNotaFiscal);

    function CriarGeradorXml(const ANFSe: TNFSe): TNFSeWClass; override;
    function CriarLeitorXml(const ANFSe: TNFSe): TNFSeRClass; override;
    function CriarServiceClient(const AMetodo: TMetodo): TACBrNFSeXWebservice; override;

    procedure PrepararEmitir(Response: TNFSeEmiteResponse); override;
    procedure TratarRetornoEmitir(Response: TNFSeEmiteResponse); override;

    procedure PrepararConsultaSituacao(Response: TNFSeConsultaSituacaoResponse); override;
    procedure TratarRetornoConsultaSituacao(Response: TNFSeConsultaSituacaoResponse); override;

    procedure PrepararConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;
    procedure TratarRetornoConsultaLoteRps(Response: TNFSeConsultaLoteRpsResponse); override;

    procedure PrepararConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;
    procedure TratarRetornoConsultaNFSeporRps(Response: TNFSeConsultaNFSeporRpsResponse); override;

    procedure PrepararConsultaNFSe(Response: TNFSeConsultaNFSeResponse); override;
    procedure TratarRetornoConsultaNFSe(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse); override;
    procedure TratarRetornoConsultaNFSeServicoPrestado(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse); override;
    procedure TratarRetornoConsultaNFSeServicoTomado(Response: TNFSeConsultaNFSeResponse); override;

    procedure PrepararCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;
    procedure TratarRetornoCancelaNFSe(Response: TNFSeCancelaNFSeResponse); override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TNFSeWebserviceResponse;
                                     const AListTag: string = '';
                                     const AMessageTag: string = 'Erro'); override;

    function LerChaveNFe(ANode: TACBrXmlNode): string;
    function LerChaveRPS(ANode: TACBrXmlNode): string;
  public
    function SituacaoLoteRpsToStr(const t: TSituacaoLoteRps): string; override;
    function StrToSituacaoLoteRps(out ok: boolean; const s: string): TSituacaoLoteRps; override;
    function SituacaoLoteRpsToDescr(const t: TSituacaoLoteRps): string; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrDFeException,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrNFSeX,
  ACBrNFSeXConfiguracoes,
  ACBrNFSeXConsts,
  ISSSaoPaulo.GravarXml,
  ISSSaoPaulo.LerXml;

{ TACBrNFSeProviderISSSaoPaulo }

procedure TACBrNFSeProviderISSSaoPaulo.AssinaturaAdicional(Nota: TNotaFiscal);
var
  LSituacao, LISSRetido, LCPFCNPJTomador, LIndTomador, LTomador,
  LCPFCNPJInter, LIndInter, LISSRetidoInter, LInter, LAssinatura, LNIF, LValorServicos: string;
  iTamanhoIM: Integer;
begin
  with Nota do
  begin
    LSituacao := EnumeradoToStr(NFSe.SituacaoNfse, ['N', 'C'], [snNormal, snCancelado]);

    LISSRetido := EnumeradoToStr(NFSe.Servico.Valores.IssRetido,
                                 ['N', 'S'], [stNormal, stRetencao]);

    // Tomador do Serviço
    LCPFCNPJTomador := OnlyNumber(NFSe.Tomador.IdentificacaoTomador.CpfCnpj);

    if LCPFCNPJTomador = '' then
      LIndTomador := '3'
    else
      if Length(LCPFCNPJTomador) <= 11 then
        LIndTomador := '1'
      else
        if Length(LCPFCNPJTomador) <= 14 then
          LIndTomador := '2';

    LTomador := LIndTomador + Poem_Zeros(LCPFCNPJTomador, 14);

    // Prestador Intermediario
    LCPFCNPJInter := OnlyNumber(NFSe.Intermediario.Identificacao.CpfCnpj);

    if LCPFCNPJInter = '' then
      LIndInter := '3'
    else
      if Length(LCPFCNPJInter) <= 11 then
        LIndInter := '1'
      else
        if Length(LCPFCNPJInter) <= 14 then
          LIndInter := '2';

    LISSRetidoInter := EnumeradoToStr(NFSe.Intermediario.IssRetido,
                                      ['N', 'S'], [stNormal, stRetencao]);

    LNIF := trim(NFSe.Intermediario.Identificacao.Nif);

    if LIndInter = '3' then
      LNIF := NaoNIFToStr(NFSe.Intermediario.Identificacao.cNaoNIF);

    if FPVersaoDFe = '2' then
    begin
      if (LCPFCNPJInter <> '') then
        LInter := LIndInter + Poem_Zeros(LCPFCNPJInter, 14) + LISSRetidoInter + LNIF
      else
        LInter := '';

      iTamanhoIM := 12;

      if NFSe.Servico.Valores.ValorInicialCobrado > 0 then
        LValorServicos := Poem_Zeros(OnlyNumber(FormatFloat('#0.00', NFSe.Servico.Valores.ValorInicialCobrado)), 15)
      else
        LValorServicos := Poem_Zeros(OnlyNumber(FormatFloat('#0.00', NFSe.Servico.Valores.ValorFinalCobrado)), 15);
    end
    else
    begin
      if LIndInter <> '3' then
        LInter := LIndInter + Poem_Zeros(LCPFCNPJInter, 14) + LISSRetidoInter
      else
        LInter := '';

      iTamanhoIM := 8;

      LValorServicos := Poem_Zeros(OnlyNumber(FormatFloat('#0.00', NFSe.Servico.Valores.ValorServicos)), 15);
    end;

    LAssinatura := Poem_Zeros(NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal, iTamanhoIM) +
                   PadRight(NFSe.IdentificacaoRps.Serie, 5, ' ') +
                   Poem_Zeros(NFSe.IdentificacaoRps.Numero, 12) +
                   FormatDateTime('yyyymmdd', NFse.DataEmissao) +
                   TipoTributacaoRPSToStr(NFSe.TipoTributacaoRPS) +
                   LSituacao +
                   LISSRetido +
                   LValorServicos +
                   Poem_Zeros(OnlyNumber(FormatFloat('#0.00', NFSe.Servico.Valores.ValorDeducoes)), 15) +
                   Poem_Zeros(OnlyNumber(NFSe.Servico.ItemListaServico), 5) +
                   LTomador +
                   LInter;

    NFSe.Assinatura := string(TACBrNFSeX(FAOwner).SSL.CalcHash(AnsiString(LAssinatura), dgstSHA1, outBase64, True));
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.Configuracao;
begin
  inherited Configuracao;

  FPVersaoDFe := '1';

  if TACBrNFSeX(FAOwner).Configuracoes.Geral.Versao = ve200 then
  begin
    FPVersaoDFe := '2';

    ConfigGeral.Particularidades.AtendeReformaTributaria := True;
  end;

  ConfigGeral.Identificador := '';
  ConfigGeral.QuebradeLinha := '|';
  ConfigGeral.ModoEnvio := meLoteAssincrono;

  ConfigGeral.ServicosDisponibilizados.EnviarLoteAssincrono := True;
  ConfigGeral.ServicosDisponibilizados.EnviarUnitario := True;
  ConfigGeral.ServicosDisponibilizados.TestarEnvio := True;
  ConfigGeral.ServicosDisponibilizados.ConsultarSituacao := True;
  ConfigGeral.ServicosDisponibilizados.ConsultarLote := True;
  ConfigGeral.ServicosDisponibilizados.ConsultarRps := True;
  ConfigGeral.ServicosDisponibilizados.ConsultarNfse := True;
  ConfigGeral.ServicosDisponibilizados.ConsultarServicoPrestado := True;
  ConfigGeral.ServicosDisponibilizados.ConsultarServicoTomado := True;
  ConfigGeral.ServicosDisponibilizados.CancelarNfse := True;
  ConfigGeral.ServicosDisponibilizados.EnviarLoteSincrono := True;

  ConfigAssinar.LoteRps := True;
  ConfigAssinar.ConsultarSituacao := True;
  ConfigAssinar.ConsultarLote := True;
  ConfigAssinar.ConsultarNFSeRps := True;
  ConfigAssinar.ConsultarNFSe := True;
  ConfigAssinar.CancelarNFSe := True;
  ConfigAssinar.ConsultarNFSeServicoTomado := True;
  ConfigAssinar.ConsultarNFSeServicoPrestado := True;
  ConfigAssinar.LoteGerarNFSe := True;

  ConfigAssinar.IncluirURI := False;

  ConfigAssinar.AssinaturaAdicional := True;

  SetXmlNameSpace('http://www.prefeitura.sp.gov.br/nfe');

  with ConfigMsgDados do
  begin
    UsarNumLoteConsLote := True;

    GerarNSLoteRps := True;
    LoteRps.InfElemento := 'RPS';
    LoteRps.DocElemento := 'PedidoEnvioLoteRPS';

    GerarNFSe.InfElemento := '';
    GerarNFSe.DocElemento := 'PedidoEnvioRPS';

    ConsultarSituacao.InfElemento := '';
    ConsultarSituacao.DocElemento := 'PedidoInformacoesLote';

    ConsultarLote.InfElemento := '';
    ConsultarLote.DocElemento := 'PedidoConsultaLote';

    ConsultarNFSeRps.InfElemento := '';
    ConsultarNFSeRps.DocElemento := 'PedidoConsultaNFe';

    ConsultarNFSe.InfElemento := '';
    ConsultarNFSe.DocElemento := 'PedidoConsultaNFe';

    ConsultarNFSeServicoPrestado.InfElemento := '';
    ConsultarNFSeServicoPrestado.DocElemento := 'PedidoConsultaNFePeriodo';

    ConsultarNFSeServicoTomado.InfElemento := '';
    ConsultarNFSeServicoTomado.DocElemento := 'PedidoConsultaNFePeriodo';

    CancelarNFSe.InfElemento := '';
    CancelarNFSe.DocElemento := 'PedidoCancelamentoNFe';

    LoteRpsSincrono.InfElemento := 'RPS';
    LoteRpsSincrono.DocElemento := 'PedidoEnvioLoteRPS';

    DadosCabecalho := FPVersaoDFe;
  end;

  SetNomeXSD('***');

  with ConfigSchemas do
  begin
    Teste := 'PedidoEnvioLoteRPS_v0' + FPVersaoDFe + '.xsd';
    Recepcionar := 'PedidoEnvioLoteRPS_v0' + FPVersaoDFe + '.xsd';
    GerarNFSe := 'PedidoEnvioRPS_v0' + FPVersaoDFe + '.xsd';
    ConsultarSituacao := 'PedidoInformacoesLote_v0' + FPVersaoDFe + '.xsd';
    ConsultarLote := 'PedidoConsultaLote_v0' + FPVersaoDFe + '.xsd';
    ConsultarNFSeRps := 'PedidoConsultaNFe_v0' + FPVersaoDFe + '.xsd';
    ConsultarNFSe := 'PedidoConsultaNFe_v0' + FPVersaoDFe + '.xsd';
    ConsultarNFSeServicoPrestado := 'PedidoConsultaNFePeriodo_v0' + FPVersaoDFe + '.xsd';
    ConsultarNFSeServicoTomado := 'PedidoConsultaNFePeriodo_v0' + FPVersaoDFe + '.xsd';
    CancelarNFSe := 'PedidoCancelamentoNFe_v0' + FPVersaoDFe + '.xsd';
    RecepcionarSincrono := 'PedidoEnvioLoteRPS_v0' + FPVersaoDFe + '.xsd';
  end;
end;

function TACBrNFSeProviderISSSaoPaulo.CriarGeradorXml(
  const ANFSe: TNFSe): TNFSeWClass;
begin
  Result := TNFSeW_ISSSaoPaulo.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSSaoPaulo.CriarLeitorXml(
  const ANFSe: TNFSe): TNFSeRClass;
begin
  Result := TNFSeR_ISSSaoPaulo.Create(Self);
  Result.NFSe := ANFSe;
end;

function TACBrNFSeProviderISSSaoPaulo.CriarServiceClient(
  const AMetodo: TMetodo): TACBrNFSeXWebservice;
var
  LURL: string;
begin
  LURL := GetWebServiceURL(AMetodo);

  if FPVersaoDFe = '2' then
    LURL := 'https://nfews.prefeitura.sp.gov.br/lotenfe.asmx';

  if LURL <> '' then
    Result := TACBrNFSeXWebserviceISSSaoPaulo.Create(FAOwner, AMetodo, LURL)
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

function TACBrNFSeProviderISSSaoPaulo.LerChaveNFe(ANode: TACBrXmlNode): string;
var
  LNode: TACBrXmlNode;
begin
  Result := '';
  if ANode = nil then
    Exit;

  LNode := ANode.Childrens.FindAnyNs('ChaveNFe');

  if LNode <> nil then
    Result := ObterConteudoTag(LNode.Childrens.FindAnyNs('NumeroNFe'), tcStr);
end;

function TACBrNFSeProviderISSSaoPaulo.LerChaveRPS(ANode: TACBrXmlNode): string;
var
  LNode: TACBrXmlNode;
begin
  Result := '';
  if ANode = nil then
    Exit;

  LNode := ANode.Childrens.FindAnyNs('ChaveRPS');

  if LNode <> nil then
    Result := ObterConteudoTag(LNode.Childrens.FindAnyNs('NumeroRPS'), tcStr);
end;

procedure TACBrNFSeProviderISSSaoPaulo.ProcessarMensagemErros(
  RootNode: TACBrXmlNode; Response: TNFSeWebserviceResponse;
  const AListTag, AMessageTag: string);
var
  I: Integer;
  LNode: TACBrXmlNode;
  LNodeArray: TACBrXmlNodeArray;
  LErro: TNFSeEventoCollectionItem;
  LAlerta: TNFSeEventoCollectionItem;
  LMensagem: string;
begin
  LNodeArray := RootNode.Childrens.FindAllAnyNs(AMessageTag);

  if Assigned(LNodeArray) then
  begin
    for I := Low(LNodeArray) to High(LNodeArray) do
    begin
      LErro := Response.Erros.New;
      LErro.Codigo := ObterConteudoTag(LNodeArray[I].Childrens.FindAnyNs('Codigo'), tcStr);
      LErro.Descricao := ObterConteudoTag(LNodeArray[I].Childrens.FindAnyNs('Descricao'), tcStr);

      LNode := LNodeArray[I].Childrens.FindAnyNs('ChaveRPS');

      if LNode <> nil then
        LErro.Correcao := 'Numero/Série Rps: ' +
          ObterConteudoTag(LNode.Childrens.FindAnyNs('NumeroRPS'), tcStr) + '/' +
          ObterConteudoTag(LNode.Childrens.FindAnyNs('SerieRPS'), tcStr);
    end;
  end;

  LNodeArray := RootNode.Childrens.FindAllAnyNs('Alerta');

  if Assigned(LNodeArray) then
  begin
    for I := Low(LNodeArray) to High(LNodeArray) do
    begin
      LMensagem := ObterConteudoTag(LNodeArray[I].Childrens.FindAnyNs('Descricao'), tcStr);

      if LMensagem <> '' then
      begin
        LAlerta := Response.Alertas.New;
        LAlerta.Codigo := ObterConteudoTag(LNodeArray[I].Childrens.FindAnyNs('Codigo'), tcStr);
        LAlerta.Descricao := LMensagem;

        LNode := LNodeArray[I].Childrens.FindAnyNs('ChaveRPS');

        if LNode <> nil then
          LAlerta.Correcao := 'Numero/Série Rps: ' +
            ObterConteudoTag(LNode.Childrens.FindAnyNs('NumeroRPS'), tcStr) + '/' +
            ObterConteudoTag(LNode.Childrens.FindAnyNs('SerieRPS'), tcStr);
      end;
    end;
  end
end;

function TACBrNFSeProviderISSSaoPaulo.SituacaoLoteRpsToStr(const t: TSituacaoLoteRps): string;
begin
  Result := EnumeradoToStr(t,
                           ['true', 'false'],
                           [sLoteProcessadoSucesso, sLoteProcessadoErro]);
end;

function TACBrNFSeProviderISSSaoPaulo.StrToSituacaoLoteRps(out ok: boolean; const s: string): TSituacaoLoteRps;
begin
  Result := StrToEnumerado(ok, s,
                           ['true', 'false'],
                           [sLoteProcessadoSucesso, sLoteProcessadoErro]);
end;

function TACBrNFSeProviderISSSaoPaulo.SituacaoLoteRpsToDescr(const t: TSituacaoLoteRps): string;
begin
  Result := EnumeradoToStr(t,
                           ['Lote Processado com Sucesso', 'Lote Processado com Erro'],
                           [sLoteProcessadoSucesso, sLoteProcessadoErro]);
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararEmitir(Response: TNFSeEmiteResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNota: TNotaFiscal;
  LIdAttr, LNameSpace, LListaRps, LRps,
  LTagEnvio, LCabecalho, LDataI, LDataF, LTotServicos, LTotDeducoes,
  LCNPJCPF, LDoc, LValores: string;
  I: Integer;
  LDataInicial, LDataFinal: TDateTime;
  LvTotServicos, LvTotDeducoes: Double;
  LAno, LMes, LDia: Word;
  LTransacao: Boolean;
begin

  if TACBrNFSeX(FAOwner).NotasFiscais.Count <= 0 then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod002;
    LErro.Descricao := ACBrStr(Desc002);
  end;

  if TACBrNFSeX(FAOwner).NotasFiscais.Count > Response.MaxRps then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod003;
    LErro.Descricao := ACBrStr('Conjunto de RPS transmitidos (máximo de ' +
                       IntToStr(Response.MaxRps) + ' RPS)' +
                       ' excedido. Quantidade atual: ' +
                       IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count));
  end;

  if Response.Erros.Count > 0 then
    Exit;

  LListaRps := '';

  if ConfigAssinar.IncluirURI then
    LIdAttr := ConfigGeral.Identificador
  else
    LIdAttr := 'ID';

  LDataInicial := 0;
  LDataFinal := 0;
  LvTotServicos := 0;
  LvTotDeducoes := 0;
  LTransacao := True;

  for I := 0 to TACBrNFSeX(FAOwner).NotasFiscais.Count - 1 do
  begin
    LNota := TACBrNFSeX(FAOwner).NotasFiscais.Items[I];

    AssinaturaAdicional(LNota);

    LNota.GerarXML;

    LNota.XmlRps := ConverteXMLtoUTF8(LNota.XmlRps);
    LNota.XmlRps := ChangeLineBreak(LNota.XmlRps, '');

    if ConfigAssinar.Rps or ConfigAssinar.RpsGerarNFSe then
    begin
      LNota.XmlRps := FAOwner.SSL.Assinar(LNota.XmlRps,
                                         ConfigMsgDados.XmlRps.DocElemento,
                                         ConfigMsgDados.XmlRps.InfElemento, '', '', '', LIdAttr);
    end;

    SalvarXmlRps(LNota);

    if I = 0 then
    begin
      LDataInicial := LNota.NFSe.DataEmissao;
      LDataFinal := LDataInicial;

      LTransacao := (LNota.NFSe.Transacao = snSim);
    end;

    if LNota.NFSe.DataEmissao < LDataInicial then
      LDataInicial := LNota.NFSe.DataEmissao;

    if LNota.NFSe.DataEmissao > LDataFinal then
      LDataFinal := LNota.NFSe.DataEmissao;

    LvTotServicos := LvTotServicos + LNota.NFSe.Servico.Valores.ValorServicos;
    LvTotDeducoes := LvTotDeducoes + LNota.NFSe.Servico.Valores.ValorDeducoes;

    LRps := RemoverDeclaracaoXML(LNota.XmlRps);

    LRps := '<RPS xmlns="">' + SeparaDados(LRps, 'RPS') + '</RPS>';

    LListaRps := LListaRps + LRps;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  LListaRps := ChangeLineBreak(LListaRps, '');

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  case Response.ModoEnvio of
    meUnitario:
      begin
        LTagEnvio := 'PedidoEnvioRPS';

        LCabecalho := '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                        '<CPFCNPJRemetente>' +
                          LCNPJCPF +
                        '</CPFCNPJRemetente>' +
                      '</Cabecalho>';

        if EstaVazio(ConfigMsgDados.GerarNFSe.xmlns) then
          LNameSpace := ''
        else
          LNameSpace := ' xmlns="' + ConfigMsgDados.GerarNFSe.xmlns + '"';
      end;
  else
    begin
      LTagEnvio := 'PedidoEnvioLoteRPS';

      DecodeDate(VarToDateTime(LDataInicial), LAno, LMes, LDia);
      LDataI := FormatFloat('0000', LAno) + '-' +
                FormatFloat('00', LMes) + '-' + FormatFloat('00', LDia);

      DecodeDate(VarToDateTime(LDataFinal), LAno, LMes, LDia);
      LDataF := FormatFloat('0000', LAno) + '-' +
                FormatFloat('00', LMes) + '-' + FormatFloat('00', LDia);

      {
        Tag <LTransacao>
        Informe se os RPS a serem substituídos por NFS-e farão parte de uma
        mesma transação.

        True - Os RPS só serão substituídos por NFS-e se não ocorrer nenhum
               evento de erro durante o processamento de todo o lote;

        False - Os RPS válidos serão substituídos por NFS-e, mesmo que ocorram
                eventos de erro durante processamento de outros RPS deste lote.
      }

      LTotServicos := FloatToString(LvTotServicos, '.', FloatMask(2, False));
      LTotServicos := StringReplace(LTotServicos, '.00', '', []);
      LTotDeducoes := FloatToString(LvTotDeducoes, '.', FloatMask(2, False));
      LTotDeducoes := StringReplace(LTotDeducoes, '.00', '', []);

      if FPVersaoDFe = '1' then
        LValores := '<ValorTotalServicos>' +
                      LTotServicos +
                    '</ValorTotalServicos>' +
                    '<ValorTotalDeducoes>' +
                      LTotDeducoes +
                    '</ValorTotalDeducoes>'
      else
        LValores := '';

      LCabecalho := '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                      '<CPFCNPJRemetente>' +
                        LCNPJCPF +
                      '</CPFCNPJRemetente>' +
                      '<transacao>' +
                        LowerCase(BoolToStr(LTransacao, True)) +
                      '</transacao>' +
                      '<dtInicio>' + LDataI + '</dtInicio>' +
                      '<dtFim>' + LDataF + '</dtFim>' +
                      '<QtdRPS>' +
                        IntToStr(TACBrNFSeX(FAOwner).NotasFiscais.Count) +
                      '</QtdRPS>' +
                      LValores +
                    '</Cabecalho>';

      if EstaVazio(ConfigMsgDados.LoteRps.xmlns) then
        LNameSpace := ''
      else
        LNameSpace := ' xmlns="' + ConfigMsgDados.LoteRps.xmlns + '"';
    end;
  end;

  Response.ArquivoEnvio := '<' + LTagEnvio + LNameSpace + '>' +
                             LCabecalho +
                             LListaRps +
                           '</' + LTagEnvio + '>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoEmitir(Response: TNFSeEmiteResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode: TACBrXmlNode;
  LAuxNode, LNodeChave: TACBrXmlNode;
begin
  LDocument := TACBrXmlDocument.Create;

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);

          LAuxNode := LAuxNode.Childrens.FindAnyNs('InformacoesLote');

          if LAuxNode <> nil then
          begin
            NumeroLote := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('NumeroLote'), tcStr);

            { Verificar se mais alguma dessas informações são necessárias
            with InformacoesLote do
            begin
              NumeroLote := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('NumeroLote'), tcStr);
              InscricaoPrestador := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('InscricaoPrestador'), tcStr);

              AuxNodeCPFCNPJ := LAuxNode.Childrens.FindAnyNs('CPFCNPJRemetente');

              if AuxNodeCPFCNPJ <> nil then
              begin
                CPFCNPJRemetente := ObterConteudoTag(AuxNodeCPFCNPJ.Childrens.FindAnyNs('CNPJ'), tcStr);

                if CPFCNPJRemetente = '' then
                  CPFCNPJRemetente := ObterConteudoTag(AuxNodeCPFCNPJ.Childrens.FindAnyNs('CPF'), tcStr);
              end;

              DataEnvioLote := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('DataEnvioLote'), tcDatHor);
              QtdNotasProcessadas := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('QtdNotasProcessadas'), tcInt);
              TempoProcessamento := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('TempoProcessamento'), tcInt);
              ValorTotalServico := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('ValorTotalServicos'), tcDe2);
            end;
            }
          end;
        end;
      end;

      LAuxNode := LNode.Childrens.FindAnyNs('ChaveNFeRPS');

      if LAuxNode <> nil then
      begin
        LNodeChave := LAuxNode.Childrens.FindAnyNs('ChaveRPS');

        if (LNodeChave <> nil) then
        begin
          with Response do
          begin
            SerieRps := ObterConteudoTag(LNodeChave.Childrens.FindAnyNs('SerieRPS'), tcStr);
            NumeroRps := ObterConteudoTag(LNodeChave.Childrens.FindAnyNs('NumeroRPS'), tcStr);
          end;
        end;

        LNodeChave := LAuxNode.Childrens.FindAnyNs('ChaveNFe');

        if (LNodeChave <> nil) then
        begin
          with Response do
          begin
            NumeroNota := ObterConteudoTag(LNodeChave.Childrens.FindAnyNs('NumeroNFe'), tcStr);
            CodigoVerificacao := ObterConteudoTag(LNodeChave.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNameSpace, LCNPJCPF, LDoc: string;
begin
  if EstaVazio(Response.NumeroLote) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod111;
    LErro.Descricao := ACBrStr(Desc111);
    Exit;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if EstaVazio(ConfigMsgDados.ConsultarSituacao.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.ConsultarSituacao.xmlns + '"';

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  Response.ArquivoEnvio := '<PedidoInformacoesLote' + LNameSpace + '>' +
                             '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                               '<CPFCNPJRemetente>' +
                                 LCNPJCPF +
                               '</CPFCNPJRemetente>' +
                               '<NumeroLote>' + Response.NumeroLote + '</NumeroLote>' +
                               '<InscricaoPrestador>' +
                                 OnlyNumber(LEmitente.InscMun) +
                               '</InscricaoPrestador>' +
                             '</Cabecalho>' +
                           '</PedidoInformacoesLote>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoConsultaSituacao(
  Response: TNFSeConsultaSituacaoResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
  LOk: Boolean;
  LSituacao: TSituacaoLoteRps;
begin
  LDocument := TACBrXmlDocument.Create;

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);

          LSituacao := TACBrNFSeX(FAOwner).Provider.StrToSituacaoLoteRps(LOk, Situacao);
          DescSituacao := TACBrNFSeX(FAOwner).Provider.SituacaoLoteRpsToDescr(LSituacao);

          LAuxNode := LAuxNode.Childrens.FindAnyNs('InformacoesLote');

          if LAuxNode <> nil then
          begin
            NumeroLote := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('NumeroLote'), tcStr);

            { Verificar se mais alguma dessas informações são necessárias
            with InformacoesLote do
            begin
              NumeroLote := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('NumeroLote'), tcStr);
              InscricaoPrestador := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('InscricaoPrestador'), tcStr);

              AuxNodeCPFCNPJ := LAuxNode.Childrens.FindAnyNs('CPFCNPJRemetente');

              if AuxNodeCPFCNPJ <> nil then
              begin
                CPFCNPJRemetente := ObterConteudoTag(AuxNodeCPFCNPJ.Childrens.FindAnyNs('CNPJ'), tcStr);

                if CPFCNPJRemetente = '' then
                  CPFCNPJRemetente := ObterConteudoTag(AuxNodeCPFCNPJ.Childrens.FindAnyNs('CPF'), tcStr);
              end;

              DataEnvioLote := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('DataEnvioLote'), tcDatHor);
              QtdNotasProcessadas := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('QtdNotasProcessadas'), tcInt);
              TempoProcessamento := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('TempoProcessamento'), tcInt);
              ValorTotalServico := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('ValorTotalServico'), tcDe2);
            end;
            }
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse);
var
  LErro: TNFSeEventoCollectionItem;
  Emitente: TEmitenteConfNFSe;
  LNameSpace, LCNPJCPF, LDoc: string;
begin
  if EstaVazio(Response.NumeroLote) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod111;
    LErro.Descricao := ACBrStr(Desc111);
    Exit;
  end;

  Emitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if EstaVazio(ConfigMsgDados.ConsultarLote.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.ConsultarLote.xmlns + '"';

  LDoc := OnlyNumber(Emitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  Response.ArquivoEnvio := '<PedidoConsultaLote' + LNameSpace + '>' +
                             '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                               '<CPFCNPJRemetente>' +
                                 LCNPJCPF +
                               '</CPFCNPJRemetente>' +
                               '<NumeroLote>' + Response.NumeroLote + '</NumeroLote>' +
                             '</Cabecalho>' +
                           '</PedidoConsultaLote>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoConsultaLoteRps(
  Response: TNFSeConsultaLoteRpsResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
  LNodeArray: TACBrXmlNodeArray;
  i: Integer;
  LNumRps, LNumNFSe: string;
  LNota: TNotaFiscal;
begin
  LDocument := TACBrXmlDocument.Create;
  try
    LNumRps := '';
    LNumNFSe := '';


    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);
        end;
      end;

      LNodeArray := LNode.Childrens.FindAllAnyNs('NFe');
      if not Assigned(LNodeArray) then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod203;
        LErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for i := Low(LNodeArray) to High(LNodeArray) do
      begin
        LNode := LNodeArray[i];

        LNumRps := LerChaveRPS(LNode);
        LNumNFSe := LerChaveNFe(LNode);

        LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(LNumNFSe);

        if LNota = nil then
          LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(LNumRps);

        LNota := CarregarXmlNfse(LNota, LNode.OuterXml);
        SalvarXmlNfse(LNota);
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNameSpace, LCNPJCPF, LDoc: string;
begin
  if EstaVazio(Response.NumeroRps) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod102;
    LErro.Descricao := ACBrStr(Desc102);
    Exit;
  end;

  if EstaVazio(Response.SerieRps) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod103;
    LErro.Descricao := ACBrStr(Desc103);
    Exit;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if EstaVazio(ConfigMsgDados.ConsultarNFSeRps.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSeRps.xmlns + '"';

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  Response.ArquivoEnvio := '<PedidoConsultaNFe' + LNameSpace + '>' +
                             '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                               '<CPFCNPJRemetente>' +
                                 LCNPJCPF +
                               '</CPFCNPJRemetente>' +
                             '</Cabecalho>' +
                             '<Detalhe xmlns="">' +
                               '<ChaveRPS>' +
                                 '<InscricaoPrestador>' +
                                   OnlyNumber(LEmitente.InscMun) +
                                 '</InscricaoPrestador>' +
                                 '<SerieRPS>' + Response.SerieRps + '</SerieRPS>' +
                                 '<NumeroRPS>' + Response.NumeroRps + '</NumeroRPS>' +
                               '</ChaveRPS>' +
                             '</Detalhe>' +
                           '</PedidoConsultaNFe>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoConsultaNFSeporRps(
  Response: TNFSeConsultaNFSeporRpsResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
  LNodeArray: TACBrXmlNodeArray;
  i: Integer;
  LNumRps, LNumNFSe: string;
  LNota: TNotaFiscal;
begin
  LDocument := TACBrXmlDocument.Create;
  try
    LNumRps := '';
    LNumNFSe := '';


    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);
        end;
      end;

      LNodeArray := LNode.Childrens.FindAllAnyNs('NFe');
      if not Assigned(LNodeArray) then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod203;
        LErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for i := Low(LNodeArray) to High(LNodeArray) do
      begin
        LNode := LNodeArray[i];

        LNumRps := LerChaveRPS(LNode);
        LNumNFSe := LerChaveNFe(LNode);

        LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(LNumNFSe);

        if LNota = nil then
          LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(LNumRps);

        LNota := CarregarXmlNfse(LNota, LNode.OuterXml);
        SalvarXmlNfse(LNota);
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararConsultaNFSe(
  Response: TNFSeConsultaNFSeResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNameSpace, LCNPJCPF, LDoc: string;
begin
  case Response.InfConsultaNFSe.tpConsulta of
    tcServicoPrestado:
      begin
        PrepararConsultaNFSeServicoPrestado(Response);
        exit;
      end;

    tcServicoTomado:
      begin
        PrepararConsultaNFSeServicoTomado(Response);
        exit;
      end;
  end;

  if EstaVazio(Response.InfConsultaNFSe.NumeroIniNFSe) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod108;
    LErro.Descricao := ACBrStr(Desc108);
    Exit;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  Response.Metodo := tmConsultarNFSe;

  if EstaVazio(ConfigMsgDados.ConsultarNFSe.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSe.xmlns + '"';

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  Response.ArquivoEnvio := '<PedidoConsultaNFe' + LNameSpace + '>' +
                             '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                               '<CPFCNPJRemetente>' +
                                 LCNPJCPF +
                               '</CPFCNPJRemetente>' +
                             '</Cabecalho>' +
                             '<Detalhe xmlns="">' +
                               '<ChaveNFe>' +
                                 '<InscricaoPrestador>' +
                                   OnlyNumber(LEmitente.InscMun) +
                                 '</InscricaoPrestador>' +
                                 '<NumeroNFe>' +
                                   Response.InfConsultaNFSe.NumeroIniNFSe +
                                 '</NumeroNFe>' +
                               '</ChaveNFe>' +
                             '</Detalhe>' +
                           '</PedidoConsultaNFe>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoConsultaNFSe(
  Response: TNFSeConsultaNFSeResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
  LNodeArray: TACBrXmlNodeArray;
  i: Integer;
  LNumRps, LNumNFSe: string;
  LNota: TNotaFiscal;
begin
  LDocument := TACBrXmlDocument.Create;
  LNumRps := '';
  LNumNFSe := '';

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);
        end;
      end;

      LNodeArray := LNode.Childrens.FindAllAnyNs('NFe');
      if not Assigned(LNodeArray) then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod203;
        LErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for i := Low(LNodeArray) to High(LNodeArray) do
      begin
        LNode := LNodeArray[i];

        LNumRps := LerChaveRPS(LNode);
        LNumNFSe := LerChaveNFe(LNode);

        LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(LNumNFSe);

        if LNota = nil then
          LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(LNumRps);

        LNota := CarregarXmlNfse(LNota, LNode.OuterXml);
        SalvarXmlNfse(LNota);
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNameSpace, LCNPJCPF, LDoc, LCNPJCPFPrestador, LDocPrestador: string;
begin
  if EstaVazio(Response.InfConsultaNFSe.CNPJPrestador) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod137;
    LErro.Descricao := ACBrStr(Desc137);
    Exit;
  end;

  if Response.InfConsultaNFSe.DataInicial = 0 then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod115;
    LErro.Descricao := ACBrStr(Desc115);
    Exit;
  end;

  if Response.InfConsultaNFSe.DataFinal = 0 then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod116;
    LErro.Descricao := ACBrStr(Desc116);
    Exit;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  Response.Metodo := tmConsultarNFSeServicoPrestado;

  if EstaVazio(ConfigMsgDados.ConsultarNFSe.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSe.xmlns + '"';

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  LDocPrestador := OnlyNumber(Response.InfConsultaNFSe.CNPJPrestador);

  if Length(LDocPrestador) = 14 then
    LCNPJCPFPrestador := '<CNPJ>' + LDocPrestador + '</CNPJ>'
  else
    LCNPJCPFPrestador := '<CPF>' + LDocPrestador + '</CPF>';

  Response.ArquivoEnvio := '<PedidoConsultaNFePeriodo' + LNameSpace + '>' +
                              '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                                '<CPFCNPJRemetente>' +
                                  LCNPJCPF +
                                '</CPFCNPJRemetente>' +
                                '<CPFCNPJ>' +
                                  LCNPJCPFPrestador +
                                '</CPFCNPJ>' +
                                '<dtInicio>' +
                                  FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataInicial) +
                                '</dtInicio>' +
                                '<dtFim>' +
                                  FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataFinal) +
                                '</dtFim>' +
                                '<NumeroPagina>' +
                                  IntToStr(Response.InfConsultaNFSe.Pagina) +
                                '</NumeroPagina>' +
                              '</Cabecalho>' +
                           '</PedidoConsultaNFePeriodo>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoConsultaNFSeServicoPrestado(
  Response: TNFSeConsultaNFSeResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
  LNodeArray: TACBrXmlNodeArray;
  i: Integer;
  LNumRps, LNumNFSe: string;
  LNota: TNotaFiscal;
begin
  LDocument := TACBrXmlDocument.Create;
  LNumRps := '';
  LNumNFSe := '';

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);
        end;
      end;

      LNodeArray := LNode.Childrens.FindAllAnyNs('NFe');
      if not Assigned(LNodeArray) then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod203;
        LErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for i := Low(LNodeArray) to High(LNodeArray) do
      begin
        LNode := LNodeArray[i];

        LNumRps := LerChaveRPS(LNode);
        LNumNFSe := LerChaveNFe(LNode);

        LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(LNumNFSe);

        if LNota = nil then
          LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(LNumRps);

        LNota := CarregarXmlNfse(LNota, LNode.OuterXml);
        SalvarXmlNfse(LNota);
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNameSpace, LCNPJCPF, LDoc, LCNPJCPFTomador, LDocTomador: string;
begin
  if EstaVazio(Response.InfConsultaNFSe.CNPJTomador) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod127;
    LErro.Descricao := ACBrStr(Desc127);
    Exit;
  end;

  if Response.InfConsultaNFSe.DataInicial = 0 then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod115;
    LErro.Descricao := ACBrStr(Desc115);
    Exit;
  end;

  if Response.InfConsultaNFSe.DataFinal = 0 then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod116;
    LErro.Descricao := ACBrStr(Desc116);
    Exit;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  Response.Metodo := tmConsultarNFSeServicoTomado;

  if EstaVazio(ConfigMsgDados.ConsultarNFSe.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.ConsultarNFSe.xmlns + '"';

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  LDocTomador := OnlyNumber(Response.InfConsultaNFSe.CNPJTomador);

  if Length(LDocTomador) = 14 then
    LCNPJCPFTomador := '<CNPJ>' + LDocTomador + '</CNPJ>'
  else
    LCNPJCPFTomador := '<CPF>' + LDocTomador + '</CPF>';

  Response.ArquivoEnvio := '<PedidoConsultaNFePeriodo' + LNameSpace + '>' +
                              '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                                '<CPFCNPJRemetente>' +
                                  LCNPJCPF +
                                '</CPFCNPJRemetente>' +
                                '<CPFCNPJ>' +
                                  LCNPJCPFTomador +
                                '</CPFCNPJ>' +
                                '<dtInicio>' +
                                  FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataInicial) +
                                '</dtInicio>' +
                                '<dtFim>' +
                                  FormatDateTime('yyyy-mm-dd', Response.InfConsultaNFSe.DataFinal) +
                                '</dtFim>' +
                                '<NumeroPagina>' +
                                  IntToStr(Response.InfConsultaNFSe.Pagina) +
                                '</NumeroPagina>' +
                              '</Cabecalho>' +
                           '</PedidoConsultaNFePeriodo>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoConsultaNFSeServicoTomado(
  Response: TNFSeConsultaNFSeResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
  LNodeArray: TACBrXmlNodeArray;
  i: Integer;
  LNumRps, LNumNFSe: string;
  LNota: TNotaFiscal;
begin
  LDocument := TACBrXmlDocument.Create;
  LNumRps := '';
  LNumNFSe := '';

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);
        end;
      end;

      LNodeArray := LNode.Childrens.FindAllAnyNs('NFe');
      if not Assigned(LNodeArray) then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod203;
        LErro.Descricao := ACBrStr(Desc203);
        Exit;
      end;

      for i := Low(LNodeArray) to High(LNodeArray) do
      begin
        LNode := LNodeArray[i];

        LNumRps := LerChaveRPS(LNode);
        LNumNFSe := LerChaveNFe(LNode);

        LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByNFSe(LNumNFSe);

        if LNota = nil then
          LNota := TACBrNFSeX(FAOwner).NotasFiscais.FindByRps(LNumRps);

        LNota := CarregarXmlNfse(LNota, LNode.OuterXml);
        SalvarXmlNfse(LNota);
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

procedure TACBrNFSeProviderISSSaoPaulo.PrepararCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse);
var
  LErro: TNFSeEventoCollectionItem;
  LEmitente: TEmitenteConfNFSe;
  LNameSpace, LAssinatura, LInscMun, LNumeroNFSe, LCNPJCPF, LDoc: string;
begin
  if EstaVazio(Response.InfCancelamento.NumeroNFSe) then
  begin
    LErro := Response.Erros.New;
    LErro.Codigo := Cod108;
    LErro.Descricao := ACBrStr(Desc108);
    Exit;
  end;

  LEmitente := TACBrNFSeX(FAOwner).Configuracoes.Geral.Emitente;

  if EstaVazio(ConfigMsgDados.CancelarNFSe.xmlns) then
    LNameSpace := ''
  else
    LNameSpace := ' xmlns="' + ConfigMsgDados.CancelarNFSe.xmlns + '"';

  {
    Tag <transacao>
    Informe se as NFS-e a serem canceladas farão parte de uma mesma transação.

    True - As NFS-e só serão canceladas se não ocorrer nenhum evento de erro
           durante o processamento de todo o lote;

    False - As NFS-e aptas a serem canceladas serão canceladas, mesmo que
            ocorram eventos de erro durante processamento do cancelamento de
            outras NFS-e deste lote.
  }

  LInscMun := OnlyNumber(LEmitente.InscMun);
  LNumeroNFSe := OnlyNumber(Response.InfCancelamento.NumeroNFSe);

  LAssinatura := Poem_Zeros(LInscMun, 8) + Poem_Zeros(LNumeroNFSe, 12);

  LAssinatura := string(TACBrNFSeX(FAOwner).SSL.CalcHash(AnsiString(LAssinatura),
                                                    dgstSHA1, outBase64, True));

  LDoc := OnlyNumber(LEmitente.CNPJ);

  if Length(LDoc) = 14 then
    LCNPJCPF := '<CNPJ>' + LDoc + '</CNPJ>'
  else
    LCNPJCPF := '<CPF>' + LDoc + '</CPF>';

  Response.ArquivoEnvio := '<PedidoCancelamentoNFe' + LNameSpace + '>' +
                             '<Cabecalho xmlns="" Versao="' + FPVersaoDFe + '">' +
                               '<CPFCNPJRemetente>' +
                                 LCNPJCPF +
                               '</CPFCNPJRemetente>' +
                               '<transacao>false</transacao>' +
                             '</Cabecalho>' +
                             '<Detalhe xmlns="">' +
                               '<ChaveNFe>' +
                                 '<InscricaoPrestador>' +
                                   LInscMun +
                                 '</InscricaoPrestador>' +
                                 '<NumeroNFe>' + LNumeroNFSe + '</NumeroNFe>' +
                               '</ChaveNFe>' +
                               '<AssinaturaCancelamento>' +
                                 LAssinatura +
                               '</AssinaturaCancelamento>' +
                             '</Detalhe>' +
                           '</PedidoCancelamentoNFe>';
end;

procedure TACBrNFSeProviderISSSaoPaulo.TratarRetornoCancelaNFSe(
  Response: TNFSeCancelaNFSeResponse);
var
  LDocument: TACBrXmlDocument;
  LErro: TNFSeEventoCollectionItem;
  LNode, LAuxNode: TACBrXmlNode;
begin
  LDocument := TACBrXmlDocument.Create;

  try
    try
      if Response.ArquivoRetorno = '' then
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod201;
        LErro.Descricao := ACBrStr(Desc201);
        Exit
      end;

      LDocument.LoadFromXml(Response.ArquivoRetorno);

      LNode := LDocument.Root;

      ProcessarMensagemErros(LNode, Response);

      Response.Sucesso := (Response.Erros.Count = 0);

      LAuxNode := LNode.Childrens.FindAnyNs('Cabecalho');

      if LAuxNode <> nil then
      begin
        with Response do
        begin
          Situacao := ObterConteudoTag(LAuxNode.Childrens.FindAnyNs('Sucesso'), tcStr);
        end;
      end;
    except
      on E: Exception do
      begin
        LErro := Response.Erros.New;
        LErro.Codigo := Cod999;
        LErro.Descricao := ACBrStr(Desc999 + E.Message);
      end;
    end;
  finally
    FreeAndNil(LDocument);
  end;
end;

{ TACBrNFSeXWebserviceISSSaoPaulo }

function TACBrNFSeXWebserviceISSSaoPaulo.Recepcionar(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:EnvioLoteRPSRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:EnvioLoteRPSRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/envioLoteRPS', LRequest,
                     ['RetornoXML', 'RetornoEnvioLoteRPS'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.GerarNFSe(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:EnvioRPSRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:EnvioRPSRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/envioRPS', LRequest,
                     ['RetornoXML', 'RetornoEnvioRPS'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.TesteEnvio(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:TesteEnvioLoteRPSRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:TesteEnvioLoteRPSRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/testeenvio', LRequest,
                     ['RetornoXML', 'RetornoEnvioLoteRPS'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.ConsultarSituacao(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:ConsultaInformacoesLoteRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:ConsultaInformacoesLoteRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/consultaInformacoesLote', LRequest,
                     ['RetornoXML', 'RetornoInformacoesLote'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.ConsultarLote(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:ConsultaLoteRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:ConsultaLoteRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/consultaLote', LRequest,
                     ['RetornoXML', 'RetornoConsulta'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.ConsultarNFSePorRps(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:ConsultaNFeRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:ConsultaNFeRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/consultaNFe', LRequest,
                     ['RetornoXML', 'RetornoConsulta'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.ConsultarNFSe(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:ConsultaNFeRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:ConsultaNFeRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/consultaNFe', LRequest,
                     ['RetornoXML', 'RetornoConsulta'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.ConsultarNFSeServicoPrestado(
  const ACabecalho, AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:ConsultaNFeEmitidasRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:ConsultaNFeEmitidasRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/consultaNFeEmitidas', LRequest,
                     ['RetornoXML', 'RetornoConsulta'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.ConsultarNFSeServicoTomado(
  const ACabecalho, AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:ConsultaNFeRecebidasRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:ConsultaNFeRecebidasRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/consultaNFeRecebidas', LRequest,
                     ['RetornoXML', 'RetornoConsulta'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.Cancelar(const ACabecalho,
  AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:CancelamentoNFeRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:CancelamentoNFeRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/cancelamentoNFe', LRequest,
                     ['RetornoXML', 'RetornoCancelamentoNFe'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.RecepcionarSincrono(
  const ACabecalho, AMSG: string): string;
var
  LRequest: string;
begin
  FPMsgOrig := AMSG;

  LRequest := '<nfe:EnvioLoteRPSRequest>';
  LRequest := LRequest + '<nfe:VersaoSchema>' + ACabecalho + '</nfe:VersaoSchema>';
  LRequest := LRequest + '<nfe:MensagemXML>' + XmlToStr(AMSG) + '</nfe:MensagemXML>';
  LRequest := LRequest + '</nfe:EnvioLoteRPSRequest>';

  Result := Executar('http://www.prefeitura.sp.gov.br/nfe/ws/envioLoteRPS', LRequest,
                     ['RetornoXML', 'RetornoEnvioLoteRPS'],
                     ['xmlns:nfe="http://www.prefeitura.sp.gov.br/nfe"']);
end;

function TACBrNFSeXWebserviceISSSaoPaulo.TratarXmlRetornado(
  const aXML: string): string;
begin
  Result := inherited TratarXmlRetornado(aXML);

  Result := ParseText(Result);
  Result := RemoverDeclaracaoXML(Result);
end;

end.
