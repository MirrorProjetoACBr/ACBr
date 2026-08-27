{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Juliomar Marchetti                              }
{                              Leonardo Gregianin                              }
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

unit ACBr.DANFSeX.FPDFPadraoNacional;

{$I ACBr.inc}

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  DateUtils,
  Math,

  ACBr_fpdf,
  ACBr_fpdf_ext,
  ACBr_fpdf_report,

  ACBrNFSeXClass,
  ACBrValidador,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,

  ACBrDFeUtil,
  ACBrDFe.Conversao,
  StrUtilsEx,

  TypInfo,

  ACBr.DANFSeX.Classes,
  ACBr.DANFSeX.FPDF.Utils,
  ACBrUtil.Compatibilidade;

const
  // NT 008, item 2.2 - Pagina A4 retrato (mm)
  cnPaginaLargura       = 210.0;
  cnPaginaAltura        = 297.0;
  cnMargem              = 3.0;     // 0,30 cm (entre 1,5 e 2,0 mm e' o exigido; 3 mm e' confortavel)
  cnLargUtil            = 204.0;   // 20,40 cm

  // NT 008, item 2.2.3 - Linhas e bordas
  cnEspBorda            = 1.0;     // 1 pt -> mm (1 pt = 0,3528 mm) - desenhado como 0,3528
  cnEspLinha            = 0.5;     // 0,5 pt -> 0,176 mm aprox.
  cnPt2Mm               = 0.3528;  // fator pt -> mm

  // NT 008, item 2.4 - Tamanhos de fonte (pontos)
  cnFTituloBloco        = 7.0;
  cnFLabelCampo         = 6.0;
  cnFLabelIdentNFSe     = 7.0;
  cnFConteudo           = 7.0;
  cnFTituloDoc          = 9.0;   // "DANFSe v2.0" e "Documento Auxiliar da NFS-e"
  cnFMunicipio          = 8.0;
  cnFAmbiente           = 6.0;
  cnFTextoQR            = 6.0;
  cnFMarcaDagua         = 50.0;
  cnFSemValidade        = 9.0;

  cAlturaLinhaVazia     = 4.5;

  // NT 008, item 2.4.5 - Cabecalho
  cnCabH                = 11.6;
  cnLogoX               = 4.9;
  cnLogoY               = 4.4;
  cnLogoW               = 40.0;
  cnLogoH               = 8.5;
  cnTituloX             = 54.1;
  cnTituloW             = 101.9;
  cnIdentMunX           = 156.2;
  cnIdentMunW           = 50.9;

  // NT 008, item 2.4.3 - QR Code
  cnQRX                 = 174.8;
  cnQRY                 = 7.0;
  cnQRSize              = 15.2;
  cnQRComplX            = 150.0;
  cnQRComplY            = 22.6;
  cnQRComplW            = 54.0;
  cnQRComplH            = 12.0;
  cURLConsultaPublica   = 'https://www.nfse.gov.br/ConsultaPublica/?tpc=1&chave=';
  cTextoQRComplemento   = 'A autenticidade desta NFS-e pode ser verificada '+ #13+
                          'pela leitura deste codigo QR ou pela consulta da'+ #13+
                          'chave de acesso no portal nacional da NFS-e';

  // Cores - NT 008, item 2.2.3
  cCorCinzaClaroR       = 242;   // 5% K
  cCorCinzaClaroG       = 242;
  cCorCinzaClaroB       = 242;
  cCorCinzaMDR          = 166;   // 35% K (marca d'agua)
  cCorCinzaMDG          = 166;
  cCorCinzaMDB          = 166;
  cCorVermelhoR         = 237;   // M100 Y100 (homologacao)
  cCorVermelhoG         = 28;
  cCorVermelhoB         = 36;

  // Mensagens fixas - NT 008, item 2.3 e 2.5
  cMsgTomadorVazio      = 'TOMADOR/ADQUIRENTE DA OPERAÇÃO NÃO IDENTIFICADO NA NFS-e';
  cMsgDestVazio         = 'DESTINATÁRIO DA OPERAÇÃO NÃO IDENTIFICADO NA NFS-e';
  cMsgDestIgualTomador  = 'O DESTINATÁRIO É O PROPRIO TOMADOR/ADQUIRENTE DA OPERACAO';
  cMsgIntermVazio       = 'INTERMEDIÁRIO DA OPERAÇÃO NÃO IDENTIFICADO NA NFS-e';
  cMsgISSQNVazio        = 'TRIBUTAÇÃO MUNICIPAL (ISSQN) - OPERAÇÃO NÃO SUJEITA AO ISSQN';
  cMsgSemValidade       = 'NFS-e SEM VALIDADE JURÍDICA';
  cMsgCancelada         = 'CANCELADA';
  cMsgSubstituida       = 'SUBSTITUÍDA';

  // Fontes - mapeamento NT 008 -> nucleos FPDF
  // NT 008 exige Arial (labels) e Microsoft Sans Serif (conteudos). Como sao
  // TTF nao-core, ficam como mapeamento logico para Helvetica (core)
  // ate que se embarque as TTFs via AddFont.
  cFontLabel            = 'Arial';  // -> "Arial"
  cFontConteudo         = 'Arial';  // -> "Microsoft Sans Serif"

