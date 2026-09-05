{ ****************************************************************************** }
{ Projeto: Componentes ACBr                                                      }
{ Biblioteca multiplataforma de componentes Delphi para interação com equipa-    }
{ mentos de Automação Comercial utilizados no Brasil                             }
{                                                                                }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida                 }
{                                                                                }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                           }
{                                                                                }
{ Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr       }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr        }
{                                                                                }
{ Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la    }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela    }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério)   }
{ qualquer versão posterior.                                                     }
{                                                                                }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM      }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU        }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor  }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)                }
{                                                                                }
{ Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto   }
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,    }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.            }
{ Você também pode obter uma copia da licença em:                                }
{ http://www.opensource.org/licenses/lgpl-license.php                            }
{                                                                                }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br  }
{ Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170                 }
{ ****************************************************************************** }

{$I ACBr.inc}

unit ACBrNFSeXDANFSeRLPadraoNacional;

interface

uses
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  RLFilters,
  RLPDFFilter,
  RLReport,
  ACBrDelphiZXingQRCode,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXDANFSeRL;

type

  { TfrlXDANFSeRLPadraoNacional }

  TfrlXDANFSeRLPadraoNacional = class(TfrlXDANFSeRL)
    rlbBanda02_Ide_NFSe: TRLBand;
    rllNumNF0: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel12: TRLLabel;
    rllEmissaoNFSe: TRLLabel;
    RLLabel7: TRLLabel;
    rllCompetencia: TRLLabel;
    RLLabel18: TRLLabel;
    rllNumeroDPS: TRLLabel;
    rlbBanda03_Emitente: TRLBand;
    RLLabel30: TRLLabel;
    RLLabel32: TRLLabel;
    rllEmitenteInscMunicipal: TRLLabel;
    rllEmitenteCNPJ: TRLLabel;
    RLLabel1: TRLLabel;
    rllEmitenteNome: TRLLabel;
    rlbBanda04_Tomador: TRLBand;
    rllTomaCNPJ: TRLLabel;
    rllTomaInscMunicipal: TRLLabel;
    rllTomaNome: TRLLabel;
    rllTomaEndereco: TRLLabel;
    rllTomaMunicipio: TRLLabel;
    rllTomaEmail: TRLLabel;
    rllTomaTelefone: TRLLabel;
    rlbBanda07_ServicoPrestado: TRLBand;
    RLLabel14: TRLLabel;
    rlbBanda14_InformacoesComplementares: TRLBand;
    rlmDadosAdicionais: TRLMemo;
    RLLabel6: TRLLabel;
    rlbBanda08_ItensDetalhado: TRLBand;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    rlbBanda09_SubItens: TRLSubDetail;
    rlbBanda08_ItensServico: TRLBand;
    txtServicoQtde: TRLLabel;
    rlmServicoDescricao: TRLMemo;
    txtServicoUnitario: TRLLabel;
    txtServicoTotal: TRLLabel;
    rlbBanda16_Sistema: TRLBand;
    rllDataHoraImpressao: TRLLabel;
    rllSistema: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel9: TRLLabel;
    txtBaseCalculo: TRLLabel;
    txtISS: TRLLabel;
    rlbBanda10_TributacaoMunicipal: TRLBand;
    rlbBanda01_Logos: TRLBand;
    RLLabel74: TRLLabel;
    RLLabel8: TRLLabel;
    rliLogoNFSe: TRLImage;
    rlmPrefeitura: TRLMemo;
    rllCodigoChave: TRLLabel;
    rllChaveAcesso: TRLLabel;
    RLLabel16: TRLLabel;
    rllSerieDPS: TRLLabel;
    RLLabel22: TRLLabel;
    rllEmissaoDPS: TRLLabel;
    RLMemo1: TRLMemo;
    RLLabel2: TRLLabel;
    rllEmitenteTelefone: TRLLabel;
    RLLabel24: TRLLabel;
    rllEmitenteEndereco: TRLLabel;
    RLLabel29: TRLLabel;
    rllEmitenteEmail: TRLLabel;
    RLLabel31: TRLLabel;
    rllEmitenteMunicipio: TRLLabel;
    RLLabel55: TRLLabel;
    rllEmitenteCEP: TRLLabel;
    RLLabel60: TRLLabel;
    rllEmitenteSimplesNacional: TRLLabel;
    RLLabel69: TRLLabel;
    rllEmitenteRegimeApuracao: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    rllTomaCEP: TRLLabel;
    rlbBanda06_Intermediario: TRLBand;
    rllInterCNPJ: TRLLabel;
    rllInterInscMunicipal: TRLLabel;
    rllInterNome: TRLLabel;
    rllInterEndereco: TRLLabel;
    rllInterMunicipio: TRLLabel;
    rllInterEmail: TRLLabel;
    rllInterTelefone: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    rllInterCEP: TRLLabel;
    rllIntermediarioNaoIdentificado: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabel92: TRLLabel;
    rllLocalPrestacao: TRLLabel;
    RLLabel94: TRLLabel;
    rllCodigoNBS: TRLLabel;
    RLLabel96: TRLLabel;
    rlmDescServico: TRLMemo;
    rlmCodTribNac: TRLMemo;
    rllMsgTeste: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    rllTribISSQN: TRLLabel;
    RLLabel17: TRLLabel;
    rllTipoImunidade: TRLLabel;
    RLLabel25: TRLLabel;
    rllValorBCISSQN: TRLLabel;
    RLLabel90: TRLLabel;
    rllSuspensao: TRLLabel;
    RLLabel93: TRLLabel;
    rllValorDescIncond: TRLLabel;
    RLLabel97: TRLLabel;
    rllAliquotaAplicada: TRLLabel;
    RLLabel99: TRLLabel;
    rllMunicipioIncidencia: TRLLabel;
    RLLabel101: TRLLabel;
    rllNumeroProcesso: TRLLabel;
    RLLabel103: TRLLabel;
    rllValorTotalDedRed: TRLLabel;
    RLLabel105: TRLLabel;
    rllRetencaoISSQN: TRLLabel;
    RLLabel111: TRLLabel;
    rllCalculoBM: TRLLabel;
    RLLabel113: TRLLabel;
    rllValorISSQNApurado: TRLLabel;
    rlbBanda11_TributacaoFederal: TRLBand;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    rllValorIRRF: TRLLabel;
    RLLabel118: TRLLabel;
    rllValorPIS: TRLLabel;
    RLLabel124: TRLLabel;
    rllValorCP: TRLLabel;
    RLLabel126: TRLLabel;
    rllValorCOFINS: TRLLabel;
    RLLabel132: TRLLabel;
    rllValorCSLL: TRLLabel;
    RLLabel134: TRLLabel;
    rllDescCSLL: TRLLabel;
    rlbBanda13_ValorTotaNFSe: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel26: TRLLabel;
    rllValorTotalServico: TRLLabel;
    RLLabel35: TRLLabel;
    rllValorTotalDescCond: TRLLabel;
    RLLabel37: TRLLabel;
    rllValorTotalIBSCBS: TRLLabel;
    RLLabel39: TRLLabel;
    rllValorTotalDescIncond: TRLLabel;
    RLLabel41: TRLLabel;
    rllValorTotalISSQNRetido: TRLLabel;
    RLLabel43: TRLLabel;
    rllValorTotalLiq: TRLLabel;
    rlbHomologacao: TRLLabel;
    RLLabel23: TRLLabel;
    rllEmitente: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel19: TRLLabel;
    rllSituacao: TRLLabel;
    rllFinalidade: TRLLabel;
    RLLabel21: TRLLabel;
    rlbBanda05_Destinatario: TRLBand;
    rllDestCNPJ: TRLLabel;
    rllDestInscMunicipal: TRLLabel;
    rllDestNome: TRLLabel;
    rllDestEndereco: TRLLabel;
    rllDestMunicipio: TRLLabel;
    rllDestEmail: TRLLabel;
    rllDestTelefone: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    RLLabel56: TRLLabel;
    rllDestCEP: TRLLabel;
    rllDestinatarioNaoIdentificado: TRLLabel;
    RLLabel20: TRLLabel;
    rllValorLiqIBSCBS: TRLLabel;
    rlbBanda12_TributacaoFederalIBSCBS: TRLBand;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    rllCST: TRLLabel;
    RLLabel34: TRLLabel;
    rllExcRedBC: TRLLabel;
    RLLabel38: TRLLabel;
    rllcIndOp: TRLLabel;
    RLLabel57: TRLLabel;
    rllValorBC: TRLLabel;
    RLLabel59: TRLLabel;
    rllAliqEfetIBSUF: TRLLabel;
    RLLabel63: TRLLabel;
    rllRedAliquota: TRLLabel;
    RLLabel79: TRLLabel;
    rllAliqEfetIBSMun: TRLLabel;
    RLLabel91: TRLLabel;
    rllValorApurIBS: TRLLabel;
    RLLabel98: TRLLabel;
    rllValorApurIBSMun: TRLLabel;
    RLLabel102: TRLLabel;
    rllAliquotaCBS: TRLLabel;
    RLLabel106: TRLLabel;
    rllAliqEfetCBS: TRLLabel;
    RLLabel110: TRLLabel;
    rllAliquotaIBS: TRLLabel;
    RLLabel114: TRLLabel;
    rllValorApurIBSUF: TRLLabel;
    RLLabel119: TRLLabel;
    rllValorApurCBS: TRLLabel;
    RLLabel109: TRLLabel;
    rllBeneficioMunic: TRLLabel;
    RLLabel107: TRLLabel;
    rllRegimeEspecial: TRLLabel;
    rlbCanhoto: TRLBand;
    rllNumChave: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel54: TRLLabel;
    RLDraw5: TRLDraw;
    RLLabel121: TRLLabel;
    RLLabel122: TRLLabel;
    rllNumNFSe: TRLLabel;
    RLLabel33: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel62: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    imgQRCode: TRLImage;

    procedure RLNFSeBeforePrint(Sender: TObject; var PrintIt: Boolean);

    procedure rlbBanda01_LogosBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda02_Ide_NFSeBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda03_EmitenteBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda04_TomadorBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda06_IntermediarioBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda07_ServicoPrestadoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);

    procedure rlbBanda08_ItensServicoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda09_SubItensDataRecord(Sender: TObject; RecNo: Integer;
      CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);

    procedure rlbBanda10_TributacaoMunicipalBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda11_TributacaoFederalBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda13_ValorTotaNFSeBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda14_InformacoesComplementaresBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda16_SistemaBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbBanda05_DestinatarioBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbCanhotoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbBanda12_TributacaoFederalIBSCBSBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
    FNumItem: Integer;
    Detalhar: Boolean;
  public
    { Public declarations }
    class procedure QuebradeLinha(const sQuebradeLinha: String); override;
  end;

