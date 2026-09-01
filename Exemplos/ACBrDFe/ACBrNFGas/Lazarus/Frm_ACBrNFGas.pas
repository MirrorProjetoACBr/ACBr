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

unit Frm_ACBrNFGas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, ComCtrls, SynEdit,
  ShellAPI, zlib, ACBrDFe, ACBrDFeReport, ACBrBase,
  ACBrPosPrinter, ACBrMail, ACBrNFGas;

type

  { TfrmACBrNFGas }

  TfrmACBrNFGas = class(TForm)
    pnlMenus: TPanel;
    pnlCentral: TPanel;
    PageControl1: TPageControl;
    WBResposta: TSynEdit;
    TabSheet1: TTabSheet;
    PageControl4: TPageControl;
    TabSheet3: TTabSheet;
    lSSLLib: TLabel;
    lCryptLib: TLabel;
    lHttpLib: TLabel;
    lXmlSign: TLabel;
    gbCertificado: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    Label25: TLabel;
    sbtnGetCert: TSpeedButton;
    sbtnNumSerie: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    edtNumSerie: TEdit;
    btnDataValidade: TButton;
    btnNumSerie: TButton;
    btnSubName: TButton;
    btnCNPJ: TButton;
    btnIssuerName: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    btnSha256: TButton;
    cbAssinar: TCheckBox;
    btnHTTPS: TButton;
    btnLeituraX509: TButton;
    cbSSLLib: TComboBox;
    cbCryptLib: TComboBox;
    cbHttpLib: TComboBox;
    cbXmlSignLib: TComboBox;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    sbtnPathSalvar: TSpeedButton;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label42: TLabel;
    spPathSchemas: TSpeedButton;
    edtPathLogs: TEdit;
    ckSalvar: TCheckBox;
    cbFormaEmissao: TComboBox;
    cbxAtualizarXML: TCheckBox;
    cbxExibirErroSchema: TCheckBox;
    edtFormatoAlerta: TEdit;
    cbxRetirarAcentos: TCheckBox;
    cbVersaoDF: TComboBox;
    edtPathSchemas: TEdit;
    TabSheet7: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    lTimeOut: TLabel;
    lSSLLib1: TLabel;
    cbxVisualizar: TCheckBox;
    cbUF: TComboBox;
    rgTipoAmb: TRadioGroup;
    cbxSalvarSOAP: TCheckBox;
    seTimeOut: TSpinEdit;
    cbSSLType: TComboBox;
    gbProxy: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    gbxRetornoEnvio: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    cbxAjustarAut: TCheckBox;
    edtTentativas: TEdit;
    edtIntervalo: TEdit;
    edtAguardar: TEdit;
    TabSheet12: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtEmitCNPJ: TEdit;
    edtEmitIE: TEdit;
    edtEmitRazao: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitCEP: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitComp: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitCidade: TEdit;
    edtEmitUF: TEdit;
    TabSheet13: TTabSheet;
    sbPathNFGas: TSpeedButton;
    Label35: TLabel;
    Label47: TLabel;
    sbPathEvento: TSpeedButton;
    cbxSalvarArqs: TCheckBox;
    cbxPastaMensal: TCheckBox;
    cbxAdicionaLiteral: TCheckBox;
    cbxEmissaoPathNFGas: TCheckBox;
    cbxSalvaPathEvento: TCheckBox;
    cbxSepararPorCNPJ: TCheckBox;
    edtPathNFGas: TEdit;
    edtPathEvento: TEdit;
    cbxSepararPorModelo: TCheckBox;
    TabSheet2: TTabSheet;
    Label7: TLabel;
    sbtnLogoMarca: TSpeedButton;
    edtLogoMarca: TEdit;
    rgTipoDANFGas: TRadioGroup;
    TabSheet14: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    cbEmailSSL: TCheckBox;
    mmEmailMsg: TMemo;
    btnSalvarConfig: TBitBtn;
    lblColaborador: TLabel;
    lblPatrocinador: TLabel;
    lblDoar1: TLabel;
    lblDoar2: TLabel;
    pgcBotoes: TPageControl;
    tsEnvios: TTabSheet;
    tsConsultas: TTabSheet;
    tsEventos: TTabSheet;
    btnCriarEnviar: TButton;
    btnConsultar: TButton;
    btnConsultarChave: TButton;
    btnValidarRegrasNegocio: TButton;
    btnGerarXML: TButton;
    btnValidarXML: TButton;
    btnEnviarEmail: TButton;
    btnAdicionarProtocolo: TButton;
    btnCarregarXMLEnviar: TButton;
    btnValidarAssinatura: TButton;
    btnCancelarXML: TButton;
    btnCancelarChave: TButton;
    btnImprimirEvento: TButton;
    btnEnviarEventoEmail: TButton;
    pgRespostas: TPageControl;
    TabSheet5: TTabSheet;
    MemoResp: TMemo;
    TabSheet6: TTabSheet;

    TabSheet8: TTabSheet;
    memoLog: TMemo;
    TabSheet9: TTabSheet;
    trvwDocumento: TTreeView;
    TabSheet10: TTabSheet;
    memoRespWS: TMemo;
    Dados: TTabSheet;
    MemoDados: TMemo;
    ACBrPosPrinter1: TACBrPosPrinter;
    ACBrMail1: TACBrMail;
    OpenDialog1: TOpenDialog;
    gbEscPos: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    btSerial: TBitBtn;
    cbxModeloPosPrinter: TComboBox;
    cbxPorta: TComboBox;
    cbxPagCodigo: TComboBox;
    seColunas: TSpinEdit;
    seEspLinhas: TSpinEdit;
    seLinhasPular: TSpinEdit;
    cbCortarPapel: TCheckBox;
    btnImprimirDANFGas: TButton;
    btnImprimirDANFGasOffline: TButton;
    rgDANFGas: TRadioGroup;
    btnStatusServ: TButton;
    tsOutros: TTabSheet;
    btnLerArqINI: TButton;
    btnGerarArqINI: TButton;
    rgReformaTributaria: TRadioGroup;
    ACBrNFGas1: TACBrNFGas;
    Label53: TLabel;
    cbVersaoQRCode: TComboBox;
    Label41: TLabel;
    edtIdCSRT: TEdit;
    Label46: TLabel;
    edtCSRT: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure sbPathNFGasClick(Sender: TObject);
    procedure sbPathEventoClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnNumSerieClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure btnDataValidadeClick(Sender: TObject);
    procedure btnNumSerieClick(Sender: TObject);
    procedure btnSubNameClick(Sender: TObject);
    procedure btnCNPJClick(Sender: TObject);
    procedure btnIssuerNameClick(Sender: TObject);
    procedure btnSha256Click(Sender: TObject);
    procedure btnHTTPSClick(Sender: TObject);
    procedure btnLeituraX509Click(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure spPathSchemasClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure PathClick(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure lblColaboradorClick(Sender: TObject);
    procedure lblPatrocinadorClick(Sender: TObject);
    procedure lblDoar1Click(Sender: TObject);
    procedure lblDoar2Click(Sender: TObject);
    procedure lblMouseEnter(Sender: TObject);
    procedure lblMouseLeave(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
    procedure btnCriarEnviarClick(Sender: TObject);
    procedure btnCarregarXMLEnviarClick(Sender: TObject);
    procedure btnValidarRegrasNegocioClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnValidarAssinaturaClick(Sender: TObject);
    procedure btnAdicionarProtocoloClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnConsultarChaveClick(Sender: TObject);
    procedure btnCancelarXMLClick(Sender: TObject);
    procedure btnCancelarChaveClick(Sender: TObject);
    procedure btnImprimirEventoClick(Sender: TObject);
    procedure btnEnviarEventoEmailClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure btnImprimirDANFGasClick(Sender: TObject);
    procedure btnImprimirDANFGasOfflineClick(Sender: TObject);
    procedure btnLerArqINIClick(Sender: TObject);
    procedure btnGerarArqINIClick(Sender: TObject);
    procedure ACBrNFGas1GerarLog(const ALogLine: string; var Tratado: Boolean);
    procedure ACBrNFGas1StatusChange(Sender: TObject);
//    procedure ACBrNFAg1GerarLog(const ALogLine: string; var Tratado: Boolean);
//    procedure ACBrNFAg1StatusChange(Sender: TObject);
  private
    { Private declarations }
    procedure GravarConfiguracao;
    procedure LerConfiguracao;
    procedure ConfigurarComponente;
    procedure ConfigurarEmail;
    Procedure AlimentarComponente(NumDFe: String);
    procedure LoadXML(MyMemo: TMemo; SynEdit: TSynEdit);
    procedure AtualizarSSLLibsCombo;
    procedure PrepararImpressao;
  public
    { Public declarations }
  end;

var
  frmACBrNFGas: TfrmACBrNFGas;

implementation

uses
  strutils, math, TypInfo, DateUtils, synacode, blcksock, FileCtrl, Grids,
  IniFiles, Printers,
  ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.XMLHTML, ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrDFe.Conversao,
  ACBrDFeUtil, ACBrDFeSSL, ACBrDFeOpenSSL,
  ACBrXmlBase,
  ACBrNFGas.Conversao,
  Frm_Status, Frm_SelecionarCertificado, Frm_ConfiguraSerial;

const
  SELDIRHELP = 1000;

{$R *.lfm}

{ TfrmACBrNFGas }

procedure TfrmACBrNFGas.AlimentarComponente(NumDFe: String);
begin
  ACBrNFGas1.NotasFiscais.Clear;

  with ACBrNFGas1.NotasFiscais.Add.NFGas do
  begin
    // Dados de Identificação do NF3-e
    //
    Ide.cUF := UFparaCodigoUF(edtEmitUF.Text);

    // TACBrTipoAmbiente = (taProducao, taHomologacao);
    case rgTipoAmb.ItemIndex of
      0: Ide.tpAmb := taProducao;
      1: Ide.tpAmb := taHomologacao;
    end;

    Ide.modelo := 76;
    Ide.serie  := 3;
    Ide.nNF    := StrToIntDef(NumDFe, 0);
    {
      A função GerarCodigoDFe possui 2 parâmetros:
      sendo que o primeiro (obrigatório) é o numero do documento
      e o segundo (opcional) é a quantidade de digitos que o código tem.
      Os valores aceitos para o segundo parâmentros são: 7 ou 8 (padrão)
    }
    Ide.cNF := GerarCodigoDFe(Ide.nNF, 7);

    Ide.dhEmi := Now;
    // TACBrTipoEmissao = (teNormal, teOffLine);
    Ide.tpEmis  := teNormal;
    Ide.nSiteAutoriz := sa0;
    Ide.cMunFG  := 3503208;
    Ide.finNFGas := fnNormal;
    Ide.tpFat := tfNormal;
    Ide.verProc := '1.0.0.0'; //Versão do seu sistema

    // Alimentar os 2 campos abaixo só em caso de contingência
    {
    Ide.dhCont := Now;
    Ide.xJust  := 'Motivo da Contingência';
    }

    // Reforma Tributária
    if rgReformaTributaria.ItemIndex = 0 then
    begin
      // tcgNenhum, tcgUniao, tcgEstados, tcgDistritoFederal,
      // tcgMunicipios, tcgConsorcioPublico, tcgComiteGestorIBS
      Ide.gCompraGov.tpEnteGov := tcgUniao;
      Ide.gCompraGov.pRedutor := 5;
      // togNenhum, togFornecimento, togRecebimentoPag,
      // togFornecimentoPagRealizado, togRecebimentoPagFornecPosterior
      Ide.gCompraGov.tpOperGov := togFornecimento;
    end;

    // Dados do
    //
    Emit.CNPJ  := edtEmitCNPJ.Text;
    Emit.IE    := edtEmitIE.Text;
    Emit.xNome := edtEmitRazao.Text;
    Emit.xFant := edtEmitFantasia.Text;
    Emit.ISUFEmit := '';

    Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
    Emit.EnderEmit.Nro     := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl    := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun    := edtEmitCidade.Text;
    Emit.EnderEmit.CEP     := StrToIntDef(edtEmitCEP.Text, 0);
    Emit.EnderEmit.UF      := edtEmitUF.Text;
    Emit.EnderEmit.fone    := edtEmitFone.Text;
    Emit.enderEmit.email   := 'endereco@provedor.com.br';

    // Dados do Destinatário
    //
    Dest.xNome := edtEmitRazao.Text;
    Dest.CNPJCPF := edtEmitCNPJ.Text;
    Dest.idOutros := '';
    Dest.IE := edtEmitIE.Text;
    Dest.IM := '';
    Dest.cNIS := '123456789012345';
    Dest.NB := '';
    Dest.xNomeAdicional := '';

    Dest.EnderDest.xLgr    := edtEmitLogradouro.Text;
    Dest.EnderDest.Nro     := edtEmitNumero.Text;
    Dest.EnderDest.xCpl    := edtEmitComp.Text;
    Dest.EnderDest.xBairro := edtEmitBairro.Text;
    Dest.EnderDest.cMun    := StrToInt(edtEmitCodCidade.Text);
    Dest.EnderDest.xMun    := edtEmitCidade.Text;
    Dest.EnderDest.CEP     := StrToIntDef(edtEmitCEP.Text, 0);
    Dest.EnderDest.UF      := edtEmitUF.Text;
    Dest.EnderDest.fone    := edtEmitFone.Text;
    Dest.EnderDest.email   := 'endereco@provedor.com.br';

    // Dados da Ligação
    Instalacao.idInstalacao := '123';
    Instalacao.idCodCliente := '123';
    // tiCativo, tiLivre, tiParcialmenteLivre
    Instalacao.tpInstalacao := tiLivre;
    Instalacao.nContrato := '123';
    // tcComercial, tcIndustrial, tcResidencial, tcTermico, tcVeicularPosto,
    // tcVeicularFrota, tcGNC, tcGNL, tcCogeracao, tcRefinaria, tcOutros
    Instalacao.tpClasse := tcResidencial;
    Instalacao.xClasse := '';
    Instalacao.latGPS := '20.904346';
    Instalacao.longGPS := '18.624526';
    Instalacao.codRoteiroLeitura := '123';

    // Dados da Substituição
    gSub.chNFGas := '';
    // msErroLeitura, msErroPreco, msDecisaoJudicial, msErroCadastral,
    // msErroTributacao, msDecisaoReguladora
    gSub.motSub := msErroLeitura;

    gSub.gNF.CNPJ := '';
    gSub.gNF.Serie := '';
    gSub.gNF.nNF := 0;
    gSub.gNF.CompetEmis := 0;
    gSub.gNF.CompetApur := 0;
    gSub.gNF.hash115 := '';

    // Grupo de informações das volumes contratados
    with gVolContrat.New do
    begin
      // vcDemandaMinima, vcMontanteUso, vcEncargoCapacidade, vcVolumeContratado
      tpVolContrat := vcDemandaMinima;
      qUnidContrat := 100;
      nContrat := 1;
    end;

    // Dados do Medidor
    with gMed.New do
    begin
      idEqp := '123';
      dMedAnt := StrToDate('03/04/2026');
      vMedAnt := 100;
      dMedAtu := StrToDate('03/05/2026');
      vMedAtu := 100;
      // teMedidor, teConversor
      tpEqp := teMedidor;
      // tmTurbina, tmRotativo, tmDiafragma, tmUltrasonico
      tpMedidor := tmTurbina;
      nMed := 1;
    end;

    // Detalhamento de Produtos e Serviços
    with Det.New do
    begin
      nItem := 1;
      chNFGasAnt := '';
      nItemAnt := 0;

      with gNormal.gTarif.New do
      begin
        dIniTarif := StrToDate('03/04/2026');
        dFimTarif := StrToDate('03/05/2026');
        nAto := '1234';
        anoAto := 2026;
        // tfFixa, tfMedia
        tpFaixaCons := tfFixa;
        vTarifAplic := 100;
      end;

      // ioMedia, ioMedido, ioContatada, ioCalculada, ioCusto, ioSemQuantidade
      gNormal.Prod.indOrigemQtd := ioMedido;

      // Grupo para referenciar qual medição e medida estão relacionadas ao item
      // Informar para origem qtd = 1 ou 5
      gNormal.Prod.gMedicao.nMed := 0;
      gNormal.Prod.gMedicao.nContrat := 0;

      // Grupo de medida
      gNormal.Prod.gMedicao.gMedida.uMed := umm3;
      gNormal.Prod.gMedicao.gMedida.vMed := 100;
      // tmConsumidor, tmDistribuidora, tmIndependente
      gNormal.Prod.gMedicao.tpMotNaoLeitura := tmConsumidor;
      gNormal.Prod.gMedicao.xMotNaoLeitura := '';

      gNormal.Prod.cProd := '123';
      gNormal.Prod.xProd := 'Descricao do Produto';
      gNormal.Prod.cClass := 4562032;
      gNormal.Prod.CFOP := 1562;
      // umiM3, umiUnidade
      gNormal.Prod.uMed := umiM3;
      gNormal.Prod.qFaturada := 50;
      gNormal.Prod.vItem := 2;
      gNormal.Prod.fatorPCS := 2;
      gNormal.Prod.fatorPTZ := 2;
      gNormal.Prod.fatorP := 2;
      gNormal.Prod.fatorT := 2;
      gNormal.Prod.vProd := gNormal.Prod.qFaturada * gNormal.Prod.vItem;
      // tiSim, tiNao
      gNormal.Prod.indDevolucao := tiNao;
      // Grupo de antecipação de pagamento Permite informar apenas quando tpPagAnt=3
      gNormal.Prod.gPagAntecipado.chDFePagAnt := '';
      gNormal.Prod.gPagAntecipado.nItemPagAnt := 0;

      // Tributos incidentes no Produto ou Serviço
      // oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil,
      // oeNacionalConteudoImportacaoSuperior40, oeNacionalProcessosBasicos,
      // oeNacionalConteudoImportacaoInferiorIgual40,
      // oeEstrangeiraImportacaoDiretaSemSimilar, oeEstrangeiraAdquiridaBrasilSemSimilar,
      // oeNacionalConteudoImportacaoSuperior70, oeVazio
      gNormal.Imposto.orig := oeNacional;

      gNormal.Imposto.ICMS.CST := cst00;

      case gNormal.Imposto.ICMS.CST of
        cst00:
          begin
            gNormal.Imposto.ICMS.vBC := 100;
            gNormal.Imposto.ICMS.pICMS := 5;
            gNormal.Imposto.ICMS.vICMS := 100;
            gNormal.Imposto.ICMS.pFCP := 5;
            gNormal.Imposto.ICMS.vFCP := 100;
          end;

        cst10:
          begin

          end;

        cst20:
          begin

          end;

        cst40,
        cst41:
          begin

          end;

        cst51:
          begin

          end;

        cst60:
          begin

          end;

        cst70:
          begin

          end;

        cst90:
          begin

          end;
      end;

      // tiSim, tiNao
      gNormal.Imposto.indSemCST := tiNao;

      // Reforma Tributária
      gNormal.Imposto.IBSCBS.CST := cst000;
      gNormal.Imposto.IBSCBS.cClassTrib := '000001';

      gNormal.Imposto.IBSCBS.gIBSCBS.vBC := 100;

      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.pIBSUF := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.pDif := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.vDif := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.gDevTrib.vDevTrib := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.gRed.pRedAliq := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.gRed.pAliqEfet := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSUF.vIBSUF := 50;

      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.pIBSMun := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.pDif := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.vDif := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.gDevTrib.vDevTrib := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.gRed.pRedAliq := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.gRed.pAliqEfet := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSMun.vIBSMun := 50;

      // vIBS = vIBS do IBSUF + vIBS do IBSMun
      gNormal.Imposto.IBSCBS.gIBSCBS.vIBS := 100;

      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.pCBS := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.gDif.pDif := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.gDif.vDif := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.gDevTrib.vDevTrib := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.gRed.pRedAliq := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.gRed.pAliqEfet := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBS.vCBS := 50;

      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.CSTReg := cst000;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.cClassTribReg := '000001';
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.pAliqEfetRegIBSUF := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.vTribRegIBSUF := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.pAliqEfetRegIBSMun := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.vTribRegIBSMun := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.pAliqEfetRegCBS := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribRegular.vTribRegCBS := 50;
      {
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSCredPres.cCredPres := cp01;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSCredPres.pCredPres := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSCredPres.vCredPres := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gIBSCredPres.vCredPresCondSus := 50;

      gNormal.Imposto.IBSCBS.gIBSCBS.gCBSCredPres.cCredPres := cp01;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBSCredPres.pCredPres := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBSCredPres.vCredPres := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gCBSCredPres.vCredPresCondSus := 50;
      }
      // Tipo Tributação Compra Governamental
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribCompraGov.pAliqIBSUF := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribCompraGov.vTribIBSUF := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribCompraGov.pAliqIBSMun := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribCompraGov.vTribIBSMun := 50;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribCompraGov.pAliqCBS := 5;
      gNormal.Imposto.IBSCBS.gIBSCBS.gTribCompraGov.vTribCBS := 50;

      // PIS
      gNormal.Imposto.PIS.CST := pis01;
      gNormal.Imposto.PIS.vBC := 100;
      gNormal.Imposto.PIS.pPIS := 2;
      gNormal.Imposto.PIS.vPIS := gNormal.Imposto.PIS.vBC * gNormal.Imposto.PIS.pPIS / 100;

      // COFINS
      gNormal.Imposto.COFINS.CST := cof01;
      gNormal.Imposto.COFINS.vBC := 100;
      gNormal.Imposto.COFINS.pCOFINS := 1.5;
      gNormal.Imposto.COFINS.vCOFINS := gNormal.Imposto.COFINS.vBC * gNormal.Imposto.COFINS.pCOFINS / 100;

      // retTrib
      gNormal.Imposto.retTrib.vRetPIS := 100;
      gNormal.Imposto.retTrib.vRetCofins := 100;
      gNormal.Imposto.retTrib.vRetCSLL := 100;
      gNormal.Imposto.retTrib.vIRRF := 100;

      gNormal.Imposto.TxReg.vBC := 100;
      gNormal.Imposto.TxReg.pTaxa := 1.5;
      gNormal.Imposto.TxReg.vTaxa := gNormal.Imposto.TxReg.vBC * gNormal.Imposto.TxReg.pTaxa / 100;

      // Dados do grupo Processo Referenciado
      gNormal.gProcRef.vItem := 0;
      gNormal.gProcRef.qFaturada := 0;
      gNormal.gProcRef.vProd := 0;
      // tiSim, tiNao
      gNormal.gProcRef.indDevolucao := tiNao;

      //  Grupo identificador do Processo
      with gNormal.gProcRef.gProc.New do
      begin
        // tpProcAdmEstadual, tpJusticaFederal, tpJusticaEstadual,
        // tpProcAdmMunicial, tpProcAdmFederal, tpProcon
        tpProc := tpProcAdmMunicial;
        nProcesso := '123';
      end;

      // Dados de Informações Adicionais do Produto
      gNormal.infAdProd := 'dados adicionais';

      // Informar para faturamento agregador (3)
      gAgregadora.cClass := '';
      gAgregadora.vTotDFe := 0;
    end;

    // Dados do Total
    Total.vProd := 100;

    Total.vBC := 100;
    Total.vICMS := 100;
    Total.vICMSDeson := 100;
    Total.vFCP := 100;
    Total.vBCST := 100;
    Total.vST := 100;
    Total.vFCPST := 100;
    Total.vBC := 100;

    Total.vRetPIS := 100;
    Total.vRetCofins := 18;
    Total.vRetCSLL := 0;
    Total.vIRRF := 0;

    Total.vCOFINS := 0;
    Total.vPIS := 0;
    Total.vTxReg := 0;
    Total.vNF := 2;

    Total.vTotDFe := 100;

    // Reforma Tributária
    Total.IBSCBSTot.vBCIBSCBS := 100;

    Total.IBSCBSTot.gIBS.gIBSUFTot.vDif := 100;
    Total.IBSCBSTot.gIBS.gIBSUFTot.vDevTrib := 100;
    Total.IBSCBSTot.gIBS.gIBSUFTot.vIBSUF := 100;

    Total.IBSCBSTot.gIBS.gIBSMunTot.vDif := 100;
    Total.IBSCBSTot.gIBS.gIBSMunTot.vDevTrib := 100;
    Total.IBSCBSTot.gIBS.gIBSMunTot.vIBSMun := 100;

//    Total.IBSCBSTot.gIBS.vCredPres := 100;
//    Total.IBSCBSTot.gIBS.vCredPresCondSus := 100;
    Total.IBSCBSTot.gIBS.vIBS := 100;

    Total.IBSCBSTot.gCBS.vDif := 100;
    Total.IBSCBSTot.gCBS.vCBS := 100;
    Total.IBSCBSTot.gCBS.vDevTrib := 100;
//    Total.IBSCBSTot.gCBS.vCredPres := 100;
//    Total.IBSCBSTot.gCBS.vCredPresCondSus := 100;

    // Dados do Pagamento Vinculado
    {
    with pgtoVinc.pgto.New do
    begin
      tpMeioPgto := '10';
      CNPJReceb := '';
      CNPJBasePSP := '';
      nPag := 1;
      idTransacao := '';
    end;
    }
    // Dados da Fatura
    gFat.CompetFat := StrToDate('01/10/2019');
    gFat.dVencFat := StrToDate('10/11/2019');
    gFat.dApresFat := StrToDate('25/10/2019');
    gFat.dProxLeitura := StrToDate('25/11/2019');
    gFat.nFat := '123456';
    gFat.codBarras := '123456789012345678901234567890123456789012345678';
    gFat.codDebAuto := '12345678';
    gFat.codBanco := '12345678';
    gFat.codAgencia := '12345678';

    gFat.enderCorresp.xLgr    := edtEmitLogradouro.Text;
    gFat.enderCorresp.Nro     := edtEmitNumero.Text;
    gFat.enderCorresp.xCpl    := edtEmitComp.Text;
    gFat.enderCorresp.xBairro := edtEmitBairro.Text;
    gFat.enderCorresp.cMun    := StrToInt(edtEmitCodCidade.Text);
    gFat.enderCorresp.xMun    := edtEmitCidade.Text;
    gFat.enderCorresp.CEP     := StrToIntDef(edtEmitCEP.Text, 0);
    gFat.enderCorresp.UF      := edtEmitUF.Text;
    gFat.enderCorresp.fone    := edtEmitFone.Text;
    gFat.enderCorresp.email   := 'endereco@provedor.com.br';

    gFat.gPix.urlQRCodePIX := '12345678';

    gFat.infAdFat := '';

    // Dados da Agencia
    gAgencia.nomeAgenciaAtend := '';
    gAgencia.enderAgenciaAtend := '';
    gAgencia.sitioAgenciaAtend := '';
    gAgencia.infAdReg := '';

    // Histórico de Consumo
    with gAgencia.gHistCons.New do
    begin
      xHistorico := 'historico';
      medMensal := 100;

      with gCons.New do
      begin
        CompetFat := StrToDate('01/10/2019');
        // umM3
        uMed := umM3;
        qtdDias := 23;
        medDiaria := 10;
        consumo := 10;
        vFat := 10;
      end;
    end;

    // Dados de Autorização do XML
    {
    with autXML.New do
    begin
      CNPJCPF := '00000000000000';
    end;
    }
    // Dados de Informações Adicionais
    infAdic.infAdFisco := '';
    infAdic.infCpl     := 'Informações Complementares';

    // Dados do Responsável Técnico
    {
    infRespTec.CNPJ := '00000000000000';
    infRespTec.xContato := 'Nome do Contato';
    infRespTec.email := 'nome@provedor.com.br';
    infRespTec.fone := '33445566';
    }
  end;

  ACBrNFGas1.NotasFiscais.GerarNFGas;
end;

procedure TfrmACBrNFGas.AtualizarSSLLibsCombo;
begin
  cbSSLLib.ItemIndex     := Integer(ACBrNFGas1.Configuracoes.Geral.SSLLib);
  cbCryptLib.ItemIndex   := Integer(ACBrNFGas1.Configuracoes.Geral.SSLCryptLib);
  cbHttpLib.ItemIndex    := Integer(ACBrNFGas1.Configuracoes.Geral.SSLHttpLib);
  cbXmlSignLib.ItemIndex := Integer(ACBrNFGas1.Configuracoes.Geral.SSLXmlSignLib);

  cbSSLType.Enabled := (ACBrNFGas1.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]);
end;

procedure TfrmACBrNFGas.btnAdicionarProtocoloClick(Sender: TObject);
var
  NomeArq: String;
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFGas1.Consultar;

    ShowMessage(ACBrNFGas1.WebServices.Consulta.Protocolo);

    MemoResp.Lines.Text := ACBrNFGas1.WebServices.Consulta.RetWS;
    memoRespWS.Lines.Text := ACBrNFGas1.WebServices.Consulta.RetornoWS;
    LoadXML(MemoResp, WBResposta);
    NomeArq := OpenDialog1.FileName;

    if pos(UpperCase('-NFGas.xml'), UpperCase(NomeArq)) > 0 then
       NomeArq := StringReplace(NomeArq, '-NFGas.xml', '-procNFGas.xml', [rfIgnoreCase]);

    ACBrNFGas1.NotasFiscais.Items[0].GravarXML(NomeArq);
    ShowMessage('Arquivo gravado em: ' + NomeArq);
    memoLog.Lines.Add('Arquivo gravado em: ' + NomeArq);
  end;
end;

procedure TfrmACBrNFGas.btnCancelarChaveClick(Sender: TObject);
var
  Chave, idLote, CNPJ, Protocolo, Justificativa: string;
begin
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Chave da NFGas', Chave)) then
     exit;
  Chave := Trim(OnlyNumber(Chave));
  idLote := '1';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
     exit;
  CNPJ := copy(Chave,7,14);
  if not(InputQuery('WebServices Eventos: Cancelamento', 'CNPJ ou o CPF do autor do Evento', CNPJ)) then
     exit;
  Protocolo:='';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Protocolo de Autorização', Protocolo)) then
     exit;
  Justificativa := 'Justificativa do Cancelamento';
  if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa do Cancelamento', Justificativa)) then
     exit;

  ACBrNFGas1.EventoNFGas.Evento.Clear;

  with ACBrNFGas1.EventoNFGas.Evento.New do
  begin
    infEvento.chNFGas := Chave;
    infEvento.CNPJ   := CNPJ;
    infEvento.dhEvento := now;
    infEvento.tpEvento := teCancelamento;
    infEvento.detEvento.xJust := Justificativa;
    infEvento.detEvento.nProt := Protocolo;
  end;

  ACBrNFGas1.EnviarEvento(StrToInt(idLote));

  MemoResp.Lines.Text := ACBrNFGas1.WebServices.EnvEvento.RetWS;
  memoRespWS.Lines.Text := ACBrNFGas1.WebServices.EnvEvento.RetornoWS;
  LoadXML(MemoResp, WBResposta);

  (*
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.TpAmb
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.verAplic
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.cStat
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.xMotivo
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.chNFGas
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento
  ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt
  *)
end;

procedure TfrmACBrNFGas.btnCancelarXMLClick(Sender: TObject);
var
  idLote, vAux: String;
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    idLote := '1';
    if not(InputQuery('WebServices Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
       exit;

    if not(InputQuery('WebServices Eventos: Cancelamento', 'Justificativa', vAux)) then
       exit;

    ACBrNFGas1.EventoNFGas.Evento.Clear;
    ACBrNFGas1.EventoNFGas.idLote := StrToInt(idLote);

    with ACBrNFGas1.EventoNFGas.Evento.New do
    begin
      infEvento.dhEvento := now;
      infEvento.tpEvento := teCancelamento;
      infEvento.detEvento.xJust := vAux;
    end;

    ACBrNFGas1.EnviarEvento(StrToInt(idLote));

    MemoResp.Lines.Text := ACBrNFGas1.WebServices.EnvEvento.RetWS;
    memoRespWS.Lines.Text := ACBrNFGas1.WebServices.EnvEvento.RetornoWS;
    LoadXML(MemoResp, WBResposta);
    ShowMessage(IntToStr(ACBrNFGas1.WebServices.EnvEvento.cStat));
    ShowMessage(ACBrNFGas1.WebServices.EnvEvento.EventoRetorno.RetInfEvento.nProt);
  end;
end;

procedure TfrmACBrNFGas.btnCarregarXMLEnviarClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName, False);

    with ACBrNFGas1.NotasFiscais.Items[0].NFGas do
    begin
      Emit.CNPJ              := edtEmitCNPJ.Text;
      Emit.IE                := edtEmitIE.Text;
      Emit.xNome             := edtEmitRazao.Text;
      Emit.xFant             := edtEmitFantasia.Text;

      Emit.EnderEmit.fone    := edtEmitFone.Text;
      Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
      Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
      Emit.EnderEmit.nro     := edtEmitNumero.Text;
      Emit.EnderEmit.xCpl    := edtEmitComp.Text;
      Emit.EnderEmit.xBairro := edtEmitBairro.Text;
      Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
      Emit.EnderEmit.xMun    := edtEmitCidade.Text;
      Emit.EnderEmit.UF      := edtEmitUF.Text;
    end;

    ACBrNFGas1.Enviar('1');

    MemoResp.Lines.Text := ACBrNFGas1.WebServices.Enviar.RetWS;
    memoRespWS.Lines.Text := ACBrNFGas1.WebServices.Enviar.RetornoWS;
    LoadXML(MemoResp, WBResposta);

    MemoDados.Lines.Add('');
    MemoDados.Lines.Add('Envio NFGas');
    MemoDados.Lines.Add('tpAmb: '+ TipoAmbienteToStr(ACBrNFGas1.WebServices.Enviar.TpAmb));
    MemoDados.Lines.Add('verAplic: '+ ACBrNFGas1.WebServices.Enviar.verAplic);
    MemoDados.Lines.Add('cStat: '+ IntToStr(ACBrNFGas1.WebServices.Enviar.cStat));
    MemoDados.Lines.Add('cUF: '+ IntToStr(ACBrNFGas1.WebServices.Enviar.cUF));
    MemoDados.Lines.Add('xMotivo: '+ ACBrNFGas1.WebServices.Enviar.xMotivo);
//    MemoDados.Lines.Add('cMsg: '+ IntToStr(ACBrNFGas1.WebServices.Enviar.cMsg));
//    MemoDados.Lines.Add('xMsg: '+ ACBrNFGas1.WebServices.Enviar.xMsg);
    MemoDados.Lines.Add('Protocolo: '+ ACBrNFGas1.WebServices.Enviar.Protocolo);
  end;
end;

procedure TfrmACBrNFGas.btnCNPJClick(Sender: TObject);
begin
  ShowMessage(ACBrNFGas1.SSL.CertCNPJ);
end;

procedure TfrmACBrNFGas.btnConsultarChaveClick(Sender: TObject);
var
  vChave: String;
begin
  if not(InputQuery('WebServices Consultar', 'Chave da NFGas:', vChave)) then
    exit;

  ACBrNFGas1.NotasFiscais.Clear;
  ACBrNFGas1.WebServices.Consulta.NFGasChave := vChave;
  ACBrNFGas1.WebServices.Consulta.Executar;

  MemoResp.Lines.Text := ACBrNFGas1.WebServices.Consulta.RetWS;
  memoRespWS.Lines.Text := ACBrNFGas1.WebServices.Consulta.RetornoWS;
  LoadXML(MemoResp, WBResposta);
end;

procedure TfrmACBrNFGas.btnConsultarClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFGas1.Consultar;

    ShowMessage(ACBrNFGas1.WebServices.Consulta.Protocolo);
    MemoResp.Lines.Text := ACBrNFGas1.WebServices.Consulta.RetWS;
    memoRespWS.Lines.Text := ACBrNFGas1.WebServices.Consulta.RetornoWS;
    LoadXML(MemoResp, WBResposta);
  end;
end;

procedure TfrmACBrNFGas.btnCriarEnviarClick(Sender: TObject);
var
  vAux, vNumLote: String;
begin
  if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
    exit;

  if not(InputQuery('WebServices Enviar', 'Numero do Lote', vNumLote)) then
    exit;

  vNumLote := OnlyNumber(vNumLote);

  if Trim(vNumLote) = '' then
  begin
    MessageDlg('Número do Lote inválido.', mtError,[mbok], 0);
    exit;
  end;

  AlimentarComponente(vAux);

  ACBrNFGas1.Enviar(vNumLote, True);

  pgRespostas.ActivePageIndex := 1;

  MemoResp.Lines.Text := ACBrNFGas1.WebServices.Enviar.RetWS;
  memoRespWS.Lines.Text := ACBrNFGas1.WebServices.Enviar.RetornoWS;
  LoadXML(MemoResp, WBResposta);

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Envio NFGas');
  MemoDados.Lines.Add('tpAmb: ' + TipoAmbienteToStr(ACBrNFGas1.WebServices.Enviar.TpAmb));
  MemoDados.Lines.Add('verAplic: ' + ACBrNFGas1.WebServices.Enviar.verAplic);
  MemoDados.Lines.Add('cStat: ' + IntToStr(ACBrNFGas1.WebServices.Enviar.cStat));
  MemoDados.Lines.Add('cUF: ' + IntToStr(ACBrNFGas1.WebServices.Enviar.cUF));
  MemoDados.Lines.Add('xMotivo: ' + ACBrNFGas1.WebServices.Enviar.xMotivo);

  (*
  MemoDados.Lines.Add('Recibo: '+ ACBrNFGas1.WebServices.Enviar.Recibo);
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].tpAmb
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].verAplic
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].chNFGas
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].dhRecbto
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].nProt
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].digVal
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].cStat
  ACBrNFGas1.WebServices.Retorno.NFGasRetorno.ProtNFGas.Items[0].xMotivo
  *)
