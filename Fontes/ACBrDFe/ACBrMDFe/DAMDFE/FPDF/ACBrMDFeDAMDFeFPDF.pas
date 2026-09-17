{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Victor H. Gonzales - Pandaaa                    }
{                              Antonio Carlos Junior                           }
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

{$I ACBr.inc}

unit ACBrMDFeDAMDFeFPDF;

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
  ACBrMDFe.Classes,
  ACBrMDFe.EnvEvento,
  ACBrMDFe.EventoClass,
  ACBrDFe.Conversao,
  ACBrMDFe.Conversao,
  ACBrValidador,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeUtil,
  ACBrUtil.Compatibilidade,
  ACBrUtil.Base,
  ACBrMDFe,
  ACBrBase,
  ACBrMDFeUtilsFPDF,
  ACBrMDFeDAMDFeClass,
  ACBrImage;

type
  { TMDFeDAMDFeFPDF }

  TMDFeDAMDFeFPDF = class(TFPDFReport)
    private
      FMDFe: TMDFe;
      FMDFeUtils: TMDFeUtilsFPDF;
      FDAMDFEClassOwner: TACBrMDFeDAMDFEClass;
      FCancelada: boolean;
      FCanhoto: TPosRecibo;
      FLogo: TBytes;
      FLogoStretched: boolean;
      FLogoAlign: TLogoAlign;
      FMensagemRodape: string;
      FInitialized: boolean;
      property MDFe: TMDFe read FMDFe;

    protected
      procedure OnStartReport(Args: TFPDFReportEventArgs); override;

    public
      constructor Create(AMDFe: TMDFe; AACBrMDFeDAMDFEClass : TACBrMDFeDAMDFEClass); reintroduce;
      destructor Destroy; override;

    public
      property Cancelada: boolean read FCancelada write FCancelada;
      property PosCanhoto: TPosRecibo read FCanhoto write FCanhoto;
      property LogoBytes: TBytes read FLogo write FLogo;
      property LogoStretched: boolean read FLogoStretched write FLogoStretched;
      property LogoAlign: TLogoAlign read FLogoAlign write FLogoAlign;
      property MensagemRodape: string read FMensagemRodape write FMensagemRodape;
  end;

type
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}

  { TACBrMDFeDAMDFeFPDF }

  TACBrMDFeDAMDFeFPDF = class(TACBrMDFeDAMDFEClass)
    private
      FFPDFReport: TMDFeDAMDFeFPDF;
      FDAMDFEClassOwner: TACBrMDFeDAMDFEClass;
      FStream : TStream;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      // Adicione propriedades, métodos e eventos específicos do componente
      procedure ImprimirDAMDFe(MDFE: TMDFe = nil); override;
      procedure ImprimirDAMDFePDF(MDFE: TMDFe = nil); override;
      procedure ImprimirDAMDFePDF(AStream: TStream; MDFE: TMDFe = nil); override;
      procedure ImprimirEVENTO(AMDFe: TMDFe = nil); override;
      procedure ImprimirEVENTOPDF(AMDFe: TMDFe = nil); override;
      procedure ImprimirEVENTOPDF(AStream: TStream; AMDFe: TMDFe = nil); override;

    published
      // Declare propriedades publicamente acessíveis aqui
  end;

implementation

type

  { TBlocoCanhoto }

  TBlocoCanhoto = class(TFPDFBand)
    private
      FAlign: TPosRecibo;
      FMDFeUtils: TMDFeUtilsFPDF;
      procedure DrawCanhoto(Args: TFPDFBandDrawArgs; vX, vY, vW, vH: double);
      procedure DrawTopBottom(Args: TFPDFBandDrawArgs);
      procedure DrawLeft(Args: TFPDFBandDrawArgs);
      procedure DrawRight(Args: TFPDFBandDrawArgs);

    protected
      procedure OnInit(Args: TFPDFBandInitArgs); override;
      procedure OnDraw(Args: TFPDFBandDrawArgs); override;

    public
      constructor Create(AAlign: TPosRecibo; AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
  end;

  { TBlocoDadosMDFe }
  TBlocoDadosMDFe = class(TFPDFBand)
    private
      FMDFeUtils: TMDFeUtilsFPDF;

      FLogo: TBytes;
      FLogoStretched: Boolean;
      FLogoAlign: TLogoAlign;
      FImageUtils: TImageUtils;

    protected
      procedure OnInit(Args: TFPDFBandInitArgs); override;
      procedure OnDraw(Args: TFPDFBandDrawArgs); override;

    public
      constructor Create(AMDFeUtils: TMDFeUtilsFPDF; ALogo: TBytes; ALogoStretched: Boolean; ALogoAlign: TLogoAlign); reintroduce;
      destructor Destroy; override;
  end;

{ TBlocoDocAuxiliarMDFe }
TBlocoDocAuxiliarMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoModalCargaRodoviarioMDFe }
TBlocoModalCargaRodoviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoModalCargaAereoMDFe }
TBlocoModalCargaAereoMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoModalCargaAquaviarioMDFe }
TBlocoModalCargaAquaviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoModalCargaFerroviarioMDFe }
TBlocoModalCargaFerroviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoProtocoloAutorizacaoMDFe }
TBlocoProtocoloAutorizacaoMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesModalRodoviarioMDFe }
TBlocoTabelaInformacoesModalRodoviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesModalAereoMDFe }
TBlocoTabelaInformacoesModalAereoMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesModalAquaviarioMDFe }
TBlocoTabelaInformacoesModalAquaviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesModalFerroviarioMDFe }
TBlocoTabelaInformacoesModalFerroviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe }
TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesComposicaoCargaAereoMDFe }
TBlocoTabelaInformacoesComposicaoCargaAereoMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe }
TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe }
TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoObservacoesMDFe }
TBlocoObservacoesMDFe = class(TFPDFBand)
  private
    FMDFeUtils: TMDFeUtilsFPDF;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFeUtils: TMDFeUtilsFPDF); reintroduce;
end;

{ TBlocoRodapeMDFe }
TBlocoRodapeMDFe = class(TFPDFBand)
  private
    FMensagem: string;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(const AMensagem: string); reintroduce;
end;

{ TBlocoCabecalhoEventoMDFe }
TBlocoCabecalhoEventoMDFe = class(TFPDFBand)
  private
    FProcEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AProcEvento: TInfEventoCollectionItem); reintroduce;
end;

{ TBlocoDadosMDFeEvento }
TBlocoDadosMDFeEvento = class(TFPDFBand)
  private
    FMDFe: TMDFe;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AMDFe: TMDFe); reintroduce;
end;

{ TBlocoDadosEventoMDFe }
TBlocoDadosEventoMDFe = class(TFPDFBand)
  private
    FProcEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AProcEvento: TInfEventoCollectionItem); reintroduce;
end;

{ TBlocoJustificativaMDFe }
TBlocoJustificativaMDFe = class(TFPDFBand)
  private
    FProcEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AProcEvento: TInfEventoCollectionItem); reintroduce;
end;

{ TBlocoEncerramentoMDFe }
TBlocoEncerramentoMDFe = class(TFPDFBand)
  private
    FProcEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AProcEvento: TInfEventoCollectionItem); reintroduce;
end;

{ TBlocoCondutorMDFe }
TBlocoCondutorMDFe = class(TFPDFBand)
  private
    FProcEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AProcEvento: TInfEventoCollectionItem); reintroduce;
end;

{ TBlocoMensagemEventoMDFe }
TBlocoMensagemEventoMDFe = class(TFPDFBand)
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
end;

