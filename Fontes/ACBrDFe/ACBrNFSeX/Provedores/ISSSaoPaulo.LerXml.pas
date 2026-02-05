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

unit ISSSaoPaulo.LerXml;

interface

uses
  SysUtils,
  Classes,
  StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXLerXml;

type
  { TNFSeR_ISSSaoPaulo }

  TNFSeR_ISSSaoPaulo = class(TNFSeRClass)
  protected

    procedure LerChaveNFe(const ANode: TACBrXmlNode);
    procedure LerChaveRPS(const ANode: TACBrXmlNode);
    procedure LerCPFCNPJPrestador(const ANode: TACBrXmlNode);
    procedure LerEnderecoPrestador(const ANode: TACBrXmlNode);
    procedure LerCPFCNPJTomador(const ANode: TACBrXmlNode);
    procedure LerEnderecoTomador(const ANode: TACBrXmlNode);
    procedure LerCPFCNPJIntermediario(const ANode: TACBrXmlNode);
  public
    function LerXml: Boolean; override;
    function LerXmlRps(const ANode: TACBrXmlNode): Boolean;
    function LerXmlNfse(const ANode: TACBrXmlNode): Boolean;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings;

//==============================================================================
// Essa unit tem por finalidade exclusiva ler o XML do provedor:
//     ISSSaoPaulo
//==============================================================================

{ TNFSeR_ISSSaoPaulo }

