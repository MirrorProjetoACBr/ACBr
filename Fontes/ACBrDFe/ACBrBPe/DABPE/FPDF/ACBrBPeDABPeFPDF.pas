{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrBPeDABPeFPDF;

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
  ACBrBPeClass,
  ACBrBPeEventoClass,
  ACBrBPeEnvEvento,
  ACBrBPeDABPEClass,
  ACBrBPeUtilsFPDF,
  ACBrXmlBase,
  ACBrBase,
  ACBrDFe.Conversao;

type
  { TBPeDABPeFPDF }
  TBPeDABPeFPDF = class(TFPDFReport)
  private
    FBPe: TBPe;
    FBPeUtils: TBPeUtilsFPDF;
    FDABPEClassOwner: TACBrBPeDABPEClass;
    FInitialized: Boolean;
    FFontFamily: string;
    FPaperWidth: Double;
    FDashWidth: Double;
    FMensagemRodape: string;

    property BPe: TBPe read FBPe;

    procedure DesenharBannerSituacao(PDF: IFPDF; AWidth: Double; var y: Double);
    function DesenharLinhaCentralizadaMista(PDF: IFPDF; AWidth, AY,
      ATamanho: Double; const ATextos: array of string;
      const ANegritos: array of Boolean): Double;
    function LarguraLinhaMista(PDF: IFPDF; ATamanho: Double;
      const ATextos: array of string;
      const ANegritos: array of Boolean): Double;
    function DesenharCampoComQuebra(PDF: IFPDF; AX, AY, AWidth,
      ATamanho: Double; const ARotulo, AValor: string;
      ARotuloNegrito: Boolean = False; AValorNegrito: Boolean = True): Double;

    procedure BlocoCabecalhoAgencia(Args: TFPDFBandDrawArgs);
    procedure BlocoCabecalhoEmitente(Args: TFPDFBandDrawArgs);
    procedure BlocoInformacoesViagem(Args: TFPDFBandDrawArgs);
    procedure BlocoInformacoesValores(Args: TFPDFBandDrawArgs);
    procedure BlocoPagamentos(Args: TFPDFBandDrawArgs);
    procedure BlocoConsultaChaveAcesso(Args: TFPDFBandDrawArgs);
    procedure BlocoQRCodeEDadosPassageiro(Args: TFPDFBandDrawArgs);
    procedure BlocoTotalTributos(Args: TFPDFBandDrawArgs);
    procedure BlocoMensagemFiscal(Args: TFPDFBandDrawArgs);
    procedure BlocoMensagemInteresseContribuinte(Args: TFPDFBandDrawArgs);
    procedure BlocoRodape(Args: TFPDFBandDrawArgs);
  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;
  public
    constructor Create(ABPe: TBPe; ADABPEClassOwner: TACBrBPeDABPEClass;
      AMargemEsquerda: Double = 2; AMargemSuperior: Double = 2;
      AMargemDireita: Double = -1; AMargemInferior: Double = -1); reintroduce;
    destructor Destroy; override;

    property LarguraBobina: Double read FPaperWidth write FPaperWidth;
    property MensagemRodape: string read FMensagemRodape write FMensagemRodape;
  end;

  { TBPeDABPeEventoFPDF }
  TBPeDABPeEventoFPDF = class(TFPDFReport)
  private
    FBPe: TBPe;
    FBPeUtils: TBPeUtilsFPDF;
    FEvento: TInfEventoCollectionItem;
    FDABPEClassOwner: TACBrBPeDABPEClass;
    FInitialized: Boolean;
    FFontFamily: string;
    FPaperWidth: Double;
    FDashWidth: Double;
    FMensagemRodape: string;

    property BPe: TBPe read FBPe;

    procedure BlocoCabecalhoEmitente(Args: TFPDFBandDrawArgs);
    procedure BlocoDadosBPe(Args: TFPDFBandDrawArgs);
    procedure BlocoDadosEvento(Args: TFPDFBandDrawArgs);
    procedure BlocoInformacoesPassageiro(Args: TFPDFBandDrawArgs);
    procedure BlocoObservacoesEvento(Args: TFPDFBandDrawArgs);
    procedure BlocoQRCodeCancelamento(Args: TFPDFBandDrawArgs);
    procedure BlocoRodape(Args: TFPDFBandDrawArgs);
  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;
  public
    constructor Create(ABPe: TBPe; AEvento: TInfEventoCollectionItem;
      ADABPEClassOwner: TACBrBPeDABPEClass; AMargemEsquerda: Double = 2;
      AMargemSuperior: Double = 2; AMargemDireita: Double = -1;
      AMargemInferior: Double = -1); reintroduce;
    destructor Destroy; override;

    property LarguraBobina: Double read FPaperWidth write FPaperWidth;
    property MensagemRodape: string read FMensagemRodape write FMensagemRodape;
  end;

  { TACBrBPeDABPeFPDF }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrBPeDABPeFPDF = class(TACBrBPeDABPEClass)
  private
    FLarguraBobina: Double;
    FMargemEsquerda: Double;
    FMargemSuperior: Double;
    FMargemDireita: Double;
    FMargemInferior: Double;

    procedure GerarESalvarDABPePDF(ABPe: TBPe);
    procedure GerarESalvarEventoPDF(ABPe: TBPe; AEvento: TInfEventoCollectionItem);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDABPE(BPe: TBPe = nil); override;
    procedure ImprimirDABPECancelado(BPe: TBPe = nil); override;
    procedure ImprimirDABPEResumido(BPe: TBPe = nil); override;
    procedure ImprimirDABPEPDF(BPe: TBPe = nil); overload; override;
    procedure ImprimirDABPEPDF(AStream: TStream; BPe: TBPe = nil); overload; override;
    procedure ImprimirDABPEResumidoPDF(BPe: TBPe = nil); override;
    procedure ImprimirEVENTO(BPe: TBPe = nil); override;
    procedure ImprimirEVENTOPDF(BPe: TBPe = nil); overload; override;
    procedure ImprimirEVENTOPDF(AStream: TStream; BPe: TBPe = nil); overload; override;
  published
    property LarguraBobina: Double read FLarguraBobina write FLarguraBobina;

    property MargemEsquerda: Double read FMargemEsquerda write FMargemEsquerda;
    property MargemSuperior: Double read FMargemSuperior write FMargemSuperior;
    property MargemDireita: Double read FMargemDireita write FMargemDireita;
    property MargemInferior: Double read FMargemInferior write FMargemInferior;
  end;

implementation

uses
  ACBrBPe,
  ACBrBPeConversao,
  ACBrValidador,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeUtil;

const
  cDefaultFontFamily = 'Arial';
  cDefaultFontSize = 5;

{ TBPeDABPeFPDF }

constructor TBPeDABPeFPDF.Create(ABPe: TBPe;
  ADABPEClassOwner: TACBrBPeDABPEClass; AMargemEsquerda, AMargemSuperior,
  AMargemDireita, AMargemInferior: Double);
begin
  inherited Create;

  FBPe := ABPe;
  FDABPEClassOwner := ADABPEClassOwner;
  FBPeUtils := TBPeUtilsFPDF.Create(ABPe, ADABPEClassOwner);

  SetUTF8(False);
  FFontFamily := cDefaultFontFamily;
  FDashWidth := 0.1;
  FPaperWidth := 80;

  EngineOptions.DoublePass := True;

  SetFont(FFontFamily);
  SetMargins(AMargemEsquerda, AMargemSuperior, AMargemDireita, AMargemInferior);
end;

destructor TBPeDABPeFPDF.Destroy;
begin
  FBPeUtils.Free;
  inherited Destroy;
end;

procedure TBPeDABPeFPDF.DesenharBannerSituacao(PDF: IFPDF; AWidth: Double;
  var y: Double);
var
  texto: string;
begin
  if FBPeUtils.EmitidoEmHomologacao then
  begin
    PDF.SetFont(9, 'B');
    texto := 'EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO';
    y := y + PDF.TextBox(0, y, AWidth, 4, texto, 'T', 'C', 0, '', True);
    PDF.SetFont(8, '');
    texto := 'SEM VALOR FISCAL';
    y := y + PDF.TextBox(0, y, AWidth, 3, texto, 'T', 'C', 0, '', True);
    y := y + 1;
  end;

  if FBPeUtils.EmitidoEmContingencia then
  begin
    PDF.SetFont(9, 'B');
    texto := 'EMITIDA EM CONTINGÊNCIA';
    y := y + PDF.TextBox(0, y, AWidth, 4, texto, 'T', 'C', 0, '', True);
    PDF.SetFont(8, 'I');
    texto := 'Pendente de autorização';
    y := y + PDF.TextBox(0, y, AWidth, 3, texto, 'T', 'C', 0, '', True);
    y := y + 1;
  end;
end;

function TBPeDABPeFPDF.DesenharLinhaCentralizadaMista(PDF: IFPDF; AWidth, AY,
  ATamanho: Double; const ATextos: array of string;
  const ANegritos: array of Boolean): Double;
var
  I: Integer;
  LarguraTotal, X, Baseline, Tamanho: Double;
begin
  Tamanho := ATamanho;

  repeat
    LarguraTotal := 0;
    for I := Low(ATextos) to High(ATextos) do
    begin
      PDF.SetFont(FFontFamily, IfThen(ANegritos[I], 'B', ''), Tamanho);
      LarguraTotal := LarguraTotal + PDF.GetStringWidth(ATextos[I]);
    end;

    if (LarguraTotal > AWidth) and (Tamanho > 5) then
      Tamanho := Tamanho - 0.5
    else
      Break;
  until False;

  X := Max(0, (AWidth - LarguraTotal) / 2);
  Baseline := AY + (Tamanho * 0.3528) + 0.3;

  for I := Low(ATextos) to High(ATextos) do
  begin
    PDF.SetFont(FFontFamily, IfThen(ANegritos[I], 'B', ''), Tamanho);
    PDF.Text(X, Baseline, ATextos[I]);
    X := X + PDF.GetStringWidth(ATextos[I]);
  end;

  Result := (Tamanho * 0.3528) + 1.2;
end;

function TBPeDABPeFPDF.LarguraLinhaMista(PDF: IFPDF; ATamanho: Double;
  const ATextos: array of string; const ANegritos: array of Boolean): Double;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(ATextos) to High(ATextos) do
  begin
    PDF.SetFont(FFontFamily, IfThen(ANegritos[I], 'B', ''), ATamanho);
    Result := Result + PDF.GetStringWidth(ATextos[I]);
  end;
end;

function TBPeDABPeFPDF.DesenharCampoComQuebra(PDF: IFPDF; AX, AY, AWidth,
  ATamanho: Double; const ARotulo, AValor: string;
  ARotuloNegrito: Boolean = False; AValorNegrito: Boolean = True): Double;
var
  LarguraRotulo, AlturaValor, AlturaRotulo: Double;
begin
  PDF.SetFont(FFontFamily, IfThen(ARotuloNegrito, 'B', ''), ATamanho);
  LarguraRotulo := PDF.GetStringWidth(ARotulo);
  AlturaRotulo := PDF.GetStringHeight(ARotulo, LarguraRotulo);
  PDF.TextBox(AX, AY, LarguraRotulo, AlturaRotulo, ARotulo, 'T', 'L', False, False, False, 0);

  PDF.SetFont(FFontFamily, IfThen(AValorNegrito, 'B', ''), ATamanho);
  AlturaValor := PDF.GetStringHeight(AValor, AWidth - LarguraRotulo);
  Result := PDF.TextBox(AX + LarguraRotulo, AY, AWidth - LarguraRotulo,
    AlturaValor, AValor, 'T', 'L', False, True, False, 0);

  if Result < AlturaRotulo then
    Result := AlturaRotulo;
end;

procedure TBPeDABPeFPDF.BlocoCabecalhoAgencia(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  if Trim(BPe.Agencia.xNome) = '' then
    Exit;

  y := y + DesenharLinhaCentralizadaMista(PDF, Args.Band.Width, y, cDefaultFontSize,
    ['CNPJ: ', FormatarCNPJ(BPe.Agencia.CNPJ) + '  ', Trim(BPe.Agencia.xNome)],
    [False, False, True]);

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  texto := FBPeUtils.GetTextoEnderecoAgencia;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  y := y + 1.5;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeFPDF.BlocoCabecalhoEmitente(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  if FDABPEClassOwner.ImprimeNomeFantasia and (Trim(BPe.Emit.xFant) <> '') then
  begin
    PDF.SetFont(FFontFamily, 'B', cDefaultFontSize);
    y := y + PDF.TextBox(0, y, Args.Band.Width, 3, Trim(BPe.Emit.xFant), 'T', 'C', 0, '', True);
  end;

  PDF.SetFont(FFontFamily, 'B', cDefaultFontSize);
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, Trim(BPe.Emit.xNome), 'T', 'C', 0, '', True);

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  texto := 'CNPJ: ' + FormatarCNPJ(BPe.Emit.CNPJ) + '  IE: ' + FormatarIE(BPe.Emit.IE, BPe.Emit.EnderEmit.UF);
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  texto := FBPeUtils.GetTextoEnderecoEmitente;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  if NaoEstaVazio(BPe.Emit.EnderEmit.fone) then
  begin
    texto := 'Fone: ' + FormatarFone(BPe.Emit.EnderEmit.fone);
    y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);
  end;

  y := y + 1;
  PDF.SetFont(FFontFamily, '', 6);
  texto := 'Documento Auxiliar do Bilhete de Passagem Eletrônico';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  y := y + 1;
  DesenharBannerSituacao(PDF, Args.Band.Width, y);

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeFPDF.BlocoInformacoesViagem(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  I: Integer;
  Poltrona: string;
  hOrigem, hDestino, ColunaW: Double;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;
  ColunaW := (Args.Band.Width / 2) - 1;

  for I := 0 to BPe.infViagem.Count - 1 do
  begin
    if I > 0 then
    begin
      PDF.SetFont(FFontFamily, 'B', cDefaultFontSize);
      y := y + PDF.TextBox(0, y, Args.Band.Width, 3, '-- CONEXÃO --', 'T', 'C', 0, '', True);
    end;

    hOrigem := DesenharCampoComQuebra(PDF, 0, y, ColunaW, cDefaultFontSize,
      'Origem: ', BPe.infPassagem.xLocOrig + ' (' + BPe.Ide.UFIni + ')');
    hDestino := DesenharCampoComQuebra(PDF, Args.Band.Width / 2 + 1, y, ColunaW, cDefaultFontSize,
      'Destino: ', BPe.infPassagem.xLocDest + ' (' + BPe.Ide.UFFim + ')');
    y := y + Max(hOrigem, hDestino);

    y := y + DesenharLinhaCentralizadaMista(PDF, Args.Band.Width, y, 7,
      ['Data: ', FormatDateTime('dd/mm/yyyy', BPe.infPassagem.dhEmb),
       '  |  Horário: ', FormatDateTime('hh:nn', BPe.infPassagem.dhEmb)],
      [False, True, False, True]);

    Poltrona := IfThen(BPe.infViagem.Items[I].Poltrona > 0,
      IntToStr(BPe.infViagem.Items[I].Poltrona), '');
    y := y + DesenharLinhaCentralizadaMista(PDF, Args.Band.Width, y, 7,
      ['(Poltrona: ' + Poltrona + '  Plataforma: ' +
       BPe.infViagem.Items[I].Plataforma + ')'],
      [True]);

    if LarguraLinhaMista(PDF, cDefaultFontSize,
        ['Prefixo: ', BPe.infViagem.Items[I].Prefixo,
         '   Linha: ', BPe.infViagem.Items[I].xPercurso,
         '   Tipo: ', tpServicoToDesc(BPe.infViagem.Items[I].tpServ)],
        [False, True, False, True, False, True]) <= Args.Band.Width then
    begin
      y := y + DesenharLinhaCentralizadaMista(PDF, Args.Band.Width, y, cDefaultFontSize,
        ['Prefixo: ', BPe.infViagem.Items[I].Prefixo,
         '   Linha: ', BPe.infViagem.Items[I].xPercurso,
         '   Tipo: ', tpServicoToDesc(BPe.infViagem.Items[I].tpServ)],
        [False, True, False, True, False, True]);
    end
    else
    begin
      y := y + DesenharLinhaCentralizadaMista(PDF, Args.Band.Width, y, cDefaultFontSize,
        ['Prefixo: ', BPe.infViagem.Items[I].Prefixo,
         '   Linha: ', BPe.infViagem.Items[I].xPercurso],
        [False, True, False, True]);
      y := y + DesenharLinhaCentralizadaMista(PDF, Args.Band.Width, y, cDefaultFontSize,
        ['Tipo: ', tpServicoToDesc(BPe.infViagem.Items[I].tpServ)],
        [False, True]);
    end;

    y := y + 1;
  end;

  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeFPDF.BlocoInformacoesValores(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
  I: Integer;
  Total: Currency;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  Total := 0;
  for I := 0 to BPe.infValorBPe.Comp.Count - 1 do
  begin
    texto := tpComponenteToDesc(BPe.infValorBPe.Comp.Items[I].tpComp);
    PDF.TextBox(0, y, Args.Band.Width / 2, 3, texto, 'T', 'L', 0, '', False);
    texto := FormatFloat('#,0.00', BPe.infValorBPe.Comp.Items[I].vComp);
    y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, texto, 'T', 'R', 0, '', False);
    Total := Total + BPe.infValorBPe.Comp.Items[I].vComp;
  end;

  PDF.TextBox(0, y, Args.Band.Width / 2, 3, 'Valor Total R$', 'T', 'L', 0, '', False);
  texto := FormatFloat('#,0.00', Total);
  y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, texto, 'T', 'R', 0, '', False);

  if BPe.infValorBPe.vDesconto > 0 then
  begin
    PDF.TextBox(0, y, Args.Band.Width / 2, 3, 'Desconto R$', 'T', 'L', 0, '', False);
    texto := FormatFloat('#,0.00', BPe.infValorBPe.vDesconto);
    y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, texto, 'T', 'R', 0, '', False);
  end;

  PDF.SetFont(FFontFamily, 'B', cDefaultFontSize);
  PDF.TextBox(0, y, Args.Band.Width / 2, 3, 'Valor a Pagar R$', 'T', 'L', 0, '', False);
  texto := FormatFloat('#,0.00', Total - BPe.infValorBPe.vDesconto);
  y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, texto, 'T', 'R', 0, '', False);

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeFPDF.BlocoPagamentos(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
  I: Integer;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  PDF.TextBox(0, y, Args.Band.Width / 2, 3, 'FORMA PAGAMENTO', 'T', 'L', 0, '', False);
  y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, 'VALOR PAGO R$', 'T', 'R', 0, '', False);

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  for I := 0 to BPe.pag.Count - 1 do
  begin
    texto := FormaPagamentoBPeToDescricao(BPe.pag.Items[I].tPag);
    PDF.TextBox(0, y, Args.Band.Width / 2, 3, texto, 'T', 'L', 0, '', False);
    texto := FormatFloat('#,0.00', BPe.pag.Items[I].vPag);
    y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, texto, 'T', 'R', 0, '', False);
  end;

  if BPe.infValorBPe.vTroco > 0 then
  begin
    PDF.TextBox(0, y, Args.Band.Width / 2, 3, 'Troco R$', 'T', 'L', 0, '', False);
    texto := FormatFloat('#,0.00', BPe.infValorBPe.vTroco);
    y := y + PDF.TextBox(Args.Band.Width / 2, y, Args.Band.Width / 2, 3, texto, 'T', 'R', 0, '', False);
  end;

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeFPDF.BlocoConsultaChaveAcesso(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y, bW, bH: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, '', 7);
  texto := 'Consulte pela Chave de Acesso em';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  PDF.SetFont(FFontFamily, 'B', 6.5);
  texto := FBPeUtils.GetURLConsulta;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  PDF.SetFont(FFontFamily, '', 7);
  texto := FBPeUtils.GetChaveAcessoFormatada;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  y := y + 1.5;
  PDF.SetFillColor(0, 0, 0);
  bW := Args.Band.Width * 0.85;
  bH := 10;
  PDF.Code128(RemoverLiteralChave(BPe.infBPe.ID), (Args.Band.Width - bW) / 2, y, bH, bW);
  y := y + bH + 1;

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeFPDF.BlocoQRCodeEDadosPassageiro(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  QrSize, ColEsqW, ColDirX, ColDirW, y, yBanner, yFinal: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;

  ColEsqW := Args.Band.Width / 3;
  QrSize := ColEsqW - 1;
  if QrSize < 25 then
    QrSize := 25;
  if QrSize > ColEsqW then
    QrSize := ColEsqW - 1;

  PDF.SetFillColor(0, 0, 0);
  PDF.QRCode(0, 1, QrSize, FBPeUtils.GetQRCodeData);

  ColDirX := ColEsqW + 2;
  ColDirW := Args.Band.Width - ColDirX;
  y := 3;

  if Trim(BPe.infPassagem.infPassageiro.xNome) = '' then
  begin
    PDF.SetFont(FFontFamily, 'B', cDefaultFontSize);
    texto := 'PASSAGEIRO NÃO IDENTIFICADO';
    y := y + PDF.TextBox(ColDirX, y, ColDirW, 0, texto, 'T', 'L', 0, '', False);
  end
  else
  begin
    texto := tpDocumentoToDesc(BPe.infPassagem.infPassageiro.tpDoc) + ' ' +
      BPe.infPassagem.infPassageiro.nDoc + ' - ' + BPe.infPassagem.infPassageiro.xNome;
    y := y + DesenharCampoComQuebra(PDF, ColDirX, y, ColDirW, cDefaultFontSize,
      'PASSAGEIRO: ', texto, True, False);
  end;

  if BPe.infValorBPe.tpDesconto <> tdNenhum then
  begin
    texto := tpDescontoToDesc(BPe.infValorBPe.tpDesconto);
    y := y + DesenharCampoComQuebra(PDF, ColDirX, y, ColDirW, cDefaultFontSize,
      'TIPO DE DESCONTO: ', texto, True, False);
  end;

  PDF.SetFont(FFontFamily, 'B', cDefaultFontSize);
  texto := 'BP-e nº ' + IntToStrZero(BPe.Ide.nBP, 9) +
           '  Série ' + IntToStrZero(BPe.Ide.serie, 3) +
           '  ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', BPe.Ide.dhEmi);
  y := y + PDF.TextBox(ColDirX, y, ColDirW, 0, texto, 'T', 'L', 0, '', False);

  if FBPeUtils.TemProtocoloAutorizacao then
  begin
    PDF.SetFont(FFontFamily, '', cDefaultFontSize);
    texto := 'Protocolo de Autorização: ' + Trim(BPe.procBPe.nProt);
    y := y + PDF.TextBox(ColDirX, y, ColDirW, 0, texto, 'T', 'L', 0, '', False);

    if BPe.procBPe.dhRecbto <> 0 then
    begin
      texto := 'Data de Autorização: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', BPe.procBPe.dhRecbto);
      y := y + PDF.TextBox(ColDirX, y, ColDirW, 0, texto, 'T', 'L', 0, '', False);
    end;
  end;

  yFinal := Max(QrSize + 1, y);
  yBanner := yFinal + 1;
  DesenharBannerSituacao(PDF, Args.Band.Width, yBanner);