type

  { TACBrDANFSeFPDFPadraoNacional }

  TACBrDANFSeFPDFPadraoNacional = class(TFPDFReport)
  {$IFDEF SUPPORTS_STRICT}
    strict private
  {$ELSE}
    private
  {$ENDIF}
    FNFSe: TNFSe;
    FCancelada: Boolean;
    FSubstituida: Boolean;
    FHomologacao: Boolean;
    FQRCode: Boolean;
    FLogoNFSe: string;
    FCabecalhoLinha1: string;
    FCabecalhoLinha2: string;
    FQuebraDeLinha: string;
    FMensagemRodape: string;
    FFormatSettings: TFormatSettings;
    FInitialized: Boolean;
    FPage: TFPDFPage;
    FDadosAux: TDadosNecessariosParaDANFSeX;
  private
    procedure InicializaValoresPadraoObjeto;

    function NN(const S: string): string;
    function Ellipsis(const S: string; MaxLen: Integer): string;
    function FormatVlr(V: Double): string;
    function FormatPerc(V: Double): string;
    function FormatCNPJCPFNIF(const ID: TIdentificacao): string;
    function FormatCNPJCPFNIFPessoa(const P: TDadosdaPessoa): string;
    function FormatTelefone(const Contato: TContato): string;
    function FormatCEPBR(const CEP: string): string;
    function FormatMunicipioUF(const End_: TEndereco;
      const NomeResolvidoXML: string = ''): string;
    function ObterUFPorCodigoMunicipio(const ACodigoMunicipio: string): string;
    function FormatIBGE_CEP(const End_: TEndereco): string;
    function FormatEnderecoCompleto(const End_: TEndereco): string;
    function FormatMunicipioUFTender(const End_: Tender): string;
    function FormatIBGE_CEPTender(const End_: Tender): string;
    function FormatEnderecoCompletoTender(const End_: Tender): string;
    function FormatDataNT(D: TDateTime): string;
    function FormatDataHoraNT(D: TDateTime): string;

    function GetChaveAcesso: string;
    function GetSituacaoNFSeDescricao: string;
    function GetSimplesNacionalDataCompetencia:string;
    function GetFinalidadeDescricao: string;
    function GetEmitenteDescricao: string;
    function GetAmbienteGeradorDescricao: string;
    function GetRegimeApuracaoSNDescricao: string;
    function GetTextoDescricaoServico: string;
    function GetTextoInformacoesComplementares: string;
    function GetTextoTotaisAproximados: string;
    function CarregarLogoNFSeBytes: TBytes;

    function PossuiTomador: Boolean;
    function PossuiDestinatario: Boolean;
    function DestinatarioEhTomador: Boolean;
    function PossuiIntermediario: Boolean;
    function PossuiISSQN: Boolean;

    procedure DesenharBordaPagina(PDF: IFPDF);
    procedure DesenharRetanguloSombreado(PDF: IFPDF; X, Y, W, H: Double);
    procedure DesenharLinhaSeparadora(PDF: IFPDF; W: Double);
    procedure DesenharTituloBloco(PDF: IFPDF; X, Y, W: Double; const Titulo: string);
    procedure DesenharTituloBlocoInline(PDF: IFPDF; X, Y, W, H: Double; const Titulo: string);
    procedure DesenharCampo(PDF: IFPDF; X, Y, W, H: Double;
      const Labl, Valor: string; Sombreado: Boolean = False;
      PermitirVazio: Boolean = False);
    procedure DesenharLinhaVazia(PDF: IFPDF; X, Y, W: Double; const Mensagem: string);

    procedure BandaCabecalho(Args: TFPDFBandDrawArgs);
    procedure BandaDadosNFSe(Args: TFPDFBandDrawArgs);
    procedure BandaPrestador(Args: TFPDFBandDrawArgs);
    procedure BandaTomador(Args: TFPDFBandDrawArgs);
    procedure BandaDestinatario(Args: TFPDFBandDrawArgs);
    procedure BandaIntermediario(Args: TFPDFBandDrawArgs);
    procedure BandaServicoPrestado(Args: TFPDFBandDrawArgs);
    procedure BandaTributacaoMunicipal(Args: TFPDFBandDrawArgs);
    procedure BandaTributacaoFederal(Args: TFPDFBandDrawArgs);
    procedure BandaTributacaoIBSCBS(Args: TFPDFBandDrawArgs);
    procedure BandaValorTotalNFSe(Args: TFPDFBandDrawArgs);
    procedure BandaInformacoesComplementares(Args: TFPDFBandDrawArgs);
    procedure BandaCanhoto(Args: TFPDFBandDrawArgs);
    procedure BandaMarcaDagua(Args: TFPDFBandDrawArgs);

    function CalcAlturaPrestador: Double;
    function CalcAlturaTomador: Double;
    function CalcAlturaDestinatario: Double;
    function CalcAlturaIntermediario: Double;
    function CalcAlturaServicoPrestado: Double;
    function CalcAlturaTributacaoMunicipal: Double;
    function CalcAlturaTributacaoIBSCBS: Double;
    function CalcAlturaInformacoesComplementares: Double;

  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;

  public
    constructor Create; reintroduce; overload;
    constructor Create(ANFSe: TNFSe); reintroduce; overload;

    procedure SalvarPDF(DadosAuxDANFSe: TDadosNecessariosParaDANFSeX; AStream: TStream); overload;
    procedure SalvarPDF(DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
      const NomeArquivoDestinoPDF: string); overload;
    procedure SalvarPDF(NFSe: TNFSe; DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
      const NomeArquivoDestinoPDF: string); overload;

    property Cancelada: Boolean read FCancelada write FCancelada;
    property Substituida: Boolean read FSubstituida write FSubstituida;
    property Homologacao: Boolean read FHomologacao write FHomologacao;
    property LogoNFSe: string read FLogoNFSe write FLogoNFSe;
    property QRCode: Boolean read FQRCode write FQRCode;
    property CabecalhoLinha1: string read FCabecalhoLinha1 write FCabecalhoLinha1;
    property CabecalhoLinha2: string read FCabecalhoLinha2 write FCabecalhoLinha2;
    property QuebraDeLinha: string read FQuebraDeLinha write FQuebraDeLinha;
    property MensagemRodape: string read FMensagemRodape write FMensagemRodape;
    property NFSe: TNFSe read FNFSe;
  end;

implementation

uses
  ACBrUtil.FilesIO,
  ACBrNFSeXConversao;

{ TACBrDANFSeFPDFPadraoNacional }

constructor TACBrDANFSeFPDFPadraoNacional.Create;
begin
  inherited Create;
  InicializaValoresPadraoObjeto;
end;

constructor TACBrDANFSeFPDFPadraoNacional.Create(ANFSe: TNFSe);
begin
  inherited Create;
  InicializaValoresPadraoObjeto;
  FNFSe := ANFSe;
end;

procedure TACBrDANFSeFPDFPadraoNacional.InicializaValoresPadraoObjeto;
begin
{$IFNDEF FPC}
{$IFDEF HAS_FORMATSETTINGS}
  FFormatSettings := TFormatSettings.Create;
{$ENDIF}
{$ENDIF}
  SetUTF8(False);
  FFormatSettings.DecimalSeparator := ',';
  FFormatSettings.ThousandSeparator := '.';

  SetFont(cFontLabel);
  // NT 008, item 2.2.2 - margem entre 1,5 e 2,0 mm; usando 3 mm (dentro da tolerancia)
  SetMargins(cnMargem, cnMargem, cnMargem, cnMargem);
end;

function TACBrDANFSeFPDFPadraoNacional.NN(const S: string): string;
begin
  // NT 008, Nota 12: campo sem informacao no XML deve ser preenchido com '-'
  if Trim(S) = '' then
    Result := '-'
  else
    Result := NativeStringToAnsi(S);
end;

function TACBrDANFSeFPDFPadraoNacional.Ellipsis(const S: string; MaxLen: Integer): string;
begin
  if (MaxLen > 3) and (Length(S) > MaxLen) then
    Result := Copy(S, 1, MaxLen - 3) + '...'
  else
    Result := S;
end;

function TACBrDANFSeFPDFPadraoNacional.FormatVlr(V: Double): string;
begin
  Result := FormatFloat('#,##0.00', V, FFormatSettings);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatPerc(V: Double): string;
begin
  Result := FormatFloat('#,##0.00', V, FFormatSettings) + '%';
end;

function TACBrDANFSeFPDFPadraoNacional.FormatCNPJCPFNIF(const ID: TIdentificacao): string;
begin
  Result := '-';
  if ID = nil then
    Exit;
  if Trim(ID.CpfCnpj) <> '' then
    Result := FormatarCNPJouCPF(ID.CpfCnpj)
  else if Trim(ID.Nif) <> '' then
    Result := 'NIF: ' + ID.Nif;
end;

function TACBrDANFSeFPDFPadraoNacional.FormatCNPJCPFNIFPessoa(const P: TDadosdaPessoa): string;
begin
  Result := '-';
  if P = nil then
    Exit;
  if Trim(P.CNPJCPF) <> '' then
    Result := FormatarCNPJouCPF(P.CNPJCPF)
  else if Trim(P.NIF) <> '' then
    Result := 'NIF: ' + P.NIF;
end;

function TACBrDANFSeFPDFPadraoNacional.FormatTelefone(const Contato: TContato): string;
begin
  Result := '-';
  if Contato = nil then
    Exit;
  Result := Trim(Contato.DDD + ' ' + Contato.Telefone);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatCEPBR(const CEP: string): string;
var
  S: string;
begin
  S := OnlyNumber(CEP);
  if Length(S) = 8 then
    Result := Copy(S, 1, 2) + '.' + Copy(S, 3, 3) + '-' + Copy(S, 6, 3)
  else
    Result := NN(CEP);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatMunicipioUF(const End_: TEndereco;
  const NomeResolvidoXML: string): string;
var
  NomeMun, UFMun: string;
begin
  Result := '-';
  if End_ = nil then Exit;
  if Trim(NomeResolvidoXML) <> '' then
    Result := Ellipsis(AnsiUpperCase(NomeResolvidoXML) + ' / ' + End_.UF, 37)
  else if Trim(End_.xMunicipio) <> '' then
    Result := Ellipsis(AnsiUpperCase(End_.xMunicipio) + ' / ' + End_.UF, 37)
  else if Trim(End_.CodigoMunicipio) <> '' then
  begin
    NomeMun := ObterNomeMunicipio(StrToIntDef(End_.CodigoMunicipio, 0), UFMun, '', False);
    if NomeMun <> '' then
      Result := Ellipsis(AnsiUpperCase(NomeMun) + ' / ' + IfThen(End_.UF <> '', End_.UF, UFMun), 37)
    else
      Result := End_.CodigoMunicipio + ' / ' + End_.UF;
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.ObterUFPorCodigoMunicipio(
  const ACodigoMunicipio: string): string;