end;

procedure TfrmACBrNFGas.btnDataValidadeClick(Sender: TObject);
begin
  ShowMessage(FormatDateBr(ACBrNFGas1.SSL.CertDataVenc));
end;

procedure TfrmACBrNFGas.btnEnviarEmailClick(Sender: TObject);
var
  Para: String;
  CC: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if not OpenDialog1.Execute then
    Exit;

  ACBrNFGas1.NotasFiscais.Clear;
  ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

  CC := TStringList.Create;
  try
    //CC.Add('email_1@provedor.com'); // especifique um email valido
    //CC.Add('email_2@provedor.com.br');    // especifique um email valido
    ConfigurarEmail;

    ACBrNFGas1.NotasFiscais.Items[0].EnviarEmail( Para, edtEmailAssunto.Text,
                                             mmEmailMsg.Lines
                                             , True  // Enviar PDF junto
                                             , CC    // Lista com emails que serao enviado copias - TStrings
                                             , nil); // Lista de anexos - TStrings
  finally
    CC.Free;
  end;
end;

procedure TfrmACBrNFGas.btnEnviarEventoEmailClick(Sender: TObject);
var
  Para: String;
  CC, Evento: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione ao Evento';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if not OpenDialog1.Execute then
    Exit;

  Evento := TStringList.Create;
  CC := TStringList.Create;
  try
    Evento.Clear;
    Evento.Add(OpenDialog1.FileName);
    ACBrNFGas1.EventoNFGas.Evento.Clear;
    ACBrNFGas1.EventoNFGas.LerXML(OpenDialog1.FileName);

    //CC.Add('email_1@provedor.com'); // especifique um email valido
    //CC.Add('email_2@provedor.com.br');    // especifique um email valido
    ConfigurarEmail;

    ACBrNFGas1.EnviarEmailEvento(Para
      , edtEmailAssunto.Text
      , mmEmailMsg.Lines
      , CC // Lista com emails que serao enviado copias - TStrings
      , nil // Lista de anexos - TStrings
      , nil  // ReplyTo
      );
  finally
    CC.Free;
    Evento.Free;
  end;