end;

procedure TBPeDABPeFPDF.BlocoTotalTributos(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y, h: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  if BPe.Imp.vTotTrib <= 0 then
    Exit;

  PDF.SetFont(FFontFamily, '', 6.5);
  texto := Format('Tributos Totais Incidentes (Lei Federal 12.741/2012) - R$ %s',
    [FormatFloat('#,0.00', BPe.Imp.vTotTrib)]);
  h := PDF.GetStringHeight(texto, Args.Band.Width);
  PDF.TextBox(0, y, Args.Band.Width, h, texto, 'T', 'L', 0, '', False);
end;

procedure TBPeDABPeFPDF.BlocoMensagemFiscal(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  texto: string;
  h: Double;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;

  texto := FBPeUtils.GetTextoMensagemFiscal(FDABPEClassOwner.CaractereQuebraDeLinha);
  if texto = '' then
    Exit;

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  h := PDF.GetStringHeight(texto, Args.Band.Width);
  PDF.TextBox(0, 0, Args.Band.Width, h, texto, 'T', 'L', 0, '', False);
end;

procedure TBPeDABPeFPDF.BlocoMensagemInteresseContribuinte(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  texto: string;
  h: Double;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;

  texto := FBPeUtils.GetTextoMensagemContribuinte(FDABPEClassOwner.CaractereQuebraDeLinha);
  if texto = '' then
    Exit;

  PDF.SetFont(FFontFamily, '', cDefaultFontSize);
  h := PDF.GetStringHeight(texto, Args.Band.Width);
  PDF.TextBox(0, 0, Args.Band.Width, h, texto, 'T', 'C', 0, '', False);
end;

procedure TBPeDABPeFPDF.BlocoRodape(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  Mensagens: TStringArray;
  y: Double;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 1;

  if FMensagemRodape = '' then
    Exit;

  Mensagens := ACBr_fpdf.Split(FMensagemRodape, '|');

  PDF.SetFont(FFontFamily, 'I', 5.5);
  if Length(Mensagens) >= 1 then
    PDF.TextBox(0, y, Args.Band.Width, 0, Mensagens[0], 'T', 'C', 0, '', True);
end;

procedure TBPeDABPeFPDF.OnStartReport(Args: TFPDFReportEventArgs);
var
  Page: TFPDFPage;
begin
  if FInitialized then
    Exit;

  if FBPe = nil then
    raise Exception.Create('BPe não informado para o TBPeDABPeFPDF');

  Page := AddPage(poPortrait, puMM, FPaperWidth, 20);
  Page.EndlessHeight := True;

  AddBand(btData, 10, BlocoCabecalhoAgencia);
  AddBand(btData, 20, BlocoCabecalhoEmitente);
  AddBand(btData, 20, BlocoInformacoesViagem);
  AddBand(btData, 16, BlocoInformacoesValores);
  AddBand(btData, 10, BlocoPagamentos);
  AddBand(btData, 10, BlocoConsultaChaveAcesso);
  AddBand(btData, 40, BlocoQRCodeEDadosPassageiro);
  AddBand(btData, 5, BlocoTotalTributos);
  AddBand(btData, 8, BlocoMensagemFiscal);
  AddBand(btData, 8, BlocoMensagemInteresseContribuinte);
  if MensagemRodape <> '' then
    AddBand(btData, 5, BlocoRodape);

  FInitialized := True;
end;

{ TBPeDABPeEventoFPDF }

constructor TBPeDABPeEventoFPDF.Create(ABPe: TBPe;
  AEvento: TInfEventoCollectionItem; ADABPEClassOwner: TACBrBPeDABPEClass;
  AMargemEsquerda, AMargemSuperior, AMargemDireita, AMargemInferior: Double);
begin
  inherited Create;

  FBPe := ABPe;
  FEvento := AEvento;
  FDABPEClassOwner := ADABPEClassOwner;
  FBPeUtils := TBPeUtilsFPDF.Create(ABPe, ADABPEClassOwner);

  SetUTF8(False);
  FFontFamily := cDefaultFontFamily;
  FDashWidth := 0.1;
  FPaperWidth := 80;

  EngineOptions.DoublePass := True;

  SetFont(FFontFamily);
  SetMargins(AMargemEsquerda, AMargemSuperior, AMargemDireita, AMargemInferior);
end;

destructor TBPeDABPeEventoFPDF.Destroy;
begin
  FBPeUtils.Free;
  inherited Destroy;
end;

procedure TBPeDABPeEventoFPDF.BlocoCabecalhoEmitente(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, 'B', 7);
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, Trim(BPe.Emit.xNome), 'T', 'C', 0, '', True);

  PDF.SetFont(FFontFamily, '', 7);
  texto := FormatarCNPJ(BPe.Emit.CNPJ) + '  IE: ' + FormatarIE(BPe.Emit.IE, BPe.Emit.EnderEmit.UF);
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  texto := FBPeUtils.GetTextoEnderecoEmitente;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  y := y + 1;
  PDF.SetFont(FFontFamily, 'B', 7);
  texto := 'Documento Auxiliar do Bilhete de Passagem Eletrônico';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeEventoFPDF.BlocoDadosBPe(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, 'B', 7);
  texto := 'Bilhete de Passagem Eletrônico';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  PDF.SetFont(FFontFamily, '', 7);
  texto := 'Número: ' + IntToStrZero(BPe.Ide.nBP, 9) + '  Série: ' + IntToStrZero(BPe.Ide.serie, 3);
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  texto := 'Emissão: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', BPe.Ide.dhEmi);
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  y := y + 1;
  PDF.SetFont(FFontFamily, 'B', 6.5);
  texto := 'CHAVE DE ACESSO';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  PDF.SetFont(FFontFamily, '', 6.5);
  texto := FBPeUtils.GetChaveAcessoFormatada;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'C', 0, '', False);

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeEventoFPDF.BlocoDadosEvento(Args: TFPDFBandDrawArgs);
const
  cLargColuna = 30;
var
  PDF: IFPDF;
  y: Double;
  texto, Ambiente: string;

  procedure Linha(const ARotulo, AValor: string);
  var
    h: Double;
  begin
    PDF.TextBox(0, y, cLargColuna, 3, ARotulo, 'T', 'L', 0, '', False);
    if Trim(AValor) = '' then
      h := 3
    else
      h := PDF.TextBox(cLargColuna, y, Args.Band.Width - cLargColuna, 0, AValor, 'T', 'L', 0, '', False);
    y := y + h;
  end;

begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, 'B', 7);
  texto := 'EVENTO';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);
  y := y + 0.5;

  PDF.SetFont(FFontFamily, '', 6.5);

  Ambiente := IfThen(FEvento.RetInfEvento.tpAmb = taProducao, 'PRODUÇÃO',
    'HOMOLOGAÇÃO - SEM VALOR FISCAL');

  Linha('Evento:', FEvento.InfEvento.TipoEvento);
  Linha('Descrição:', FEvento.InfEvento.DescEvento);
  Linha('Órgão:', IntToStr(FEvento.InfEvento.cOrgao));
  Linha('Ambiente:', Ambiente);
  Linha('Emissão:', FormatDateTime('dd/mm/yyyy hh:nn:ss', FEvento.InfEvento.dhEvento));
  Linha('Sequência:', IntToStr(FEvento.InfEvento.nSeqEvento));
  Linha('Status:', FEvento.RetInfEvento.xMotivo);
  Linha('Protocolo:', FEvento.RetInfEvento.nProt);
  Linha('Registro:', FormatDateTime('dd/mm/yyyy hh:nn:ss', FEvento.RetInfEvento.dhRegEvento));

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeEventoFPDF.BlocoInformacoesPassageiro(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, 'B', 7);
  texto := FBPeUtils.GetTextoPassageiro;
  y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'L', 0, '', False);

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeEventoFPDF.BlocoObservacoesEvento(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, '', 7);

  if FEvento.InfEvento.detEvento.vTotBag > 0 then
  begin
    texto := 'Quantidade de Bagagem: ' + IntToStr(FEvento.InfEvento.detEvento.qBagagem);
    y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'L', 0, '', True);
    texto := 'Valor Total da Bagagem: ' + FormatFloat('#,0.00', FEvento.InfEvento.detEvento.vTotBag);
    y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'L', 0, '', True);
    y := y + 1;
  end;

  if Trim(FEvento.InfEvento.detEvento.xJust) <> '' then
  begin
    PDF.SetFont(FFontFamily, 'B', 7);
    texto := 'JUSTIFICATIVA';
    y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

    PDF.SetFont(FFontFamily, '', 7);
    texto := FEvento.InfEvento.detEvento.xJust;
    y := y + PDF.TextBox(0, y, Args.Band.Width, 0, texto, 'T', 'L', 0, '', False);
    y := y + 1;
  end;

  if y > 0 then
    PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeEventoFPDF.BlocoQRCodeCancelamento(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
  QrSize, QrX, y: Double;
  texto: string;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;
  y := 0;

  PDF.SetFont(FFontFamily, '', 7);
  texto := 'Consulta via leitor de QR Code';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);
  y := y + 1;

  QrSize := Max(25, Args.Band.Width * 0.7);
  QrSize := Min(QrSize, Args.Band.Width);
  QrX := (Args.Band.Width - QrSize) / 2;

  PDF.SetFillColor(0, 0, 0);
  PDF.QRCode(QrX, y, QrSize, FBPeUtils.GetQRCodeData);
  y := y + QrSize + 1;

  PDF.SetFont(FFontFamily, 'B', 6.5);
  texto := 'Protocolo de Autorização';
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  PDF.SetFont(FFontFamily, '', 6.5);
  texto := Trim(BPe.procBPe.nProt) + IfThen(BPe.procBPe.dhRecbto <> 0,
    ' ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', BPe.procBPe.dhRecbto), '');
  y := y + PDF.TextBox(0, y, Args.Band.Width, 3, texto, 'T', 'C', 0, '', True);

  y := y + 1;
  PDF.SetLineWidth(FDashWidth);
  PDF.Line(0, y, Args.Band.Width, y);
