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

unit Saatri.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrNFSeXGravarXml_ABRASFv2,
  ACBrXmlDocument,
  ACBrNFSeXClass;

type
  { TNFSeW_Saatri201 }

  TNFSeW_Saatri201 = class(TNFSeW_ABRASFv2)
  protected
    procedure DefinirIDDeclaracao; override;
    procedure DefinirIDRps; override;

    procedure Configuracao; override;

  end;

  { TNFSeW_Saatri203 }

  TNFSeW_Saatri203 = class(TNFSeW_Saatri201)
  protected
    procedure Configuracao; override;

    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
    function GerarIBSCBS(IBSCBS: TIBSCBSDPS): TACBrXmlNode;
    function GerarIBSMunicipal: TACBrXmlNode;
    function GerarIBSEstadual: TACBrXmlNode;
    function GerarCBS: TACBrXmlNode;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXConsts,
  ACBrUtil.Strings;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     Saatri
//==============================================================================

{ TNFSeW_Saatri201 }

procedure TNFSeW_Saatri201.Configuracao;
begin
  inherited Configuracao;

  NrOcorrValorISS := 1;
  NrOcorrAliquota := 1;

  GerarIDRps := True;
end;

procedure TNFSeW_Saatri201.DefinirIDDeclaracao;
begin
  NFSe.InfID.ID := 'Declaracao_' +
                      OnlyNumber(NFSe.Prestador.IdentificacaoPrestador.CpfCnpj);
end;

procedure TNFSeW_Saatri201.DefinirIDRps;
begin
  NFSe.InfID.ID := 'rps' + OnlyNumber(NFSe.IdentificacaoRps.Numero) +
                    NFSe.IdentificacaoRps.Serie +
                    FpAOwner.TipoRPSToStr(NFSe.IdentificacaoRps.Tipo);
end;

{ TNFSeW_Saatri203 }

procedure TNFSeW_Saatri203.Configuracao;
begin
  inherited Configuracao;

  NrOcorrDiscriminacao_1 := -1;
  NrOcorrCodigoMunic_1 := -1;

  NrOcorrDiscriminacao_2 := 1;
  NrOcorrCodigoMunic_2 := 1;
end;

function TNFSeW_Saatri203.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
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

  Result.AppendChild(GerarListaServicos);

  Result.AppendChild(AddNode(FormatoCompetencia, '#4', 'Competencia', 10, 10, 1,
                                                  NFSe.Competencia, DSC_DHEMI));

  Result.AppendChild(GerarServico);

  nodeArray := GerarServicos;
  if nodeArray <> nil then
  begin
    for i := 0 to Length(nodeArray) - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;

  Result.AppendChild(GerarPrestador);
  Result.AppendChild(GerarTomador);
  Result.AppendChild(GerarIntermediarioServico);
  Result.AppendChild(GerarConstrucaoCivil);

  if GerarAtividadeEventoAposConstrucaoCivil then
    Result.AppendChild(GeraAtividadeEvento);

  Result.AppendChild(AddNode(tcStr, '#6', 'RegimeEspecialTributacao', 1, 2, 0,
   FpAOwner.RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), DSC_REGISSQN));

  Result.AppendChild(AddNode(tcStr, '#7', 'OptanteSimplesNacional', 1, 1, 1,
               FpAOwner.SimNaoToStr(NFSe.OptanteSimplesNacional), DSC_INDOPSN));

  Result.AppendChild(AddNode(tcStr, '#8', 'IncentivoFiscal', 1, 1, 0,
              FpAOwner.SimNaoToStr(NFSe.IncentivadorCultural), DSC_INDINCCULT));

  Result.AppendChild(AddNode(tcStr, '#1', 'RegimeApuracaoSN', 1, 1, 1,
                             RegimeApuracaoSNToStr(NFSe.RegimeApuracaoSN), ''));

  Result.AppendChild(GerarIBSCBS(NFSe.IBSCBS));
end;

function TNFSeW_Saatri203.GerarServico: TACBrXmlNode;
begin
  Result := inherited GerarServico;

  Result.AppendChild(AddNode(tcStr, '#27', 'CSTPisCofins', 1, 15, 0,
                               CSTToStr(NFSe.Servico.Valores.tribFed.CST), ''));

  Result.AppendChild(AddNode(tcStr, '#28', 'RetencaoPisCofinsCsll', 1, 15, 0,
         tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.tpRetPisCofins), ''));
end;