var
  frlXDANFSeRLPadraoNacional: TfrlXDANFSeRLPadraoNacional;

implementation

uses
  StrUtils, 
  DateUtils, 
  Types,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrDFeUtil,
  ACBrNFSeX,
  ACBrNFSeXClass,
  ACBrNFSeXInterface,
  ACBrNFSeXLerXml,
  ACBrValidador,
  ACBrImage,
  ACBrDFeReportFortes;

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

var
  FQuebradeLinha: String;

  { TfrlXDANFSeRLPadraoNacional }

class procedure TfrlXDANFSeRLPadraoNacional.QuebradeLinha(const sQuebradeLinha: String);
begin
  FQuebradeLinha := sQuebradeLinha;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda01_LogosBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  Ambiente, Logo, TipoLogo: string;
  Res: TResourceStream;
  LogoStream: TStringStream;
begin
  inherited;

  TDFeReportFortes.CarregarLogo(rliLogoNFSe, fpDANFSe.LogoNFSe);

  rlbHomologacao.Visible := (fpNFSe.Producao = snNao);

  if fpNFSe.Producao = snNao then
    Ambiente := 'Homologação'
  else
    Ambiente := 'Produção';

  rlmPrefeitura.Lines.Clear;
  rlmPrefeitura.Lines.Add(ACBrStr('Município: ' + fpNFSe.infNFSe.xLocEmi + '/' +
                                          fpNFSe.infNFSe.UFLocEmi));
  rlmPrefeitura.Lines.Add(ACBrStr('Ambiente Gerador: ' + ambGerToStrText(fpNFSe.infNFSe.ambGer)));
  rlmPrefeitura.Lines.Add(ACBrStr('Tipo Ambiente: ' + Ambiente));
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda02_Ide_NFSeBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  QrCode: TDelphiZXingQRCode;
  QrCodeBitmap: TBitmap;
  QRCodeData: string;
  rlImgQrCode: TRLImage;
  Row, Column: Integer;
