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

unit Centi.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrNFSeXGravarXml_ABRASFv2,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrXmlDocument,
  ACBrNFSeXConsts,
  ACBrUtil.Strings;

type
  { TNFSeW_Centi202 }

  TNFSeW_Centi202 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;
    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
    function GerarDadosObra: TACBrXmlNode;
    function GerarDadosImovel: TACBrXmlNode;
    function GerarPrestador: TACBrXmlNode; override;
    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
    function GerarCondicaoPagamento: TACBrXmlNode;
    function GerarParcelas: TACBrXmlNodeArray;
  end;

implementation

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     Centi
//==============================================================================

{ TNFSeW_Centi202 }

procedure TNFSeW_Centi202.Configuracao;
begin
  inherited Configuracao;

  GerarIDDeclaracao := False;

  FormatoEmissao := tcDatHor;
  FormatoCompetencia := tcDatHor;
  FormatoAliq := tcDe2;
  FormatoItemListaServico := filsSemFormatacaoSemZeroEsquerda;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoFormatarItemServico') then
    FormatoItemListaServico := filsSemFormatacao;

  NrOcorrCodTribMun_1 := 1;

  NrOcorrValorISS := -1;
  NrOcorrDescCond := -1;
  NrOcorrRespRetencao := -1;

  NrOcorrIssRetido := 0;
  NrOcorrExigibilidadeISS := -1;
  NrOcorrCodigoCNAE := -1;

  NrOcorrCompetencia := -1;
  NrOcorrOptanteSimplesNacional := -1;
  NrOcorrIncentCultural := -1;

  NrOcorrInscEstTomador_2 := 0;

  GerarIDDeclaracao := False;
  GerarIDRps := True;
end;

