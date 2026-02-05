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

unit ISSSaoPaulo.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXGravarXml;

type
  { TNFSeW_ISSSaoPaulo }

  TNFSeW_ISSSaoPaulo = class(TNFSeWClass)
  private
    FNrOcorr: Integer;
  protected
    procedure Configuracao; override;

    function GerarChaveRPS: TACBrXmlNode;
    function GerarCPFCNPJTomador: TACBrXmlNode;
    function GerarEnderecoTomador: TACBrXmlNode;
    function GerarCPFCNPJIntermediario: TACBrXmlNode;

    function GerarXMLDocumentos: TACBrXmlNodeArray; override;
  public
    function GerarXml: Boolean; override;

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrUtil.Strings,
  ACBrNFSeXConversao,
  ACBrNFSeXConsts;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     ISSSaoPaulo
//==============================================================================

{ TNFSeW_ISSSaoPaulo }

procedure TNFSeW_ISSSaoPaulo.Configuracao;
begin
  inherited Configuracao;

  FNrOcorr := 0;
  NrOcorrCST := -1;
  NrOcorrcCredPres := -1;
  NrOcorrCSTReg := -1;

  GerargDif := False;

  if VersaoNFSe = ve200 then
    FNrOcorr := 1;
end;

function TNFSeW_ISSSaoPaulo.GerarChaveRPS: TACBrXmlNode;
begin
  Result := CreateElement('ChaveRPS');

  Result.AppendChild(AddNode(tcStr, '#1', 'InscricaoPrestador', 1, 11, 1,
        NFSe.Prestador.IdentificacaoPrestador.InscricaoMunicipal, DSC_INSCMUN));

  Result.AppendChild(AddNode(tcStr, '#2', 'SerieRPS', 1, 05, 1,
                                    NFSe.IdentificacaoRps.Serie, DSC_SERIERPS));

  Result.AppendChild(AddNode(tcStr, '#2', 'NumeroRPS', 1, 12, 1,
                                     NFSe.IdentificacaoRps.Numero, DSC_NUMRPS));
end;

function TNFSeW_ISSSaoPaulo.GerarCPFCNPJIntermediario: TACBrXmlNode;
begin
  Result := nil;

  if OnlyAlphaNum(NFSe.Intermediario.Identificacao.CpfCnpj) <> '' then
  begin
    Result := CreateElement('CPFCNPJIntermediario');

    Result.AppendChild(AddNodeCNPJCPF('#1', '#1',
                                     NFSe.Intermediario.Identificacao.CpfCnpj));
  end;
end;

function TNFSeW_ISSSaoPaulo.GerarCPFCNPJTomador: TACBrXmlNode;
begin
  Result := nil;

  if VersaoNFSe = ve100 then
  begin
    if (OnlyAlphaNum(NFSe.Tomador.IdentificacaoTomador.CpfCnpj) <> '') then
    begin
      Result := CreateElement('CPFCNPJTomador');

      Result.AppendChild(AddNodeCNPJCPF('#1', '#1',
                                     NFSe.Tomador.IdentificacaoTomador.CpfCnpj))
    end;
  end
  else
  begin
    if (OnlyAlphaNum(NFSe.Tomador.IdentificacaoTomador.CpfCnpj) <> '') or
       (NFSe.Tomador.IdentificacaoTomador.Nif <> '') then
    begin
      Result := CreateElement('CPFCNPJTomador');

      if NFSe.Tomador.IdentificacaoTomador.CpfCnpj <> '' then
        Result.AppendChild(AddNodeCNPJCPF('#1', '#1',
                                     NFSe.Tomador.IdentificacaoTomador.CpfCnpj))
      else
      begin
        if NFSe.Tomador.IdentificacaoTomador.Nif <> '' then
          Result.AppendChild(AddNode(tcStr, '#1', 'NIF', 1, 40, 1,
                                     NFSe.Tomador.IdentificacaoTomador.Nif, ''))
        else
          Result.AppendChild(AddNode(tcStr, '#1', 'NaoNIF', 1, 1, 1,
                   NaoNIFToStr(NFSe.Tomador.IdentificacaoTomador.cNaoNIF), ''));
      end;
    end;
  end;
end;