end;

procedure TfrmACBrNFGas.btnGerarArqINIClick(Sender: TObject);
var
  vAux: string;
  SaveDlg: TSaveDialog;
  ArqINI: TStringList;
begin
  vAux := '1';
  if not(InputQuery('Gerar Arquivo INI', 'Numero da Nota', vAux)) then
    exit;

  ACBrNFGas1.NotasFiscais.Clear;
  AlimentarComponente(vAux);
//  ACBrNFGas1.NotasFiscais.GerarNFGas;

  ArqINI := TStringList.Create;
  SaveDlg := TSaveDialog.Create(nil);
  try
    ArqINI.Text := ACBrNFGas1.NotasFiscais.GerarIni;

    SaveDlg.Title := 'Escolha o local onde salvar o INI';
    SaveDlg.DefaultExt := '*.INI';
    SaveDlg.Filter := 'Arquivo INI(*.INI)|*.INI|Arquivo ini(*.ini)|*.ini|Todos os arquivos(*.*)|*.*';

    if SaveDlg.Execute then
      ArqINI.SaveToFile(SaveDlg.FileName);

    memoLog.Lines.Add('Arquivo Salvo: ' + SaveDlg.FileName);
  finally
    SaveDlg.Free;
    ArqINI.Free;
  end;
end;