function TNFSeW_Centi202.GerarCondicaoPagamento: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Result := CreateElement('CondicaoPagamento');

  Result.AppendChild(AddNode(tcStr, '#1', 'Condicao', 1, 1, 1,
               FpAOwner.CondicaoPagToStr(NFSe.CondicaoPagamento.Condicao), ''));

  Result.AppendChild(AddNode(tcInt, '#54', 'QuantidadeParcela', 1, 03, 1,
                                 NFSe.CondicaoPagamento.QtdParcela, DSC_QPARC));

  nodeArray := GerarParcelas;
  if nodeArray <> nil then
  begin
    for i := 0 to Length(nodeArray) - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFSeW_Centi202.GerarParcelas: TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, NFSe.CondicaoPagamento.Parcelas.Count);

  for i := 0 to NFSe.CondicaoPagamento.Parcelas.Count - 1 do
  begin
    Result[i] := CreateElement('Parcela');

    Result[i].AppendChild(AddNode(tcStr, '#55', 'Parcela', 1, 03, 1,
                  NFSe.CondicaoPagamento.Parcelas.Items[i].Parcela, DSC_NPARC));

    Result[i].AppendChild(AddNode(tcDe2, '#57', 'Valor', 1, 18, 1,
                    NFSe.CondicaoPagamento.Parcelas.Items[i].Valor, DSC_VPARC));
  end;

  if NFSe.CondicaoPagamento.Parcelas.Count > 10 then
    wAlerta('#54', 'Parcela', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

function TNFSeW_Centi202.GerarDadosImovel: TACBrXmlNode;
begin
  Result := CreateElement('DadosImovel');

  Result.AppendChild(AddNode(tcStr, '#1', 'CibImovel', 1, 8, 0,
                                                  NFSe.IBSCBS.Imovel.cCIB, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CepImovel', 1, 8, 0,
                                             NFSe.IBSCBS.Imovel.ender.CEP, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'LogradouroImovel', 1, 255, 0,
                                            NFSe.IBSCBS.Imovel.ender.xLgr, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'NumeroImovel', 1, 60, 0,
                                             NFSe.IBSCBS.Imovel.ender.nro, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'BairroImovel', 1, 60, 0,
                                         NFSe.IBSCBS.Imovel.ender.xBairro, ''));
end;

function TNFSeW_Centi202.GerarDadosObra: TACBrXmlNode;
begin
  Result := CreateElement('DadosObra');

  Result.AppendChild(AddNode(tcStr, '#1', 'CnoObra', 1, 125, 0,
    NFSe.ConstrucaoCivil.CodigoObra, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CepObra', 8, 8, 1,
    NFSe.ConstrucaoCivil.Endereco.CEP, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'LogradouroObra', 1, 125, 1,
    NFSe.ConstrucaoCivil.Endereco.Endereco, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'NumeroObra', 1, 10, 1,
    NFSe.ConstrucaoCivil.Endereco.Numero, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'BairroObra', 1, 60, 1,
    NFSe.ConstrucaoCivil.Endereco.Bairro, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'ComplementoObra', 1, 60, 0,
    NFSe.ConstrucaoCivil.Endereco.Complemento, ''));
end;

function TNFSeW_Centi202.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
var
  aNameSpace: string;
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  aNameSpace := DefinirNameSpaceDeclaracao;

  Result := CreateElement('InfDeclaracaoPrestacaoServico');

  if aNameSpace <> '' then
    Result.SetNamespace(aNameSpace);

  DefinirIDDeclaracao;

  if (FpAOwner.ConfigGeral.Identificador <> '') and GerarIDDeclaracao then
    Result.SetAttribute(FpAOwner.ConfigGeral.Identificador, NFSe.infID.ID);

  Result.AppendChild(AddNode(tcStr, '#4', 'Id', 1, 15, NrOcorrID,
                                                            NFSe.infID.ID, ''));

  if (NFSe.IdentificacaoRps.Numero <> '') and GerarTagRps then
    Result.AppendChild(GerarRps);

  Result.AppendChild(AddNode(FormatoCompetencia, '#4', 'Competencia', 10, 10, 0,
                                                  NFSe.Competencia, DSC_DHEMI));

  Result.AppendChild(GerarServico);
  Result.AppendChild(GerarPrestador);
  Result.AppendChild(GerarTomador);
  Result.AppendChild(GerarIntermediarioServico);
  Result.AppendChild(GerarConstrucaoCivil);

  Result.AppendChild(AddNode(tcStr, '#6', 'RegimeEspecialTributacao', 1, 2, 0,
   FpAOwner.RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), DSC_REGISSQN));

  Result.AppendChild(AddNode(tcStr, '#7', 'OptanteSimplesNacional', 1, 1, 0,
               FpAOwner.SimNaoToStr(NFSe.OptanteSimplesNacional), DSC_INDOPSN));

  Result.AppendChild(AddNode(tcStr, '#8', 'IncentivoFiscal', 1, 1, 0,
              FpAOwner.SimNaoToStr(NFSe.IncentivadorCultural), DSC_INDINCCULT));

  if NFSe.CondicaoPagamento.Parcelas.Count > 0 then
    Result.AppendChild(GerarCondicaoPagamento);

  if NFSe.ConstrucaoCivil.CodigoObra <> '' then
    Result.AppendChild(GerarDadosObra);

  if NFSe.IBSCBS.Imovel.cCIB <> '' then
    Result.AppendChild(GerarDadosImovel);
end;

function TNFSeW_Centi202.GerarPrestador: TACBrXmlNode;
begin
  Result := CreateElement('Prestador');

  Result.AppendChild(GerarCPFCNPJ(NFSe.Prestador.IdentificacaoPrestador.CpfCnpj));

  if NFSe.ConstrucaoCivil.Endereco.CEP <> '' then
    Result.AppendChild(GerarDadosObra);

  Result.AppendChild(AddNode(tcStr, '#1', 'RazaoSocial', 1, 115, 0,
    NFSe.Prestador.RazaoSocial, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'InscricaoMunicipal', 1, 15, 0,
    NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal, ''));
end;

function TNFSeW_Centi202.GerarServico: TACBrXmlNode;
var
  item: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  {
    Os campos comentados não devem ser enviados segundo o Schema.
  }
//  Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, NrOcorrIssRetido,
//    FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