function TNFSeW_ISSSaoPaulo.GerarEnderecoTomador: TACBrXmlNode;
begin
  Result := CreateElement('EnderecoTomador');

  Result.AppendChild(AddNode(tcStr, '#1', 'TipoLogradouro', 1, 10, 0,
                                     NFSe.Tomador.Endereco.TipoLogradouro, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'Logradouro ', 1, 50, 0,
                                           NFSe.Tomador.Endereco.Endereco, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'NumeroEndereco ', 1, 9, 0,
                                             NFSe.Tomador.Endereco.Numero, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'ComplementoEndereco ', 1, 30, 0,
                                        NFSe.Tomador.Endereco.Complemento, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'Bairro ', 1, 50, 0,
                                             NFSe.Tomador.Endereco.Bairro, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'Cidade ', 1, 10, 0,
                                    NFSe.Tomador.Endereco.CodigoMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'UF ', 1, 2, 0,
                                                 NFSe.Tomador.Endereco.UF, ''));

  Result.AppendChild(AddNode(tcStr, '#2', 'CEP ', 1, 8, 0,
                                    OnlyNumber(NFSe.Tomador.Endereco.CEP), ''));
end;

function TNFSeW_ISSSaoPaulo.GerarXml: Boolean;
var
  LNFSeNode, LNode: TACBrXmlNode;
  LTipoRPS, LSituacao, LAliquota, LISSRetido, LISSRetidoInter: String;