procedure TfrmACBrNFGas.btnGerarXMLClick(Sender: TObject);
var
  vAux: String;
begin
  if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
    exit;

  ACBrNFGas1.NotasFiscais.Clear;

  AlimentarComponente(vAux);

  ACBrNFGas1.NotasFiscais.Assinar;
  ACBrNFGas1.NotasFiscais.Validar;

  ACBrNFGas1.NotasFiscais.Items[0].GravarXML();

  ShowMessage('Arquivo gerado em: ' + ACBrNFGas1.NotasFiscais.Items[0].NomeArq);
  MemoDados.Lines.Add('Arquivo gerado em: ' + ACBrNFGas1.NotasFiscais.Items[0].NomeArq);

  MemoResp.Lines.LoadFromFile(ACBrNFGas1.NotasFiscais.Items[0].NomeArq);

  LoadXML(MemoResp, WBResposta);

  pgRespostas.ActivePageIndex := 1;
end;

procedure TfrmACBrNFGas.btnHTTPSClick(Sender: TObject);
var
  Acao: String;
  OldUseCert: Boolean;
begin
  Acao := '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' +
     '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' +
     'xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/"> ' +
     ' <soapenv:Header/>' +
     ' <soapenv:Body>' +
     ' <cli:consultaCEP>' +
     ' <cep>18270-170</cep>' +
     ' </cli:consultaCEP>' +
     ' </soapenv:Body>' +
     ' </soapenv:Envelope>';

  OldUseCert := ACBrNFGas1.SSL.UseCertificateHTTP;
  ACBrNFGas1.SSL.UseCertificateHTTP := False;

  try
    MemoResp.Lines.Text := ACBrNFGas1.SSL.Enviar(Acao, 'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl', '');
  finally
    ACBrNFGas1.SSL.UseCertificateHTTP := OldUseCert;
  end;

  pgRespostas.ActivePageIndex := 0;