end;

procedure TBPeDABPeEventoFPDF.BlocoRodape(Args: TFPDFBandDrawArgs);
var
  PDF: IFPDF;
begin
  Args.Band.AutoHeight := True;
  PDF := Args.PDF;

  if FMensagemRodape = '' then
    Exit;

  PDF.SetFont(FFontFamily, 'I', 5.5);
  PDF.TextBox(0, 1, Args.Band.Width, 0, FMensagemRodape, 'T', 'C', 0, '', True);
end;

procedure TBPeDABPeEventoFPDF.OnStartReport(Args: TFPDFReportEventArgs);
var
  Page: TFPDFPage;
begin
  if FInitialized then
    Exit;

  if (FBPe = nil) or (FEvento = nil) then
    raise Exception.Create('BPe/Evento não informado para o TBPeDABPeEventoFPDF');

  Page := AddPage(poPortrait, puMM, FPaperWidth, 20);
  Page.EndlessHeight := True;

  AddBand(btData, 20, BlocoCabecalhoEmitente);
  AddBand(btData, 16, BlocoDadosBPe);
  AddBand(btData, 24, BlocoDadosEvento);
  AddBand(btData, 10, BlocoInformacoesPassageiro);
  AddBand(btData, 12, BlocoObservacoesEvento);
  AddBand(btData, Max(25, FPaperWidth * 0.7) + 12, BlocoQRCodeCancelamento);
  if MensagemRodape <> '' then
    AddBand(btData, 5, BlocoRodape);

  FInitialized := True;
