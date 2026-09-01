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

unit ISSNet.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXClass,
  ACBrNFSeXGravarXml_ABRASFv1,
  ACBrNFSeXGravarXml_ABRASFv2,
  PadraoNacional.GravarXml;

type
  { TNFSeW_ISSNet }

  TNFSeW_ISSNet = class(TNFSeW_ABRASFv1)
  protected
    procedure Configuracao; override;

    function GerarPrestador: TACBrXmlNode; override;
    function GerarCodigoMunicipioUF: TACBrXmlNodeArray; override;
    function GerarServicoCodigoMunicipio: TACBrXmlNode; override;
  end;

  { TNFSeW_ISSNet204 }

  TNFSeW_ISSNet204 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

  public
    function GerarXml: Boolean; Override;
  end;

  { TNFSeW_ISSNetAPIPropria }

  TNFSeW_ISSNetAPIPropria = class(TNFSeW_PadraoNacional)
  protected
    function GerarXMLPrestador: TACBrXmlNode; override;

    function GerarXMLObra: TACBrXmlNode; override;
    function GerarXMLEnderecoObra: TACBrXmlNode;
    function GerarXMLEnderecoNacionalObra: TACBrXmlNode;
    function GerarXMLEnderecoExteriorObra: TACBrXmlNode; override;

    function GerarXMLAtividadeEvento: TACBrXmlNode; override;
    function GerarXMLEnderecoEvento: TACBrXmlNode; override;
    function GerarXMLEnderecoNacionalEvento: TACBrXmlNode;
    function GerarXMLEnderecoExteriorEvento: TACBrXmlNode; override;

    function GerarXMLImovel(Imovel: TDadosimovel): TACBrXmlNode; override;
    function GerarXMLEnderecoImovel(ender: TenderImovel): TACBrXmlNode;
    function GerarXMLEnderecoNacionalImovel(ender: TenderImovel): TACBrXmlNode; override;
    function GerarXMLEnderecoExteriorImovel(endExt: TendExt): TACBrXmlNode; override;

    function GerarXMLCodigoServico: TACBrXmlNode; override;

  public
    function GerarXml: Boolean; override;

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrUtil.Strings,
  ACBrNFSeXConsts,
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     ISSNet
//==============================================================================

{ TNFSeW_ISSNet }

procedure TNFSeW_ISSNet.Configuracao;
begin
  inherited Configuracao;

  FormatoItemListaServico := filsSemFormatacaoSemZeroEsquerda;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoFormatarItemServico') then
    FormatoItemListaServico := filsNaoSeAplica;

  DivAliq100 := True;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoDividir100') then
    DivAliq100 := False;

  NrOcorrValorPis := 1;
  NrOcorrValorCofins := 1;
  NrOcorrValorInss := 1;
  NrOcorrValorIr := 1;
  NrOcorrValorCsll := 1;
  NrOcorrValorIss := 1;
  NrOcorrAliquota := 1;

  PrefixoPadrao := 'tc';
end;

function TNFSeW_ISSNet.GerarPrestador: TACBrXmlNode;
begin
  Result := CreateElement('Prestador');

  Result.AppendChild(GerarCPFCNPJ(NFSe.Prestador.IdentificacaoPrestador.CpfCnpj));

  Result.AppendChild(AddNode(tcStr, '#35', 'InscricaoMunicipal', 1, 15, 0,
             NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal, DSC_IM));
end;

function TNFSeW_ISSNet.GerarCodigoMunicipioUF: TACBrXmlNodeArray;
begin
  SetLength(Result, 2);

  Result[0] := AddNode(tcStr, '#43', 'Cidade', 7, 7, 0,
                  OnlyNumber(NFSe.Tomador.Endereco.CodigoMunicipio), DSC_CMUN);

  Result[1] := AddNode(tcStr, '#44', 'Estado', 2, 2, 0,
                                             NFSe.Tomador.Endereco.UF, DSC_UF);
end;

function TNFSeW_ISSNet.GerarServicoCodigoMunicipio: TACBrXmlNode;
begin
  Result := AddNode(tcStr, '#33', 'MunicipioPrestacaoServico', 1, 7, 1,
                            OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN);
end;

{ TNFSeW_ISSNet204 }

procedure TNFSeW_ISSNet204.Configuracao;
begin
  inherited Configuracao;

  FormatoAliq := tcDe2;

  NrOcorrCodTribMun_1 := 0;
  NrOcorrInformacoesComplemetares := 0;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;

  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;
  NrOcorrCodigoPaisServico := -1;
  NrOcorrCodigoPaisTomador := -1;

  TagTomador := 'TomadorServico';
end;

function TNFSeW_ISSNet204.GerarXml: Boolean;
begin
  if ((NFSe.Tomador.Endereco.CodigoMunicipio = '9999999') or
      (NFSe.Tomador.Endereco.UF = 'EX')) and
     ((NFSe.Servico.ExigibilidadeISS = exiExportacao) or
     (NFSe.Servico.ExigibilidadeISS = exiExigivel)) then
    NrOcorrCodigoPaisServico := 1;

  if (NFSe.OptanteSimplesNacional = snSim) or
     (NFSe.RegimeEspecialTributacao = retMicroempresarioIndividual) then
  begin
    if FpAOwner.ConfigGeral.Params.TemParametro('TagAliquotaObrigSN') then
      NrOcorrAliquota := 1;

    if FpAOwner.ConfigGeral.Params.TemParametro('TagValorISSObrigSN') then
      NrOcorrValorIss := 1;
  end;

  Result := inherited GerarXml;