end;

procedure TfrmACBrNFGas.btnImprimirDANFGasClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
//    if ACBrNFGas1.DANFGas = ACBrNFGasDANFGasESCPOS1 then
//      PrepararImpressao;

    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName,False);
    ACBrNFGas1.NotasFiscais.Imprimir;
  end;
end;

procedure TfrmACBrNFGas.btnImprimirDANFGasOfflineClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
//    if ACBrNFGas1.DANFGas = ACBrNFGasDANFGasESCPOS1 then
//      PrepararImpressao;

    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName,False);
    ACBrNFGas1.NotasFiscais.Imprimir;
  end;
end;

procedure TfrmACBrNFGas.btnImprimirEventoClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
  end;

  OpenDialog1.Title := 'Selecione o Evento';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.EventoNFGas.Evento.Clear;
    ACBrNFGas1.EventoNFGas.LerXML(OpenDialog1.FileName);
    ACBrNFGas1.ImprimirEvento;
  end;
end;

procedure TfrmACBrNFGas.btnIssuerNameClick(Sender: TObject);
begin
 ShowMessage(ACBrNFGas1.SSL.CertIssuerName + sLineBreak + sLineBreak +
             'Certificadora: ' + ACBrNFGas1.SSL.CertCertificadora);
end;

procedure TfrmACBrNFGas.btnLeituraX509Click(Sender: TObject);
//var
//  Erro, AName: String;
begin
  with ACBrNFGas1.SSL do
  begin
     CarregarCertificadoPublico(MemoDados.Lines.Text);
     MemoResp.Lines.Add(CertIssuerName);
     MemoResp.Lines.Add(CertRazaoSocial);
     MemoResp.Lines.Add(CertCNPJ);
     MemoResp.Lines.Add(CertSubjectName);
     MemoResp.Lines.Add(CertNumeroSerie);

    //MemoDados.Lines.LoadFromFile('c:\temp\teste2.xml');
    //MemoResp.Lines.Text := Assinar(MemoDados.Lines.Text, 'Entrada', 'Parametros');
    //Erro := '';
    //if VerificarAssinatura(MemoResp.Lines.Text, Erro, 'Parametros' ) then
    //  ShowMessage('OK')
    //else
    //  ShowMessage('ERRO: '+Erro)

    pgRespostas.ActivePageIndex := 0;
  end;
end;

procedure TfrmACBrNFGas.btnLerArqINIClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Arquivo INI';
  OpenDialog1.DefaultExt := '*.ini';
  OpenDialog1.Filter :=
    'Arquivos INI (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromIni(OpenDialog1.FileName);
    ACBrNFGas1.NotasFiscais.Assinar;
    ACBrNFGas1.NotasFiscais.GravarXML();

    memoLog.Lines.Add('Arquivo gerado em: ' + ACBrNFGas1.NotasFiscais[0].NomeArq);

    try
      ACBrNFGas1.NotasFiscais.Validar;

      if ACBrNFGas1.NotasFiscais[0].Alertas <> '' then
        memoLog.Lines.Add('Alertas: '+ACBrNFGas1.NotasFiscais[0].Alertas);

      ShowMessage('Nota Fiscal de Energia Elétrica Eletrônica Valida');
    except
      on E: Exception do
      begin
        memoLog.Lines.Add('Exception: ' + E.Message);
        memoLog.Lines.Add('Erro: ' + ACBrNFGas1.NotasFiscais[0].ErroValidacao);
        memoLog.Lines.Add('Erro Completo: ' + ACBrNFGas1.NotasFiscais[0].ErroValidacaoCompleto);
      end;
    end;
  end;
end;

procedure TfrmACBrNFGas.btnNumSerieClick(Sender: TObject);
begin
  ShowMessage(ACBrNFGas1.SSL.CertNumeroSerie);
end;

procedure TfrmACBrNFGas.btnSalvarConfigClick(Sender: TObject);
begin
  GravarConfiguracao;
end;

procedure TfrmACBrNFGas.btnSha256Click(Sender: TObject);
var
  Ahash: AnsiString;
begin
  Ahash := ACBrNFGas1.SSL.CalcHash(Edit1.Text, dgstSHA256, outBase64, cbAssinar.Checked);
  MemoResp.Lines.Add( Ahash );
  pgRespostas.ActivePageIndex := 0;
end;

procedure TfrmACBrNFGas.btnStatusServClick(Sender: TObject);
begin
  ACBrNFGas1.WebServices.StatusServico.Executar;

  MemoResp.Lines.Text := ACBrNFGas1.WebServices.StatusServico.RetWS;
  memoRespWS.Lines.Text := ACBrNFGas1.WebServices.StatusServico.RetornoWS;
  LoadXML(MemoResp, WBResposta);

  pgRespostas.ActivePageIndex := 1;

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Status Serviço');
  MemoDados.Lines.Add('tpAmb: '    +TipoAmbienteToStr(ACBrNFGas1.WebServices.StatusServico.tpAmb));
  MemoDados.Lines.Add('verAplic: ' +ACBrNFGas1.WebServices.StatusServico.verAplic);
  MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFGas1.WebServices.StatusServico.cStat));
  MemoDados.Lines.Add('xMotivo: '  +ACBrNFGas1.WebServices.StatusServico.xMotivo);
  MemoDados.Lines.Add('cUF: '      +IntToStr(ACBrNFGas1.WebServices.StatusServico.cUF));
  MemoDados.Lines.Add('dhRecbto: ' +DateTimeToStr(ACBrNFGas1.WebServices.StatusServico.dhRecbto));
  MemoDados.Lines.Add('tMed: '     +IntToStr(ACBrNFGas1.WebServices.StatusServico.TMed));
  MemoDados.Lines.Add('dhRetorno: '+DateTimeToStr(ACBrNFGas1.WebServices.StatusServico.dhRetorno));
  MemoDados.Lines.Add('xObs: '     +ACBrNFGas1.WebServices.StatusServico.xObs);
end;

procedure TfrmACBrNFGas.btnSubNameClick(Sender: TObject);
begin
  ShowMessage(ACBrNFGas1.SSL.CertSubjectName + sLineBreak + sLineBreak +
              'Razão Social: ' + ACBrNFGas1.SSL.CertRazaoSocial);
end;

procedure TfrmACBrNFGas.btnValidarAssinaturaClick(Sender: TObject);
var
  Msg: String;
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    pgRespostas.ActivePageIndex := 0;
    MemoResp.Lines.Add('');
    MemoResp.Lines.Add('');

    if not ACBrNFGas1.NotasFiscais.VerificarAssinatura(Msg) then
      MemoResp.Lines.Add('Erro: '+Msg)
    else
    begin
      MemoResp.Lines.Add('OK: Assinatura Válida');
      ACBrNFGas1.SSL.CarregarCertificadoPublico( ACBrNFGas1.NotasFiscais[0].NFGas.signature.X509Certificate );
      MemoResp.Lines.Add('Assinado por: '+ ACBrNFGas1.SSL.CertRazaoSocial);
      MemoResp.Lines.Add('CNPJ: '+ ACBrNFGas1.SSL.CertCNPJ);
      MemoResp.Lines.Add('Num.Série: '+ ACBrNFGas1.SSL.CertNumeroSerie);

      ShowMessage('ASSINATURA VÁLIDA');
    end;
  end;
end;

procedure TfrmACBrNFGas.btnValidarRegrasNegocioClick(Sender: TObject);
var
  Msg, Tempo: String;
  Inicio: TDateTime;
  Ok: Boolean;
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    Inicio := Now;
    Ok := ACBrNFGas1.NotasFiscais.ValidarRegrasdeNegocios(Msg);
    Tempo := FormatDateTime('hh:nn:ss:zzz', Now - Inicio);

    if not Ok then
    begin
      MemoDados.Lines.Add('Erro: ' + Msg);
      ShowMessage('Erros encontrados' + sLineBreak + 'Tempo: ' + Tempo);
    end
    else
      ShowMessage('Tudo OK' + sLineBreak + 'Tempo: ' + Tempo);
  end;
end;

procedure TfrmACBrNFGas.btnValidarXMLClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFGas';
  OpenDialog1.DefaultExt := '*-NFGas.XML';
  OpenDialog1.Filter := 'Arquivos NFGas (*-NFGas.XML)|*-NFGas.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ACBrNFGas1.Configuracoes.Arquivos.PathSalvar;

  // Sugestão de configuração para apresentação de mensagem mais amigável ao usuário final
  ACBrNFGas1.Configuracoes.Geral.ExibirErroSchema := False;
  ACBrNFGas1.Configuracoes.Geral.FormatoAlerta := 'Campo:%DESCRICAO% - %MSG%';

  if OpenDialog1.Execute then
  begin
    ACBrNFGas1.NotasFiscais.Clear;
    ACBrNFGas1.NotasFiscais.LoadFromFile(OpenDialog1.FileName, False);

    try
      ACBrNFGas1.NotasFiscais.Validar;

      if ACBrNFGas1.NotasFiscais.Items[0].Alertas <> '' then
        MemoDados.Lines.Add('Alertas: '+ACBrNFGas1.NotasFiscais.Items[0].Alertas);

      ShowMessage('Nota Fiscal Eletrônica Valida');
    except
      on E: Exception do
      begin
        pgRespostas.ActivePage := Dados;
        MemoDados.Lines.Add('Exception: ' + E.Message);
        MemoDados.Lines.Add('Erro: ' + ACBrNFGas1.NotasFiscais.Items[0].ErroValidacao);
        MemoDados.Lines.Add('Erro Completo: ' + ACBrNFGas1.NotasFiscais.Items[0].ErroValidacaoCompleto);
      end;
    end;
  end;