function TNFSeW_Saatri203.GerarValores: TACBrXmlNode;
begin
  Result := inherited GerarValores;

  Result.AppendChild(AddNode(tcDe2, '#27', 'AliquotaPis', 1, 15, 0,
                                         NFSe.Servico.Valores.AliquotaPis, ''));

  Result.AppendChild(AddNode(tcDe2, '#28', 'AliquotaCofins', 1, 15, 0,
                                      NFSe.Servico.Valores.AliquotaCofins, ''));
end;

function TNFSeW_Saatri203.GerarIBSCBS(IBSCBS: TIBSCBSDPS): TACBrXmlNode;
  const TindFinalArrayStrings: array[TindFinal] of string = ('1', '2');
  //1-sim
  //2-não
  function indFinalToStr(const t: TindFinal): string;
  begin
    Result := TindFinalArrayStrings[t];
  end;
begin
  Result := CreateElement('IbsCbs');

  Result.AppendChild(AddNode(tcInt, '#1', 'MunicipioIncidencia', 7, 7, 1,
                                     NFSe.infNFSe.IBSCBS.cLocalidadeIncid, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'IndicadorFinalidade', 1, 1, 1,
                                            indFinalToStr(IBSCBS.indFinal), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'IndicadorOperacao', 6, 6, 1,
                                                            IBSCBS.cIndOp, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'ClassificacaoTributaria', 6, 6, 1,
                                   IBSCBS.valores.trib.gIBSCBS.cClassTrib, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'IndicadorDestino', 1, 1, 1,
                                             indDestToStr(IBSCBS.indDest), ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'BaseCalculo', 1, 15, 1,
                                          NFSe.infNFSe.IBSCBS.valores.vBC, ''));

//  Result.AppendChild(AddNode(tcDe2, '#1', 'ValorCalcReeRepRes', 1, 15, 0,
//                NFSe.IBSCBS.valores.gReeRepRes.documentos[0].vlrReeRepRes, ''));

  Result.AppendChild(GerarIBSMunicipal);
  Result.AppendChild(GerarIBSEstadual);
  Result.AppendChild(GerarCBS);
end;

function TNFSeW_Saatri203.GerarIBSMunicipal: TACBrXmlNode;
begin
  Result := CreateElement('IbsMunicipal');

  Result.AppendChild(AddNode(tcDe2, '#1', 'Percentual', 1, 7, 1,
                                  NFSe.infNFSe.IBSCBS.valores.Mun.pIBSMun, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercRedAliq', 1, 7, 0,
                              NFSe.infNFSe.IBSCBS.valores.Mun.pRedAliqMun, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercAliqEfet', 1, 7, 1,
                             NFSe.infNFSe.IBSCBS.valores.Mun.pAliqEfetMun, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'Valor', 1, 15, 1,
                      NFSe.infNFSe.IBSCBS.totCIBS.gIBS.gIBSMunTot.vIBSMun, ''));
end;

function TNFSeW_Saatri203.GerarIBSEstadual: TACBrXmlNode;
begin
  Result := CreateElement('IbsEstadual');

  Result.AppendChild(AddNode(tcDe2, '#1', 'Percentual', 1, 7, 1,
                              NFSe.infNFSe.IBSCBS.valores.UF.pIBSUF, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercRedAliq', 1, 7, 0,
                                NFSe.infNFSe.IBSCBS.valores.UF.pRedAliqUF, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercAliqEfet', 1, 7, 1,
                               NFSe.infNFSe.IBSCBS.valores.UF.pAliqEfetUF, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'Valor', 1, 15, 1,
                        NFSe.infNFSe.IBSCBS.totCIBS.gIBS.gIBSUFTot.vIBSUF, ''));
end;

function TNFSeW_Saatri203.GerarCBS: TACBrXmlNode;
begin
  Result := CreateElement('Cbs');

  Result.AppendChild(AddNode(tcDe2, '#1', 'Percentual', 1, 7, 1,
                                     NFSe.infNFSe.IBSCBS.valores.fed.pCBS, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercRedAliq', 1, 7, 0,
                              NFSe.infNFSe.IBSCBS.valores.fed.pRedAliqCBS, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercAliqEfet', 1, 7, 1,
                             NFSe.infNFSe.IBSCBS.valores.fed.pAliqEfetCBS, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'Valor', 1, 15, 1,
                                    NFSe.infNFSe.IBSCBS.totCIBS.gCBS.vCBS, ''));
end;

end.