begin
  Result := '';
  if Trim(ACodigoMunicipio) = '' then Exit;

  if Assigned(FNFSe.Prestador) and Assigned(FNFSe.Prestador.Endereco) and
     (Trim(FNFSe.Prestador.Endereco.CodigoMunicipio) = Trim(ACodigoMunicipio)) then
    Result := Trim(FNFSe.Prestador.Endereco.UF)
  else if PossuiTomador and Assigned(FNFSe.Tomador.Endereco) and
     (Trim(FNFSe.Tomador.Endereco.CodigoMunicipio) = Trim(ACodigoMunicipio)) then
    Result := Trim(FNFSe.Tomador.Endereco.UF)
  else if PossuiIntermediario and Assigned(FNFSe.Intermediario.Endereco) and
     (Trim(FNFSe.Intermediario.Endereco.CodigoMunicipio) = Trim(ACodigoMunicipio)) then
    Result := Trim(FNFSe.Intermediario.Endereco.UF);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatIBGE_CEP(const End_: TEndereco): string;
begin
  Result := '-';
  // NT 008: "nnnnnnn / nn.nnn-nnn"
  if End_ = nil then Exit;
  Result := NN(End_.CodigoMunicipio) + ' / ' + FormatCEPBR(End_.CEP);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatEnderecoCompleto(const End_: TEndereco): string;
var
  S: string;
begin
  Result := '-';
  if End_ = nil then Exit;
  S := Trim(End_.Endereco);
  if Trim(End_.Numero) <> '' then
    S := S + ', ' + End_.Numero;
  if Trim(End_.Complemento) <> '' then
    S := S + ', ' + End_.Complemento;
  if Trim(End_.Bairro) <> '' then
    S := S + ', ' + End_.Bairro;
  Result := Ellipsis(NN(S), 77);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatMunicipioUFTender(const End_: Tender): string;
var
  NomeMun, UFMun: string;
begin
  Result := '-';
  if End_ = nil then Exit;
  // NT 008: "Municipio / UF" - dest (IBSCBS) so traz cMun/UF resolvidos
  // quando o provedor preenche; senao busca na tabela nacional de
  // municipios do IBGE (ObterNomeMunicipio) antes de exibir so o codigo cru.
  if Trim(End_.DescricaoMunicipio) <> '' then
    Result := Ellipsis(AnsiUpperCase(End_.DescricaoMunicipio) + ' / ' + End_.UF, 37)
  else if Assigned(End_.endNac) and (End_.endNac.cMun <> 0) then
  begin
    NomeMun := ObterNomeMunicipio(End_.endNac.cMun, UFMun, '', False);
    if NomeMun <> '' then
      Result := Ellipsis(AnsiUpperCase(NomeMun) + ' / ' + IfThen(End_.endNac.UF <> '', End_.endNac.UF, UFMun), 37)
    else
      Result := IntToStr(End_.endNac.cMun) + ' / ' + End_.endNac.UF;
  end
  else if Assigned(End_.endExt) then
    Result := Ellipsis(End_.endExt.xCidade + ' / ' + End_.endExt.xEstProvReg, 37);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatIBGE_CEPTender(const End_: Tender): string;
begin
  Result := '-';
  if End_ = nil then Exit;
  if Assigned(End_.endNac) and (End_.endNac.cMun <> 0) then
    Result := IntToStr(End_.endNac.cMun) + ' / ' + FormatCEPBR(End_.endNac.CEP)
  else if Assigned(End_.endExt) then
    Result := NN(End_.endExt.cEndPost);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatEnderecoCompletoTender(const End_: Tender): string;
var
  S: string;
begin
  Result := '-';
  if End_ = nil then Exit;
  S := Trim(End_.xLgr);
  if Trim(End_.nro) <> '' then
    S := S + ', ' + End_.nro;
  if Trim(End_.xCpl) <> '' then
    S := S + ', ' + End_.xCpl;
  if Trim(End_.xBairro) <> '' then
    S := S + ', ' + End_.xBairro;
  Result := Ellipsis(NN(S), 77);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatDataNT(D: TDateTime): string;
begin
  if D <= 0 then
    Result := '-'
  else
    Result := FormatDateTime('dd/mm/yyyy', D);
end;

function TACBrDANFSeFPDFPadraoNacional.FormatDataHoraNT(D: TDateTime): string;
begin
  if D <= 0 then
    Result := '-'
  else
    Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', D);
end;

function TACBrDANFSeFPDFPadraoNacional.GetChaveAcesso: string;
var
  S: string;
begin
  Result := '-';
  if FNFSe = nil then Exit;
  S := OnlyNumber(FNFSe.infNFSe.ID);
  if Length(S) = 50 then
    Result := S
  else if Trim(FNFSe.ChaveAcesso) <> '' then
    Result := FNFSe.ChaveAcesso;
end;

function TACBrDANFSeFPDFPadraoNacional.GetSituacaoNFSeDescricao: string;
begin
  Result := cStatToStr(FNFSe.infNFSe.cStat);
end;

function TACBrDANFSeFPDFPadraoNacional.GetSimplesNacionalDataCompetencia: string;
begin
  case FNFSe.OptanteSN of
      osnNaoOptante:
        Result := ACBrStr('Não Optante');
      osnOptanteMEI:
        Result := ACBrStr('Optante - Microempreendedor Individual (MEI)');
    else
      // osnOptanteMEEPP
      Result := ACBrStr('Optante - MicroEmpresa EPP');
    end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetFinalidadeDescricao: string;
begin
  finNFSeToStrText(FNFSe.IBSCBS.finNFSe);
end;

function TACBrDANFSeFPDFPadraoNacional.GetEmitenteDescricao: string;
begin
  // NT 008: tpEmit - 1=Prestador, 2=Tomador, 3=Intermediario
  Result := 'Prestador';
  case Integer(FNFSe.tpEmit) of
    1: Result := 'Prestador';
    2: Result := 'Tomador';
    3: Result := 'Intermediario';
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetAmbienteGeradorDescricao: string;
begin
  // NT 008: "Ambiente Gerador" e' o sistema que gerou a NFS-e (tag ambGer),
  // nao o tipo de ambiente (producao/homologacao)
  case FNFSe.infNFSe.ambGer of
    agSistemaNacional: Result := 'Sefin Nacional NFS-e';
    agPrefeitura:      Result := 'Prefeitura Municipal';
  else
    Result := '-';
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetRegimeApuracaoSNDescricao: string;
begin
  if fNFSe.OptanteSN = osnOptanteMEEPP then
  begin
    case fNFSe.RegimeApuracaoSN of
      raFederaisMunicipalpeloSN:
        Result := ACBrStr('Federais e Municipal pelo SN');
      raFederaisSN:
        Result := ACBrStr('Federais pelo SN');
    else
      // raFederaisMunicipalforaSN
      Result := ACBrStr('Federais e Municipal fora SN');
    end;
  end
  else
      Result := '-';
end;

function TACBrDANFSeFPDFPadraoNacional.GetTextoDescricaoServico: string;
var
  S: string;