end;

procedure TfrmACBrNFGas.btSerialClick(Sender: TObject);
begin
  frmConfiguraSerial.Device.Porta        := ACBrPosPrinter1.Device.Porta;
  frmConfiguraSerial.cmbPortaSerial.Text := cbxPorta.Text;
  frmConfiguraSerial.Device.ParamsString := ACBrPosPrinter1.Device.ParamsString;

  if frmConfiguraSerial.ShowModal = mrOk then
  begin
    cbxPorta.Text := frmConfiguraSerial.Device.Porta;
    ACBrPosPrinter1.Device.ParamsString := frmConfiguraSerial.Device.ParamsString;
  end;
end;

procedure TfrmACBrNFGas.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      ACBrNFGas1.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFGas.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      ACBrNFGas1.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFGas.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      ACBrNFGas1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFGas.cbSSLTypeChange(Sender: TObject);
begin
  if cbSSLType.ItemIndex <> -1 then
     ACBrNFGas1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);
end;

procedure TfrmACBrNFGas.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      ACBrNFGas1.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrNFGas.FormCreate(Sender: TObject);
var
  T: TSSLLib;
  I: TACBrTipoEmissao;
  K: TVersaoNFGas;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
  N: TACBrPosPrinterModelo;
  O: TACBrPosPaginaCodigo;
  l: Integer;
  P: TVersaoQrCode;
begin
  cbSSLLib.Items.Clear;
  for T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add( GetEnumName(TypeInfo(TSSLLib), integer(T) ) );
  cbSSLLib.ItemIndex := 0;

  cbCryptLib.Items.Clear;
  for U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add( GetEnumName(TypeInfo(TSSLCryptLib), integer(U) ) );
  cbCryptLib.ItemIndex := 0;

  cbHttpLib.Items.Clear;
  for V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add( GetEnumName(TypeInfo(TSSLHttpLib), integer(V) ) );
  cbHttpLib.ItemIndex := 0;

  cbXmlSignLib.Items.Clear;
  for X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add( GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X) ) );
  cbXmlSignLib.ItemIndex := 0;

  cbSSLType.Items.Clear;
  for Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add( GetEnumName(TypeInfo(TSSLType), integer(Y) ) );
  cbSSLType.ItemIndex := 0;

  cbFormaEmissao.Items.Clear;
  for I := Low(TACBrTipoEmissao) to High(TACBrTipoEmissao) do
     cbFormaEmissao.Items.Add( GetEnumName(TypeInfo(TACBrTipoEmissao), integer(I) ) );
  cbFormaEmissao.ItemIndex := 0;

  cbVersaoDF.Items.Clear;
  for K := Low(TVersaoNFGas) to High(TVersaoNFGas) do
     cbVersaoDF.Items.Add( GetEnumName(TypeInfo(TVersaoNFGas), integer(K) ) );
  cbVersaoDF.ItemIndex := 0;

  cbxModeloPosPrinter.Items.Clear ;
  for N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
    cbxModeloPosPrinter.Items.Add( GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ) ) ;

  cbxPagCodigo.Items.Clear ;
  for O := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
     cbxPagCodigo.Items.Add( GetEnumName(TypeInfo(TACBrPosPaginaCodigo), integer(O) ) ) ;

  cbVersaoQRCode.Items.Clear;
  for P := Low(TVersaoQrCode) to High(TVersaoQrCode) do
     cbVersaoQRCode.Items.Add( GetEnumName(TypeInfo(TVersaoQrCode), integer(P) ) );
  cbVersaoQRCode.ItemIndex := 0;

  cbxPorta.Items.Clear;
  ACBrPosPrinter1.Device.AcharPortasSeriais( cbxPorta.Items );
  cbxPorta.Items.Add('LPT1') ;
  cbxPorta.Items.Add('LPT2') ;
  cbxPorta.Items.Add('\\localhost\Epson') ;
  cbxPorta.Items.Add('c:\temp\ecf.txt') ;
  cbxPorta.Items.Add('TCP:192.168.0.31:9100') ;

  for l := 0 to Printer.Printers.Count-1 do
    cbxPorta.Items.Add('RAW:'+Printer.Printers[l]);

  cbxPorta.Items.Add('/dev/ttyS0') ;
  cbxPorta.Items.Add('/dev/ttyS1') ;
  cbxPorta.Items.Add('/dev/ttyUSB0') ;
  cbxPorta.Items.Add('/dev/ttyUSB1') ;
  cbxPorta.Items.Add('/tmp/ecf.txt') ;

  LerConfiguracao;
  pgRespostas.ActivePageIndex := 2;
end;

procedure TfrmACBrNFGas.GravarConfiguracao;
var
  IniFile: String;
  Ini: TIniFile;
  StreamMemo: TMemoryStream;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    Ini.WriteInteger('Certificado', 'SSLLib',     cbSSLLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'CryptLib',   cbCryptLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'HttpLib',    cbHttpLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'XmlSignLib', cbXmlSignLib.ItemIndex);
    Ini.WriteString( 'Certificado', 'Caminho',    edtCaminho.Text);
    Ini.WriteString( 'Certificado', 'Senha',      edtSenha.Text);
    Ini.WriteString( 'Certificado', 'NumSerie',   edtNumSerie.Text);

    Ini.WriteBool(   'Geral', 'AtualizarXML',     cbxAtualizarXML.Checked);
    Ini.WriteBool(   'Geral', 'ExibirErroSchema', cbxExibirErroSchema.Checked);
    Ini.WriteString( 'Geral', 'FormatoAlerta',    edtFormatoAlerta.Text);
    Ini.WriteInteger('Geral', 'FormaEmissao',     cbFormaEmissao.ItemIndex);
    Ini.WriteInteger('Geral', 'VersaoDF',         cbVersaoDF.ItemIndex);
    Ini.WriteInteger('Geral', 'VersaoQRCode',     cbVersaoQRCode.ItemIndex);
    Ini.WriteBool(   'Geral', 'RetirarAcentos',   cbxRetirarAcentos.Checked);
    Ini.WriteBool(   'Geral', 'Salvar',           ckSalvar.Checked);
    Ini.WriteString( 'Geral', 'PathSalvar',       edtPathLogs.Text);
    Ini.WriteString( 'Geral', 'PathSchemas',      edtPathSchemas.Text);

    Ini.WriteString( 'WebService', 'UF',         cbUF.Text);
    Ini.WriteInteger('WebService', 'Ambiente',   rgTipoAmb.ItemIndex);
    Ini.WriteBool(   'WebService', 'Visualizar', cbxVisualizar.Checked);
    Ini.WriteBool(   'WebService', 'SalvarSOAP', cbxSalvarSOAP.Checked);
    Ini.WriteBool(   'WebService', 'AjustarAut', cbxAjustarAut.Checked);
    Ini.WriteString( 'WebService', 'Aguardar',   edtAguardar.Text);
    Ini.WriteString( 'WebService', 'Tentativas', edtTentativas.Text);
    Ini.WriteString( 'WebService', 'Intervalo',  edtIntervalo.Text);
    Ini.WriteInteger('WebService', 'TimeOut',    seTimeOut.Value);
    Ini.WriteInteger('WebService', 'SSLType',    cbSSLType.ItemIndex);

    Ini.WriteString('Proxy', 'Host',  edtProxyHost.Text);
    Ini.WriteString('Proxy', 'Porta', edtProxyPorta.Text);
    Ini.WriteString('Proxy', 'User',  edtProxyUser.Text);
    Ini.WriteString('Proxy', 'Pass',  edtProxySenha.Text);

    Ini.WriteBool(  'Arquivos', 'Salvar',           cbxSalvarArqs.Checked);
    Ini.WriteBool(  'Arquivos', 'PastaMensal',      cbxPastaMensal.Checked);
    Ini.WriteBool(  'Arquivos', 'AddLiteral',       cbxAdicionaLiteral.Checked);
    Ini.WriteBool(  'Arquivos', 'EmissaoPathNFGas',  cbxEmissaoPathNFGas.Checked);
    Ini.WriteBool(  'Arquivos', 'SalvarPathEvento', cbxSalvaPathEvento.Checked);
    Ini.WriteBool(  'Arquivos', 'SepararPorCNPJ',   cbxSepararPorCNPJ.Checked);
    Ini.WriteBool(  'Arquivos', 'SepararPorModelo', cbxSepararPorModelo.Checked);
    Ini.WriteString('Arquivos', 'PathNFGas',         edtPathNFGas.Text);
    Ini.WriteString('Arquivos', 'PathEvento',       edtPathEvento.Text);

    Ini.WriteString('Emitente', 'CNPJ',        edtEmitCNPJ.Text);
    Ini.WriteString('Emitente', 'IE',          edtEmitIE.Text);
    Ini.WriteString('Emitente', 'RazaoSocial', edtEmitRazao.Text);
    Ini.WriteString('Emitente', 'Fantasia',    edtEmitFantasia.Text);
    Ini.WriteString('Emitente', 'Fone',        edtEmitFone.Text);
    Ini.WriteString('Emitente', 'CEP',         edtEmitCEP.Text);
    Ini.WriteString('Emitente', 'Logradouro',  edtEmitLogradouro.Text);
    Ini.WriteString('Emitente', 'Numero',      edtEmitNumero.Text);
    Ini.WriteString('Emitente', 'Complemento', edtEmitComp.Text);
    Ini.WriteString('Emitente', 'Bairro',      edtEmitBairro.Text);
    Ini.WriteString('Emitente', 'CodCidade',   edtEmitCodCidade.Text);
    Ini.WriteString('Emitente', 'Cidade',      edtEmitCidade.Text);
    Ini.WriteString('Emitente', 'UF',          edtEmitUF.Text);

    Ini.WriteString('Email', 'Host',    edtSmtpHost.Text);
    Ini.WriteString('Email', 'Port',    edtSmtpPort.Text);
    Ini.WriteString('Email', 'User',    edtSmtpUser.Text);
    Ini.WriteString('Email', 'Pass',    edtSmtpPass.Text);
    Ini.WriteString('Email', 'Assunto', edtEmailAssunto.Text);
    Ini.WriteBool(  'Email', 'SSL',     cbEmailSSL.Checked );

    // Responsável Técnico
    Ini.WriteString('RespTecnico', 'IdCSRT', edtIdCSRT.Text);
    Ini.WriteString('RespTecnico', 'CSRT', edtCSRT.Text);

    StreamMemo := TMemoryStream.Create;
    mmEmailMsg.Lines.SaveToStream(StreamMemo);
    StreamMemo.Seek(0,soFromBeginning);

    Ini.WriteBinaryStream('Email', 'Mensagem', StreamMemo);

    StreamMemo.Free;

    Ini.WriteInteger('DANFGas', 'Tipo',       rgTipoDANFGas.ItemIndex);
    Ini.WriteString( 'DANFGas', 'LogoMarca',  edtLogoMarca.Text);
    Ini.WriteInteger('DANFGas', 'TipoDANFGas', rgDANFGas.ItemIndex);

    INI.WriteInteger('PosPrinter', 'Modelo',            cbxModeloPosPrinter.ItemIndex);
    INI.WriteString( 'PosPrinter', 'Porta',             cbxPorta.Text);
    INI.WriteInteger('PosPrinter', 'PaginaDeCodigo',    cbxPagCodigo.ItemIndex);
    INI.WriteString( 'PosPrinter', 'ParamsString',      ACBrPosPrinter1.Device.ParamsString);
    INI.WriteInteger('PosPrinter', 'Colunas',           seColunas.Value);
    INI.WriteInteger('PosPrinter', 'EspacoLinhas',      seEspLinhas.Value);
    INI.WriteInteger('PosPrinter', 'LinhasEntreCupons', seLinhasPular.Value);
    Ini.WriteBool(   'PosPrinter', 'CortarPapel',       cbCortarPapel.Checked );

    ConfigurarComponente;
    ConfigurarEmail;
  finally
    Ini.Free;
  end;