begin
  inherited;

  if Length(fpNFSe.ChaveAcesso)=50 then
     rllChaveAcesso.Caption := ACBrStr(fpNFSe.ChaveAcesso)
  else
     rllChaveAcesso.Caption := ACBrStr(fpNFSe.CodigoVerificacao);
  rllNumNF0.Caption := fpNFSe.Numero;
  rllNumeroDPS.Caption := fpNFSe.IdentificacaoRps.Numero;

  case fpNFSe.tpEmit of
    tePrestador: rllEmitente.Caption := ACBrStr('Prestador do Serviço');
    teTomador: rllEmitente.Caption := ACBrStr('Tomador do Serviço');
  else
    // teIntermediario
    rllEmitente.Caption := ACBrStr('Intermediário do Serviço');
  end;

  rllCompetencia.Caption := IfThen(fpNFSe.Competencia > 0, FormatDateTime('dd/mm/yyyy', fpNFSe.Competencia), '');
  rllSerieDPS.Caption := fpNFSe.IdentificacaoRps.Serie;
  rllSituacao.Caption := cStatToStr(fpNFSe.infNFSe.cStat);

  rllEmissaoNFSe.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', fpNFSe.DataEmissao);
  rllEmissaoDPS.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', fpNFSe.DataEmissaoRPS);
  rllFinalidade.Caption := finNFSeToStrText(fpNFSe.IBSCBS.finNFSe);

  if fpNFSe.Link <> '' then
    PintarQRCode(fpNFSe.Link, imgQRCode.Picture.Bitmap, qrUTF8NoBOM);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda03_EmitenteBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllEmitenteNome.Caption := fpNFSe.infNFSe.emit.RazaoSocial;
  rllEmitenteEndereco.Caption := fpNFSe.infNFSe.emit.Endereco.Endereco + ', ' +
                                 fpNFSe.infNFSe.emit.Endereco.Numero + ', ' +
                                 fpNFSe.infNFSe.emit.Endereco.Bairro;

  case fpNFSe.OptanteSN of
    osnNaoOptante:
      rllEmitenteSimplesNacional.Caption := ACBrStr('Não Optante');
    osnOptanteMEI:
      rllEmitenteSimplesNacional.Caption := ACBrStr('Optante - Microempreendedor Individual (MEI)');
  else
    // osnOptanteMEEPP
    rllEmitenteSimplesNacional.Caption := ACBrStr('Optante - MicroEmpresa EPP');
  end;

  if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
    rllEmitenteCNPJ.Caption := fpNFSe.infNFSe.emit.Identificacao.Nif
  else
    rllEmitenteCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.infNFSe.emit.Identificacao.CpfCnpj);

  rllEmitenteInscMunicipal.Caption := fpNFSe.infNFSe.emit.Identificacao.InscricaoMunicipal;
  rllEmitenteEmail.Caption := fpNFSe.infNFSe.emit.Contato.Email;
  rllEmitenteMunicipio.Caption := fpNFSe.infNFSe.emit.Endereco.xMunicipio + '/' +
                                  fpNFSe.infNFSe.emit.Endereco.UF;

  if fpNFSe.OptanteSN = osnOptanteMEEPP then
  begin
    case fpNFSe.RegimeApuracaoSN of
      raFederaisMunicipalpeloSN:
        rllEmitenteRegimeApuracao.Caption := ACBrStr('Federais e Municipal pelo SN');
      raFederaisSN:
        rllEmitenteRegimeApuracao.Caption := ACBrStr('Federais pelo SN');
    else
      // raFederaisMunicipalforaSN
      rllEmitenteRegimeApuracao.Caption := ACBrStr('Federais e Municipal fora SN');
    end;
  end
  else
    rllEmitenteRegimeApuracao.Caption := '-';

  rllEmitenteTelefone.Caption := FormatarFone(fpNFSe.infNFSe.emit.Contato.Telefone);
  rllEmitenteCEP.Caption := fpNFSe.Prestador.Endereco.CodigoMunicipio + ' / ' +
                            FormatarCEP(fpNFSe.infNFSe.emit.Endereco.CEP);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda04_TomadorBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllTomaNome.Caption := fpNFSe.Tomador.RazaoSocial;
  rllTomaEndereco.Caption := fpNFSe.Tomador.Endereco.Endereco + ', ' +
                                 fpNFSe.Tomador.Endereco.Numero + ', ' +
                                 fpNFSe.Tomador.Endereco.Bairro;

  if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
    rllTomaCNPJ.Caption := fpNFSe.Tomador.IdentificacaoTomador.Nif
  else
    rllTomaCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.Tomador.IdentificacaoTomador.CpfCnpj);

  rllTomaInscMunicipal.Caption := fpNFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal;
  rllTomaEmail.Caption := fpNFSe.Tomador.Contato.Email;
  rllTomaMunicipio.Caption := fpNFSe.Tomador.Endereco.xMunicipio + '/' +
                                  fpNFSe.Tomador.Endereco.UF;
  rllTomaTelefone.Caption := FormatarFone(fpNFSe.Tomador.Contato.Telefone);
  rllTomaCEP.Caption := fpNFSe.Tomador.Endereco.CodigoMunicipio + ' / ' +
                            FormatarCEP(fpNFSe.Tomador.Endereco.CEP);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda05_DestinatarioBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllDestinatarioNaoIdentificado.Visible := True;
  rlbBanda05_Destinatario.Height := 20;
  RLLabel42.Visible := False;