end;

{ TACBrBPeDABPeFPDF }

constructor TACBrBPeDABPeFPDF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLarguraBobina := 80;
  FMargemEsquerda := 2;
  FMargemSuperior := 2;
  FMargemDireita := -1;
  FMargemInferior := -1;
end;

destructor TACBrBPeDABPeFPDF.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrBPeDABPeFPDF.ImprimirDABPE(BPe: TBPe);
begin
  ImprimirDABPEPDF(BPe);
end;

procedure TACBrBPeDABPeFPDF.ImprimirDABPECancelado(BPe: TBPe);
var
  LBPe: TBPe;
  LEvento: TInfEventoCollectionItem;
begin
  if not Assigned(ACBrBPe) then
    raise EACBrBPeException.Create('Componente ACBrBPe não atribuído');

  if BPe = nil then
  begin
    if TACBrBPe(ACBrBPe).Bilhetes.Count <= 0 then
      raise EACBrBPeException.Create('XML do BPe não informado')
    else
      LBPe := TACBrBPe(ACBrBPe).Bilhetes.Items[0].BPe;
  end
  else
    LBPe := BPe;

  if not Assigned(TACBrBPe(ACBrBPe).EventoBPe) or
     (TACBrBPe(ACBrBPe).EventoBPe.Evento.Count <= 0) then
    raise EACBrBPeException.Create('Arquivo de Evento não informado');

  LEvento := TACBrBPe(ACBrBPe).EventoBPe.Evento[0];
  GerarESalvarEventoPDF(LBPe, LEvento);