end;

procedure TfrmACBrNFGas.lblColaboradorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TfrmACBrNFGas.lblDoar1Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TfrmACBrNFGas.lblDoar2Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TfrmACBrNFGas.lblMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold,fsUnderline];
end;

procedure TfrmACBrNFGas.lblMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold];
end;

procedure TfrmACBrNFGas.lblPatrocinadorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TfrmACBrNFGas.LerConfiguracao;
var
  IniFile: String;
  Ini: TIniFile;
  StreamMemo: TMemoryStream;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    cbSSLLib.ItemIndex     := Ini.ReadInteger('Certificado', 'SSLLib',     0);
    cbCryptLib.ItemIndex   := Ini.ReadInteger('Certificado', 'CryptLib',   0);
    cbHttpLib.ItemIndex    := Ini.ReadInteger('Certificado', 'HttpLib',    0);
    cbXmlSignLib.ItemIndex := Ini.ReadInteger('Certificado', 'XmlSignLib', 0);
    edtCaminho.Text        := Ini.ReadString( 'Certificado', 'Caminho',    '');
    edtSenha.Text          := Ini.ReadString( 'Certificado', 'Senha',      '');
    edtNumSerie.Text       := Ini.ReadString( 'Certificado', 'NumSerie',   '');

    cbxAtualizarXML.Checked     := Ini.ReadBool(   'Geral', 'AtualizarXML',     True);
    cbxExibirErroSchema.Checked := Ini.ReadBool(   'Geral', 'ExibirErroSchema', True);
    edtFormatoAlerta.Text       := Ini.ReadString( 'Geral', 'FormatoAlerta',    'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.');
    cbFormaEmissao.ItemIndex    := Ini.ReadInteger('Geral', 'FormaEmissao',     0);

    cbVersaoDF.ItemIndex      := Ini.ReadInteger('Geral', 'VersaoDF',       0);
    cbVersaoQRCode.ItemIndex  := Ini.ReadInteger('Geral', 'VersaoQRCode',   1);
    ckSalvar.Checked          := Ini.ReadBool(   'Geral', 'Salvar',         True);
    cbxRetirarAcentos.Checked := Ini.ReadBool(   'Geral', 'RetirarAcentos', True);
    edtPathLogs.Text          := Ini.ReadString( 'Geral', 'PathSalvar',     PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
    edtPathSchemas.Text       := Ini.ReadString( 'Geral', 'PathSchemas',    PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\'+GetEnumName(TypeInfo(TVersaoNFGas), integer(cbVersaoDF.ItemIndex) ));

    cbUF.ItemIndex := cbUF.Items.IndexOf(Ini.ReadString('WebService', 'UF', 'SP'));

    rgTipoAmb.ItemIndex   := Ini.ReadInteger('WebService', 'Ambiente',   0);
    cbxVisualizar.Checked := Ini.ReadBool(   'WebService', 'Visualizar', False);
    cbxSalvarSOAP.Checked := Ini.ReadBool(   'WebService', 'SalvarSOAP', False);
    cbxAjustarAut.Checked := Ini.ReadBool(   'WebService', 'AjustarAut', False);
    edtAguardar.Text      := Ini.ReadString( 'WebService', 'Aguardar',   '0');
    edtTentativas.Text    := Ini.ReadString( 'WebService', 'Tentativas', '5');
    edtIntervalo.Text     := Ini.ReadString( 'WebService', 'Intervalo',  '0');
    seTimeOut.Value       := Ini.ReadInteger('WebService', 'TimeOut',    5000);
    cbSSLType.ItemIndex   := Ini.ReadInteger('WebService', 'SSLType',    0);

    edtProxyHost.Text  := Ini.ReadString('Proxy', 'Host',  '');
    edtProxyPorta.Text := Ini.ReadString('Proxy', 'Porta', '');
    edtProxyUser.Text  := Ini.ReadString('Proxy', 'User',  '');
    edtProxySenha.Text := Ini.ReadString('Proxy', 'Pass',  '');

    cbxSalvarArqs.Checked       := Ini.ReadBool(  'Arquivos', 'Salvar',           false);
    cbxPastaMensal.Checked      := Ini.ReadBool(  'Arquivos', 'PastaMensal',      false);
    cbxAdicionaLiteral.Checked  := Ini.ReadBool(  'Arquivos', 'AddLiteral',       false);
    cbxEmissaoPathNFGas.Checked  := Ini.ReadBool(  'Arquivos', 'EmissaoPathNFGas',  false);
    cbxSalvaPathEvento.Checked  := Ini.ReadBool(  'Arquivos', 'SalvarPathEvento', false);
    cbxSepararPorCNPJ.Checked   := Ini.ReadBool(  'Arquivos', 'SepararPorCNPJ',   false);
    cbxSepararPorModelo.Checked := Ini.ReadBool(  'Arquivos', 'SepararPorModelo', false);
    edtPathNFGas.Text            := Ini.ReadString('Arquivos', 'PathNFGas',         '');
    edtPathEvento.Text          := Ini.ReadString('Arquivos', 'PathEvento',       '');

    edtEmitCNPJ.Text       := Ini.ReadString('Emitente', 'CNPJ',        '');
    edtEmitIE.Text         := Ini.ReadString('Emitente', 'IE',          '');
    edtEmitRazao.Text      := Ini.ReadString('Emitente', 'RazaoSocial', '');
    edtEmitFantasia.Text   := Ini.ReadString('Emitente', 'Fantasia',    '');
    edtEmitFone.Text       := Ini.ReadString('Emitente', 'Fone',        '');
    edtEmitCEP.Text        := Ini.ReadString('Emitente', 'CEP',         '');
    edtEmitLogradouro.Text := Ini.ReadString('Emitente', 'Logradouro',  '');
    edtEmitNumero.Text     := Ini.ReadString('Emitente', 'Numero',      '');
    edtEmitComp.Text       := Ini.ReadString('Emitente', 'Complemento', '');
    edtEmitBairro.Text     := Ini.ReadString('Emitente', 'Bairro',      '');
    edtEmitCodCidade.Text  := Ini.ReadString('Emitente', 'CodCidade',   '');
    edtEmitCidade.Text     := Ini.ReadString('Emitente', 'Cidade',      '');
    edtEmitUF.Text         := Ini.ReadString('Emitente', 'UF',          '');

    edtSmtpHost.Text     := Ini.ReadString('Email', 'Host',    '');
    edtSmtpPort.Text     := Ini.ReadString('Email', 'Port',    '');
    edtSmtpUser.Text     := Ini.ReadString('Email', 'User',    '');
    edtSmtpPass.Text     := Ini.ReadString('Email', 'Pass',    '');
    edtEmailAssunto.Text := Ini.ReadString('Email', 'Assunto', '');
    cbEmailSSL.Checked   := Ini.ReadBool(  'Email', 'SSL',     False);

    // Responsável Técnico
    edtIdCSRT.Text := Ini.ReadString('RespTecnico', 'IdCSRT', '');
    edtCSRT.Text := Ini.ReadString('RespTecnico', 'CSRT', '');

    StreamMemo := TMemoryStream.Create;
    Ini.ReadBinaryStream('Email', 'Mensagem', StreamMemo);
    mmEmailMsg.Lines.LoadFromStream(StreamMemo);
    StreamMemo.Free;

    rgTipoDaNFGas.ItemIndex := Ini.ReadInteger('DANFGas', 'Tipo',       0);
    edtLogoMarca.Text      := Ini.ReadString( 'DANFGas', 'LogoMarca',  '');
    rgDANFGas.ItemIndex     := Ini.ReadInteger('DANFGas', 'TipoDANFGas', 0);

    cbxModeloPosPrinter.ItemIndex := INI.ReadInteger('PosPrinter', 'Modelo',            Integer(ACBrPosPrinter1.Modelo));
    cbxPorta.Text                 := INI.ReadString( 'PosPrinter', 'Porta',             ACBrPosPrinter1.Porta);
    cbxPagCodigo.ItemIndex        := INI.ReadInteger('PosPrinter', 'PaginaDeCodigo',    Integer(ACBrPosPrinter1.PaginaDeCodigo));
    seColunas.Value               := INI.ReadInteger('PosPrinter', 'Colunas',           ACBrPosPrinter1.ColunasFonteNormal);
    seEspLinhas.Value             := INI.ReadInteger('PosPrinter', 'EspacoLinhas',      ACBrPosPrinter1.EspacoEntreLinhas);
    seLinhasPular.Value           := INI.ReadInteger('PosPrinter', 'LinhasEntreCupons', ACBrPosPrinter1.LinhasEntreCupons);
    cbCortarPapel.Checked         := Ini.ReadBool(   'PosPrinter', 'CortarPapel',       True);

    ACBrPosPrinter1.Device.ParamsString := INI.ReadString('PosPrinter', 'ParamsString', '');

    ConfigurarComponente;
    ConfigurarEmail;
  finally
    Ini.Free;
  end;
end;

procedure TfrmACBrNFGas.ConfigurarComponente;
var
  PathMensal: string;
begin
  ACBrNFGas1.Configuracoes.Certificados.ArquivoPFX  := edtCaminho.Text;
  ACBrNFGas1.Configuracoes.Certificados.Senha       := edtSenha.Text;
  ACBrNFGas1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
  {
  case rgDANFGas.ItemIndex of
    0: ACBrNFGas1.DANFGas := ACBrNFGasDANFGasRL1;
    1: ACBrNFGas1.DANFGas := ACBrNFGasDANFGasESCPOS1;
  end;
  }
  ACBrNFGas1.SSL.DescarregarCertificado;

  with ACBrNFGas1.Configuracoes.Geral do
  begin
    SSLLib        := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib   := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib    := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);

    AtualizarSSLLibsCombo;

    Salvar           := ckSalvar.Checked;
    ExibirErroSchema := cbxExibirErroSchema.Checked;
    RetirarAcentos   := cbxRetirarAcentos.Checked;
    FormatoAlerta    := edtFormatoAlerta.Text;
    FormaEmissao     := TACBrTipoEmissao(cbFormaEmissao.ItemIndex);
    VersaoDF         := TVersaoNFGas(cbVersaoDF.ItemIndex);
    VersaoQRCode     := TVersaoQrCode(cbVersaoQRCode.ItemIndex);
  end;

  with ACBrNFGas1.Configuracoes.WebServices do
  begin
    UF         := cbUF.Text;
    Ambiente   := StrToTipoAmbiente(IntToStr(rgTipoAmb.ItemIndex+1));
    Visualizar := cbxVisualizar.Checked;
    Salvar     := cbxSalvarSOAP.Checked;

    AjustaAguardaConsultaRet := cbxAjustarAut.Checked;

    if NaoEstaVazio(edtAguardar.Text)then
      AguardarConsultaRet := ifThen(StrToInt(edtAguardar.Text) < 1000, StrToInt(edtAguardar.Text) * 1000, StrToInt(edtAguardar.Text))
    else
      edtAguardar.Text := IntToStr(AguardarConsultaRet);

    if NaoEstaVazio(edtTentativas.Text) then
      Tentativas := StrToInt(edtTentativas.Text)
    else
      edtTentativas.Text := IntToStr(Tentativas);

    if NaoEstaVazio(edtIntervalo.Text) then
      IntervaloTentativas := ifThen(StrToInt(edtIntervalo.Text) < 1000, StrToInt(edtIntervalo.Text) * 1000, StrToInt(edtIntervalo.Text))
    else
      edtIntervalo.Text := IntToStr(ACBrNFGas1.Configuracoes.WebServices.IntervaloTentativas);

    TimeOut   := seTimeOut.Value;
    ProxyHost := edtProxyHost.Text;
    ProxyPort := edtProxyPorta.Text;
    ProxyUser := edtProxyUser.Text;
    ProxyPass := edtProxySenha.Text;
  end;

  ACBrNFGas1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);

  with ACBrNFGas1.Configuracoes.Arquivos do
  begin
    Salvar           := cbxSalvarArqs.Checked;
    SepararPorMes    := cbxPastaMensal.Checked;
    AdicionarLiteral := cbxAdicionaLiteral.Checked;
    EmissaoPathNFGas  := cbxEmissaoPathNFGas.Checked;
    SalvarEvento     := cbxSalvaPathEvento.Checked;
    SepararPorCNPJ   := cbxSepararPorCNPJ.Checked;
    SepararPorModelo := cbxSepararPorModelo.Checked;
    PathSchemas      := edtPathSchemas.Text;
    PathNFGas         := edtPathNFGas.Text;
    PathEvento       := edtPathEvento.Text;
    PathMensal       := GetPathNFGas(0);
    PathSalvar       := PathMensal;
  end;

  // IdCSRT e CSRT do Responsável Técnico, no momento só a SEFAZ-PR esta exigindo
  ACBrNFGas1.Configuracoes.RespTec.idCSRT := StrToIntDef(edtIdCSRT.Text, 0);
  ACBrNFGas1.Configuracoes.RespTec.CSRT := edtCSRT.Text;

  if ACBrNFGas1.DANFGas <> nil then
  begin
    ACBrNFGas1.DANFGas.TipoDANFGas := StrToTpImp(IntToStr(rgTipoDaNFGas.ItemIndex + 1));
    ACBrNFGas1.DANFGas.Logo       := edtLogoMarca.Text;
  end;