//  RLLabel84.Visible := False;
//  RLLabel85.Visible := False;
  RLLabel53.Visible := False;

  rllDestNome.Caption := '';
  rllDestEndereco.Caption := '';
  rllDestCNPJ.Caption := '';
  rllDestInscMunicipal.Caption := '';
  rllDestEmail.Caption := '';
  rllDestMunicipio.Caption := '';
  rllDestTelefone.Caption := '';
  rllDestCEP.Caption := '';

  if fpNFSe.IBSCBS.dest.xNome <> '' then
  begin
    rllDestinatarioNaoIdentificado.Visible := False;
    rlbBanda05_Destinatario.Height := 120;
    RLLabel81.Visible := True;
    RLLabel84.Visible := True;
    RLLabel85.Visible := True;
    RLLabel88.Visible := True;

    rllDestNome.Caption := fpNFSe.IBSCBS.dest.xNome;
    rllDestEndereco.Caption := fpNFSe.IBSCBS.dest.ender.xLgr + ', ' +
                                   fpNFSe.IBSCBS.dest.ender.nro + ', ' +
                                   fpNFSe.IBSCBS.dest.ender.xBairro;

    if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
      rllDestCNPJ.Caption := fpNFSe.IBSCBS.dest.Nif
    else
      rllDestCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.IBSCBS.dest.CNPJCPF);

    rllDestInscMunicipal.Caption := fpNFSe.IBSCBS.dest.IM;
    rllDestEmail.Caption := fpNFSe.IBSCBS.dest.Email;
    rllInterMunicipio.Caption := IntToStr(fpNFSe.IBSCBS.dest.ender.endNac.cMun) + '/' +
                                 fpNFSe.IBSCBS.dest.ender.endNac.UF;
    rllDestTelefone.Caption := FormatarFone(fpNFSe.IBSCBS.dest.fone);
    rllDestCEP.Caption := IntToStr(fpNFSe.IBSCBS.dest.ender.endNac.cMun) + ' / ' +
                          FormatarCEP(fpNFSe.IBSCBS.dest.ender.endNac.CEP);
  end;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda06_IntermediarioBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllIntermediarioNaoIdentificado.Visible := True;
  rlbBanda06_Intermediario.Height := 20;
  RLLabel81.Visible := False;
  RLLabel84.Visible := False;
  RLLabel85.Visible := False;
  RLLabel88.Visible := False;

  rllInterNome.Caption := '';
  rllInterEndereco.Caption := '';
  rllInterCNPJ.Caption := '';
  rllInterInscMunicipal.Caption := '';
  rllInterEmail.Caption := '';
  rllInterMunicipio.Caption := '';
  rllInterTelefone.Caption := '';
  rllInterCEP.Caption := '';

  if fpNFSe.Intermediario.RazaoSocial <> '' then
  begin
    rllIntermediarioNaoIdentificado.Visible := False;
    rlbBanda06_Intermediario.Height := 120;
    RLLabel81.Visible := True;
    RLLabel84.Visible := True;
    RLLabel85.Visible := True;
    RLLabel88.Visible := True;

    rllInterNome.Caption := fpNFSe.Intermediario.RazaoSocial;
    rllInterEndereco.Caption := fpNFSe.Intermediario.Endereco.Endereco + ', ' +
                                   fpNFSe.Intermediario.Endereco.Numero + ', ' +
                                   fpNFSe.Intermediario.Endereco.Bairro;

    if fpNFSe.infNFSe.emit.Identificacao.Nif <> '' then
      rllInterCNPJ.Caption := fpNFSe.Intermediario.Identificacao.Nif
    else
      rllInterCNPJ.Caption := FormatarCNPJouCPF(fpNFSe.Intermediario.Identificacao.CpfCnpj);

    rllInterInscMunicipal.Caption := fpNFSe.Intermediario.Identificacao.InscricaoMunicipal;
    rllInterEmail.Caption := fpNFSe.Intermediario.Contato.Email;
    rllInterMunicipio.Caption := fpNFSe.Intermediario.Endereco.xMunicipio + '/' +
                                    fpNFSe.Intermediario.Endereco.UF;
    rllInterTelefone.Caption := FormatarFone(fpNFSe.Intermediario.Contato.Telefone);
    rllInterCEP.Caption := fpNFSe.Intermediario.Endereco.xMunicipio + ' / ' +
                          FormatarCEP(fpNFSe.Intermediario.Endereco.CEP);
  end;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda07_ServicoPrestadoBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  Codigo, Desc: string;
begin
  inherited;

  Codigo := fpNFSe.Servico.ItemListaServico;

  Codigo := Copy(Codigo, 1, 2) + '.' + Copy(Codigo, 3, 2) + '.' +
            Copy(Codigo, 5, 2);

  if fpNFSe.Servico.CodigoTributacaoMunicipio <> '' then
    Codigo := Codigo + '/' + fpNFSe.Servico.CodigoTributacaoMunicipio;

  If fpNFSe.infNFSe.xTribMun <> '' then
    Desc := fpNFSe.infNFSe.xTribMun
  else
    Desc := fpNFSe.infNFSe.xTribNac;

  rlmCodTribNac.Lines.Clear;
  rlmCodTribNac.Lines.Add(Codigo + ' - ' + Desc);

  rllCodigoNBS.Caption := fpNFSe.Servico.CodigoNBS;
  rllLocalPrestacao.Caption := fpNFSe.Servico.MunicipioPrestacaoServico + ' / ' +
                              CodIBGEPaisToSiglaISO2(fpNFSe.Servico.CodigoPais);

  rlmDescServico.Lines.Clear;
  rlmDescServico.Lines.Add(fpNFSe.Servico.Discriminacao);

  if Detalhar then
    rlbBanda07_ServicoPrestado.Height := 76;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda09_SubItensDataRecord(Sender: TObject;
  RecNo: Integer; CopyNo: Integer; var Eof: Boolean;
  var RecordAction: TRLRecordAction);