{ TMDFeDAMDFeEventoFPDF }
TMDFeDAMDFeEventoFPDF = class(TFPDFReport)
  private
    FMDFe: TMDFe;
    FProcEvento: TInfEventoCollectionItem;
    FMensagemRodape: string;
    FInitialized: boolean;
  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;
  public
    constructor Create(AMDFe: TMDFe; AProcEvento: TInfEventoCollectionItem); reintroduce;
    property MensagemRodape: string read FMensagemRodape write FMensagemRodape;
end;

{ TBlocoCanhoto }

const
  cDefaultFontFamily = 'Times';

procedure TBlocoCanhoto.DrawCanhoto(Args: TFPDFBandDrawArgs; vX, vY, vW, vH: double);
begin
  inherited;
end;

procedure TBlocoCanhoto.DrawTopBottom(Args: TFPDFBandDrawArgs);
begin
  DrawCanhoto(Args, 0, 0, Width, 10);
end;

procedure TBlocoCanhoto.DrawLeft(Args: TFPDFBandDrawArgs);
var
  x, y: double;
begin
  x := 0;
  y := Height;

  Args.PDF.Rotate(90, x, y);
  try
    DrawCanhoto(Args, x, y, Height, 10);
  finally
    Args.PDF.Rotate(0, x, y);
  end;
end;

procedure TBlocoCanhoto.DrawRight(Args: TFPDFBandDrawArgs);
var
  x, y: double;
begin
  x := 0;
  y := Height;

  Args.PDF.Rotate(90, x, y);
  try
    DrawCanhoto(Args, x, y, Height, 10);
  finally
    Args.PDF.Rotate(0, x, y);
  end;
end;

procedure TBlocoCanhoto.OnInit(Args: TFPDFBandInitArgs);
begin
  case FAlign of
    prCabecalho,
    prRodape:
      Height := 33;
    prEsquerda:
      Width := 33;
  else
    //
  end;

  // Por causa do double pass
  Visible := True;
end;

procedure TBlocoCanhoto.OnDraw(Args: TFPDFBandDrawArgs);
begin
    case FAlign of
    prCabecalho,
    prRodape:
      DrawTopBottom(Args);
    prEsquerda:
      DrawLeft(Args);
    //caRight:
    //  DrawRight(Args);
  else
    //
  end;

  // Para não ser exibido nas próximas páginas
  Visible := False;
end;

constructor TBlocoCanhoto.Create(AAlign: TPosRecibo; AMDFeUtils: TMDFeUtilsFPDF);
begin
  FAlign := AAlign;

    case FAlign of
    prCabecalho:
      inherited Create(btTopMargin);
    prEsquerda:
      inherited Create(btLeftMargin);
    //caRight:
    //  inherited Create(btRightMargin);
    prRodape:
      inherited Create(btBottomMargin);
  else
    inherited Create(btTopMargin);
    Visible := False;
  end;

  FMDFeUtils := AMDFeUtils;
end;

{ TMDFeDAMDFeFPDF }

procedure TMDFeDAMDFeFPDF.OnStartReport(Args: TFPDFReportEventArgs);
var
  LLogoStringStream : TStringStream;
  LStream : TMemoryStream;
  LOrientation: TFPDFOrientation;
begin
  if not FInitialized then
  begin
    if FMDFe = nil then
      raise Exception.Create('FACBrMDFe not initialized');

    if FDAMDFEClassOwner.Logo <> '' then
    begin
      LStream := TMemoryStream.Create;
      try
        if FileExists(FDAMDFEClassOwner.Logo) then
        LStream.LoadFromFile(FDAMDFEClassOwner.Logo)
        else
        begin
          LLogoStringStream := TStringStream.Create(FDAMDFEClassOwner.Logo);
          try
            LStream.LoadFromStream(LLogoStringStream);
            LStream.Position := 0;
          finally
            LLogoStringStream.Free;
          end;
        end;
          SetLength(FLogo, LStream.Size);
          LStream.Position := 0;
          LStream.Read(FLogo[0], LStream.Size);
      finally
        LStream.Free;
      end;
    end;
    AddPage(LOrientation);
    AddBand(TBlocoCanhoto.Create(PosCanhoto, FMDFeUtils));
    AddBand(TBlocoDadosMDFe.Create(FMDFeUtils, FLogo, FLogoStretched, FLogoAlign));
    AddBand(TBlocoDocAuxiliarMDFe.Create(FMDFeUtils));

    // "Informações da Composição da Carga" só consta no leiaute do manual
    // (Anexo II do MOC) nos modelos de emissão em contingência - na emissão
    // normal esse bloco não aparece em nenhum dos 4 modais.
    case FMDFe.Ide.modal of
      moRodoviario:
        begin
          //Modal Carga Rodoviario
          AddBand(TBlocoModalCargaRodoviarioMDFe.Create(FMDFeUtils));
          AddBand(TBlocoTabelaInformacoesModalRodoviarioMDFe.Create(FMDFeUtils));
          if FMDFe.Ide.tpEmis <> teNormal then
            AddBand(TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe.Create(FMDFeUtils));
        end;
      moAereo:
        begin
          //Modal Carga Aereo
          AddBand(TBlocoModalCargaAereoMDFe.Create(FMDFeUtils));
          AddBand(TBlocoTabelaInformacoesModalAereoMDFe.Create(FMDFeUtils));
          if FMDFe.Ide.tpEmis <> teNormal then
            AddBand(TBlocoTabelaInformacoesComposicaoCargaAereoMDFe.Create(FMDFeUtils));
        end;
      moAquaviario:
        begin
          //Modal Carga Aquaviario
          AddBand(TBlocoModalCargaAquaviarioMDFe.Create(FMDFeUtils));
          AddBand(TBlocoTabelaInformacoesModalAquaviarioMDFe.Create(FMDFeUtils));
          if FMDFe.Ide.tpEmis <> teNormal then
            AddBand(TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe.Create(FMDFeUtils));
        end;
      moFerroviario:
        begin
          //Modal Carga Ferroviario
          AddBand(TBlocoModalCargaFerroviarioMDFe.Create(FMDFeUtils));
          AddBand(TBlocoTabelaInformacoesModalFerroviarioMDFe.Create(FMDFeUtils));
          if FMDFe.Ide.tpEmis <> teNormal then
            AddBand(TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe.Create(FMDFeUtils));
        end;
    end;
    //Protocolo de Autorização
    AddBand(TBlocoProtocoloAutorizacaoMDFe.Create(FMDFeUtils));

    AddBand(TBlocoObservacoesMDFe.Create(FMDFeUtils));
    AddBand(TBlocoRodapeMDFe.Create(FMensagemRodape));
    FInitialized := True;
  end;
end;

constructor TMDFeDAMDFeFPDF.Create(AMDFe: TMDFe; AACBrMDFeDAMDFEClass: TACBrMDFeDAMDFEClass);
var
  LFormatSettings: TFormatSettings;
begin
  inherited Create;
  FMDFeUtils := TMDFeUtilsFPDF.Create(AMDFe, AACBrMDFeDAMDFEClass);
  FMDFe:= AMDFe;
  Self.FDAMDFEClassOwner := AACBrMDFeDAMDFEClass;
  {$IFDEF HAS_FORMATSETTINGS}
    LFormatSettings := CreateFormatSettings;
  {$ENDIF}
  LFormatSettings.DecimalSeparator  := ',';
  LFormatSettings.ThousandSeparator := '.';
  FMDFeUtils.FormatSettings := LFormatSettings;

  SetFont('Times');
  SetUTF8(false);
  EngineOptions.DoublePass := True;
end;

destructor TMDFeDAMDFeFPDF.Destroy;
begin
  FMDFeUtils.Free;
  inherited;
end;

{ TACBrMDFeDAMDFeFPDF }

constructor TACBrMDFeDAMDFeFPDF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TACBrMDFeDAMDFeFPDF.Destroy;
begin
  FFPDFReport.Free;
  inherited;
end;