begin
  Configuracao;

  Opcoes.SuprimirDecimais := True;
  Opcoes.DecimalChar := '.';

  ListaDeAlertas.Clear;

  FDocument.Clear();

  NFSe.InfID.ID := NFSe.IdentificacaoRps.Numero;

  LNFSeNode := CreateElement('RPS');
  LNFSeNode.SetNamespace(FpAOwner.ConfigMsgDados.LoteRps.xmlns, Self.PrefixoPadrao);

  FDocument.Root := LNFSeNode;

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'Assinatura', 1, 2000, 1,
                                                          NFSe.Assinatura, ''));

  LNode := GerarChaveRPS;
  LNFSeNode.AppendChild(LNode);

  LTipoRPS := EnumeradoToStr(NFSe.IdentificacaoRps.Tipo,
                      ['RPS','RPS-M','RPS-C'], [trRPS, trNFConjugada, trCupom]);

  LSituacao := EnumeradoToStr(NFSe.StatusRps, ['N', 'C'], [srNormal, srCancelado]);

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'TipoRPS', 1, 5, 1, LTipoRPS, ''));

  LNFSeNode.AppendChild(AddNode(tcDat, '#1', 'DataEmissao', 1, 10, 1,
                                                         NFse.DataEmissao, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'StatusRPS', 1, 1, 1, LSituacao, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'TributacaoRPS', 1, 1, 1,
                  FPAOwner.TipoTributacaoRPSToStr(NFSe.TipoTributacaoRPS), ''));

  if VersaoNFSe = ve100 then
    LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorServicos', 1, 15, 1,
                                       NFSe.Servico.Valores.ValorServicos, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorDeducoes', 1, 15, 1,
                                       NFSe.Servico.Valores.ValorDeducoes, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorPIS', 1, 15, FNrOcorr,
                                            NFSe.Servico.Valores.ValorPis, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorCOFINS', 1, 15, FNrOcorr,
                                         NFSe.Servico.Valores.ValorCofins, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorINSS', 1, 15, FNrOcorr,
                                           NFSe.Servico.Valores.ValorInss, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorIR', 1, 15, FNrOcorr,
                                             NFSe.Servico.Valores.ValorIr, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorCSLL', 1, 15, FNrOcorr,
                                           NFSe.Servico.Valores.ValorCsll, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'CodigoServico', 1, 5, 1,
                                OnlyNumber(NFSe.Servico.ItemListaServico), ''));

  if NFSe.Servico.Valores.Aliquota > 0 then
  begin
    LAliquota := FormatFloat('0.00##', NFSe.Servico.Valores.Aliquota / 100);

    LAliquota := StringReplace(LAliquota, ',', '.', [rfReplaceAll]);
  end
  else
    LAliquota := '0';

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'AliquotaServicos', 1, 6, 1,
                                                                 LAliquota, ''));

  LISSRetido := EnumeradoToStr( NFSe.Servico.Valores.ISSRetido,
                                     ['false', 'true'], [stNormal, stRetencao]);

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'ISSRetido', 1, 5, 1, LISSRetido, ''));

  LNode := GerarCPFCNPJTomador;
  LNFSeNode.AppendChild(LNode);

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'InscricaoMunicipalTomador', 1, 8, 0,
         OnlyNumber(NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal), ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'InscricaoEstadualTomador', 1, 19, 0,
          OnlyNumber(NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual), ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'RazaoSocialTomador', 1, 75, 0,
                                                 NFSe.Tomador.RazaoSocial, ''));

  LNode := GerarEnderecoTomador;
  LNFSeNode.AppendChild(LNode);

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'EmailTomador', 1, 75, 0,
                                               NFSe.Tomador.Contato.Email, ''));

  if OnlyNumber(NFSe.Intermediario.Identificacao.CpfCnpj) <> '' then
  begin
    LNode := GerarCPFCNPJIntermediario;
    LNFSeNode.AppendChild(LNode);

    LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'InscricaoMunicipalIntermediario', 1, 8, 0,
          OnlyNumber(NFSe.Intermediario.Identificacao.InscricaoMunicipal), ''));

    LISSRetidoInter := EnumeradoToStr( NFSe.Intermediario.ISSRetido,
                                     ['false', 'true'], [stNormal, stRetencao]);

    LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'ISSRetidoIntermediario', 1, 5, 0,
                                                          LISSRetidoInter, ''));

    LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'EmailIntermediario', 1, 75, 0,
                                         NFSe.Intermediario.Contato.EMail, ''));
  end;

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'Discriminacao', 1, 2000, 1,
    StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
                          FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll])));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorCargaTributaria', 1, 15, 0,
                                        NFSe.Servico.ValorCargaTributaria, ''));

  LNFSeNode.AppendChild(AddNode(tcDe4, '#1', 'PercentualCargaTributaria', 1, 5, 0,
                                   NFSe.Servico.PercentualCargaTributaria, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'FonteCargaTributaria', 1, 10, 0,
                                        NFSe.Servico.FonteCargaTributaria, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'CodigoCEI', 1, 12, 0,
                                                NFSe.ConstrucaoCivil.nCei, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'MatriculaObra', 1, 12, 0,
                                              NFSe.ConstrucaoCivil.nMatri, ''));

  if (NFSe.TipoTributacaoRPS <> ttTribnoMun) and
     (NFSe.TipoTributacaoRPS <> ttTribnoMunIsento) and
     (NFSe.TipoTributacaoRPS <> ttTribnoMunImune) then
    LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'MunicipioPrestacao', 1, 7, 0,
                                             NFSe.Servico.CodigoMunicipio, ''));

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'NumeroEncapsulamento', 1, 12, 0,
                               NFSe.ConstrucaoCivil.nNumeroEncapsulamento, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorTotalRecebido', 1, 15, 0,
                                          NFSe.Servico.ValorTotalRecebido, ''));

  if VersaoNFSe = ve200 then
  begin
    if NFSe.Servico.Valores.ValorInicialCobrado > 0 then
      LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorInicialCobrado', 1, 15, 1,
                                  NFSe.Servico.Valores.ValorInicialCobrado, ''))
    else
      LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorFinalCobrado', 1, 15, 1,
                                   NFSe.Servico.Valores.ValorFinalCobrado, ''));
  end;

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorMulta', 1, 15, 0,
                                          NFSe.Servico.Valores.ValorMulta, ''));

  LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorJuros', 1, 15, 0,
                                          NFSe.Servico.Valores.ValorJuros, ''));

  if VersaoNFSe = ve200 then
  begin
    LNFSeNode.AppendChild(AddNode(tcDe2, '#1', 'ValorIPI', 1, 15, 1,
                                            NFSe.Servico.Valores.ValorIPI, ''));

    if NFSe.Servico.ExigibilidadeISS = exiSuspensaProcessoAdministrativo then
      LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'ExigibilidadeSuspensa', 1, 1, 1,
                                                                       '1', ''))
    else
      LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'ExigibilidadeSuspensa', 1, 1, 1,
                                                                      '0', ''));

    LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'PagamentoParceladoAntecipado', 1, 1, 1,
                                                                      '0', ''));
  end;

  LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'NCM', 1, 15, 0,
                                                   NFSe.Servico.CodigoNCM, ''));

  if VersaoNFSe = ve200 then
    LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'NBS', 1, 15, 1,
                                                   NFSe.Servico.CodigoNBS, ''));