begin
  Result := '-';
  if FNFSe = nil then Exit;
  S := Trim(FNFSe.Servico.Discriminacao);
  if S = '' then Exit;

  S := StringReplace(S, sLineBreak, #10, [rfReplaceAll]);
  S := StringReplace(S, #13, #10, [rfReplaceAll]);
  S := StringReplace(S, #10, sLineBreak, [rfReplaceAll]);
  if Trim(FQuebraDeLinha) <> '' then
    S := StringReplace(S, FQuebraDeLinha, sLineBreak, [rfReplaceAll, rfIgnoreCase]);
  Result := Ellipsis(S, 1297);
end;

function TACBrDANFSeFPDFPadraoNacional.GetTextoInformacoesComplementares: string;
var
  Linhas: TStringList;
  S: string;

  procedure AddIfDef(const Rotulo, Valor: string);
  begin
    if Trim(Valor) <> '' then
      Linhas.Add(Rotulo + ' ' + Valor);
  end;

begin
  // NT 008: ordem fixa, separadores '|', encerrando com Totais Aproximados.
  Linhas := TStringList.Create;
  try
    AddIfDef('Inf. Cont.:', NativeStringToAnsi(FNFSe.OutrasInformacoes));
    AddIfDef('NFS-e Subst.:', FNFSe.NfseSubstituida);
    AddIfDef('Doc. Ref.:', FNFSe.refNF);

    // Campos novos (NT 008) - placeholders preenchiveis quando disponivel no XML
    // AddIfDef('Cod. Obra:',   FNFSe.ConstrucaoCivil.Obra);
    // AddIfDef('Insc. Imob.:', FNFSe.ConstrucaoCivil.InscricaoImobiliaria);
    // AddIfDef('Cod. Evt.:',   ... );

    AddIfDef('Inf. A. T. Mun.:', NativeStringToAnsi(FNFSe.InformacoesComplementares));

    // Totais Aproximados dos Tributos - linha fixa (NT 008, Nota 10)
    Linhas.Add(GetTextoTotaisAproximados);

    S := Linhas.Text;
    S := StringReplace(S, sLineBreak, ' | ', [rfReplaceAll]);
    S := Trim(S);
    if (Length(S) >= 2) and (Copy(S, Length(S) - 1, 2) = ' |') then
      Delete(S, Length(S) - 1, 2);
    Result := Ellipsis(S, 1997 + 200); // limite NT mais margem da linha fixa
  finally
    Linhas.Free;
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.GetTextoTotaisAproximados: string;
var
  vFed, vEst, vMun: Double;
  Sufixo: string;
begin
  vFed := FNFSe.Servico.Valores.totTrib.vTotTribFed;            // tributos federais aproximados
  vEst := FNFSe.Servico.Valores.totTrib.vTotTribEst;
  vMun := FNFSe.Servico.Valores.totTrib.vTotTribMun;

  if (vFed > 0) or (vEst > 0) or (vMun > 0) then
    Sufixo := Format('Federais: R$ %s; Estaduais: R$ %s; Municipais: R$ %s',
      [FormatVlr(vFed),
       FormatVlr(vEst),
       FormatVlr(vMun)])
  else
    Sufixo := Format('Federais: %s; Estaduais: %s; Municipais: %s',
      [FormatPerc(FNFSe.Servico.Valores.totTrib.pTotTribFed),
       FormatPerc(FNFSe.Servico.Valores.totTrib.pTotTribEst),
       FormatPerc(FNFSe.Servico.Valores.totTrib.pTotTribMun)]);

  Result := 'Totais Aproximados dos Tributos cfe. Lei no. 12.741/2012: ' + Sufixo;
end;

function TACBrDANFSeFPDFPadraoNacional.CarregarLogoNFSeBytes: TBytes;
var
  LStream: TStringStream;
  StrLen: Integer;
begin
  SetLength(Result, 0);
  if Trim(FLogoNFSe) = '' then
    Exit;

  if FileExists(FLogoNFSe) then
    ACBrUtil.FilesIO.FileToBytes(FLogoNFSe, Result)
  else
  begin
    LStream := TStringStream.Create(FLogoNFSe);
    try
      StrLen := Length(LStream.DataString);
      SetLength(Result, StrLen);
  
      if StrLen > 0 then       
        Move(LStream.DataString[1], Result[0], StrLen);

      //Result := LStream.Bytes;
      ///SetLength(Result, LStream.Size);
    finally
      LStream.Free;
    end;
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiTomador: Boolean;
begin
  Result := (FNFSe <> nil) and (FNFSe.Tomador <> nil) and
            (FNFSe.Tomador.IdentificacaoTomador <> nil) and
            (Trim(FNFSe.Tomador.IdentificacaoTomador.CpfCnpj +
                  FNFSe.Tomador.IdentificacaoTomador.Nif +
                  FNFSe.Tomador.RazaoSocial) <> '');
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiDestinatario: Boolean;
begin
  // NT 008: Destinatario da Operacao vem de infDPS/IBSCBS/dest
  Result := (FNFSe <> nil) and (FNFSe.IBSCBS <> nil) and (FNFSe.IBSCBS.dest <> nil) and
            (Trim(FNFSe.IBSCBS.dest.CNPJCPF + FNFSe.IBSCBS.dest.NIF +
                  FNFSe.IBSCBS.dest.xNome) <> '');
end;

function TACBrDANFSeFPDFPadraoNacional.DestinatarioEhTomador: Boolean;
begin
  // NT 008, item 2.3.2 - indDest = idTomadorAdquirenteDestinatarioIguais
  // indica que o destinatario e o proprio tomador/adquirente.
  Result := PossuiTomador and (not PossuiDestinatario) and
            ((FNFSe.IBSCBS = nil) or
             (FNFSe.IBSCBS.indDest = idTomadorAdquirenteDestinatarioIguais));
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiIntermediario: Boolean;
begin
  Result := (FNFSe <> nil) and (FNFSe.Intermediario <> nil) and
            (FNFSe.Intermediario.Identificacao <> nil) and
            (Trim(FNFSe.Intermediario.Identificacao.CpfCnpj +
                  FNFSe.Intermediario.RazaoSocial) <> '');
end;

function TACBrDANFSeFPDFPadraoNacional.PossuiISSQN: Boolean;
begin
  Result := (FNFSe <> nil) and (FNFSe.Servico <> nil) and
            (FNFSe.Servico.Valores.ValorIss > 0);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharBordaPagina(PDF: IFPDF);
begin
  // NT 008, item 2.2.3 - borda da pagina 1 pt
  PDF.SetLineWidth(cnPt2Mm * 1.0);
  PDF.SetDrawColor(0);
  PDF.Rect(cnMargem, cnMargem,
           cnPaginaLargura - 2 * cnMargem,
           cnPaginaAltura  - 2 * cnMargem);
  PDF.SetLineWidth(cnPt2Mm * cnEspLinha);   // restaura padrao 0,5 pt
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharRetanguloSombreado(PDF: IFPDF; X, Y, W, H: Double);
begin
  PDF.SetFillColor(cCorCinzaClaroR, cCorCinzaClaroG, cCorCinzaClaroB);
  PDF.Rect(X, Y, W, H, 'F');
  PDF.SetFillColor(255, 255, 255);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharLinhaSeparadora(PDF: IFPDF; W: Double);
begin
  PDF.SetLineWidth(cnPt2Mm * cnEspLinha);
  PDF.SetDrawColor(0);
  PDF.Line(0, 0, W, 0);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharTituloBloco(PDF: IFPDF; X, Y, W: Double;
  const Titulo: string);
const
  cHTitulo = 3.5;   // ~1 linha de 7pt + folga
begin
  // NT 008, item 2.4.1: titulo de bloco 7 pt negrito CAIXA ALTA, fundo cinza 5% K
  DesenharRetanguloSombreado(PDF, X, Y, W, cHTitulo);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFTituloBloco, 'B');
  PDF.SetTextColor(0);
  PDF.TextBox(X, Y, W, cHTitulo, UpperCase(Titulo), 'C', 'C', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharTituloBlocoInline(PDF: IFPDF;
  X, Y, W, H: Double; const Titulo: string);
begin
  DesenharRetanguloSombreado(PDF, X, Y, W, H);
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFTituloBloco, 'B');
  PDF.SetTextColor(0);
  PDF.TextBox(X + 0.5, Y, W - 1.0, H, UpperCase(Titulo), 'C', 'L', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharCampo(PDF: IFPDF; X, Y, W, H: Double;
  const Labl, Valor: string; Sombreado: Boolean; PermitirVazio: Boolean);
begin
  if Sombreado then
    DesenharRetanguloSombreado(PDF, X, Y, W, H);

  // Label - 6 pt negrito, alinhado ao topo
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelCampo, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, H, Labl, 'T', 'L', False, False, True);

  // Valor - 7 pt normal, alinhado abaixo do label
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  if PermitirVazio then
    PDF.TextBox(X + 0.5, Y + 2.3, W - 1.0, H - 2.3,
                Valor, 'T', 'L', False, False, True)
  else
    PDF.TextBox(X + 0.5, Y + 2.3, W - 1.0, H - 2.3,
                NN(Valor), 'T', 'L', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.DesenharLinhaVazia(PDF: IFPDF; X, Y, W: Double;
  const Mensagem: string);
begin
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFConteudo, 'B');
  PDF.TextBox(X, Y, W, cAlturaLinhaVazia, Mensagem, 'C', 'C', False, False, True);
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaPrestador: Double;
begin
  Result := 4 * 6.3;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaTomador: Double;
begin
  if not PossuiTomador then
    Result := cAlturaLinhaVazia
  else
    Result := 3 * 6.3;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaDestinatario: Double;
begin
  if not PossuiDestinatario then
    Result := cAlturaLinhaVazia
  else
    Result := 3 * 6.3;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaIntermediario: Double;
begin
  if not PossuiIntermediario then
    Result := cAlturaLinhaVazia
  else
    Result := 3 * 6.3;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaServicoPrestado: Double;
var
  PageSize: TFPDFPageSize;
  PDF: TFPDFExt;
  W, H: Double;
begin
  Result := 2 * 6.3 + 14.0;

  PageSize.w := FPage.PageWidth;
  PageSize.h := FPage.PageHeight;
  PDF := TFPDFExt.Create(FPage.Orientation, FPage.PageUnit, PageSize);
  try
    W := cnLargUtil - 2.0;
    PDF.SetFont(cFontConteudo, '', cnFConteudo);
    H := PDF.GetStringHeight(GetTextoDescricaoServico, W);
    if H + 2 * 6.3 + 3.0 > Result then
      Result := H + 2 * 6.3 + 3.0;
  finally
    PDF.Free;
  end;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaTributacaoMunicipal: Double;
begin
  if not PossuiISSQN then
    Result := cAlturaLinhaVazia
  else
    Result := 4 * 6.3;
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaTributacaoIBSCBS: Double;
begin
  Result := 4 * 6.3;   // titulo inline na 1a linha + 4 linhas de grid (ver Anexo I)
end;

function TACBrDANFSeFPDFPadraoNacional.CalcAlturaInformacoesComplementares: Double;
var
  PageSize: TFPDFPageSize;
  PDF: TFPDFExt;
  W, H: Double;
begin
  Result := 10.0;
  PageSize.w := FPage.PageWidth;
  PageSize.h := FPage.PageHeight;
  PDF := TFPDFExt.Create(FPage.Orientation, FPage.PageUnit, PageSize);
  try
    W := cnLargUtil - 2.0;
    PDF.SetFont(cFontConteudo, '', cnFConteudo);
    H := PDF.GetStringHeight(GetTextoInformacoesComplementares, W);
    if H + 6 > Result then
      Result := H + 6;
  finally
    PDF.Free;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaCabecalho(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W: Double;
  Stream: TBytesStream;
  Municipio: string;
  LLogoBytes: TBytes;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;

  // Borda externa do bloco - cinza claro
  DesenharRetanguloSombreado(PDF, X, Y, W, cnCabH);

  // Logomarca NFS-e (canto esquerdo) - NT 008, item 2.4.3. Sem valor padrao
  // no componente (ver CarregarLogoNFSeBytes) - se a aplicacao chamadora
  // nao informar LogoNFSe, o espaco fica em branco.
  LLogoBytes := CarregarLogoNFSeBytes;
  if Length(LLogoBytes) > 0 then
  begin
    Stream := TBytesStream.Create(LLogoBytes);
    try
      PDF.Image(cnLogoX - cnMargem, cnLogoY - cnMargem,
                cnLogoW, cnLogoH, Stream, 'L', 'C');
    finally
      Stream.Free;
    end;
  end;

  // Centro - DANFSe v2.0 + Documento Auxiliar da NFS-e
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFTituloDoc, 'B');
  PDF.SetTextColor(0);
  PDF.TextBox(cnTituloX - cnMargem, Y + 1.0, cnTituloW, 4.5,
              'DANFSe v2.0', 'T', 'C', False, False, True);
  PDF.TextBox(cnTituloX - cnMargem, Y + 5.0, cnTituloW, 4.5,
              'Documento Auxiliar da NFS-e', 'T', 'C', False, False, True);

  // NFS-e SEM VALIDADE JURIDICA - apenas em homologacao
  if FHomologacao then
  begin
    PDF.SetFont(cFontLabel);
    PDF.SetFont(cnFSemValidade, 'B');
    PDF.SetTextColor(cCorVermelhoR, cCorVermelhoG, cCorVermelhoB);
    PDF.TextBox(cnTituloX - cnMargem, Y + 8.0, cnTituloW, 3.5,
                cMsgSemValidade, 'T', 'C', False, False, True);
    PDF.SetTextColor(0);
  end;

  // Coluna direita - Municipio / Ambiente Gerador / Tipo de Ambiente
  Municipio := Trim(FCabecalhoLinha1);
  if Municipio = '' then
  begin
    Municipio := Trim(FNFSe.infNFSe.xLocEmi);
    if (Municipio = '') and Assigned(FNFSe.Prestador) and Assigned(FNFSe.Prestador.Endereco) then
      Municipio := Trim(FNFSe.Prestador.Endereco.xMunicipio);

    if Municipio <> '' then
    begin
      if Assigned(FNFSe.Prestador) and Assigned(FNFSe.Prestador.Endereco) and
         (Trim(FNFSe.Prestador.Endereco.UF) <> '') then
        Municipio := Municipio + ' / ' + Trim(FNFSe.Prestador.Endereco.UF)
      else if (Trim(FNFSe.infNFSe.UFLocEmi) <> '') then
        Municipio := Municipio + ' / ' + Trim(FNFSe.infNFSe.UFLocEmi);
    end;
  end;

  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFMunicipio, '');
  PDF.TextBox(cnIdentMunX - cnMargem, Y + 1.0, cnIdentMunW, 4.0,
              'Municipio: ' + Ellipsis(NN(Municipio), 37), 'T', 'C', False, False, True);

  PDF.SetFont(cnFAmbiente, '');
  PDF.TextBox(cnIdentMunX - cnMargem, Y + 5.0, cnIdentMunW, 3.0,
              'Ambiente Gerador: ' + GetAmbienteGeradorDescricao,
              'T', 'C', False, False, True);
  PDF.TextBox(cnIdentMunX - cnMargem, Y + 8.0, cnIdentMunW, 3.0,
              'Tipo de Ambiente: ' + IfThen(FHomologacao,
                'Homologação', 'Produção'),
              'T', 'C', False, False, True);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaDadosNFSe(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW: Double;
  Chave: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;

  // ---- Chave de Acesso ----
  Chave := GetChaveAcesso;
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelIdentNFSe, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, 3.0, 'CHAVE DE ACESSO DA NFS-e',
              'T', 'L', False, False, True);
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo + 1, '');
  PDF.TextBox(X + 0.5, Y + 3.0, W - 1.0, 3.5, Chave, 'T', 'L', False, False, True);

  Y := Y + 6.7;

  // ---- Linha 1: Numero / Competencia / Data emissao NFS-e ----
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, 6.7, 'NUMERO DA NFS-e', NN(FNFSe.Numero));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, 6.7, 'COMPETENCIA',
                IfThen(FNFSe.Competencia > 0, FormatDateTime('mm/yyyy', FNFSe.Competencia), '-'));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, 6.7, 'DATA/HORA DA EMISSAO DA NFS-e',
                FormatDataHoraNT(FNFSe.DataEmissao));

  Y := Y + 6.7;

  // ---- Linha 2: Numero DPS / Serie DPS / Data emissao DPS ----
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, 6.7, 'NUMERO DA DPS',
                NN(FNFSe.IdentificacaoRps.Numero));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, 6.7, 'SERIE DA DPS',
                NN(FNFSe.IdentificacaoRps.Serie));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, 6.7, 'DATA/HORA DA EMISSAO DA DPS',
                FormatDataHoraNT(FNFSe.DataEmissaoRps));

  Y := Y + 6.7;

  // ---- Linha 3: Emitente (sombreado) / Situacao / Finalidade ----
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, 6.7, 'EMITENTE DA NFS-e',
                GetEmitenteDescricao, True);
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, 6.7, 'SITUACAO DA NFS-e',
                GetSituacaoNFSeDescricao);
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, 6.7, 'FINALIDADE',
                GetFinalidadeDescricao);

  // ---- QR Code (posicao absoluta em relacao a pagina) ----
  if FQRCode and (Trim(Chave) <> '') then
  begin
    PDF.SetFillColor(0, 0, 0);
    PDF.QRCode(cnQRX - cnMargem, cnQRY - cnMargem, cnQRSize,
               cURLConsultaPublica + Chave);
    PDF.SetFillColor(255, 255, 255);

    // Texto complementar (3 linhas, 6 pt)
    PDF.SetFont(cFontConteudo);
    PDF.SetFont(cnFTextoQR, '');
    PDF.TextBox(cnQRComplX - cnMargem, cnQRComplY - cnMargem,
                cnQRComplW, cnQRComplH,
                cTextoQRComplemento, 'T', 'C', False, True, True);
  end;
  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaPrestador(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  P: TDadosPrestador;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  P := FNFSe.Prestador;

  // Linha 1: Titulo do bloco (1a celula) | CNPJ/CPF/NIF | Indicador Municipal | Telefone
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Prestador / Fornecedor');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIF(P.IdentificacaoPrestador));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Indicador Municipal (Inscricao)',
                NN(P.IdentificacaoPrestador.InscricaoMunicipal));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Telefone', FormatTelefone(P.Contato));

  Y := Y + LineH;

  // Linha 2: Nome / Razao Social (2 colunas) | Municipio/UF | IBGE/CEP
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(P.RazaoSocial), 167));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUF(P.Endereco, FNFSe.infNFSe.xLocEmi));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEP(P.Endereco));

  Y := Y + LineH;

  // Linha 3: Endereco (2 colunas) | E-mail (2 colunas)
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Endereco', FormatEnderecoCompleto(P.Endereco));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'E-mail',
                Ellipsis(LowerCase(NN(P.Contato.Email)), 77));

  Y := Y + LineH;

  // Linha 4: Simples Nacional (2 colunas) | Regime de Apuracao SN (2 colunas)
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH,
                'Simples Nacional na Data de Competencia',
                GetSimplesNacionalDataCompetencia);
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH,
                'Regime de Apuracao Tributaria pelo SN',
                Ellipsis(GetRegimeApuracaoSNDescricao, 37));

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTomador(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  T: TDadosTomador;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  if not PossuiTomador then
  begin
    DesenharLinhaVazia(PDF, X, Y, W, cMsgTomadorVazio);
    DesenharLinhaSeparadora(PDF, W);
    Exit;
  end;

  T := FNFSe.Tomador;

  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Tomador / Adquirente');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIF(T.IdentificacaoTomador));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Indicador Municipal (Inscricao)',
                NN(T.IdentificacaoTomador.InscricaoMunicipal));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Telefone', FormatTelefone(T.Contato));

  Y := Y + LineH;

  // Linha 2: Nome (2 colunas) | Municipio/UF | IBGE/CEP
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(T.RazaoSocial), 167));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUF(T.Endereco));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEP(T.Endereco));

  Y := Y + LineH;

  // Linha 3: Endereco (2 colunas) | E-mail (2 colunas)
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Endereco', FormatEnderecoCompleto(T.Endereco));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'E-mail',
                Ellipsis(LowerCase(NN(T.Contato.Email)), 77));

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaDestinatario(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  D: TDadosdaPessoa;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  if not PossuiDestinatario then
  begin
    if DestinatarioEhTomador then
      DesenharLinhaVazia(PDF, X, Y, W, cMsgDestIgualTomador)
    else
      DesenharLinhaVazia(PDF, X, Y, W, cMsgDestVazio);
    DesenharLinhaSeparadora(PDF, W);
    Exit;
  end;

  D := FNFSe.IBSCBS.dest;

  // Linha 1: Titulo do bloco (1a celula) | CNPJ/CPF/NIF | Telefone
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Destinatario da Operacao');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIFPessoa(D));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'Telefone', NN(D.fone));

  Y := Y + LineH;

  // Linha 2: Nome (2 colunas) | Municipio/UF | IBGE/CEP
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(D.xNome), 167));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUFTender(D.ender));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEPTender(D.ender));

  Y := Y + LineH;

  // Linha 3: Endereco (2 colunas) | E-mail (2 colunas)
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Endereco', FormatEnderecoCompletoTender(D.ender));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'E-mail',
                Ellipsis(LowerCase(NN(D.email)), 77));

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaIntermediario(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  I: TDadosIntermediario;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  if not PossuiIntermediario then
  begin
    DesenharLinhaVazia(PDF, X, Y, W, cMsgIntermVazio);
    DesenharLinhaSeparadora(PDF, W);
    Exit;
  end;

  I := FNFSe.Intermediario;

  // Linha 1: Titulo do bloco (1a celula) | CNPJ/CPF/NIF | Indicador Municipal | Telefone
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Intermediario da Operacao');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'CNPJ/CPF/NIF',
                FormatCNPJCPFNIF(I.Identificacao));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Indicador Municipal (Inscricao)',
                NN(I.Identificacao.InscricaoMunicipal));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Telefone', FormatTelefone(I.Contato));

  Y := Y + LineH;

  // Linha 2: Nome (2 colunas) | Municipio/UF | IBGE/CEP
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Nome / Nome Empresarial',
                Ellipsis(NN(I.RazaoSocial), 167));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Municipio / Sigla UF',
                FormatMunicipioUF(I.Endereco));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Codigo IBGE / CEP',
                FormatIBGE_CEP(I.Endereco));

  Y := Y + LineH;

  // Linha 3: Endereco (2 colunas) | E-mail (2 colunas)
  DesenharCampo(PDF, X, Y, 2 * ColW, LineH, 'Endereco', FormatEnderecoCompleto(I.Endereco));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH, 'E-mail',
                Ellipsis(LowerCase(NN(I.Contato.Email)), 77));

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaServicoPrestado(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  S: TDadosServico;
  PaisISO, NomeMunPrestacao, UFMunPrestacao: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;
  S := FNFSe.Servico;

  Args.Band.Height := CalcAlturaServicoPrestado;

  // Linha 1: Titulo do bloco (1a celula) | Cod. Tributacao Nac./Mun. | Cod. NBS | Local Prestacao/UF/Pais
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Servico Prestado');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Codigo de Tributacao Nacional / Municipal',
                NN(S.ItemListaServico) + ' / ' + NN(S.CodigoTributacaoMunicipio));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Codigo da NBS',
                NN(S.CodigoNbs));

  NomeMunPrestacao := Trim(FNFSe.infNFSe.xLocPrestacao);
  if NomeMunPrestacao = '' then
    NomeMunPrestacao := Trim(S.MunicipioPrestacaoServico);

  UFMunPrestacao := ObterUFPorCodigoMunicipio(S.CodigoMunicipio);

  if (NomeMunPrestacao <> '') and (NomeMunPrestacao <> '/') then
  begin
    if UFMunPrestacao <> '' then
      PaisISO := AnsiUpperCase(StringReplace(NomeMunPrestacao, '/', '', [rfReplaceAll])) +
                 ' / ' + UFMunPrestacao + ' / BR'
    else
      PaisISO := AnsiUpperCase(StringReplace(NomeMunPrestacao, '/', ' / ', [])) + ' / BR';
  end
  else if Trim(S.CodigoMunicipio) <> '' then
  begin
    NomeMunPrestacao := ObterNomeMunicipio(StrToIntDef(S.CodigoMunicipio, 0), UFMunPrestacao, '', False);
    if NomeMunPrestacao <> '' then
      PaisISO := AnsiUpperCase(NomeMunPrestacao) + ' / ' + UFMunPrestacao + ' / BR'
    else
      PaisISO := '-';
  end
  else
    PaisISO := '-';
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Local da Prestacao / Sigla UF / Pais', PaisISO);

  Y := Y + LineH;

  // Linha 2: Descricao do Codigo de Tributacao (sem label - NT 008 nao preve
  // titulo para este campo)
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, LineH - 0.4,
              Ellipsis(NN(S.xItemListaServico), 167), 'T', 'L', False, False, True);

  Y := Y + LineH;

  // Linha 3 ate o final: Descricao do Servico (texto livre, multi-linha)
  PDF.SetFont(cFontLabel);
  PDF.SetFont(cnFLabelCampo, 'B');
  PDF.TextBox(X + 0.5, Y + 0.4, W - 1.0, 4.0,
              'Descricao do Servico', 'T', 'L', False, False, True);

  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  // AScale=False: mesmo motivo de BandaInformacoesComplementares - tamanho
  // de fonte fixo, sem encolher sozinho.
  PDF.TextBox(X + 0.5, Y + 2.5, W - 1.0, Args.Band.Height - Y - 3.0,
              GetTextoDescricaoServico, 'T', 'L', False, True, False);

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTributacaoMunicipal(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  V: TValores;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;
  V := FNFSe.Servico.Valores;

  if not PossuiISSQN then
  begin
    DesenharLinhaVazia(PDF, X, Y, W, cMsgISSQNVazio);
    DesenharLinhaSeparadora(PDF, W);
    Exit;
  end;

  // Linha 1: Titulo do bloco (1a celula) | Tipo Tributacao | Municipio/UF/Pais Incidencia (2 col)
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Tributacao Municipal (ISSQN)');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Tipo de Tributacao do ISSQN',
                IfThen(Assigned(FDadosAux) and (FDadosAux.NaturezaOperacaoDescricao <> ''),
                       Ellipsis(FDadosAux.NaturezaOperacaoDescricao, 37),
                       IfThen(V.IssRetido = stRetencao, 'Operacao Tributavel (Retido)', 'Operacao Tributavel')));
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH,
                'Municipio / Sigla UF / Pais da Incidencia',
                NN(FNFSe.infNFSe.xLocIncid) + ' / BR');

  Y := Y + LineH;

  // Linha 2: Regime Especial | Imunidade | Suspensao | nProcesso
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Regime Especial de Tributacao do ISSQN',
                IfThen(Assigned(FDadosAux) and (FDadosAux.RegimeEspecialDescricao <> ''),
                       Ellipsis(FDadosAux.RegimeEspecialDescricao, 37),
                       Ellipsis(GetEnumName(TypeInfo(TnfseRegimeEspecialTributacao),
                                            Ord(FNFSe.RegimeEspecialTributacao)), 37)));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Tipo de Imunidade do ISSQN', '-');
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Suspensao da Exigibilidade do ISSQN', '-');
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Numero Processo Suspensao', '-');

  Y := Y + LineH;

  // Linha 3: Beneficio Municipal | Calculo BM | Deducoes | Desconto Incond.
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'Beneficio Municipal', '-');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Calculo do BM',
                FormatVlr(0));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Total Deducoes / Reducoes',
                FormatVlr(V.ValorDeducoes));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'Desconto Incondicionado',
                FormatVlr(V.DescontoIncondicionado));

  Y := Y + LineH;

  // Linha 4: BC | Aliquota | Retencao | ISSQN Apurado
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, 'BC ISSQN',
                FormatVlr(V.BaseCalculo));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'Aliquota Aplicada',
                FormatPerc(V.Aliquota));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH, 'Retencao do ISSQN',
                IfThen(V.IssRetido = stRetencao, 'Retido', 'Nao Retido'));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH, 'ISSQN Apurado',
                FormatVlr(V.ValorIss));

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTributacaoFederal(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  V: TValores;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;
  V := FNFSe.Servico.Valores;

  // Linha 1: Titulo do bloco (1a celula) | IRRF | Contrib. Previdenciaria | Contrib. Sociais
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Tributacao Federal (Exceto CBS)');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'IRRF', FormatVlr(V.ValorIr));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Contribuicao Previdenciaria Retida', FormatVlr(V.ValorInss));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Contribuicoes Sociais Retidas', FormatVlr(V.ValorCsll));

  Y := Y + LineH;

  // Linha 2: (1a celula vazia) | PIS | COFINS | Descricao Contrib. Sociais
  // NT 008 Nota 6: linha so para NFS-e com competencia ate fim de 2026
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH, '', '');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'PIS - Debito de Apuracao Propria', FormatVlr(V.ValorPis));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'COFINS - Debito de Apuracao Propria', FormatVlr(V.ValorCofins));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Descricao das Contribuicoes Sociais Retidas', '-');

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaTributacaoIBSCBS(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  IBSCBSNfse: TIBSCBSNfse;
  ValoresDPS: Tvalorestrib;
  gIBSCBS: TgIBSCBS;
  CSTcClassTrib, IndOpMunUF, UFIncidencia: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.3;

  IBSCBSNfse := FNFSe.infNFSe.IBSCBS;
  ValoresDPS := FNFSe.IBSCBS.valores;
  gIBSCBS := ValoresDPS.trib.gIBSCBS;

  // Linha 1: Titulo do bloco (1a celula) | CST/cClassTrib | Indicador Op./IBGE/Mun./UF (2 col)
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Tributacao IBS / CBS');

  CSTcClassTrib := NN(CSTIBSCBSToStr(gIBSCBS.CST)) + ' / ' + NN(gIBSCBS.cClassTrib);
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH, 'CST / cClassTrib', CSTcClassTrib);

  UFIncidencia := IBSCBSNfse.UFLocalidadeIncid;
  if Trim(UFIncidencia) = '' then
  begin
    UFIncidencia := ObterUFPorCodigoMunicipio(IntToStr(IBSCBSNfse.cLocalidadeIncid));
    if (UFIncidencia = '') and (IBSCBSNfse.cLocalidadeIncid <> 0) then
      ObterNomeMunicipio(IBSCBSNfse.cLocalidadeIncid, UFIncidencia, '', False);
  end;

  IndOpMunUF := NN(FNFSe.IBSCBS.cIndOp) + ' / ' + NN(IntToStr(IBSCBSNfse.cLocalidadeIncid)) +
    ' / ' + NN(IBSCBSNfse.xLocalidadeIncid) + ' / ' + NN(UFIncidencia);
  DesenharCampo(PDF, X + 2 * ColW, Y, 2 * ColW, LineH,
                'Indicador de Operacao / Codigo IBGE Incidencia / Municipio Incidencia / Sigla UF',
                Ellipsis(IndOpMunUF, 80));

  Y := Y + LineH;

  // Linha 2: Exclusoes/Reducoes BC | BC Apos Exclusoes | Red.Aliq.IBS/CBS | Aliquota IBS UF/Mun
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Exclusoes e Reducoes da Base de Calculo',
                FormatVlr(IBSCBSNfse.valores.vCalcReeRepRes));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Base de Calculo Apos Exclusoes e Reducoes',
                FormatVlr(IBSCBSNfse.valores.vBC));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Red. Aliquota IBS / Red. Aliquota CBS',
                FormatPerc(IBSCBSNfse.valores.uf.pRedAliqUF) + ' / ' +
                FormatPerc(IBSCBSNfse.valores.fed.pRedAliqCBS));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Aliquota - IBS UF / IBS Mun',
                FormatPerc(IBSCBSNfse.valores.uf.pIBSUF) + ' / ' +
                FormatPerc(IBSCBSNfse.valores.mun.pIBSMun));

  Y := Y + LineH;

  // Linha 3: Aliq.Efet.Mun IBS | Valor Apurado Mun IBS | Aliq.Efet.Estadual IBS | Valor Apurado Estadual IBS
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Aliq. Efetiva Municipal - IBS', FormatPerc(IBSCBSNfse.valores.mun.pAliqEfetMun));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Valor Apurado Municipal - IBS',
                FormatVlr(IBSCBSNfse.totCIBS.gIBS.gIBSMunTot.vIBSMun));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Aliq. Efetiva Estadual - IBS', FormatPerc(IBSCBSNfse.valores.uf.pAliqEfetUF));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Valor Apurado Estadual - IBS',
                FormatVlr(IBSCBSNfse.totCIBS.gIBS.gIBSUFTot.vIBSUF));

  Y := Y + LineH;

  // Linha 4: Valor Total Apurado IBS | Aliquota CBS | Aliquota Efetiva CBS | Valor Total Apurado CBS
  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Valor Total Apurado - IBS', FormatVlr(IBSCBSNfse.totCIBS.gIBS.vIBSTot));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Aliquota - CBS', FormatPerc(IBSCBSNfse.valores.fed.pCBS));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Aliquota Efetiva - CBS', FormatPerc(IBSCBSNfse.valores.fed.pAliqEfetCBS));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Valor Total Apurado - CBS', FormatVlr(IBSCBSNfse.totCIBS.gCBS.vCBS));

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaValorTotalNFSe(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
  V: TValores;
  vRetencoes, vTotalNFSe: Double;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  ColW := W / 4;
  LineH := 6.7;
  V := FNFSe.Servico.Valores;

  // Linha 1: Titulo do bloco (1a celula, sombreado) | V.Operacao | Desc.Incond | Desc.Cond
  DesenharTituloBlocoInline(PDF, X, Y, ColW, LineH, 'Valor Total da NFS-e');
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Valor da Operacao / Servico', FormatVlr(V.ValorServicos));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Desconto Incondicionado', FormatVlr(V.DescontoIncondicionado));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Desconto Condicionado', FormatVlr(V.DescontoCondicionado));

  Y := Y + LineH;

  // Linha 2: Total Retencoes | V.Liquido NFS-e | Total IBS/CBS | V.Liquido+IBS/CBS (sombreado)
  //vRetencoes := V.ValorIssRetido + V.ValorIr + V.ValorInss +
                //V.ValorCsll + V.ValorPis + V.ValorCofins;
  vRetencoes := FNFSe.infNFSe.valores.vTotalRet;

  // NT 008: quando a NFS-e nao traz o bloco IBSCBS (municipio ainda sem
  // reforma tributaria aplicada), vTotNF fica zerado - usa-se o liquido normal.
  vTotalNFSe := FNFSe.infNFSe.IBSCBS.totCIBS.vTotNF;
  if vTotalNFSe = 0 then
    vTotalNFSe := V.ValorLiquidoNfse;

  DesenharCampo(PDF, X + 0 * ColW, Y, ColW, LineH,
                'Total das Retencoes (ISSQN / Federais)', FormatVlr(vRetencoes));
  DesenharCampo(PDF, X + 1 * ColW, Y, ColW, LineH,
                'Valor Liquido da NFS-e', FormatVlr(V.ValorLiquidoNfse));
  DesenharCampo(PDF, X + 2 * ColW, Y, ColW, LineH,
                'Total do IBS / CBS',
                FormatVlr(FNFSe.infNFSe.IBSCBS.totCIBS.gIBS.vIBSTot +
                          FNFSe.infNFSe.IBSCBS.totCIBS.gCBS.vCBS));
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'Valor Liquido da NFS-e + IBS/CBS', FormatVlr(vTotalNFSe), True);

  DesenharLinhaSeparadora(PDF, W);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaInformacoesComplementares(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, H: Double;
  Texto: string;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;

  H := Args.FreeSpace - Args.ReservedSpace;
  if H < CalcAlturaInformacoesComplementares then
    H := CalcAlturaInformacoesComplementares;
  Args.Band.Height := H;

  DesenharTituloBloco(PDF, X, Y, W, 'INFORMAÇÕES COMPLEMENTARES');
  Y := Y + 3.5;

  DesenharLinhaSeparadora(PDF, W);

  Texto := GetTextoInformacoesComplementares;
  PDF.SetFont(cFontConteudo);
  PDF.SetFont(cnFConteudo, '');
  PDF.TextBox(X + 0.8, Y + 0.6, W - 1.6, H - 4.5,
              Texto, 'T', 'L', False, True, False);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaCanhoto(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  X, Y, W, ColW, LineH: Double;
begin
  PDF := Args.PDF;
  X := 0; Y := 0;
  W := Args.Band.Width;
  LineH := 6.7;
  ColW := W * 0.25;

  DesenharTituloBloco(PDF, X, Y, W, 'Canhoto');
  Y := Y + 3.5;

  DesenharLinhaSeparadora(PDF, W);

  PDF.SetLineWidth(cnPt2Mm * cnEspLinha);
  PDF.SetDrawColor(0);
  PDF.Rect(X, Y, W, LineH);
  PDF.Line(X + ColW, Y, X + ColW, Y + LineH);
  PDF.Line(X + 3 * ColW, Y, X + 3 * ColW, Y + LineH);

  // Data Cientificacao e Identificacao/Assinatura sao linhas em branco pra
  // preenchimento manual (canhoto fisico).
  DesenharCampo(PDF, X, Y, ColW, LineH, 'Data Cientificação', '', False, True);
  DesenharCampo(PDF, X + ColW, Y, 2 * ColW, LineH, 'Identificação e Assinatura', '', False, True);
  DesenharCampo(PDF, X + 3 * ColW, Y, ColW, LineH,
                'N. NFS-e / Chave NFS-e',
                NN(FNFSe.Numero) + sLineBreak + GetChaveAcesso);
end;

procedure TACBrDANFSeFPDFPadraoNacional.BandaMarcaDagua(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  Texto, PrevColor: string;
begin
  // NT 008, item 2.2.3: borda da pagina, 1 pt de espessura
  DesenharBordaPagina(Args.PDF);

  // NT 008, item 2.5: marca d'agua diagonal, Arial >= 50 pt, cinza K35
  Texto := '';
  if FCancelada then
    Texto := cMsgCancelada
  else if FSubstituida then
    Texto := cMsgSubstituida;

  if Texto = '' then Exit;

  PDF := Args.PDF;
  PrevColor := Args.PDF.TextColor;
  try
    PDF.SetTextColor(cCorCinzaMDR, cCorCinzaMDG, cCorCinzaMDB);
    PDF.SetFont(cFontLabel);
    PDF.SetFont(cnFMarcaDagua, 'B');

    PDF.TextBox(cnMargem, cnPaginaAltura / 2 - 25,
                cnPaginaLargura - 2 * cnMargem, 50,
                Texto, 'C', 'C', False, False, True);
  finally
    Args.PDF.TextColor := PrevColor;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.OnStartReport(Args: TFPDFReportEventArgs);
begin
  if FInitialized then Exit;
  if FNFSe = nil then
    raise Exception.Create('TACBrDANFSeFPDFPadraoNacional: NFSe nao atribuida');

  FPage := AddPage(poPortrait, puMM, pfA4);

  // Ordem das bandas conforme NT 008, Anexo I
  AddBand(btPageHeader, cnCabH,                       BandaCabecalho);
  AddBand(btPageHeader, 26.8,                         BandaDadosNFSe);              // chave + 3 linhas (6,7 cada)
  AddBand(btPageHeader, CalcAlturaPrestador,          BandaPrestador);
  AddBand(btPageHeader, CalcAlturaTomador,            BandaTomador);
  AddBand(btPageHeader, CalcAlturaDestinatario,       BandaDestinatario);
  AddBand(btPageHeader, CalcAlturaIntermediario,      BandaIntermediario);

  AddBand(btPageHeader, CalcAlturaServicoPrestado,     BandaServicoPrestado);
  AddBand(btPageHeader, CalcAlturaTributacaoMunicipal, BandaTributacaoMunicipal);
  AddBand(btPageHeader, 2 * 6.3,                       BandaTributacaoFederal);
  AddBand(btPageHeader, CalcAlturaTributacaoIBSCBS,    BandaTributacaoIBSCBS);
  AddBand(btPageHeader, 2 * 6.7,                       BandaValorTotalNFSe);

  AddBand(btData,       CalcAlturaInformacoesComplementares,
                                                       BandaInformacoesComplementares);
  AddBand(btPageFooter, 3.5 + 6.7 + 0.5,               BandaCanhoto);

  AddBand(btOverlay, cnPaginaAltura,                  BandaMarcaDagua);

  FInitialized := True;
end;

procedure TACBrDANFSeFPDFPadraoNacional.SalvarPDF(
  DadosAuxDANFSe: TDadosNecessariosParaDANFSeX; AStream: TStream);
var
  Engine: TFPDFEngine;
begin
  FDadosAux := DadosAuxDANFSe;
  Engine := TFPDFEngine.Create(Self, False);
  try
    Engine.Compressed := True;
    Engine.SaveToStream(AStream);
  finally
    Engine.Free;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.SalvarPDF(
  DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
  const NomeArquivoDestinoPDF: string);
var
  Engine: TFPDFEngine;
begin
  FDadosAux := DadosAuxDANFSe;
  Engine := TFPDFEngine.Create(Self, False);
  try
    Engine.Compressed := True;
    Engine.SaveToFile(NomeArquivoDestinoPDF);
  finally
    Engine.Free;
  end;
end;

procedure TACBrDANFSeFPDFPadraoNacional.SalvarPDF(NFSe: TNFSe;
  DadosAuxDANFSe: TDadosNecessariosParaDANFSeX;
  const NomeArquivoDestinoPDF: string);
begin
  FNFSe := NFSe;
  SalvarPDF(DadosAuxDANFSe, NomeArquivoDestinoPDF);
end;

end.