end;

procedure TACBrBPeDABPeFPDF.ImprimirDABPEResumido(BPe: TBPe);
begin
  ImprimirDABPEResumidoPDF(BPe);
end;

procedure TACBrBPeDABPeFPDF.GerarESalvarDABPePDF(ABPe: TBPe);
var
  Report: TBPeDABPeFPDF;
  Engine: TFPDFEngine;
  LPath: string;
begin
  Report := TBPeDABPeFPDF.Create(ABPe, Self,
    MargemEsquerda, MargemSuperior, MargemDireita, MargemInferior);
  try
    Report.LarguraBobina := LarguraBobina;
    Report.MensagemRodape := Self.Sistema;

    Engine := TFPDFEngine.Create(Report, False);
    try
      Engine.Compressed := True;

      LPath := DefinirNomeArquivo(PathPDF,
        RemoverLiteralChave(ABPe.infBPe.ID) + '-bpe.pdf', NomeDocumento);

      Engine.SaveToFile(LPath);
      FPArquivoPDF := LPath;
    finally
      Engine.Free;
    end;
  finally
    Report.Free;
  end;
end;

procedure TACBrBPeDABPeFPDF.GerarESalvarEventoPDF(ABPe: TBPe;
  AEvento: TInfEventoCollectionItem);