//  Result.AppendChild(AddNode(tcStr, '#21', 'ResponsavelRetencao', 1, 1, NrOcorrRespRetencao,
//   FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao), DSC_INDRESPRET));

  item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

  Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 8, 0,
                                                        item, DSC_CLISTSERV));

  Result.AppendChild(AddNode(tcStr, '#32', 'CodigoNbs', 12, 12, 0,
                            PadLeft(NFSe.Servico.CodigoNBS, 9, '0'), DSC_CMUN));

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoINDOP', 6, 6, 0,
                                                           NFSe.Servico.INDOP));

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoClassTrib', 6, 6, 0,
                                                      NFSe.Servico.cClassTrib));

  Result.AppendChild(AddNode(tcStr, '#31', 'CodigoTributacaoMunicipio', 1, 20, 1,
                   NFSe.Servico.CodigoTributacaoMunicipio, DSC_CSERVTRIBMUN));

  Result.AppendChild(AddNode(tcStr, '#32', 'Discriminacao', 1, 2000, 1,
    StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
             FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

  Result.AppendChild(AddNode(tcStr, '#33', 'CodigoMunicipio', 1, 7, 1,
                         OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN));

  Result.AppendChild(GerarCodigoPaisServico);

//  Result.AppendChild(AddNode(tcInt, '#36', 'ExigibilidadeISS',
//                             NrMinExigISS, NrMaxExigISS, NrOcorrExigibilidadeISS,
//  StrToInt(FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS)), DSC_INDISS));

  Result.AppendChild(AddNode(tcInt, '#37', 'MunicipioIncidencia', 7, 7, 0,
                              NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

  Result.AppendChild(AddNode(tcStr, '#38', 'NumeroProcesso', 1, 30, 0,
                                 NFSe.Servico.NumeroProcesso, DSC_NPROCESSO));
end;

function TNFSeW_Centi202.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
{
  Campos comentados não devem ser gerados conforme consta no Schema.
}
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
                         NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, 0,
                     NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, 0,
                               NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, 0,
                         NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

//  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, 0,
//                             NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, 0,
                               NFSe.Servico.Valores.ValorIR, DSC_VIR));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, 0,
                             NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(tcDe2, '#23', 'OutrasRetencoes', 1, 15, 0,
              NFSe.Servico.Valores.OutrasRetencoes, DSC_OUTRASRETENCOES));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorIss', 1, 15, 0,
                               NFSe.Servico.Valores.ValorIss, DSC_VISS));

  Aliquota := NormatizarAliquota(NFSe.Servico.Valores.Aliquota, DivAliq100);

  Result.AppendChild(AddNode(FormatoAliq, '#25', 'Aliquota', 1, 5, 1,
                                                          Aliquota, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#27', 'DescontoIncondicionado', 1, 15, 0,
          NFSe.Servico.Valores.DescontoIncondicionado, DSC_VDESCINCOND));

//  Result.AppendChild(AddNode(tcDe2, '#28', 'DescontoCondicionado', 1, 15, 0,
//              NFSe.Servico.Valores.DescontoCondicionado, DSC_VDESCCOND));

  if not (NFSe.Servico.Valores.tribFed.CST in [cstVazio, cst00, cst08, cst09]) then
  begin
    Result.AppendChild(AddNode(tcStr, '#', 'CstPisCofins', 2, 2, 0,
                          CSTToStr(NFSe.Servico.Valores.tribFed.CST), ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'TpRetPisCofins', 1, 1, 0,
          tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.tpRetPisCofins), ''));

    Result.AppendChild(AddNode(tcDe2, '#1', 'VlBcPisCofins', 1, 15, 0,
                                NFSe.Servico.Valores.tribFed.vBCPisCofins, ''));

    Result.AppendChild(AddNode(tcDe2, '#15', 'PAliqPis', 1, 15, 0,
                             NFSe.Servico.Valores.tribFed.pAliqPis, DSC_VALIQ));

    Result.AppendChild(AddNode(tcDe2, '#15', 'PAliqCofins', 1, 15, 0,
                          NFSe.Servico.Valores.tribFed.pAliqCofins, DSC_VALIQ));

    Result.AppendChild(AddNode(tcDe2, '#15', 'VlRetCSLL', 1, 15, 0,
                                    NFSe.Servico.Valores.tribFed.vRetCSLL, ''));

    Result.AppendChild(AddNode(tcDe2, '#17', 'VlINSS', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorInss, DSC_VINSS));
  end;
end;

end.