begin
  inherited;

  FNumItem := RecNo - 1;
  Eof := (RecNo > fpNFSe.Servico.ItemServico.Count);
  RecordAction := raUseIt;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda08_ItensServicoBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  with fpNFSe.Servico.ItemServico.Items[FNumItem] do
  begin
    rlmServicoDescricao.Lines.Clear;
    rlmServicoDescricao.Lines.Add(Descricao);
    txtServicoUnitario.Caption := FormatFloatBr(ValorUnitario);
    txtServicoQtde.Caption := FormatFloatBr(Quantidade);
    txtServicoTotal.Caption := FormatFloatBr(ValorTotal);
    txtBaseCalculo.Caption := FormatFloatBr(BaseCalculo);

    txtISS.Caption := FormatFloatBr(ValorISS);
  end;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda10_TributacaoMunicipalBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  LvDedRed: Double;
  i: Integer;
begin
  inherited;

  case fpNFSe.Servico.Valores.tribMun.tribISSQN of
    tiOperacaoTributavel:
      rllTribISSQN.Caption := ACBrStr('Operação Tributável');
    tiImunidade:
      rllTribISSQN.Caption := ACBrStr('Imunidade');
    tiExportacao:
      rllTribISSQN.Caption := ACBrStr('Exportação');
  else
    // tiNaoIncidencia
    rllTribISSQN.Caption := ACBrStr('Não Incidência');
  end;

  case fpNFSe.Servico.Valores.tribMun.tpImunidade of
    timImunidade:
      rllTipoImunidade.Caption := ACBrStr('Imunidade');
    timPatrimonio:
      rllTipoImunidade.Caption := ACBrStr('Patrimonio');
    timTemplos:
      rllTipoImunidade.Caption := ACBrStr('Templos');
    timPatrimonioPartidos:
      rllTipoImunidade.Caption := ACBrStr('Patrimonio Partidos');
    timLivros:
      rllTipoImunidade.Caption := ACBrStr('Livros');
    timFonogramas:
      rllTipoImunidade.Caption := ACBrStr('Fonogramas');
  else
    // timNenhum
    rllTipoImunidade.Caption := '-';
  end;

  rllValorTotalServico.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.ValorServicos);

  if fpNFSe.infNFSe.Valores.BaseCalculo > 0 then
    rllValorBCISSQN.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.Valores.BaseCalculo)
  else
    rllValorBCISSQN.Caption := '-';

  case fpNFSe.Servico.Valores.tribMun.tpSusp of
    tsDecisaoJudicial:
      rllSuspensao.Caption := ACBrStr('Decisão Judicial');
    tsProcessoAdm:
      rllSuspensao.Caption := ACBrStr('Processo Administrativo');
  else
    // tsNenhum
    rllSuspensao.Caption := ACBrStr('Não');
  end;

  if fpNFSe.Servico.Valores.DescontoIncondicionado > 0 then
    rllValorDescIncond.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.DescontoIncondicionado)
  else
    rllValorDescIncond.Caption := '-';

  if fpNFSe.infNFSe.Valores.Aliquota > 0 then
    rllAliquotaAplicada.Caption := FormatFloatBr(fpNFSe.infNFSe.Valores.Aliquota) + '%'
  else
    rllAliquotaAplicada.Caption := '-';

  if fpNFSe.infNFSe.xLocIncid <> '' then
  begin
    rllMunicipioIncidencia.Caption := fpNFSe.infNFSe.xLocIncid;

    if fpNFSe.Servico.Valores.tribMun.cPaisResult > 0 then
      rllMunicipioIncidencia.Caption := rllMunicipioIncidencia.Caption + ' / ' +
        CodIBGEPaisToSiglaISO2(fpNFSe.Servico.Valores.tribMun.cPaisResult);
  end
  else
    rllMunicipioIncidencia.Caption := 'Nenhum';

  if fpNFSe.Servico.Valores.tribMun.nProcesso <> '' then
    rllNumeroProcesso.Caption := fpNFSe.Servico.Valores.tribMun.nProcesso
  else
    rllNumeroProcesso.Caption := '-';

  LvDedRed := 0;
  for i := 0 to fpNFSe.Servico.Valores.DocDeducao.Count -1 do
    LvDedRed := LvDedRed + fpNFSe.Servico.Valores.DocDeducao[i].vDeducaoReducao;

  if LvDedRed = 0 then
    LvDedRed := fpNFSe.Servico.Valores.ValorDeducoes;

  if LvDedRed > 0 then
    rllValorTotalDedRed.Caption := 'R$ ' + FormatFloatBr(LvDedRed)
  else
    rllValorTotalDedRed.Caption := '-';

  case fpNFSe.Servico.Valores.tribMun.tpRetISSQN of
    trRetidoPeloTomador:
      rllRetencaoISSQN.Caption := ACBrStr('Retido Pelo Tomador');
    trRetidoPeloIntermediario:
      rllRetencaoISSQN.Caption := ACBrStr('Retido Pelo Intermediário');
  else
    // trNaoRetido
    rllRetencaoISSQN.Caption := ACBrStr('Não Retido');
  end;

  case fpNFSe.RegimeEspecialTributacao of
    retCooperativa:
      rllRegimeEspecial.Caption := ACBrStr('Cooperativa');
    retEstimativa:
      rllRegimeEspecial.Caption := ACBrStr('Estimativa');
    retMicroempresaMunicipal:
      rllRegimeEspecial.Caption := ACBrStr('Microempresa Municipal');
    retNotarioRegistrador:
      rllRegimeEspecial.Caption := ACBrStr('Notario Registrador');
    retISSQNAutonomos:
      rllRegimeEspecial.Caption := ACBrStr('Autonomos');
    retSociedadeProfissionais:
      rllRegimeEspecial.Caption := ACBrStr('Sociedade Profissionais');
    retOutros:
      rllRegimeEspecial.Caption := ACBrStr('Outros');
  else
    // retNenhum
    rllRegimeEspecial.Caption := ACBrStr('Nenhum');
  end;

  if fpNFSe.Servico.Valores.tribMun.nBM <> '' then
    rllBeneficioMunic.Caption := fpNFSe.Servico.Valores.tribMun.nBM
  else
    rllBeneficioMunic.Caption := '-';

  if fpNFSe.infNFSe.Valores.vCalcBM > 0 then
    rllCalculoBM.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.Valores.vCalcBM)
  else
    rllValorISSQNApurado.Caption := '-';

  if fpNFSe.infNFSe.Valores.ValorIss > 0 then
    rllValorISSQNApurado.Caption := 'R$ ' + FormatFloatBr(fpNFSe.infNFSe.Valores.ValorIss)
  else
    rllValorISSQNApurado.Caption := '-';
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda11_TributacaoFederalBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  lValor: Double;
begin
  inherited;

  if fpNFSe.Servico.Valores.tribFed.vRetIRRF > 0 then
    rllValorIRRF.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vRetIRRF)
  else
    rllValorIRRF.Caption := '-';

  if fpNFSe.Servico.Valores.tribFed.vRetCP > 0 then
    rllValorCP.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.tribFed.vRetCP)
  else
    rllValorCP.Caption := '-';

  { Quando tpRetPisCofins = 1 (PIS/COFINS Retido), este campo retornará 0,00 (zero).
    Nos demais casos, o campo retornará o valor informado em vPis. }
  if fpNFSe.Servico.Valores.tribFed.tpRetPisCofins = trpcRetido then
    lValor := 0
  else
    lValor := fpNFSe.Servico.Valores.tribFed.vPis;

  if lValor > 0 then
    rllValorPIS.Caption := 'R$ ' + FormatFloatBr(lValor)
  else
    rllValorPIS.Caption := '-';

  { Quando tpRetPisCofins = 1 (PIS/COFINS Retido), este campo retornará 0,00 (zero).
    Nos demais casos, o campo retornará o valor informado em vCofins. }
  if fpNFSe.Servico.Valores.tribFed.tpRetPisCofins = trpcRetido then
    lValor := 0
  else
    lValor := fpNFSe.Servico.Valores.tribFed.vCofins;

  if lValor > 0 then
    rllValorCOFINS.Caption := 'R$ ' + FormatFloatBr(lValor)
  else
    rllValorCOFINS.Caption := '-';

  { Quando tpRetPisCofins = 1 (PIS/COFINS Retido), este campo retornará o somatório dos valores
    informados nos campos vRetCSLL, vPis e vCofins. Nos demais casos, o campo retornará o
    valor informado em vRetCSLL. }
  if fpNFSe.Servico.Valores.tribFed.tpRetPisCofins = trpcRetido then
    lValor := fpNFSe.Servico.Valores.tribFed.vRetCSLL +
              fpNFSe.Servico.Valores.tribFed.vPis +
              fpNFSe.Servico.Valores.tribFed.vCofins
  else
    lValor := fpNFSe.Servico.Valores.tribFed.vRetCSLL;

  if lValor > 0 then
    rllValorCSLL.Caption := 'R$ ' + FormatFloatBr(lValor)
  else
    rllValorCSLL.Caption := '-';

  rllDescCSLL.Caption := tpRetPisCofinsDescricao(fpNFSe.Servico.Valores.tribFed.tpRetPisCofins);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda12_TributacaoFederalIBSCBSBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  aValor: Double;