var
  Report: TBPeDABPeEventoFPDF;
  Engine: TFPDFEngine;
  LPath: string;
begin
  Report := TBPeDABPeEventoFPDF.Create(ABPe, AEvento, Self,
    MargemEsquerda, MargemSuperior, MargemDireita, MargemInferior);
  try
    Report.LarguraBobina := LarguraBobina;
    Report.MensagemRodape := Self.Sistema;

    Engine := TFPDFEngine.Create(Report, False);
    try
      Engine.Compressed := True;

      LPath := DefinirNomeArquivo(PathPDF,
        TpEventoToStr(AEvento.InfEvento.tpEvento) + RemoverLiteralChave(ABPe.infBPe.ID) + '-bpe.pdf',
        NomeDocumento);

      Engine.SaveToFile(LPath);
      FPArquivoPDF := LPath;
    finally
      Engine.Free;
    end;
  finally
    Report.Free;
  end;
end;

procedure TACBrBPeDABPeFPDF.ImprimirDABPEPDF(BPe: TBPe);
var
  I: Integer;
  LBPe: TBPe;
begin
  if BPe <> nil then
  begin
    GerarESalvarDABPePDF(BPe);
    Exit;
  end;

  if not Assigned(ACBrBPe) then
    raise EACBrBPeException.Create('Componente ACBrBPe não atribuído');

  for I := 0 to TACBrBPe(ACBrBPe).Bilhetes.Count - 1 do
  begin
    LBPe := TACBrBPe(ACBrBPe).Bilhetes.Items[I].BPe;
    GerarESalvarDABPePDF(LBPe);
  end;