end;

procedure TfrmACBrNFGas.ConfigurarEmail;
begin
  ACBrMail1.Host := edtSmtpHost.Text;
  ACBrMail1.Port := edtSmtpPort.Text;
  ACBrMail1.Username := edtSmtpUser.Text;
  ACBrMail1.Password := edtSmtpPass.Text;
  ACBrMail1.From := edtSmtpUser.Text;
  ACBrMail1.SetSSL := cbEmailSSL.Checked; // SSL - Conexao Segura
  ACBrMail1.SetTLS := cbEmailSSL.Checked; // Auto TLS
  ACBrMail1.ReadingConfirmation := False; // Pede confirmacao de leitura do email
  ACBrMail1.UseThread := False;           // Aguarda Envio do Email(nao usa thread)
  ACBrMail1.FromName := 'Projeto ACBr - ACBrNFGas';
end;

procedure TfrmACBrNFGas.LoadXML(MyMemo: TMemo; SynEdit: TSynEdit);
var
  vText: String;
begin
  vText := MyMemo.Text;

  // formata resposta
  vText := StringReplace(vText, '>', '>' + LineEnding + '    ', [rfReplaceAll]);
  vText := StringReplace(vText, '<', LineEnding + '  <', [rfReplaceAll]);
  vText := StringReplace(vText, '>' + LineEnding + '    ' + LineEnding +
           '  <', '>' + LineEnding + '  <', [rfReplaceAll]);
  vText := StringReplace(vText, '  </ret', '</ret', []);

  // exibe resposta
  SynEdit.Text := Trim(vText);
end;

procedure TfrmACBrNFGas.PathClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(TEdit(Sender).Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := TEdit(Sender).Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    TEdit(Sender).Text := Dir;
end;

procedure TfrmACBrNFGas.PrepararImpressao;
begin
  ACBrPosPrinter1.Desativar;

  ACBrPosPrinter1.Modelo         := TACBrPosPrinterModelo(cbxModeloPosPrinter.ItemIndex);
  ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo(cbxPagCodigo.ItemIndex);
  ACBrPosPrinter1.Porta          := cbxPorta.Text;

  ACBrPosPrinter1.ColunasFonteNormal := seColunas.Value;
  ACBrPosPrinter1.LinhasEntreCupons  := seLinhasPular.Value;
  ACBrPosPrinter1.EspacoEntreLinhas  := seEspLinhas.Value;
  ACBrPosPrinter1.CortaPapel         := cbCortarPapel.Checked;

  ACBrPosPrinter1.Ativar;
end;

procedure TfrmACBrNFGas.sbPathEventoClick(Sender: TObject);
begin
  PathClick(edtPathEvento);
end;

procedure TfrmACBrNFGas.sbPathNFGasClick(Sender: TObject);
begin
  PathClick(edtPathNFGas);
end;

procedure TfrmACBrNFGas.sbtnCaminhoCertClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Certificado';
  OpenDialog1.DefaultExt := '*.pfx';
  OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

  if OpenDialog1.Execute then
    edtCaminho.Text := OpenDialog1.FileName;
end;

procedure TfrmACBrNFGas.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := ACBrNFGas1.SSL.SelecionarCertificado;
end;

procedure TfrmACBrNFGas.sbtnLogoMarcaClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Logo';
  OpenDialog1.DefaultExt := '*.bmp';
  OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';

  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);

  if OpenDialog1.Execute then
    edtLogoMarca.Text := OpenDialog1.FileName;
end;

procedure TfrmACBrNFGas.sbtnNumSerieClick(Sender: TObject);
var
  I: Integer;
  ASerie: String;
  AddRow: Boolean;
begin
  ACBrNFGas1.SSL.LerCertificadosStore;
  AddRow := False;

  with frmSelecionarCertificado.StringGrid1 do
  begin
    ColWidths[0] := 220;
    ColWidths[1] := 250;
    ColWidths[2] := 120;
    ColWidths[3] := 80;
    ColWidths[4] := 150;

    Cells[0, 0] := 'Num.Série';
    Cells[1, 0] := 'Razão Social';
    Cells[2, 0] := 'CNPJ';
    Cells[3, 0] := 'Validade';
    Cells[4, 0] := 'Certificadora';
  end;

  for I := 0 to ACBrNFGas1.SSL.ListaCertificados.Count-1 do
  begin
    with ACBrNFGas1.SSL.ListaCertificados[I] do
    begin
      ASerie := NumeroSerie;

      if (CNPJ <> '') then
      begin
        with frmSelecionarCertificado.StringGrid1 do
        begin
          if Addrow then
            RowCount := RowCount + 1;

          Cells[0, RowCount-1] := NumeroSerie;
          Cells[1, RowCount-1] := RazaoSocial;
          Cells[2, RowCount-1] := CNPJ;
          Cells[3, RowCount-1] := FormatDateBr(DataVenc);
          Cells[4, RowCount-1] := Certificadora;

          AddRow := True;
        end;
      end;
    end;
  end;

  frmSelecionarCertificado.ShowModal;

  if frmSelecionarCertificado.ModalResult = mrOK then
    edtNumSerie.Text := frmSelecionarCertificado.StringGrid1.Cells[0, frmSelecionarCertificado.StringGrid1.Row];
end;

procedure TfrmACBrNFGas.sbtnPathSalvarClick(Sender: TObject);
begin
  PathClick(edtPathLogs);
end;

procedure TfrmACBrNFGas.spPathSchemasClick(Sender: TObject);
begin
  PathClick(edtPathSchemas);
end;

procedure TfrmACBrNFGas.ACBrNFGas1GerarLog(const ALogLine: string;
  var Tratado: Boolean);
begin
  memoLog.Lines.Add(ALogLine);
  Tratado := True;
end;

procedure TfrmACBrNFGas.ACBrNFGas1StatusChange(Sender: TObject);
begin
  case ACBrNFGas1.Status of
    stNFGasIdle:
      begin
        if ( frmStatus <> nil ) then
          frmStatus.Hide;
      end;

    stNFGasStatusServico:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFGasRecepcao:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Enviando dados da NFGas...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFGasRetRecepcao:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Recebendo dados da NFGas...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFGasConsulta:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Consultando NFGas...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFGasEmail:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Enviando Email...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;

    stNFGasEvento:
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);

        frmStatus.lblStatus.Caption := 'Enviando Evento...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
  end;

  Application.ProcessMessages;
end;

end.