begin
  inherited;

  if fpNFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum then
    rllCST.Caption := CSTIBSCBSToStr(fpNFSe.IBSCBS.valores.trib.gIBSCBS.CST) + ' / ' +
                      fpNFSe.IBSCBS.valores.trib.gIBSCBS.cClassTrib
  else
    rllCST.Caption := '-';

  if fpNFSe.IBSCBS.cIndOp <> '' then
  begin
    rllcIndOp.Caption := fpNFSe.IBSCBS.cIndOp + ' / ' +
                     IntToStr(fpNFSe.infNFSe.IBSCBS.cLocalidadeIncid) + ' / ' +
                     fpNFSe.infNFSe.IBSCBS.xLocalidadeIncid + '/' +
                     fpNFSe.infNFSe.IBSCBS.UFLocalidadeIncid;
  end
  else
    rllcIndOp.Caption := '-';

  aValor := fpNFSe.Servico.Valores.DescontoIncondicionado +
            fpNFSe.infNFSe.IBSCBS.valores.vCalcReeRepRes +
            fpNFSe.infNFSe.valores.ValorIss +
            fpNFSe.Servico.Valores.tribFed.vPis +
            fpNFSe.Servico.Valores.tribFed.vCofins;

  if aValor > 0 then
    rllExcRedBC.Caption := 'R$ ' + FormatFloatBr(aValor)
  else
    rllExcRedBC.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.vBC;

  if aValor > 0 then
    rllValorBC.Caption := 'R$ ' + FormatFloatBr(aValor)
  else
    rllValorBC.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.uf.pRedAliqUF +
            fpNFSe.infNFSe.IBSCBS.valores.mun.pRedAliqMun +
            fpNFSe.infNFSe.IBSCBS.valores.fed.pRedAliqCBS;

  if aValor > 0 then
    rllRedAliquota.Caption := FormatFloatBr(fpNFSe.infNFSe.IBSCBS.valores.uf.pRedAliqUF) + '% ' +
        FormatFloatBr(fpNFSe.infNFSe.IBSCBS.valores.mun.pRedAliqMun) + '% ' +
        FormatFloatBr(fpNFSe.infNFSe.IBSCBS.valores.fed.pRedAliqCBS) + '%'
  else
    rllRedAliquota.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.uf.pIBSUF +
            fpNFSe.infNFSe.IBSCBS.valores.mun.pIBSMun;

  if aValor > 0 then
    rllAliquotaIBS.Caption := FormatFloatBr(fpNFSe.infNFSe.IBSCBS.valores.uf.pIBSUF) + '% ' +
        FormatFloatBr(fpNFSe.infNFSe.IBSCBS.valores.mun.pIBSMun) + '%'
  else
    rllAliquotaIBS.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.mun.pAliqEfetMun;

  if aValor > 0 then
    rllAliqEfetIBSMun.Caption := FormatFloatBr(aValor) + '%'
  else
    rllAliqEfetIBSMun.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.totCIBS.gIBS.gIBSMunTot.vIBSMun;

  if aValor > 0 then
    rllValorApurIBSMun.Caption := 'R$ ' + FormatFloatBr(aValor)
  else
    rllValorApurIBSMun.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.uf.pAliqEfetUF;

  if aValor > 0 then
    rllAliqEfetIBSUF.Caption := FormatFloatBr(aValor) + '%'
  else
    rllAliqEfetIBSUF.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.totCIBS.gIBS.gIBSUFTot.vIBSUF;

  if aValor > 0 then
    rllValorApurIBSUF.Caption := 'R$ ' + FormatFloatBr(aValor)
  else
    rllValorApurIBSUF.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.totCIBS.gIBS.vIBSTot;

  if aValor > 0 then
    rllValorApurIBS.Caption := 'R$ ' + FormatFloatBr(aValor)
  else
    rllValorApurIBS.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.fed.pCBS;

  if aValor > 0 then
    rllAliquotaCBS.Caption := FormatFloatBr(aValor) + '%'
  else
    rllAliquotaCBS.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.valores.fed.pAliqEfetCBS;

  if aValor > 0 then
    rllAliqEfetCBS.Caption := FormatFloatBr(aValor) + '%'
  else
    rllAliqEfetCBS.Caption := '-';

  aValor := fpNFSe.infNFSe.IBSCBS.totCIBS.gCBS.vCBS;

  if aValor > 0 then
    rllValorApurCBS.Caption := 'R$ ' + FormatFloatBr(aValor)
  else
    rllValorApurCBS.Caption := '-';
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda13_ValorTotaNFSeBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  LValor: Double;
begin
  inherited;

  if fpNFSe.Servico.Valores.ValorServicos > 0 then
    rllValorTotalServico.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.ValorServicos)
  else
    rllValorTotalServico.Caption := '-';

  if fpNFSe.Servico.Valores.DescontoIncondicionado > 0 then
    rllValorTotalDescIncond.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.DescontoIncondicionado)
  else
    rllValorTotalDescIncond.Caption := '-';

  if fpNFSe.Servico.Valores.DescontoCondicionado > 0 then
    rllValorTotalDescCond.Caption := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.DescontoCondicionado)
  else
    rllValorTotalDescCond.Caption := '-';

  LValor := fpNFSe.infNFSe.valores.vTotalRet;

  if LValor > 0 then
    rllValorTotalISSQNRetido.Caption := 'R$ ' + FormatFloatBr(LValor)
  else
    rllValorTotalISSQNRetido.Caption := '-';

  LValor := fpNFSe.infNFSe.valores.ValorLiquidoNfse;

  if LValor > 0 then
    rllValorTotalLiq.Caption := 'R$ ' + FormatFloatBr(LValor)
  else
    rllValorTotalLiq.Caption := '-';

  LValor := fpNFSe.infNFSe.IBSCBS.totCIBS.gIBS.vIBSTot +
            fpNFSe.infNFSe.IBSCBS.totCIBS.gCBS.vCBS;

  if LValor > 0 then
    rllValorTotalIBSCBS.Caption := 'R$ ' + FormatFloatBr(LValor)
  else
    rllValorTotalIBSCBS.Caption := '-';

  LValor := fpNFSe.infNFSe.IBSCBS.totCIBS.vTotNF;

  if LValor = 0 then
    LValor := fpNFSe.Servico.Valores.ValorLiquidoNfse;

  rllValorLiqIBSCBS.Caption := 'R$ ' + FormatFloatBr(LValor);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda14_InformacoesComplementaresBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