end;

procedure TACBrBPeDABPeFPDF.ImprimirDABPEPDF(AStream: TStream; BPe: TBPe);
var
  Report: TBPeDABPeFPDF;
  Engine: TFPDFEngine;
  LBPe: TBPe;
begin
  if BPe <> nil then
    LBPe := BPe
  else
  begin
    if not Assigned(ACBrBPe) or (TACBrBPe(ACBrBPe).Bilhetes.Count <= 0) then
      raise EACBrBPeException.Create('XML do BPe não informado');

    LBPe := TACBrBPe(ACBrBPe).Bilhetes.Items[0].BPe;
  end;

  Report := TBPeDABPeFPDF.Create(LBPe, Self,
    MargemEsquerda, MargemSuperior, MargemDireita, MargemInferior);
  try
    Report.LarguraBobina := LarguraBobina;
    Report.MensagemRodape := Self.Sistema;

    Engine := TFPDFEngine.Create(Report, False);
    try
      Engine.Compressed := True;
      Engine.SaveToStream(AStream);
    finally
      Engine.Free;
    end;
  finally
    Report.Free;
  end;
end;

procedure TACBrBPeDABPeFPDF.ImprimirDABPEResumidoPDF(BPe: TBPe);
begin
  ImprimirDABPEPDF(BPe);