procedure TNFSeR_ISSSaoPaulo.LerChaveNFe(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  LNode := ANode.Childrens.FindAnyNs('ChaveNFe');

  if LNode <> nil then
  begin
    NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal := ObterConteudo(LNode.Childrens.FindAnyNs('InscricaoPrestador'), tcStr);

    NFSe.Numero := ObterConteudo(LNode.Childrens.FindAnyNs('NumeroNFe'), tcStr);
    NFSe.CodigoVerificacao := ObterConteudo(LNode.Childrens.FindAnyNs('CodigoVerificacao'), tcStr);
  end;
end;

procedure TNFSeR_ISSSaoPaulo.LerChaveRPS(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  LNode := ANode.Childrens.FindAnyNs('ChaveRPS');

  if LNode <> nil then
  begin
    NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal := ObterConteudo(LNode.Childrens.FindAnyNs('InscricaoPrestador'), tcStr);

    NFSe.IdentificacaoRps.Numero := ObterConteudo(LNode.Childrens.FindAnyNs('NumeroRPS'), tcStr);
    NFSe.IdentificacaoRps.Serie := ObterConteudo(LNode.Childrens.FindAnyNs('SerieRPS'), tcStr);
    NFSe.IdentificacaoRps.Tipo := trRPS;

    if NFSe.InfID.ID = '' then
      NFSe.InfID.ID := OnlyNumber(NFSe.IdentificacaoRps.Numero) +
                       NFSe.IdentificacaoRps.Serie;
  end;
end;

procedure TNFSeR_ISSSaoPaulo.LerCPFCNPJIntermediario(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  LNode := ANode.Childrens.FindAnyNs('CPFCNPJIntermediario');

  if LNode <> nil then
  begin
    NFSe.Intermediario.Identificacao.CpfCnpj := ObterConteudo(LNode.Childrens.FindAnyNs('CNPJ'), tcStr);

    if NFSe.Intermediario.Identificacao.CpfCnpj = '' then
      NFSe.Intermediario.Identificacao.CpfCnpj := ObterConteudo(LNode.Childrens.FindAnyNs('CPF'), tcStr);
  end;
end;

procedure TNFSeR_ISSSaoPaulo.LerCPFCNPJPrestador(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  LNode := ANode.Childrens.FindAnyNs('CPFCNPJPrestador');

  if LNode <> nil then
  begin
    NFSe.Prestador.IdentificacaoPrestador.CpfCnpj := ObterConteudo(LNode.Childrens.FindAnyNs('CNPJ'), tcStr);

    if NFSe.Prestador.IdentificacaoPrestador.CpfCnpj = '' then
      NFSe.Prestador.IdentificacaoPrestador.CpfCnpj := ObterConteudo(LNode.Childrens.FindAnyNs('CPF'), tcStr);
  end;
end;

procedure TNFSeR_ISSSaoPaulo.LerCPFCNPJTomador(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  LNode := ANode.Childrens.FindAnyNs('CPFCNPJTomador');

  if LNode <> nil then
    NFSe.Tomador.IdentificacaoTomador.CpfCnpj := ObterCNPJCPF(LNode);
end;

procedure TNFSeR_ISSSaoPaulo.LerEnderecoPrestador(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
  LUF: string;
begin
  LNode := ANode.Childrens.FindAnyNs('EnderecoPrestador');

  if LNode <> nil then
  begin
    NFSe.Prestador.Endereco.TipoLogradouro  := ObterConteudo(LNode.Childrens.FindAnyNs('TipoLogradouro'), tcStr);
    NFSe.Prestador.Endereco.Endereco := ObterConteudo(LNode.Childrens.FindAnyNs('Logradouro'), tcStr);
    NFSe.Prestador.Endereco.Numero := ObterConteudo(LNode.Childrens.FindAnyNs('NumeroEndereco'), tcStr);
    NFSe.Prestador.Endereco.Complemento := ObterConteudo(LNode.Childrens.FindAnyNs('ComplementoEndereco'), tcStr);
    NFSe.Prestador.Endereco.Bairro := ObterConteudo(LNode.Childrens.FindAnyNs('Bairro'), tcStr);
    NFSe.Prestador.Endereco.CodigoMunicipio := ObterConteudo(LNode.Childrens.FindAnyNs('Cidade'), tcStr);
    NFSe.Prestador.Endereco.UF := ObterConteudo(LNode.Childrens.FindAnyNs('UF'), tcStr);
    NFSe.Prestador.Endereco.CEP := ObterConteudo(LNode.Childrens.FindAnyNs('CEP'), tcStr);
    NFSe.Prestador.Endereco.xMunicipio := ObterNomeMunicipioUF(StrToIntDef(NFSe.Prestador.Endereco.CodigoMunicipio, 0), LUF);

    if NFSe.Prestador.Endereco.UF = '' then
      NFSe.Prestador.Endereco.UF := LUF;
  end;
end;

procedure TNFSeR_ISSSaoPaulo.LerEnderecoTomador(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
  LUF: string;
begin
  LNode := ANode.Childrens.FindAnyNs('EnderecoTomador');

  if LNode <> nil then
  begin
    NFSe.Tomador.Endereco.TipoLogradouro  := ObterConteudo(LNode.Childrens.FindAnyNs('TipoLogradouro'), tcStr);
    NFSe.Tomador.Endereco.Endereco := ObterConteudo(LNode.Childrens.FindAnyNs('Logradouro'), tcStr);
    NFSe.Tomador.Endereco.Numero := ObterConteudo(LNode.Childrens.FindAnyNs('NumeroEndereco'), tcStr);
    NFSe.Tomador.Endereco.Complemento := ObterConteudo(LNode.Childrens.FindAnyNs('ComplementoEndereco'), tcStr);
    NFSe.Tomador.Endereco.Bairro := ObterConteudo(LNode.Childrens.FindAnyNs('Bairro'), tcStr);
    NFSe.Tomador.Endereco.CodigoMunicipio := ObterConteudo(LNode.Childrens.FindAnyNs('Cidade'), tcStr);
    NFSe.Tomador.Endereco.UF := ObterConteudo(LNode.Childrens.FindAnyNs('UF'), tcStr);
    NFSe.Tomador.Endereco.CEP := ObterConteudo(LNode.Childrens.FindAnyNs('CEP'), tcStr);
    NFSe.Tomador.Endereco.xMunicipio := ObterNomeMunicipioUF(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0), LUF);

    if NFSe.Tomador.Endereco.UF = '' then
      NFSe.Tomador.Endereco.UF := LUF;
  end;
end;

function TNFSeR_ISSSaoPaulo.LerXml: Boolean;
var
  LNode: TACBrXmlNode;
begin
  FpQuebradeLinha := FpAOwner.ConfigGeral.QuebradeLinha;

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo xml não carregado.');

  LerParamsTabIni(True);

  Arquivo := NormatizarXml(Arquivo);

  if FDocument = nil then
    FDocument := TACBrXmlDocument.Create();
  try
    Document.Clear();
    Document.LoadFromXml(Arquivo);

    if (Pos('NFe', Arquivo) > 0) then
      tpXML := txmlNFSe
    else
      tpXML := txmlRPS;

    LNode := Document.Root;

    if LNode = nil then
      raise Exception.Create('Arquivo xml vazio.');

    NFSe.tpXML := tpXml;

    if tpXML = txmlNFSe then
      Result := LerXmlNfse(LNode)
    else
      Result := LerXmlRps(LNode);
  finally
    FreeAndNil(FDocument);
  end;
end;

function TNFSeR_ISSSaoPaulo.LerXmlNfse(const ANode: TACBrXmlNode): Boolean;
var
  LValor: string;
  LOk :Boolean;
begin
  Result := True;

  if not Assigned(ANode) then Exit;

  NFSe.dhRecebimento := Now;
  NFSe.SituacaoNfse := snNormal;
  NFSe.NumeroLote := ObterConteudo(ANode.Childrens.FindAnyNs('NumeroLote'), tcStr);
  NFSe.DataEmissao := ObterConteudo(ANode.Childrens.FindAnyNs('DataEmissaoNFe'), tcDatHor);
  NFSe.DataEmissaoRps := ObterConteudo(ANode.Childrens.FindAnyNs('DataEmissaoRPS'), tcDat);
  NFSe.Competencia := NFSe.DataEmissao;

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('StatusNFe'), tcStr);

  if LValor = 'C' then
  begin
    NFSe.SituacaoNfse := snCancelado;
    NFSe.NfseCancelamento.DataHora := ObterConteudo(ANode.Childrens.FindAnyNs('DataCancelamento'), tcDat);
  end;

  NFSe.TipoTributacaoRPS := FpAOwner.StrToTipoTributacaoRPS(LOk, ObterConteudo(ANode.Childrens.FindAnyNs('TributacaoNFe'), tcStr));

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('OpcaoSimples'), tcStr);

  if LValor = '0' then
    NFSe.OptanteSimplesNacional := snNao
  else
    NFSe.OptanteSimplesNacional := snSim;

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('CodigoServico'), tcStr);

  NFSe.Servico.ItemListaServico := NormatizarItemListaServico(LValor);
  NFSe.Servico.xItemListaServico := ItemListaServicoDescricao(NFSe.Servico.ItemListaServico);
  NFSe.Servico.ItemListaServico := '0' + NFSe.Servico.ItemListaServico;

  NFSe.Servico.Discriminacao := ObterConteudo(ANode.Childrens.FindAnyNs('Discriminacao'), tcStr);
  NFSe.Servico.Discriminacao := StringReplace(NFSe.Servico.Discriminacao, FpQuebradeLinha,
                                                    sLineBreak, [rfReplaceAll]);

  VerificarSeConteudoEhLista(NFSe.Servico.Discriminacao);

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('ISSRetido'), tcStr);

  NFSe.Servico.Valores.ValorServicos := ObterConteudo(ANode.Childrens.FindAnyNs('ValorServicos'), tcDe2);
  NFSe.Servico.Valores.BaseCalculo := ObterConteudo(ANode.Childrens.FindAnyNs('ValorServicos'), tcDe2);
  NFSe.Servico.Valores.Aliquota := ObterConteudo(ANode.Childrens.FindAnyNs('AliquotaServicos'), tcDe2);
  NFSe.Servico.Valores.Aliquota := (NFSe.Servico.Valores.Aliquota * 100);
  NFSe.Servico.Valores.ValorIss := ObterConteudo(ANode.Childrens.FindAnyNs('ValorISS'), tcDe2);
  NFSe.Servico.Valores.ValorPis := ObterConteudo(ANode.Childrens.FindAnyNs('ValorPIS'), tcDe2);
  NFSe.Servico.Valores.ValorCofins := ObterConteudo(ANode.Childrens.FindAnyNs('ValorCOFINS'), tcDe2);
  NFSe.Servico.Valores.ValorInss := ObterConteudo(ANode.Childrens.FindAnyNs('ValorINSS'), tcDe2);
  NFSe.Servico.Valores.ValorIr := ObterConteudo(ANode.Childrens.FindAnyNs('ValorIR'), tcDe2);
  NFSe.Servico.Valores.ValorCsll := ObterConteudo(ANode.Childrens.FindAnyNs('ValorCSLL'), tcDe2);

  if LValor = 'false' then
    NFSe.Servico.Valores.IssRetido := stNormal
  else
    NFSe.Servico.Valores.IssRetido := stRetencao;

  NFSe.Servico.Valores.RetencoesFederais := NFSe.Servico.Valores.ValorPis +
                            NFSe.Servico.Valores.ValorCofins +
                            NFSe.Servico.Valores.ValorInss +
                            NFSe.Servico.Valores.ValorIr +
                            NFSe.Servico.Valores.ValorCsll;

  NFSe.Servico.Valores.ValorLiquidoNfse := NFSe.Servico.Valores.ValorServicos -
                      (NFSe.Servico.Valores.RetencoesFederais +
                      NFSe.Servico.Valores.ValorDeducoes +
                      NFSe.Servico.Valores.ValorIssRetido +
                      NFSe.Servico.Valores.DescontoCondicionado +
                      NFSe.Servico.Valores.DescontoIncondicionado);

  NFSe.Servico.Valores.ValorTotalNotaFiscal := NFSe.Servico.Valores.ValorServicos -
                          NFSe.Servico.Valores.DescontoCondicionado -
                          NFSe.Servico.Valores.DescontoIncondicionado;


  NFSe.ValoresNfse.ValorLiquidoNfse := NFSe.Servico.Valores.ValorLiquidoNfse;
  NFSe.ValoresNfse.BaseCalculo := NFSe.Servico.Valores.BaseCalculo;
  NFSe.ValoresNfse.Aliquota := NFSe.Servico.Valores.Aliquota;
  NFSe.ValoresNfse.ValorIss := NFSe.Servico.Valores.ValorIss;
//    NFSe.ValoresNfse.Aliquota := (NFSe.ValoresNfse.Aliquota * 100);

  NFSe.Prestador.RazaoSocial := ObterConteudo(ANode.Childrens.FindAnyNs('RazaoSocialPrestador'), tcStr);
  NFSe.Prestador.Contato.Email := ObterConteudo(ANode.Childrens.FindAnyNs('EmailPrestador'), tcStr);

  NFSe.Tomador.RazaoSocial := ObterConteudo(ANode.Childrens.FindAnyNs('RazaoSocialTomador'), tcStr);
  NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := ObterConteudo(ANode.Childrens.FindAnyNs('InscricaoMunicipalTomador'), tcStr);
  NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual := ObterConteudo(ANode.Childrens.FindAnyNs('InscricaoEstadualTomador'), tcStr);
  NFSe.Tomador.Contato.Email := ObterConteudo(ANode.Childrens.FindAnyNs('EmailTomador'), tcStr);

  LerChaveNFe(ANode);
  LerChaveRPS(ANode);
  LerCPFCNPJPrestador(ANode);
  LerEnderecoPrestador(ANode);
  LerCPFCNPJTomador(ANode);
  LerEnderecoTomador(ANode);

  {
   TipoTributacaoRPS = ttTribnoMun, ttTribforaMun, ttTribnoMunIsento,
                       ttTribforaMunIsento, ttTribnoMunImune, ttTribforaMunImune,
                       ttTribnoMunSuspensa, ttTribforaMunSuspensa, ttExpServicos,
                       ttSimplesNacional, ttRetidonoMun
  }

  if NFSe.TipoTributacaoRPS in [ttTribnoMun, ttTribnoMunIsento,
                                ttTribnoMunImune, ttTribnoMunSuspensa] then
    NFSe.Servico.MunicipioIncidencia := StrToIntDef(NFSe.Prestador.Endereco.CodigoMunicipio, 0)
  else
    NFSe.Servico.MunicipioIncidencia := StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0);

  NFSe.Servico.CodigoMunicipio := ObterConteudo(ANode.Childrens.FindAnyNs('MunicipioPrestacao'), tcStr);

  if NFSe.Servico.CodigoMunicipio = '' then
    NFSe.Servico.CodigoMunicipio := NFSe.Prestador.Endereco.CodigoMunicipio;

  NFSe.ConstrucaoCivil.nNumeroEncapsulamento := ObterConteudo(ANode.Childrens.FindAnyNs('NumeroEncapsulamento'), tcStr);
  NFSe.Servico.ValorTotalRecebido := ObterConteudo(ANode.Childrens.FindAnyNs('ValorTotalRecebido'), tcDe2);

  LerCampoLink;
end;

function TNFSeR_ISSSaoPaulo.LerXmlRps(const ANode: TACBrXmlNode): Boolean;
var
  LValor: string;
  LOk: Boolean;
begin
  Result := True;

  NFSe.Assinatura := ObterConteudo(ANode.Childrens.FindAnyNs('Assinatura'), tcStr);
  NFSe.DataEmissao := ObterConteudo(ANode.Childrens.FindAnyNs('DataEmissao'), tcDat);

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('StatusRPS'), tcStr);

  if LValor = 'N' then
    NFSe.StatusRps := srNormal
  else
    NFSe.StatusRps := srCancelado;

  NFSe.TipoTributacaoRPS := FPAOwner.StrToTipoTributacaoRPS(LOk, ObterConteudo(ANode.Childrens.FindAnyNs('TributacaoNFe'), tcStr));

  LerChaveRPS(ANode);

  NFSe.Servico.ItemListaServico := ObterConteudo(ANode.Childrens.FindAnyNs('CodigoServico'), tcStr);
  NFSe.Servico.Discriminacao := ObterConteudo(ANode.Childrens.FindAnyNs('Discriminacao'), tcStr);
  NFSe.Servico.Discriminacao := StringReplace(NFSe.Servico.Discriminacao, FpQuebradeLinha,
                                                  sLineBreak, [rfReplaceAll]);

  VerificarSeConteudoEhLista(NFSe.Servico.Discriminacao);

  NFSe.ValorCargaTributaria := ObterConteudo(ANode.Childrens.FindAnyNs('ValorCargaTributaria'), tcDe2);
  NFSe.PercentualCargaTributaria := ObterConteudo(ANode.Childrens.FindAnyNs('PercentualCargaTributaria'), tcDe4);
  NFSe.Servico.FonteCargaTributaria := ObterConteudo(ANode.Childrens.FindAnyNs('FonteCargaTributaria'), tcStr);
  NFSe.Servico.MunicipioIncidencia := ObterConteudo(ANode.Childrens.FindAnyNs('MunicipioPrestacao'), tcInt);
  NFSe.Servico.ValorTotalRecebido := ObterConteudo(ANode.Childrens.FindAnyNs('ValorTotalRecebido'), tcDe2);

  NFSe.Servico.Valores.ValorServicos := ObterConteudo(ANode.Childrens.FindAnyNs('ValorServicos'), tcDe2);
  NFSe.Servico.Valores.ValorDeducoes := ObterConteudo(ANode.Childrens.FindAnyNs('ValorDeducoes'), tcDe2);
  NFSe.Servico.Valores.ValorPis := ObterConteudo(ANode.Childrens.FindAnyNs('ValorPIS'), tcDe2);
  NFSe.Servico.Valores.ValorCofins := ObterConteudo(ANode.Childrens.FindAnyNs('ValorCOFINS'), tcDe2);
  NFSe.Servico.Valores.ValorInss := ObterConteudo(ANode.Childrens.FindAnyNs('ValorINSS'), tcDe2);
  NFSe.Servico.Valores.ValorIr := ObterConteudo(ANode.Childrens.FindAnyNs('ValorIR'), tcDe2);
  NFSe.Servico.Valores.ValorCsll := ObterConteudo(ANode.Childrens.FindAnyNs('ValorCSLL'), tcDe2);
  NFSe.Servico.Valores.Aliquota := ObterConteudo(ANode.Childrens.FindAnyNs('AliquotaServicos'), tcDe4);

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('ISSRetido'), tcStr);

  if LValor = 'true' then
    NFSe.Servico.Valores.IssRetido := stRetencao
  else
    NFSe.Servico.Valores.IssRetido := stNormal;

  LerCPFCNPJTomador(ANode);

  NFSe.Tomador.RazaoSocial := ObterConteudo(ANode.Childrens.FindAnyNs('RazaoSocialTomador'), tcStr);

  NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := ObterConteudo(ANode.Childrens.FindAnyNs('InscricaoMunicipalTomador'), tcStr);
  NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual := ObterConteudo(ANode.Childrens.FindAnyNs('InscricaoEstadualTomador'), tcStr);

  NFSe.Tomador.Contato.Email := ObterConteudo(ANode.Childrens.FindAnyNs('EmailTomador'), tcStr);

  LerEnderecoTomador(ANode);
  LerCPFCNPJIntermediario(ANode);

  NFSe.Intermediario.Identificacao.InscricaoMunicipal := ObterConteudo(ANode.Childrens.FindAnyNs('InscricaoMunicipalIntermediario'), tcStr);
  NFSe.Intermediario.Contato.EMail := ObterConteudo(ANode.Childrens.FindAnyNs('EmailIntermediario'), tcStr);

  LValor := ObterConteudo(ANode.Childrens.FindAnyNs('ISSRetidoIntermediario'), tcStr);

  if LValor = 'true' then
    NFSe.Intermediario.IssRetido := stRetencao
  else
    NFSe.Intermediario.IssRetido := stNormal;

  NFSe.ConstrucaoCivil.nCei := ObterConteudo(ANode.Childrens.FindAnyNs('CodigoCEI'), tcStr);
  NFSe.ConstrucaoCivil.nMatri := ObterConteudo(ANode.Childrens.FindAnyNs('MatriculaObra'), tcStr);
  NFSe.ConstrucaoCivil.nNumeroEncapsulamento := ObterConteudo(ANode.Childrens.FindAnyNs('NumeroEncapsulamento'), tcStr);
end;

end.