end;

{ TNFSeW_ISSNetAPIPropria }

function TNFSeW_ISSNetAPIPropria.GerarXml: Boolean;
var
  NFSeNode, xmlNode: TACBrXmlNode;
  chave, CodigoMun, CNPJ: string;
begin
  Configuracao;
  LerParamsTabIni(True);

  ListaDeAlertas.Clear;

  FDocument.Clear();

  FpVersao := VersaoNFSeToStr(VersaoNFSe);

  { Nas emissões para o Ambiente de Homologação, gerar a Chave do DPS
    com o Código do Município de Campo Grande - MS (Nota Control) }
//  CodigoMun := IfThen(FpAOwner.ConfigGeral.Ambiente = taProducao, IntToStr(CodMunEmit), '5002704');
  CodigoMun := IntToStr(CodMunEmit);
  CNPJ := CNPJEmitente;

  if CNPJ = '' then
    CNPJ := NFSe.Prestador.IdentificacaoPrestador.CpfCnpj;

  chave := GerarChaveDPS(CodigoMun,
                         CNPJ,
                         NFSe.IdentificacaoRps.Serie,
                         NFSe.IdentificacaoRps.Numero);

  NFSe.InfID.ID := 'DPS' + chave;

  NFSeNode := CreateElement('DPS');
  NFSeNode.SetAttribute('versao', FpVersao);
  NFSeNode.SetNamespace(FpAOwner.ConfigMsgDados.LoteRps.xmlns, Self.PrefixoPadrao);

  FDocument.Root := NFSeNode;

  xmlNode := GerarXMLInfDps;
  NFSeNode.AppendChild(xmlNode);

  Result := True;
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLAtividadeEvento: TACBrXmlNode;
begin
  Result := nil;

  if NFSe.Servico.Evento.xNome <> '' then
  begin
    Result := CreateElement('atvEvento');

    Result.AppendChild(AddNode(tcStr, '#1', 'xNome', 1, 255, 1,
                                                NFSe.Servico.Evento.xNome, ''));

    Result.AppendChild(AddNode(tcDat, '#1', 'dtIni', 10, 10, 1,
                                                NFSe.Servico.Evento.dtIni, ''));

    Result.AppendChild(AddNode(tcDat, '#1', 'dtFim', 10, 10, 1,
                                                NFSe.Servico.Evento.dtFim, ''));

    Result.AppendChild(GerarXMLEnderecoEvento);
  end;
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoEvento: TACBrXmlNode;
begin
  Result := CreateElement('end');

  if (NFSe.Servico.Evento.Endereco.UF = '') then
    Result.AppendChild(GerarXMLEnderecoNacionalEvento)
  else
    Result.AppendChild(GerarXMLEnderecoExteriorEvento);

  Result.AppendChild(AddNode(tcStr, '#1', 'xLgr', 1, 255, 1,
                                    NFSe.Servico.Evento.Endereco.Endereco, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'nro', 1, 60, 1,
                                      NFSe.Servico.Evento.Endereco.Numero, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xCpl', 1, 156, 0,
                                 NFSe.Servico.Evento.Endereco.Complemento, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xBairro', 1, 60, 1,
                                      NFSe.Servico.Evento.Endereco.Bairro, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoNacionalEvento: TACBrXmlNode;
begin
  Result := CreateElement('endNac');

  Result.AppendChild(AddNode(tcStr, '#1', 'cMun', 7, 7, 1,
                                NFSe.Servico.Evento.Endereco.CodigoMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CEP', 8, 8, 1,
                                            NFSe.Servico.Evento.Endereco.CEP, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoExteriorEvento: TACBrXmlNode;
begin
  Result := CreateElement('endExt');

  Result.AppendChild(AddNode(tcStr, '#1', 'cPais', 2, 2, 1,
               CodIBGEPaisToSiglaISO2(NFSe.Servico.Evento.Endereco.CodigoPais), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cEndPost', 1, 11, 1,
                                              NFSe.Servico.Evento.Endereco.CEP, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xCidade', 1, 60, 1,
                                       NFSe.Servico.Evento.Endereco.xMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xEstProvReg', 1, 60, 1,
                                               NFSe.Servico.Evento.Endereco.UF, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLCodigoServico: TACBrXmlNode;
begin
  Result := CreateElement('cServ');

  Result.AppendChild(AddNode(tcStr, '#1', 'cTribNac', 6, 6, 1,
                                            NFSe.Servico.ItemListaServico, ''));

  Result.AppendChild(AddNode(tcInt, '#1', 'cTribMun', 1, 10, 1,
                   StrToIntDef(NFSe.Servico.CodigoTributacaoMunicipio, 0), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xDescServ', 1, 2000, 1,
    StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
                          FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll])));

  Result.AppendChild(AddNode(tcStr, '#1', 'cNBS', 9, 9, 0,
                                                   NFSe.Servico.CodigoNBS, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cIntContrib', 1, 20, 0,
                                            NFSe.Servico.CodigoInterContr, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoExteriorImovel(
  endExt: TendExt): TACBrXmlNode;
begin
  Result := CreateElement('endExt');

  Result.AppendChild(AddNode(tcStr, '#1', 'cPais', 2, 2, 1, CodIBGEPaisToSiglaISO2(endExt.cPais), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cEndPost', 1, 11, 1,
                                                          endExt.cEndPost, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xCidade', 1, 60, 1,
                                                           endExt.xCidade, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xEstProvReg', 1, 60, 1,
                                                       endExt.xEstProvReg, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoImovel(
  ender: TenderImovel): TACBrXmlNode;
begin
  Result := CreateElement('end');

  if ender.endExt.cPais > 0 then
    Result.AppendChild(GerarXMLEnderecoExteriorImovel(ender.endExt))
  else
    Result.AppendChild(GerarXMLEnderecoNacionalImovel(ender));

  Result.AppendChild(AddNode(tcStr, '#1', 'xLgr', 1, 255, 1, ender.xLgr, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'nro', 1, 60, 1, ender.nro, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xCpl', 1, 156, 0, ender.xCpl, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xBairro', 1, 60, 1,
                                                          ender.xBairro, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoNacionalImovel(
  ender: TenderImovel): TACBrXmlNode;
begin
  Result := CreateElement('endNac');

  Result.AppendChild(AddNode(tcInt, '#1', 'cMun', 7, 7, 1, ender.CodigoMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CEP', 8, 8, 1, ender.CEP, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLImovel(
  Imovel: TDadosimovel): TACBrXmlNode;
begin
  Result := nil;

  if (Imovel.ender.CEP <> '') or (Imovel.ender.endExt.cEndPost <> '') then
  begin
    Result := CreateElement('imovel');

    Result.AppendChild(AddNode(tcStr, '#1', 'inscImobFisc', 1, 30, 0,
                                                      Imovel.inscImobFisc, ''));

    Result.AppendChild(GerarXMLEnderecoImovel(Imovel.ender));
  end;
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoExteriorObra: TACBrXmlNode;
begin
  Result := CreateElement('endExt');

  Result.AppendChild(AddNode(tcStr, '#1', 'cPais', 2, 2, 1,
         CodIBGEPaisToSiglaISO2(NFSe.ConstrucaoCivil.Endereco.CodigoPais), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cEndPost', 1, 11, 1,
                                        NFSe.ConstrucaoCivil.Endereco.CEP, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xCidade', 1, 60, 1,
                                 NFSe.ConstrucaoCivil.Endereco.xMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xEstProvReg', 1, 60, 1,
                                         NFSe.ConstrucaoCivil.Endereco.UF, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoNacionalObra: TACBrXmlNode;
begin
  Result := CreateElement('endNac');

  Result.AppendChild(AddNode(tcInt, '#1', 'cMun', 7, 7, 1,
                            NFSe.ConstrucaoCivil.Endereco.CodigoMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CEP', 8, 8, 1,
                                        NFSe.ConstrucaoCivil.Endereco.CEP, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLEnderecoObra: TACBrXmlNode;
begin
  Result := CreateElement('end');

  if NFSe.ConstrucaoCivil.Endereco.CodigoPais > 0 then
    Result.AppendChild(GerarXMLEnderecoExteriorObra)
  else
    Result.AppendChild(GerarXMLEnderecoNacionalObra);

  Result.AppendChild(AddNode(tcStr, '#1', 'xLgr', 1, 255, 1,
                                   NFSe.ConstrucaoCivil.Endereco.Endereco, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'nro', 1, 60, 1,
                                     NFSe.ConstrucaoCivil.Endereco.Numero, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xCpl', 1, 156, 0,
                                NFSe.ConstrucaoCivil.Endereco.Complemento, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'xBairro', 1, 60, 1,
                                     NFSe.ConstrucaoCivil.Endereco.Bairro, ''));
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLObra: TACBrXmlNode;
begin
  Result := CreateElement('obra');

  Result.AppendChild(AddNode(tcStr, '#1', 'inscImobFisc', 1, 30, 0,
                                      NFSe.ConstrucaoCivil.inscImobFisc, ''));

  Result.AppendChild(GerarXMLEnderecoObra);
end;

function TNFSeW_ISSNetAPIPropria.GerarXMLPrestador: TACBrXmlNode;
begin
  Result := CreateElement('prest');

  Result.AppendChild(AddNodeCNPJCPF('#1', '#1',
                                NFSe.Prestador.IdentificacaoPrestador.CpfCnpj));

  Result.AppendChild(AddNode(tcStr, '#1', 'CAEPF', 1, 14, 0,
                              NFSe.Prestador.IdentificacaoPrestador.CAEPF, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'IM', 1, 15, 0,
                 NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal, ''));

  Result.AppendChild(GerarXMLRegimeTributacaoPrestador);
end;

end.