(*
      <xs:element name="atvEvento" type="tipos:tpAtividadeEvento" minOccurs="0" maxOccurs="1">
        <xs:annotation>
          <xs:documentation>Informações dos Tipos de evento.</xs:documentation>
        </xs:annotation>
      </xs:element>
*)

  if VersaoNFSe = ve200 then
  begin
    if NFSe.Servico.CodigoMunicipio <> '' then
      LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'cLocPrestacao', 7, 7, 1,
                                              NFSe.Servico.CodigoMunicipio, ''))
    else
      LNFSeNode.AppendChild(AddNode(tcStr, '#1', 'cPaisPrestacao', 2, 2, 1,
                          CodIBGEPaisToSiglaISO2(NFSe.Servico.CodigoPais), ''));
  end;

  // Reforma Tributária
  if (NFSe.IBSCBS.dest.xNome <> '') or (NFSe.IBSCBS.imovel.cCIB <> '') or
     (NFSe.IBSCBS.imovel.ender.CEP <> '') or
     (NFSe.IBSCBS.imovel.ender.endExt.cEndPost <> '') or
     (NFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum) then
    LNFSeNode.AppendChild(GerarXMLIBSCBS(NFSe.IBSCBS));

  Result := True;
end;

function TNFSeW_ISSSaoPaulo.GerarXMLDocumentos: TACBrXmlNodeArray;
var
  i: integer;
begin
  Result := nil;
  SetLength(Result, NFSe.IBSCBS.valores.gReeRepRes.documentos.Count);

  for i := 0 to NFSe.IBSCBS.valores.gReeRepRes.documentos.Count - 1 do
  begin
    Result[i] := CreateElement('documentos');

    if NFSe.IBSCBS.valores.gReeRepRes.documentos[i].dFeNacional.chaveDFe <> '' then
      Result[i].AppendChild(GerarXMLdFeNacional(NFSe.IBSCBS.valores.gReeRepRes.documentos[i].dFeNacional))
    else
    if NFSe.IBSCBS.valores.gReeRepRes.documentos[i].docFiscalOutro.cMunDocFiscal > 0 then
      Result[i].AppendChild(GerarXMLdocFiscalOutro(NFSe.IBSCBS.valores.gReeRepRes.documentos[i].docFiscalOutro))
    else
    if NFSe.IBSCBS.valores.gReeRepRes.documentos[i].docOutro.nDoc <> '' then
      Result[i].AppendChild(GerarXMLdocOutro(NFSe.IBSCBS.valores.gReeRepRes.documentos[i].docOutro));

    if NFSe.IBSCBS.valores.gReeRepRes.documentos[i].fornec.xNome <> '' then
      Result[i].AppendChild(GerarXMLfornec(NFSe.IBSCBS.valores.gReeRepRes.documentos[i].fornec));

    Result[i].AppendChild(AddNode(tcDat, '#1', 'dtEmiDoc', 10, 10, 1,
                    NFSe.IBSCBS.valores.gReeRepRes.documentos[i].dtEmiDoc, ''));

    Result[i].AppendChild(AddNode(tcDat, '#1', 'dtCompDoc', 10, 10, 1,
                   NFSe.IBSCBS.valores.gReeRepRes.documentos[i].dtCompDoc, ''));

    Result[i].AppendChild(AddNode(tcInt, '#1', 'tpReeRepRes', 1, 2, 1,
     StrToInt(tpReeRepResToStr(NFSe.IBSCBS.valores.gReeRepRes.documentos[i].tpReeRepRes)), ''));

    Result[i].AppendChild(AddNode(tcStr, '#1', 'xTpReeRepRes', 0, 150, 0,
                NFSe.IBSCBS.valores.gReeRepRes.documentos[i].xTpReeRepRes, ''));

    Result[i].AppendChild(AddNode(tcDe2, '#1', 'vlrReeRepRes', 1, 15, 1,
                NFSe.IBSCBS.valores.gReeRepRes.documentos[i].vlrReeRepRes, ''));
  end;

  if NFSe.Servico.Valores.DocDeducao.Count > 1000 then
    wAlerta('#1', 'documentos', '', ERR_MSG_MAIOR_MAXIMO + '1000');
end;

end.