end;

procedure TACBrBPeDABPeFPDF.ImprimirEVENTO(BPe: TBPe);
begin
  ImprimirEVENTOPDF(BPe);
end;

procedure TACBrBPeDABPeFPDF.ImprimirEVENTOPDF(BPe: TBPe);
var
  LBPe: TBPe;
  LEvento: TInfEventoCollectionItem;
begin
  if not Assigned(ACBrBPe) then
    raise EACBrBPeException.Create('Componente ACBrBPe não atribuído');

  if BPe <> nil then
    LBPe := BPe
  else
  begin
    if TACBrBPe(ACBrBPe).Bilhetes.Count <= 0 then
      raise EACBrBPeException.Create('XML do BPe não informado');

    LBPe := TACBrBPe(ACBrBPe).Bilhetes.Items[0].BPe;
  end;

  if not Assigned(TACBrBPe(ACBrBPe).EventoBPe) or
     (TACBrBPe(ACBrBPe).EventoBPe.Evento.Count <= 0) then
    raise EACBrBPeException.Create('Arquivo de Evento não informado');

  LEvento := TACBrBPe(ACBrBPe).EventoBPe.Evento[0];

  GerarESalvarEventoPDF(LBPe, LEvento);
end;

procedure TACBrBPeDABPeFPDF.ImprimirEVENTOPDF(AStream: TStream; BPe: TBPe);
var
  Report: TBPeDABPeEventoFPDF;
  Engine: TFPDFEngine;
  LBPe: TBPe;
  LEvento: TInfEventoCollectionItem;
begin
  if not Assigned(ACBrBPe) then
    raise EACBrBPeException.Create('Componente ACBrBPe não atribuído');

  if BPe <> nil then
    LBPe := BPe
  else
  begin
    if TACBrBPe(ACBrBPe).Bilhetes.Count <= 0 then
      raise EACBrBPeException.Create('XML do BPe não informado');

    LBPe := TACBrBPe(ACBrBPe).Bilhetes.Items[0].BPe;
  end;

  if not Assigned(TACBrBPe(ACBrBPe).EventoBPe) or
     (TACBrBPe(ACBrBPe).EventoBPe.Evento.Count <= 0) then
    raise EACBrBPeException.Create('Arquivo de Evento não informado');

  LEvento := TACBrBPe(ACBrBPe).EventoBPe.Evento[0];

  Report := TBPeDABPeEventoFPDF.Create(LBPe, LEvento, Self,
    MargemEsquerda, MargemSuperior, MargemDireita, MargemInferior);
  try
    Report.LarguraBobina := LarguraBobina;
    Report.MensagemRodape := Self.Sistema;

    Engine := TFPDFEngine.Create(Report, False);
    try
      Engine.Compressed := True;
      Engine.SaveToStream(AStream);
    finally
      Engine.Free;
    end;
  finally
    Report.Free;
  end;
end;

end.