procedure TACBrMDFeDAMDFeFPDF.ImprimirDAMDFe(MDFE: TMDFe);
begin
  inherited;
end;

procedure TACBrMDFeDAMDFeFPDF.ImprimirDAMDFePDF(MDFE: TMDFe);
var
  Report: TFPDFReport;
  Engine: TFPDFEngine;
  I: Integer;
  LMDFe: TMDFe;
  LPath: String;
begin
  for I := 0 to TACBrMDFe(ACBrMDFe).Manifestos.Count -1 do
  begin
    LMDFe := TACBrMDFe(ACBrMDFe).Manifestos[I].MDFe;
    Report := TMDFeDAMDFeFPDF.Create(LMDFe, TACBrMDFeDAMDFeClass(TACBrMDFe(ACBrMDFe).DAMDFE));

    FIndexImpressaoIndividual := I;

    TMDFeDAMDFeFPDF(Report).PosCanhoto := TMDFeDAMDFeFPDF(TACBrMDFe(ACBrMDFe).DAMDFE).PosCanhoto;

    TMDFeDAMDFeFPDF(Report).MensagemRodape := Self.Sistema;

    try
      Engine := TFPDFEngine.Create(Report, False);
      try
        Engine.Compressed := True;
        if Assigned(FStream) then
        begin
          FPArquivoPDF := RemoverLiteralChave(LMDFe.infMDFe.Id) + '-mdfe.pdf';
          Engine.SaveToStream(FStream);
        end else
        begin
          LPath := DefinirNomeArquivo(TACBrMDFe(ACBrMDFe).DAMDFE.PathPDF,
                 RemoverLiteralChave(LMDFe.infMDFe.Id) + '-mdfe.pdf',
                 TACBrMDFe(ACBrMDFe).DAMDFE.NomeDocumento);

          ForceDirectories(ExtractFilePath(LPath));

          Engine.SaveToFile(LPath);
          FPArquivoPDF := LPath;
        end;
      finally
        Engine.Free;
      end;
    finally
      Report.Free;
    end;
  end;
end;

procedure TACBrMDFeDAMDFeFPDF.ImprimirDAMDFePDF(AStream: TStream; MDFE: TMDFe);
begin
  FStream := AStream;

  if not Assigned(FStream) then
    raise Exception.Create('Stream not initialized');

  ImprimirDAMDFEPDF(MDFE);
end;

procedure TACBrMDFeDAMDFeFPDF.ImprimirEVENTO(AMDFe: TMDFe);
begin
  inherited;
end;

procedure TACBrMDFeDAMDFeFPDF.ImprimirEVENTOPDF(AMDFe: TMDFe);
var
  Report: TFPDFReport;
  Engine: TFPDFEngine;
  I: Integer;
  LMDFe: TMDFe;
  LEvento: TInfEventoCollectionItem;
  LPath: String;
begin
  for I := 0 to TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Count - 1 do
  begin
    LMDFe   := TACBrMDFe(ACBrMDFe).Manifestos[I].MDFe;
    LEvento := TACBrMDFe(ACBrMDFe).EventoMDFe.Evento[I];

    Report := TMDFeDAMDFeEventoFPDF.Create(LMDFe, LEvento);

    FIndexImpressaoIndividual := I;

    TMDFeDAMDFeEventoFPDF(Report).MensagemRodape := Self.Sistema;

    try
      Engine := TFPDFEngine.Create(Report, False);
      try
        Engine.Compressed := True;
        if Assigned(FStream) then
        begin
          FPArquivoPDF := RemoverLiteralChave(LMDFe.infMDFe.Id) + '-evento.pdf';
          Engine.SaveToStream(FStream);
        end else
        begin
          LPath := DefinirNomeArquivo(TACBrMDFe(ACBrMDFe).DAMDFE.PathPDF,
                 TpEventoToStr(LEvento.InfEvento.tpEvento) + '-' +
                 RemoverLiteralChave(LMDFe.infMDFe.Id) + '-evento.pdf',
                 TACBrMDFe(ACBrMDFe).DAMDFE.NomeDocumento);

          ForceDirectories(ExtractFilePath(LPath));

          Engine.SaveToFile(LPath);
          FPArquivoPDF := LPath;
        end;
      finally
        Engine.Free;
      end;
    finally
      Report.Free;
    end;
  end;
end;

procedure TACBrMDFeDAMDFeFPDF.ImprimirEVENTOPDF(AStream: TStream; AMDFe: TMDFe);
begin
  FStream := AStream;

  if not Assigned(FStream) then
    raise Exception.Create('Stream not initialized');

  ImprimirEVENTOPDF(AMDFe);
end;

{ TBlocoDadosMDFe }

procedure TBlocoDadosMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 80;
end;

procedure TBlocoDadosMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y : double;
  x1, y1: double;
  DadosQRCode: string;
  LTexto: string;
  Stream: TMemoryStream;