var
  LInform, LTributosFederais, LTributosEstaduais, LTributosMunicipais: string;
begin
  inherited;

  rlmDadosAdicionais.Lines.BeginUpdate;
  rlmDadosAdicionais.Lines.Clear;

  // ********** NBS
  if fpNFSe.Servico.CodigoNBS <> '' then
    rlmDadosAdicionais.Lines.Add(ACBrStr('NBS: ') + fpNFSe.Servico.CodigoNBS);

  // ********** Imovel
  if (fpNFSe.IBSCBS.imovel.cCIB <> '') or (fpNFSe.IBSCBS.imovel.inscImobFisc <> '') then
  begin
    LInform := 'Cod. CIB: ' + fpNFSe.IBSCBS.imovel.cCIB + FQuebradeLinha +
               'Insc. Imob.: ' + fpNFSe.IBSCBS.imovel.inscImobFisc;
    rlmDadosAdicionais.Lines.Add(StringReplace(LInform,
                                       FQuebradeLinha, #13#10, [rfReplaceAll]));
  end;

  // ********** Obra
  if (fpNFSe.ConstrucaoCivil.CodigoObra <> '') or (fpNFSe.ConstrucaoCivil.inscImobFisc <> '') then
  begin
    LInform := 'Cod. Obra: ' + fpNFSe.ConstrucaoCivil.CodigoObra + FQuebradeLinha +
               'Insc. Imob.: ' + fpNFSe.ConstrucaoCivil.inscImobFisc;
    rlmDadosAdicionais.Lines.Add(StringReplace(LInform,
                                       FQuebradeLinha, #13#10, [rfReplaceAll]));
  end;

  // ********** Atividade de Evento
  if fpNFSe.Servico.Evento.idAtvEvt <> '' then
  begin
    LInform := 'Cod. Evt.: ' + fpNFSe.Servico.Evento.idAtvEvt;
    rlmDadosAdicionais.Lines.Add(LInform);
  end;

  // ********** Informações Complementares

  if (fpDANFSe.OutrasInformacaoesImp <> '') or (fpNFSe.OutrasInformacoes <> '') or
     (fpNFSe.InformacoesComplementares <> '') then
  begin
    LInform := '';

    if fpDANFSe.OutrasInformacaoesImp <> '' then
      LInform := fpDANFSe.OutrasInformacaoesImp;

    if fpNFSe.OutrasInformacoes <> '' then
    begin
      if LInform <> '' then
        LInform := LInform + FQuebradeLinha;
      LInform := LInform + fpNFSe.OutrasInformacoes;
    end;

    if fpNFSe.InformacoesComplementares <> '' then
    begin
      if LInform <> '' then
        LInform := LInform + FQuebradeLinha;
      LInform := LInform + fpNFSe.InformacoesComplementares;
    end;

    LInform := 'Inf. Compl.: ' + ACBrStr(LInform);
    rlmDadosAdicionais.Lines.Add(StringReplace(LInform,
                                       FQuebradeLinha, #13#10, [rfReplaceAll]));
  end;


  // ********** Totais Aproximados dos Tributos (Obrigatório)
  if fpNFSe.Servico.Valores.totTrib.vTotTribFed > 0 then
    LTributosFederais := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.totTrib.vTotTribFed)
  else if fpNFSe.Servico.Valores.totTrib.pTotTribFed > 0 then
    LTributosFederais := FormatFloatBr(fpNFSe.Servico.Valores.totTrib.pTotTribFed) + ' %'
  else
    LTributosFederais := 'R$ ' + FormatFloatBr(0);

  if fpNFSe.Servico.Valores.totTrib.vTotTribEst > 0 then
    LTributosEstaduais := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.totTrib.vTotTribEst)
  else if fpNFSe.Servico.Valores.totTrib.pTotTribEst > 0 then
    LTributosEstaduais := FormatFloatBr(fpNFSe.Servico.Valores.totTrib.pTotTribEst) + ' %'
  else
    LTributosEstaduais := 'R$ ' + FormatFloatBr(0);

  if fpNFSe.Servico.Valores.totTrib.vTotTribMun > 0 then
    LTributosMunicipais := 'R$ ' + FormatFloatBr(fpNFSe.Servico.Valores.totTrib.vTotTribMun)
  else if fpNFSe.Servico.Valores.totTrib.pTotTribMun > 0 then
    LTributosMunicipais := FormatFloatBr(fpNFSe.Servico.Valores.totTrib.pTotTribMun) + ' %'
  else
    LTributosMunicipais := 'R$ ' + FormatFloatBr(0);

  rlmDadosAdicionais.Lines.Add(ACBrStr('Totais Aproximados dos Tributos cfe. Lei n. 12.741/2012:') +
    ' Federais: ' + LTributosFederais +
    ' Estaduais: ' + LTributosEstaduais +
    ' Municipais: ' + LTributosMunicipais);

  rlmDadosAdicionais.Lines.EndUpdate;

  rllMsgTeste.Visible := (fpDANFSe.Producao = snNao);
  rllMsgTeste.Enabled := (fpDANFSe.Producao = snNao);

  if fpDANFSe.Cancelada or (fpNFSe.NfseCancelamento.DataHora <> 0) or
    (fpNFSe.SituacaoNfse = snCancelado) or (fpNFSe.StatusRps = srCancelado) then
  begin
    rllMsgTeste.Caption := 'NFS-e CANCELADA';
    rllMsgTeste.Visible := True;
    rllMsgTeste.Enabled := True;
  end;

  if fpNFSe.subst.chSubstda <> '' then
  begin
    rllMsgTeste.Caption := ACBrStr('NFS-e SUBSTITUÍDA');
    rllMsgTeste.Visible := True;
    rllMsgTeste.Enabled := True;
  end;

  rllMsgTeste.Repaint;
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbBanda16_SistemaBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllDataHoraImpressao.Visible := NaoEstaVazio(fpDANFSe.Usuario);
  rllDataHoraImpressao.Caption := ACBrStr('DATA / HORA DA IMPRESSÃO: ') +
                               FormatDateTimeBr(Now) + ' - ' + fpDANFSe.Usuario;

  rllSistema.Visible := NaoEstaVazio(fpDANFSe.Sistema);
  rllSistema.Caption := Format('Desenvolvido por %s', [fpDANFSe.Sistema]);
end;

procedure TfrlXDANFSeRLPadraoNacional.rlbCanhotoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

  PrintIt := fpDANFSe.ImprimeCanhoto;
  rllNumNFSe.Caption := fpNFSe.Numero;
  rllNumChave.Caption := fpNFSe.CodigoVerificacao;
end;

procedure TfrlXDANFSeRLPadraoNacional.RLNFSeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

  Detalhar := ACBrNFSe.Provider.ConfigGeral.DetalharServico;

  RLNFSe.Title := 'NFS-e: ' + fpNFSe.Numero;
  TDFeReportFortes.AjustarMargem(RLNFSe, fpDANFSe);
  rlmDescServico.Visible := not Detalhar;
  rlbBanda08_ItensDetalhado.Visible := Detalhar;
  rlbBanda09_SubItens.Visible := Detalhar;
end;

end.