begin
  inherited OnDraw(Args);

  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  // Posição inicial
  x := 10;
  y := - 20;

  // Cabeçalho - Logo
  if Length(FLogo) > 0 then
  begin
    Stream := TMemoryStream.Create;
    try
      Stream.Write(FLogo[0], Length(FLogo));
      LPDF.Image(x, y + 2, 24, 18, Stream);
    finally
      Stream.Free;
    end;
  end
  else
  begin
    LPDF.SetFont('Arial', 'B', 10);
    LPDF.Rect(x, y + 2, 24, 18);
    LPDF.Text(x + 2, y + 11, '');
  end;

  // Cabeçalho - Emitente
  LPDF.SetFont('Arial', 'B', 12);
  x1 := x + 45;
  y1 := y + 2;
  LTexto := LMDFE.emit.xNome;
  LPDF.TextBox(x1, y1, 70, 5, LTexto, 'T', 'L', 0, '');

  LPDF.SetFont('Arial', '', 9);
  x1 := x + 45;
  y1 := y + 7;
  LTexto := LMDFE.emit.enderEmit.xLgr + ', nº ' + LMDFE.emit.enderEmit.nro;
  if LMDFE.emit.enderEmit.xCpl <> '' then
    LTexto := LTexto + ', ' + LMDFE.emit.enderEmit.xCpl;
  LPDF.TextBox(x1, y1, 130, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 45;
  y1 := y + 11;
  LTexto := LMDFE.emit.enderEmit.xMun + ' - ' + LMDFE.emit.enderEmit.UF +
            '     CEP: ' + FormatarCEP(LMDFE.emit.enderEmit.CEP);
  LPDF.TextBox(x1, y1, 130, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 45;
  y1 := y + 15;
  LTexto := 'CNPJ: ' + FormatarCNPJ(LMDFE.emit.CNPJCPF);
  LPDF.TextBox(x1, y1, 80, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 85;
  y1 := y + 15;
  LTexto := 'IE: ' + LMDFE.emit.IE;
  LPDF.TextBox(x1, y1, 80, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 112;
  y1 := y + 15;
  if LMDFE.rodo.RNTRC <> '' then
    LTexto := 'RNTRC: ' + LMDFE.rodo.RNTRC
  else
    LTexto := 'RNTRC: ' + LMDFE.rodo.infANTT.RNTRC;
  LPDF.TextBox(x1, y1, 80, 5, LTexto, 'T', 'L', 0, '');

  //QRCode.
  LPDF.SetFont(6, 'B');
  x1 := x + 150;
  y1 := y + 2;
  DadosQRCode := LMDFE.infMDFeSupl.qrCodMDFe;
  LPDF.QRCode(x1, y1, 38, DadosQRCode);

end;

constructor TBlocoDadosMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF; ALogo: TBytes; ALogoStretched: Boolean; ALogoAlign: TLogoAlign);
begin
  inherited Create(btPageHeader);
  FMDFeUtils     := AMDFeUtils;
  FLogo          := ALogo;
  FLogoStretched := ALogoStretched;
  FLogoAlign     := ALogoAlign;
  FImageUtils    := TImageUtils.Create;
end;

destructor TBlocoDadosMDFe.Destroy;
begin
  inherited;
end;

{ TBlocoDocAuxiliarMDFe }

constructor TBlocoDocAuxiliarMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoDocAuxiliarMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  // Documento auxiliar
  LPDF.SetFont('Arial', 'B', 10);
  x1 := x;
  y1 := y - 65;
  LTexto := 'DAMDFE - Documento Auxiliar de Manifesto Eletrônico de Documentos Fiscais';
  LPDF.TextBox(x1, y1, 150, 5, LTexto, 'T', 'L', 0, '');

  // Campos fixos
  x1 := x;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Modelo';
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.Ide.modelo;
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 14;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Série';
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 14;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 9);
  LTexto := IntToStr(LMDFE.Ide.serie);
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 28;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Número';
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 28;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 9);
  LTexto := FormatarNumeroDocumentoFiscal(IntToStr(LMDFE.Ide.nMDF));
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 50;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'FL';
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 50;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 9);
  LTexto := IntToStr(LPDF.CurrentPage) + '/' + IntToStr(Args.TotalPages);
  LPDF.TextBox(x1, y1, 14, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 60;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Data e hora de Emissão';
  LPDF.TextBox(x1, y1, 35, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 60;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 10);
  LTexto := DateTimeToStr(LMDFE.Ide.dhEmi);
  LPDF.TextBox(x1, y1, 35, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 97;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'UF Carreg.';
  LPDF.TextBox(x1, y1, 18, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 97;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.Ide.UFIni;
  LPDF.TextBox(x1, y1, 18, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 117;
  y1 := y - 55;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'UF Descarreg.';
  LPDF.TextBox(x1, y1, 18, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 117;
  y1 := y - 51;
  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.Ide.UFFim;
  LPDF.TextBox(x1, y1, 18, 5, LTexto, 'T', 'L', 0, '');

end;

procedure TBlocoDocAuxiliarMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 80;
end;

{ TBlocoModalCargaRodoviarioMDFe }

constructor TBlocoModalCargaRodoviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoModalCargaRodoviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  bW, bH, x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  // Título da carga
  x1 := x;
  y1 := y - 121;
  LPDF.SetFont('Arial', 'B', 12);
  LTexto := 'Modelo Rodoviário de Carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 121;
  LPDF.SetFont('Arial', '', 8);
  LTexto := 'CONTROLE DO FISCO';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  //Codigo de Barras.
  LPDF.SetFont(6, 'B');
  x1 := x + 92;
  y1 := y - 116;
  bW := 100;
  bH := 18;
  //codigo de barras
  LPDF.Code128(RemoverLiteralChave(LMDFE.infMDFe.Id), x1 , y1, bH, bW);
  //linhas divisorias
  LPDF.SetFont(6, '');

  // Quantidade e Peso
  x1 := x;
  y1 := y - 111;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. CTe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qCTe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 111;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. NFe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qNFe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 111;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Peso total (Kg)';
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := FormatFloat('#,0.00', LMDFE.tot.qCarga, FMDFeUtils.FormatSettings);
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

end;

procedure TBlocoModalCargaRodoviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 80;
end;

{ TBlocoModalCargaAereoMDFe }

constructor TBlocoModalCargaAereoMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoModalCargaAereoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  bW, bH, x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  // Título da carga
  x1 := x;
  y1 := y - 121;
  LPDF.SetFont('Arial', 'B', 12);
  LTexto := 'Modelo Aéreo de Carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 121;
  LPDF.SetFont('Arial', '', 8);
  LTexto := 'CONTROLE DO FISCO';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  //Codigo de Barras.
  LPDF.SetFont(6, 'B');
  x1 := x + 92;
  y1 := y - 116;
  bW := 100;
  bH := 18;
  //codigo de barras
  LPDF.Code128(RemoverLiteralChave(LMDFE.infMDFe.Id), x1 , y1, bH, bW);
  //linhas divisorias
  LPDF.SetFont(6, '');

  // Quantidade e Peso
  x1 := x;
  y1 := y - 111;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. CTe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qCTe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 111;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. NFe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qNFe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 111;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Peso total (Kg)';
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := FormatFloat('#,0.00', LMDFE.tot.qCarga, FMDFeUtils.FormatSettings);
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoModalCargaAereoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 80;
end;

{ TBlocoModalCargaAquaviarioMDFe }

constructor TBlocoModalCargaAquaviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoModalCargaAquaviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  bW, bH, x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;


  //Embarcação
  x1 := x;
  y1 := y - 126;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Embarcação';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 121;
  LPDF.SetFont('Arial', '', 10);
  LTexto := LMDFE.aquav.cEmbar + ' - ' + LMDFE.aquav.xEmbar;
  LPDF.TextBox(x1, y1, 136, 5, LTexto, 'T', 'L', 0, '');

  // Título da carga
  x1 := x;
  y1 := y - 112;
  LPDF.SetFont('Arial', 'B', 12);
  LTexto := 'Modelo Aquaviário de Carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 112;
  LPDF.SetFont('Arial', '', 8);
  LTexto := 'CONTROLE DO FISCO';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  //Codigo de Barras.
  LPDF.SetFont(6, 'B');
  x1 := x + 92;
  y1 := y - 106;
  bW := 100;
  bH := 18;
  //codigo de barras
  LPDF.Code128(RemoverLiteralChave(LMDFE.infMDFe.Id), x1 , y1, bH, bW);
  //linhas divisorias
  LPDF.SetFont(6, '');

  // Quantidade (Qtd. CTe / Qtd. NFe / Qtd. MDFe Ref.)
  x1 := x;
  y1 := y - 106;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. CTe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 102;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qCTe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 106;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. NFe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 102;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qNFe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 106;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. MDFe Ref.';
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 102;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qMDFe);
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

  // Peso total (Kg) - linha própria, abaixo das quantidades
  x1 := x;
  y1 := y - 96;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Peso total (Kg)';
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 92;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := FormatFloat('#,0.00', LMDFE.tot.qCarga, FMDFeUtils.FormatSettings);
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoModalCargaAquaviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 80;
end;

{ TBlocoModalCargaFerroviarioMDFe }

constructor TBlocoModalCargaFerroviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoModalCargaFerroviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  bW, bH, x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Informações da Composição do trem.
  x1 := x;
  y1 := y - 127;
  LPDF.SetFont('Arial', 'B', 11);
  LTexto := 'Informações da Composição do trem';
  LPDF.TextBox(x1, y1, 65, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 123;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Prefixo do trem';
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 26;
  y1 := y - 123;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Data e hora';
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 63;
  y1 := y - 123;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Origem do trem';
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 89;
  y1 := y - 123;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Dest. do trem';
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 115;
  y1 := y - 123;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Qtd. de vagões carregados';
  LPDF.TextBox(x1, y1, 45, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x, y - 118, x + 160, y - 118);

  x1 := x;
  y1 := y - 114;
  LPDF.SetFont('Arial', '', 10);
  LTexto := LMDFE.ferrov.xPref;
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 26;
  y1 := y - 114;
  LPDF.SetFont('Arial', '', 10);
  LTexto := DateTimeToStr(LMDFE.ferrov.dhTrem);
  LPDF.TextBox(x1, y1, 35, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 63;
  y1 := y - 114;
  LPDF.SetFont('Arial', '', 10);
  LTexto := LMDFE.ferrov.xOri;
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 89;
  y1 := y - 114;
  LPDF.SetFont('Arial', '', 10);
  LTexto := LMDFE.ferrov.xDest;
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 115;
  y1 := y - 114;
  LPDF.SetFont('Arial', '', 10);
  LTexto := IntToStr(LMDFE.ferrov.qVag);
  LPDF.TextBox(x1, y1, 25, 5, LTexto, 'T', 'L', 0, '');

  // Título da carga
  x1 := x;
  y1 := y - 107;
  LPDF.SetFont('Arial', 'B', 12);
  LTexto := 'Modelo Ferroviário de Carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 107;
  LPDF.SetFont('Arial', '', 8);
  LTexto := 'CONTROLE DO FISCO';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  //Codigo de Barras.
  LPDF.SetFont(6, 'B');
  x1 := x + 92;
  y1 := y - 101;
  bW := 100;
  bH := 18;
  //codigo de barras
  LPDF.Code128(RemoverLiteralChave(LMDFE.infMDFe.Id), x1 , y1, bH, bW);
  //linhas divisorias
  LPDF.SetFont(6, '');

  // Quantidade e Peso
  x1 := x;
  y1 := y - 101;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. CTe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 97;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qCTe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 101;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Qtd. NFe';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 22;
  y1 := y - 97;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := IntToStr(LMDFE.tot.qNFe);
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 101;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Peso total (Kg)';
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 44;
  y1 := y - 97;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := FormatFloat('#,0.00', LMDFE.tot.qCarga, FMDFeUtils.FormatSettings);
  LPDF.TextBox(x1, y1, 30, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoModalCargaFerroviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 80;
end;

{ TBlocoProtocoloAutorizacaoMDFe }

constructor TBlocoProtocoloAutorizacaoMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoProtocoloAutorizacaoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Protocolo de autorização
  x1 := x;
  y1 := y - 175;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := 'Protocolo de autorização';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 171;
  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.procMDFe.nProt +' - '+ DateTimeToStr(LMDFE.procMDFe.dhRecbto);
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');

  //chave de acesso (mesma altura do bloco "Protocolo de autorização")
  x1 := x + 92;
  y1 := y - 175;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := 'Chave de Acesso';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 171;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := FormatarChaveAcesso(LMDFE.infMDFe.Id);
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 167;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := 'Consulte em https://dfe-portal.sefazvirtual.rs.gov.br/MDFe/consulta';
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoProtocoloAutorizacaoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesModalRodoviarioMDFe }

constructor TBlocoTabelaInformacoesModalRodoviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesModalRodoviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  i: Integer;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  // Tabela de Veículo
  x1 := x;
  y1 := y - 146;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Veículo';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Placa';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := LMDFE.rodo.veicTracao.placa;
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 40;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'RNTRC';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 40;
  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := LMDFE.rodo.infANTT.RNTRC;
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  // Tabela de Condutor
  x1 := x + 92;
  y1 := y - 146;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Condutor';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'CPF';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 132;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Nome';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x, y - 135, x + 90, y - 135);
  LPDF.Line(x + 92, y - 135, x + 182, y - 135);

  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  for i := 0 to LMDFE.rodo.veicTracao.condutor.Count - 1 do
  begin
    if y1 > y - 120 then
      Break;

    LPDF.TextBox(x + 92, y1, 20, 5, FormatarCPF(LMDFE.rodo.veicTracao.condutor.Items[i].CPF), 'T', 'L', 0, '');
    LPDF.TextBox(x + 132, y1, 50, 5, LMDFE.rodo.veicTracao.condutor.Items[i].xNome, 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;

  //Vale Pedágio
  x1 := x;
  y1 := y - 116;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Vale Pedágio';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 110;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Responsável CNPJ';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 34;
  y1 := y - 110;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Fornecedor CNPJ';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 70;
  y1 := y - 110;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Nº Comprovante';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x, y - 105, x + 110, y - 105);

  y1 := y - 101;
  LPDF.SetFont('Arial', '', 9);
  for i := 0 to LMDFE.rodo.infANTT.valePed.disp.Count - 1 do
  begin
    if y1 > y - 90 then
      Break;

    LPDF.TextBox(x, y1, 34, 5, FormatarCNPJouCPF(LMDFE.rodo.infANTT.valePed.disp.Items[i].CNPJPg), 'T', 'L', 0, '');
    LPDF.TextBox(x + 34, y1, 36, 5, FormatarCNPJouCPF(LMDFE.rodo.infANTT.valePed.disp.Items[i].CNPJForn), 'T', 'L', 0, '');
    LPDF.TextBox(x + 70, y1, 40, 5, LMDFE.rodo.infANTT.valePed.disp.Items[i].nCompra, 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;
end;

procedure TBlocoTabelaInformacoesModalRodoviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesModalAereoMDFe }

constructor TBlocoTabelaInformacoesModalAereoMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesModalAereoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  // Tabela de Aero
  x1 := x;
  y1 := y - 146;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Aeronave';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Marca de Nacionalidade';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 40;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Marca de Matrícula';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  // Tabela de Voo
  x1 := x + 92;
  y1 := y - 146;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Voo';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Número';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 132;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Data';
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x, y - 135, x + 90, y - 135);
  LPDF.Line(x + 92, y - 135, x + 182, y - 135);

  x1 := x;
  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := LMDFE.aereo.nac;
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 40;
  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := LMDFE.aereo.matr;
  LPDF.TextBox(x1, y1, 20, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := LMDFE.aereo.nVoo;
  LPDF.TextBox(x1, y1, 20, 5, Trim(LTexto), 'T', 'L', 0, '');

  x1 := x + 132;
  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  LTexto := DateTimeToStr(LMDFE.aereo.dVoo);
  LPDF.TextBox(x1, y1, 40, 5, Trim(LTexto), 'T', 'L', 0, '');

  //Aeródromo
  x1 := x;
  y1 := y - 116;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Aeródromo';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 110;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Embarque';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 110;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Destino';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x, y - 105, x + 90, y - 105);
  LPDF.Line(x + 92, y - 105, x + 182, y - 105);

  x1 := x;
  y1 := y - 101;
  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.aereo.cAerEmb;
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 101;
  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.aereo.cAerDes;
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoTabelaInformacoesModalAereoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesModalAquaviarioMDFe }

constructor TBlocoTabelaInformacoesModalAquaviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesModalAquaviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  i: Integer;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  // Tabela de Aquaviário
  x1 := x;
  y1 := y - 146;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Dados do Terminal';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Carregamento';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 92;
  y1 := y - 140;
  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Descarregamento';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x, y - 135, x + 90, y - 135);
  LPDF.Line(x + 92, y - 135, x + 182, y - 135);

  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  for i := 0 to LMDFE.aquav.infTermCarreg.Count - 1 do
  begin
    if y1 > y - 90 then
      Break;

    LPDF.TextBox(x, y1, 28, 5, LMDFE.aquav.infTermCarreg.Items[i].cTermCarreg, 'T', 'L', 0, '');
    LPDF.TextBox(x + 30, y1, 60, 5, LMDFE.aquav.infTermCarreg.Items[i].xTermCarreg, 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;

  y1 := y - 131;
  LPDF.SetFont('Arial', 'B', 9);
  for i := 0 to LMDFE.aquav.infTermDescarreg.Count - 1 do
  begin
    if y1 > y - 90 then
      Break;

    LPDF.TextBox(x + 92, y1, 28, 5, LMDFE.aquav.infTermDescarreg.Items[i].cTermDescarreg, 'T', 'L', 0, '');
    LPDF.TextBox(x + 122, y1, 60, 5, LMDFE.aquav.infTermDescarreg.Items[i].xTermDescarreg, 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;
end;

procedure TBlocoTabelaInformacoesModalAquaviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesModalFerroviarioMDFe }

constructor TBlocoTabelaInformacoesModalFerroviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesModalFerroviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
const
  cMaxLinhasPorColuna = 9;
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  i, iColuna, iLinha: Integer;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Tabela Ferroviário
  x1 := x;
  y1 := y - 146;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Informações dos vagões';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  LPDF.SetFont('Arial', '', 10);
  for iColuna := 0 to 1 do
  begin
    x1 := x + (iColuna * 100);
    y1 := y - 140;
    LPDF.TextBox(x1,      y1, 26, 5, 'Série de ident.', 'T', 'L', 0, '');
    LPDF.TextBox(x1 + 28, y1, 26, 5, 'Núm. ident.', 'T', 'L', 0, '');
    LPDF.TextBox(x1 + 52, y1, 16, 5, 'Seq.', 'T', 'L', 0, '');
    LPDF.TextBox(x1 + 68, y1, 26, 5, 'Ton. Útil.', 'T', 'L', 0, '');

    LPDF.Line(x1, y - 136, x1 + 90, y - 136);
  end;

  LPDF.SetFont('Arial', '', 10);
  for i := 0 to LMDFE.ferrov.vag.Count - 1 do
  begin
    iColuna := i div cMaxLinhasPorColuna;
    if iColuna > 1 then
      Break;

    iLinha := i mod cMaxLinhasPorColuna;
    x1 := x + (iColuna * 100);
    y1 := y - 132 + (iLinha * 5);

    LPDF.TextBox(x1,      y1, 26, 5, LMDFE.ferrov.vag.Items[i].serie, 'T', 'L', 0, '');
    LPDF.TextBox(x1 + 28, y1, 26, 5, IntToStr(LMDFE.ferrov.vag.Items[i].nVag), 'T', 'L', 0, '');
    LPDF.TextBox(x1 + 52, y1, 16, 5, IntToStr(LMDFE.ferrov.vag.Items[i].nSeq), 'T', 'L', 0, '');
    LPDF.TextBox(x1 + 68, y1, 26, 5, FormatFloat('#,0.000', LMDFE.ferrov.vag.Items[i].TU, FMDFeUtils.FormatSettings), 'T', 'L', 0, '');
  end;
end;

procedure TBlocoTabelaInformacoesModalFerroviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe }

constructor TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  i: Integer;
  j: Integer;
  k: Integer;
  LTexto: string;

  function AdicionarChave(ATexto: string): boolean;
  begin
    Result := (y1 <= -40);

    if not Result then
      exit;

    LPDF.TextBox(x1, y1, 90, 5, Trim(ATexto), 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;

begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Informações da Composição da Carga
  x1 := x;
  y1 := y - 90;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Informações da Composição da Carga';
  LPDF.TextBox(x1, y1, 100, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações dos documentos fiscais vinculados ao manifesto';
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := '';

  for i := 0 to LMDFE.rodo.veicTracao.condutor.Count - 1 do
    begin
      for j:=0 to LMDFE.infDoc.infMunDescarga.Count - 1 do
      begin
        for k:=0 to LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Count - 1 do
        begin
          if not AdicionarChave('NFe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Items[k].chNFe)) then
            break;
        end;

        for k:=0 to LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Count - 1 do
        begin
          if not AdicionarChave('CTe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Items[k].chCTe)) then
            break;
        end;
      end;
    end;

  x1 := x + 90;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de transporte';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 90;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := '';
  for i := 0 to LMDFE.rodo.veicTracao.condutor.Count - 1 do
    begin
      LTexto := 'Rodoviário Tração';
    end;
  LPDF.TextBox(x1, y1, 55, 5, Trim(LTexto), 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := '';
  for i := 0 to LMDFE.rodo.veicTracao.condutor.Count - 1 do
    begin
      LTexto := 'Container';
    end;
  LPDF.TextBox(x1, y1, 55, 5, Trim(LTexto), 'T', 'L', 0, '');
end;

procedure TBlocoTabelaInformacoesComposicaoCargaRodoviarioMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesComposicaoCargaAereoMDFe }

constructor TBlocoTabelaInformacoesComposicaoCargaAereoMDFe.Create(
  AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesComposicaoCargaAereoMDFe.OnDraw(
  Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  j, k: Integer;
  LTexto: string;

  function AdicionarChave(ATexto: string): boolean;
  begin
    Result := (y1 <= -40);

    if not Result then
      exit;

    LPDF.TextBox(x1, y1, 90, 5, Trim(ATexto), 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;

begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Informações da Composição da Carga
  x1 := x;
  y1 := y - 90;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Informações da Composição da Carga';
  LPDF.TextBox(x1, y1, 100, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações dos documentos fiscais vinculados ao manifesto';
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  for j := 0 to LMDFE.infDoc.infMunDescarga.Count - 1 do
  begin
    for k := 0 to LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Count - 1 do
      if not AdicionarChave('NFe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Items[k].chNFe)) then
        Break;

    for k := 0 to LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Count - 1 do
      if not AdicionarChave('CTe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Items[k].chCTe)) then
        Break;
  end;

  x1 := x + 90;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de transporte';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 90;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Aeronave';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Outros';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoTabelaInformacoesComposicaoCargaAereoMDFe.OnInit(
  Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe }

constructor TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe.Create(
  AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe.OnDraw(
  Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  j, k: Integer;
  LTexto: string;

  function AdicionarChave(ATexto: string): boolean;
  begin
    Result := (y1 <= -40);

    if not Result then
      exit;

    LPDF.TextBox(x1, y1, 90, 5, Trim(ATexto), 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;

begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Informações da Composição da Carga
  x1 := x;
  y1 := y - 90;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Informações da Composição da Carga';
  LPDF.TextBox(x1, y1, 100, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações dos documentos fiscais vinculados ao manifesto';
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  for j := 0 to LMDFE.infDoc.infMunDescarga.Count - 1 do
  begin
    for k := 0 to LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Count - 1 do
      if not AdicionarChave('NFe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Items[k].chNFe)) then
        Break;

    for k := 0 to LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Count - 1 do
      if not AdicionarChave('CTe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Items[k].chCTe)) then
        Break;
  end;

  x1 := x + 90;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de transporte';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 90;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Navio';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Outros';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoTabelaInformacoesComposicaoCargaAquaviarioMDFe.OnInit(
  Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe }

constructor TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe.Create(
  AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe.OnDraw(
  Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  j, k: Integer;
  LTexto: string;

  function AdicionarChave(ATexto: string): boolean;
  begin
    Result := (y1 <= -40);

    if not Result then
      exit;

    LPDF.TextBox(x1, y1, 90, 5, Trim(ATexto), 'T', 'L', 0, '');
    y1 := y1 + 4;
  end;

begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Informações da Composição da Carga
  x1 := x;
  y1 := y - 90;
  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Informações da Composição da Carga';
  LPDF.TextBox(x1, y1, 100, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações dos documentos fiscais vinculados ao manifesto';
  LPDF.TextBox(x1, y1, 90, 5, LTexto, 'T', 'L', 0, '');

  x1 := x;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  for j := 0 to LMDFE.infDoc.infMunDescarga.Count - 1 do
  begin
    for k := 0 to LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Count - 1 do
      if not AdicionarChave('NFe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infNFe.Items[k].chNFe)) then
        Break;

    for k := 0 to LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Count - 1 do
      if not AdicionarChave('CTe - ' + FormatarChaveAcesso(LMDFE.infDoc.infMunDescarga.Items[j].infCTe.Items[k].chCTe)) then
        Break;
  end;

  x1 := x + 90;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de transporte';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 90;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Ferroviário';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 84;
  LPDF.SetFont('Arial', 'B', 8);
  LTexto := 'Informações da unidade de carga';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');

  x1 := x + 145;
  y1 := y - 80;
  LPDF.SetFont('Arial', '', 9);
  LTexto := 'Outros';
  LPDF.TextBox(x1, y1, 55, 5, LTexto, 'T', 'L', 0, '');
end;

procedure TBlocoTabelaInformacoesComposicaoCargaFerroviarioMDFe.OnInit(
  Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoObservacoesMDFe }

constructor TBlocoObservacoesMDFe.Create(AMDFeUtils: TMDFeUtilsFPDF);
begin
  inherited Create(btData);
  FMDFeUtils := AMDFeUtils;
end;

procedure TBlocoObservacoesMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LMDFE: TMDFe;
  x, y: double;
  x1, y1: double;
  LTexto: string;
begin
  LPDF := Args.PDF;
  LMDFE := FMDFeUtils.MDFe;

  //Posição Inicial
  x := 10;
  y := 0;

  //Observações
  // "Informações da Composição da Carga" só aparece em emissão de
  // contingência (reserva até y-40) - na emissão normal esse espaço fica
  // vazio, então as Observações sobem pra ficar logo depois do bloco do
  // modal, sem vão em branco entre os dois.
  x1 := x;
  if LMDFE.Ide.tpEmis = teNormal then
    y1 := y - 88
  else
    y1 := y - 39;

  LPDF.SetFont('Arial', 'B', 10);
  LTexto := 'Observações';
  LPDF.TextBox(x1, y1, 40, 5, LTexto, 'T', 'L', 0, '');

  LPDF.Line(x1, y1 + 5, x1 + 190, y1 + 5);

  LPDF.SetFont('Arial', '', 9);
  LTexto := LMDFE.infAdic.infCpl;
  x1 := x;
  y1 := y1 + 7;
  LPDF.TextBox(x1, y1, 190, 150, LTexto, 'T', 'L', 0, '', False);
end;

procedure TBlocoObservacoesMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1;
end;

{ TBlocoRodapeMDFe }

constructor TBlocoRodapeMDFe.Create(const AMensagem: string);
begin
  inherited Create(btPageFooter);
  FMensagem := AMensagem;
end;

procedure TBlocoRodapeMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  x, y, w, h: double;
  Mensagens: TStringArray;
begin
  LPDF := Args.PDF;
  if FMensagem = '' then
    Exit;
  Mensagens := ACBr_fpdf.Split(FMensagem, '|');

  x := 0;
  y := 0;
  w := Width;
  h := Height;

  LPDF.SetFont(6, 'I');
  if Length(Mensagens) >= 1 then
    LPDF.TextBox(x, y, w, h, Mensagens[0], 'T', 'L', 0);
  if Length(Mensagens) >= 2 then
    LPDF.TextBox(x, y, w, h, Mensagens[1], 'T', 'C', 0);
  if Length(Mensagens) >= 3 then
    LPDF.TextBox(x, y, w, h, Mensagens[2], 'T', 'R', 0);
end;

procedure TBlocoRodapeMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 5;
end;

{ TBlocoCabecalhoEventoMDFe }

constructor TBlocoCabecalhoEventoMDFe.Create(AProcEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FProcEvento := AProcEvento;
end;

procedure TBlocoCabecalhoEventoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 18;
end;

procedure TBlocoCabecalhoEventoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  w, y: double;
  Texto: string;
begin
  LPDF := Args.PDF;
  w := Width;
  y := 0;

  LPDF.SetFont(12, 'B');
  Texto := FProcEvento.InfEvento.DescEvento;
  y := y + 2;
  y := y + LPDF.TextBox(0, y, w, 5, Texto, 'T', 'C', 0, '');
  y := y + 1;

  LPDF.SetFont(10, '');
  Texto := 'Nao possui valor fiscal, simples representacao do fato indicado abaixo.';
  y := y + LPDF.TextBox(0, y, w, 5, Texto, 'T', 'C', 0, '');
  y := y + 1;

  LPDF.SetFont(10, '');
  Texto := 'CONSULTE A AUTENTICIDADE NO SITE DA SEFAZ AUTORIZADORA.';
  LPDF.TextBox(0, y, w, 5, Texto, 'T', 'C', 0, '');
end;

{ TBlocoDadosMDFeEvento }

constructor TBlocoDadosMDFeEvento.Create(AMDFe: TMDFe);
begin
  inherited Create(btData);
  FMDFe := AMDFe;
end;

procedure TBlocoDadosMDFeEvento.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 20;
end;

procedure TBlocoDadosMDFeEvento.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  maxW, w, h, w1, w2, w3, w4, bW, bH: double;
  x, y: double;
  Texto: string;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 1;
  maxW := Width;
  h := 8;

  LPDF.SetFont(7, 'B');
  LPDF.TextBox(x, y, maxW, h, 'MANIFESTO ELETRONICO DE DOCUMENTOS FISCAIS', 'T', 'L', 0, '');
  y := y + 3;

  w1 := RoundTo(maxW * 0.10, 0);
  w := w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'MODELO', 'T', 'C', 1, '');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, FMDFe.Ide.modelo, 'B', 'C', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.10, 0);
  w := w2;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'SERIE', 'T', 'C', 1, '');
  Texto := FormatFloat('000', FMDFe.Ide.serie);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w3 := RoundTo(maxW * 0.15, 0);
  w := w3;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'NUMERO', 'T', 'C', 1, '');
  Texto := FormatFloat('000000000', FMDFe.Ide.nMDF);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w4 := RoundTo(maxW * 0.15, 0);
  w := w4;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'DATA/HORA DE EMISSAO', 'T', 'L', 1, '');
  Texto := FormatDateTimeBr(FMDFe.Ide.dhEmi, 'dd/mm/yyyy hh:nn:ss');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w := maxW - w1 - w2 - w3 - w4;
  LPDF.TextBox(x, y, w, 2 * h);
  LPDF.SetFillColor(0, 0, 0);
  bW := 75;
  bH := 12;
  LPDF.Code128(RemoverLiteralChave(FMDFe.infMDFe.Id), x + ((w - bW) / 2), y + 2, bH, bW);

  x := 0;
  y := y + h;
  w := w1 + w2 + w3 + w4;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'CHAVE DE ACESSO', 'T', 'L', 1, '');
  Texto := FormatarChaveAcesso(OnlyAlphaNum(FMDFe.infMDFe.Id));
  LPDF.SetFont(10, 'B');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');
end;

{ TBlocoDadosEventoMDFe }

constructor TBlocoDadosEventoMDFe.Create(AProcEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FProcEvento := AProcEvento;
end;

procedure TBlocoDadosEventoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 25;
end;

procedure TBlocoDadosEventoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  maxW, w, h, w1, w2, w3: double;
  x, y: double;
  Texto: string;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 1;
  maxW := Width;
  h := 7;

  LPDF.SetFont(7, 'B');
  LPDF.TextBox(x, y, maxW, h, 'DADOS DO EVENTO', 'T', 'L', 0, '');
  y := y + 3;

  w1 := RoundTo(maxW * 0.10, 0);
  w := w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'ORGAO', 'T', 'C', 1, '');
  Texto := CodigoUFParaUF(FProcEvento.InfEvento.cOrgao);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w2 := maxW - RoundTo(maxW * 0.30, 0);
  w := w2;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'AMBIENTE', 'T', 'L', 1, '');
  if FProcEvento.InfEvento.tpAmb = taProducao then
    Texto := '1 - PRODUCAO'
  else
    Texto := '2 - HOMOLOGACAO (SEM VALOR FISCAL)';
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'L', 0, '');

  x := x + w;
  w3 := maxW - w1 - w2;
  w := w3;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'DATA/HORA DO EVENTO', 'T', 'L', 1, '');
  Texto := FormatDateTimeBr(FProcEvento.InfEvento.dhEvento, 'dd/mm/yyyy hh:nn:ss');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := 0;
  y := y + h;
  w1 := RoundTo(maxW * 0.10, 0);
  w := w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'EVENTO', 'T', 'L', 1, '');
  Texto := TpEventoToStr(FProcEvento.InfEvento.tpEvento);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.55, 0);
  w := w2;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'DESCRICAO DO EVENTO', 'T', 'L', 1, '');
  Texto := FProcEvento.InfEvento.detEvento.descEvento;
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'L', 0, '');

  x := x + w;
  w3 := (maxW - w1 - w2) / 2;
  w := w3;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'SEQUENCIAL', 'T', 'L', 1, '');
  Texto := IntToStr(FProcEvento.InfEvento.nSeqEvento);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'VERSAO', 'T', 'L', 1, '');
  Texto := FProcEvento.InfEvento.versaoEvento;
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := 0;
  y := y + h;
  w1 := RoundTo(maxW * 0.50, 0);
  w := w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'STATUS', 'T', 'L', 1, '');
  Texto := Format('%d - %s', [FProcEvento.RetInfEvento.cStat, FProcEvento.RetInfEvento.xMotivo]);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'L', 0, '');

  x := x + w;
  w2 := (maxW - w1) / 2;
  w := w2;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'PROTOCOLO DE REGISTRO', 'T', 'L', 1, '');
  Texto := FProcEvento.RetInfEvento.nProt;
  LPDF.SetFont(10, 'B');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'DATA/HORA DO REGISTRO', 'T', 'L', 1, '');
  Texto := FormatDateTimeBr(FProcEvento.RetInfEvento.dhRegEvento, 'dd/mm/yyyy hh:nn:ss');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');
end;

{ TBlocoJustificativaMDFe }

constructor TBlocoJustificativaMDFe.Create(AProcEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FProcEvento := AProcEvento;
end;

procedure TBlocoJustificativaMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 30;
end;

procedure TBlocoJustificativaMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  maxW, y: double;
  Texto: string;
begin
  LPDF := Args.PDF;
  maxW := Width;
  y := 1;

  LPDF.SetFont(7, 'B');
  LPDF.TextBox(0, y, maxW, 5, 'JUSTIFICATIVA DO CANCELAMENTO', 'T', 'L', 0, '');
  y := y + 3;

  LPDF.Rect(0, y, maxW, Height - y);

  Texto := FProcEvento.InfEvento.detEvento.xJust;
  LPDF.SetFont(10, '');
  LPDF.TextBox(2, y + 2, maxW - 4, Height - y - 2, Texto, 'T', 'L', 0, '', False);
end;

{ TBlocoEncerramentoMDFe }

constructor TBlocoEncerramentoMDFe.Create(AProcEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FProcEvento := AProcEvento;
end;

procedure TBlocoEncerramentoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 20;
end;

procedure TBlocoEncerramentoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  DetEvento: TDetEvento;
  maxW, w, h, w1, w2, w3: double;
  x, y: double;
  Texto: string;
begin
  LPDF := Args.PDF;
  DetEvento := FProcEvento.InfEvento.detEvento;
  x := 0;
  y := 1;
  maxW := Width;
  h := 7;

  LPDF.SetFont(7, 'B');
  LPDF.TextBox(x, y, maxW, h, 'DADOS DO ENCERRAMENTO', 'T', 'L', 0, '');
  y := y + 3;

  w1 := RoundTo(maxW * 0.25, 0);
  w := w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'DATA DO ENCERRAMENTO', 'T', 'L', 1, '');
  Texto := FormatDateTimeBr(DetEvento.dtEnc, 'dd/mm/yyyy');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.15, 0);
  w := w2;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'UF', 'T', 'L', 1, '');
  Texto := CodigoUFParaUF(DetEvento.cUF);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w3 := RoundTo(maxW * 0.30, 0);
  w := w3;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'MUNICIPIO (COD. IBGE)', 'T', 'L', 1, '');
  Texto := IntToStr(DetEvento.cMun);
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');

  x := x + w;
  w := maxW - w1 - w2 - w3;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'ENCERRADO POR TERCEIRO', 'T', 'L', 1, '');
  if DetEvento.indEncPorTerceiro = tiSim then
    Texto := 'SIM'
  else
    Texto := 'NAO';
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, Texto, 'B', 'C', 0, '');
end;

{ TBlocoCondutorMDFe }

constructor TBlocoCondutorMDFe.Create(AProcEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FProcEvento := AProcEvento;
end;

procedure TBlocoCondutorMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 15;
end;

procedure TBlocoCondutorMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  DetEvento: TDetEvento;
  maxW, w, h, w1: double;
  x, y: double;
begin
  LPDF := Args.PDF;
  DetEvento := FProcEvento.InfEvento.detEvento;
  x := 0;
  y := 1;
  maxW := Width;
  h := 7;

  LPDF.SetFont(7, 'B');
  LPDF.TextBox(x, y, maxW, h, 'CONDUTOR INCLUIDO', 'T', 'L', 0, '');
  y := y + 3;

  w1 := RoundTo(maxW * 0.70, 0);
  w := w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'NOME', 'T', 'L', 1, '');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, DetEvento.xNome, 'B', 'L', 0, '');

  x := x + w;
  w := maxW - w1;
  LPDF.SetFont(6, '');
  LPDF.TextBox(x, y, w, h, 'CPF', 'T', 'L', 1, '');
  LPDF.SetFont(10, '');
  LPDF.TextBox(x, y, w, h, FormatarCPF(DetEvento.CPF), 'B', 'C', 0, '');
end;

{ TBlocoMensagemEventoMDFe }

procedure TBlocoMensagemEventoMDFe.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 15;
end;

procedure TBlocoMensagemEventoMDFe.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  Texto: string;
begin
  LPDF := Args.PDF;
  Texto := 'Este documento e uma representacao grafica de um evento do MDF-e e ' +
           'foi impresso apenas para sua informacao, nao possui validade fiscal. ' +
           'O evento deve ser recebido e mantido em arquivo eletronico XML e pode ' +
           'ser consultado atraves do Portal do MDF-e ou do site da SEFAZ autorizadora.';
  LPDF.SetFont(9, 'I');
  LPDF.TextBox(0, 0, Width, Height, Texto, 'C', 'C', 0, '', False);
end;

{ TMDFeDAMDFeEventoFPDF }

constructor TMDFeDAMDFeEventoFPDF.Create(AMDFe: TMDFe; AProcEvento: TInfEventoCollectionItem);
begin
  inherited Create;
  FMDFe := AMDFe;
  FProcEvento := AProcEvento;

  SetFont('Times');
  SetUTF8(false);
  SetMargins(4, 4);
end;

procedure TMDFeDAMDFeEventoFPDF.OnStartReport(Args: TFPDFReportEventArgs);
begin
  if not FInitialized then
  begin
    if FMDFe = nil then
      raise Exception.Create('FMDFe not initialized');
    if FProcEvento = nil then
      raise Exception.Create('FProcEvento not initialized');

    AddPage;

    AddBand(TBlocoCabecalhoEventoMDFe.Create(FProcEvento));
    AddBand(TBlocoDadosMDFeEvento.Create(FMDFe));
    AddBand(TBlocoDadosEventoMDFe.Create(FProcEvento));

    case FProcEvento.InfEvento.tpEvento of
      teCancelamento:
        AddBand(TBlocoJustificativaMDFe.Create(FProcEvento));
      teEncerramento, teEncerramentoFisco:
        AddBand(TBlocoEncerramentoMDFe.Create(FProcEvento));
      teInclusaoCondutor:
        AddBand(TBlocoCondutorMDFe.Create(FProcEvento));
    end;

    AddBand(TBlocoMensagemEventoMDFe.Create(btPageFooter));
    AddBand(TBlocoRodapeMDFe.Create(FMensagemRodape));

    FInitialized := True;
  end;
end;

end.

