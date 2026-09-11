{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interaÁ„o com equipa- }
{ mentos de AutomaÁ„o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  VocÍ pode obter a ˙ltima vers„o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca È software livre; vocÍ pode redistribuÌ-la e/ou modific·-la }
{ sob os termos da LicenÁa P˙blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers„o 2.1 da LicenÁa, ou (a seu critÈrio) }
{ qualquer vers„o posterior.                                                   }
{                                                                              }
{  Esta biblioteca È distribuÌda na expectativa de que seja ˙til, porÈm, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implÌcita de COMERCIABILIDADE OU      }
{ ADEQUA«√O A UMA FINALIDADE ESPECÕFICA. Consulte a LicenÁa P˙blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN«A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  VocÍ deve ter recebido uma cÛpia da LicenÁa P˙blica Geral Menor do GNU junto}
{ com esta biblioteca; se n„o, escreva para a Free Software Foundation, Inc.,  }
{ no endereÁo 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ VocÍ tambÈm pode obter uma copia da licenÁa em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simıes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - TatuÌ - SP - 18270-170         }
{******************************************************************************}

unit ACBrTEFTXTPayGo;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils,
    ACBrTEFComum, ACBrTEFTXTComum, ACBrTEFTXTGerenciadorPadrao;

const
  CACBRTEFTXT_NomeClientPayGo = 'PayGo';
  CACBRTEFTXT_ACBrID = 'ACBrTEFTXTPayGo';

  CACBRTEFTXTPayGo_DIRREQ = 'C:\PAYGO\Req\';
  CACBRTEFTXTPayGo_DIRRESP = 'C:\PAYGO\Resp\';

  CACBRTEFTXT_CMD_CDP = 'CDP';  // Solicita CPF ou CNPJ no PinPad
  CACBRTEFTXT_CMD_QRP = 'QRP';  // Exibe QRCode no PinPad
  CACBRTEFTXT_CMD_FQR = 'FQR';  // Fim da Exibicao de Imagem QRCode no PinPad
  CACBRTEFTXT_CMD_MNU = 'MNU';  // Menu no PinPad

  CPayGoVersaoInterface = 225;

type

  { TACBrTEFRespTXTPayGo }

  TACBrTEFRespTXTPayGo = class( TACBrTEFRespTXTGerenciadorPadrao )
  public
    procedure ProcessarTipoInterno(ALinha: TACBrTEFLinha); override;
    procedure ConteudoToProperty; override;
  end;

  { TACBrTEFTXTPayGo }

  TACBrTEFTXTPayGo = class( TACBrTEFTXTGerenciadorPadrao )
  private
    fDadosAdicionais1: String;
    fDadosAdicionais2: String;
    fIdioma: Integer;
    fModelo: Integer;
    fMoeda: Integer;
    fNomeAplicacao: String;
    fRegistroCertificacao: String;
    fSoftwareHouse: String;
    fSuportaCupomReduzido: Boolean;
    fSuportaDesconto: Boolean;
    fSuportaReajusteValor: Boolean;
    fSuportaTroco: Boolean;
    fSuportaViasDiferentes: Boolean;
    fUsarCupomReduzido: Boolean;
    fVersaoAplicacao: String;
    function CalcularCapacidadesAutomacao: Integer;
  protected
    function GetModeloTEF: String; override;
    function GetVersaoTEF: String; override;

    procedure AdicionarCamposConfiguracao;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure PrepararRequisicao(const AHeader: String); override;
    function CRT(Valor: Double;
      const DocumentoVinculado: String = ''; DataHoraFiscal: TDateTime = 0;
      TipoCartao: Byte = 0; TipoFinanciamento: Byte = 0; FormaPagamento: Byte = 0;
      TipoPessoa: AnsiChar = 'F'; DocumentoPessoa: String = '';
      Parcelas: Byte = 0; DataPreDatado: TDateTime = 0;
      TaxaServico: Double = 0; TaxaEmabarque: Double = 0;
      Rede: String = ''): Boolean; overload;
    function CHQ(Valor: Double; const DocumentoVinculado: String = ''; CMC7: String =
      ''; TipoPessoa: AnsiChar = 'F'; DocumentoPessoa: String = '';
      DataCheque: TDateTime = 0; Banco: String = ''; Agencia: String = '';
      AgenciaDC: String = ''; Conta: String = ''; ContaDC: String = '';
      Cheque: String = ''; ChequeDC: String = ''; Compensacao: String = ''
      ): Boolean; override;

    function CPD(TipoPessoa: Char = 'F'): String;
    function QRP(const ConteudoQRCode: String): Boolean;
    function FQR: Boolean;
    function MNU(const Titulo: String; Opcoes: TStrings): Integer;

    property SuportaTroco: Boolean read fSuportaTroco write fSuportaTroco default True;
    property SuportaDesconto: Boolean read fSuportaDesconto write fSuportaDesconto default True;
    property SuportaViasDiferentes: Boolean read fSuportaViasDiferentes write fSuportaViasDiferentes default True;
    property SuportaCupomReduzido: Boolean read fSuportaCupomReduzido write fSuportaCupomReduzido default True;
    property UsarCupomReduzido: Boolean read fUsarCupomReduzido write fUsarCupomReduzido default False;
    property SuportaReajusteValor: Boolean read fSuportaReajusteValor write fSuportaReajusteValor default True;

    property NomeAplicacao: String read fNomeAplicacao write fNomeAplicacao;
    property VersaoAplicacao: String read fVersaoAplicacao write fVersaoAplicacao;
    property RegistroCertificacao: String read fRegistroCertificacao write fRegistroCertificacao;
    property SoftwareHouse: String read fSoftwareHouse write fSoftwareHouse;

    property DadosAdicionais1: String read fDadosAdicionais1 write fDadosAdicionais1;
    property DadosAdicionais2: String read fDadosAdicionais2 write fDadosAdicionais2;

    property Moeda: Integer read fModelo write fMoeda default 0; // 0: Real; 1: Dolar; 2: Euro
    property Idioma: Integer read fIdioma write fIdioma default 0; // 0-pt: portugues, 1-en: ingles, 2-es: espanhol
  end;


implementation

uses
  Math,
  ACBrUtil.Strings,
  ACBrTEFPayGoRedes;

{ TACBrTEFRespTXTPayGo }

procedure TACBrTEFRespTXTPayGo.ProcessarTipoInterno(ALinha: TACBrTEFLinha);
var
  ARede: TACBrTEFPayGoRede;
  CodRede: Integer;
begin
  case ALinha.Identificacao of
    707: fpValorOriginal := ALinha.Informacao.AsFloat;
    708: fpSaque := ALinha.Informacao.AsFloat;
    709: fpDesconto := ALinha.Informacao.AsFloat;
    718: fpSerialPOS := ALinha.Informacao.AsString;
    719: fpEstabelecimento := ALinha.Informacao.AsString;
    727: fpTaxaServico := ALinha.Informacao.AsFloat;
    739:
    begin
      // 739-000 içndice da Rede Adquirente
      fpCodigoRedeAutorizada := ALinha.Informacao.AsString;
      fpNFCeSAT.CodCredenciadora := fpCodigoRedeAutorizada;
      CodRede := StrToIntDef(fpCodigoRedeAutorizada, 0);
      if (CodRede > 0) then
      begin
        ARede := TabelaRedes.Find(CodRede);
        if Assigned(ARede) then
        begin
          fpNFCeSAT.Bandeira := ARede.NomeTrad;
          fpNFCeSAT.CNPJCredenciadora := ARede.CNPJ;
          fpNFCeSAT.CodCredenciadora := Format('%3.3d', [ARede.CodSATCFe]);
        end;
      end;
    end;
    740 :
    begin
      // 740-000 - Numero do cartao, mascarado (
      // SetPAN ajusta PAN, BIN (6 primeiros), e Embosso (4 ultimos))
      PAN := ALinha.Informacao.AsString;
    end;
    741 :
    begin
      // 741-000 - Nome do Cliente, extraido do cartao ou informado pelo emissor.
      fpNFCeSAT.DonoCartao := ALinha.Informacao.AsString;
    end;
    742 :
    begin
      // 742-000 - Nome do produto enviado na transacao pela rede adquirente:
      fpModalidadePagto := ALinha.Informacao.AsString;
    end;
    744 :
    begin
      // 744-000 - Valor reajustado pela Rede Adquirente, conforme acordos contratuais com o estabelecimento,
      //           Valor total (003-000) = Valor reajustado (744-000) + Valor do troco (708-000) - Valor do desconto (709-000) - Valor devido (743-000)
      fpValorTotal := ALinha.Informacao.AsFloat;
    end;
    747 :
    begin
      // 747-000 - Data de vencimento do cartao (MMAA)
      fpNFCeSAT.DataExpiracao := ALinha.Informacao.AsString;
    end;
    748 :
    begin
      // 748-000 - Nome do cartao padronizado. Se existir, substitui o 040-000
      fpNomeAdministradora := ALinha.Informacao.AsString;
      fpNFCeSAT.Bandeira := fpNomeAdministradora;
    end;
  else
    inherited ProcessarTipoInterno(ALinha);
  end;
end;

procedure TACBrTEFRespTXTPayGo.ConteudoToProperty;
var
  ViasDeComprovante, TipoDeCartao, TipoDeFinanciamento, StatusConfirmacao, Operacao: String;
  i, TamanhoViaEstabelecimento, TamanhoCupomReduzida, TamanhoViaCliente: Integer;
  ImprimirViaCliente, ImprimirViaEstabelecimento: Boolean;
begin
  inherited ConteudoToProperty;

  // 737-000 Vias de Comprovante
  //   0: nao ha comprovante
  //   1: imprimir somente a via do Cliente
  //   2: imprimir somente a via do Estabelecimento
  //   3: imprimir ambas as vias do Cliente e do Estabelecimento
  ViasDeComprovante := Trim(LeInformacao(737, 0).AsString);
  if (ViasDeComprovante = '') then  //  Nao informado, se basear em 028-000
  begin
    if (fpQtdLinhasComprovante > 0) then // 028-000 È maior que Zero
      ViasDeComprovante := '3'
    else
      ViasDeComprovante := '0';
  end;

  ImprimirViaCliente := (ViasDeComprovante = '1') or (ViasDeComprovante = '3');
  ImprimirViaEstabelecimento := (ViasDeComprovante = '2') or (ViasDeComprovante = '3');

  // Verificando Via do Estabelecimento
  if not ImprimirViaEstabelecimento then
    fpImagemComprovante2aVia.Clear
  else
  begin
    // 714-000 Quantidade de linhas da via diferenciada do comprovante destinada ao Estabelecimento.
    TamanhoViaEstabelecimento := LeInformacao(714, 0).AsInteger;
    if (TamanhoViaEstabelecimento > 0) then
    begin
      fpImagemComprovante2aVia.Clear;
      For i := 1 to TamanhoViaEstabelecimento do
        fpImagemComprovante2aVia.Add( AjustaLinhaImagemComprovante(LeInformacao(715, i).AsString) );
    end;
  end;

  // Verificando Via do Cliente
  if not ImprimirViaCliente then
    fpImagemComprovante1aVia.Clear
  else
  begin
    if ViaClienteReduzida then
    begin
      TamanhoCupomReduzida := LeInformacao(710, 0).AsInteger;  // 710-000 - Quantidade de linhas do cupom reduzido.
      if (TamanhoCupomReduzida > 0) then
      begin
        fpImagemComprovante1aVia.Clear;
        For i := 1 to TamanhoCupomReduzida do
          fpImagemComprovante1aVia.Add( AjustaLinhaImagemComprovante(LeInformacao(711, i).AsString) );
      end
      else
        ViaClienteReduzida := False;
    end;

    if not ViaClienteReduzida then
    begin
      // 712-000 Quantidade de linhas da via diferenciada do comprovante destinada ao Cliente.
      TamanhoViaCliente := LeInformacao(712, 0).AsInteger;
      if (TamanhoViaCliente > 0) then
      begin
        fpImagemComprovante1aVia.Clear;
        For i := 1 to TamanhoViaEstabelecimento do
          fpImagemComprovante1aVia.Add( AjustaLinhaImagemComprovante(LeInformacao(713, i).AsString) );
      end;
    end;
  end;

  fpQtdLinhasComprovante := max(fpImagemComprovante1aVia.Count, fpImagemComprovante2aVia.Count);
  fpNFCeSAT.Autorizacao := fpNSU;

  // 731-000 - Tipo de cartao
  //     0: qualquer / nao definido (padrao)
  //     1: credito
  //     2: debito
  //     3: voucher
  TipoDeCartao := Trim(LeInformacao(731, 0).AsString);
  if (TipoDeCartao <> '') then
  begin
    fpCredito := (TipoDeCartao = '1');
    fpDebito  := (TipoDeCartao = '2');
  end;

  // 732-000 - Tipo de financiamento
  //     0: qualquer / nao definido (padrao)
  //     1: a vista
  //     2: parcelado pelo Emissor
  //     3: parcelado pelo Estabelecimento
  //     4: pre-datado
  //     5: pre-datado forcado
  TipoDeFinanciamento := Trim(LeInformacao(732, 0).AsString);
  if (TipoDeFinanciamento <> '') then
  begin
    if (TipoDeFinanciamento = '1') then
    begin
      fpTipoOperacao := opAvista;
      fpParceladoPor := parcNenhum;
    end
    else if (TipoDeFinanciamento = '2') then
    begin
      fpTipoOperacao := opParcelado;
      fpParceladoPor := parcADM;
    end
    else if (TipoDeFinanciamento = '2') then
    begin
      fpTipoOperacao := opParcelado;
      fpParceladoPor := parcADM;
    end
    else if (TipoDeFinanciamento = '3') then
    begin
      fpTipoOperacao := opParcelado;
      fpParceladoPor := parcLoja;
    end
    else if (TipoDeFinanciamento = '4') or (TipoDeFinanciamento = '5') then
      fpTipoOperacao := opPreDatado;
  end;

  // 729-000 - Status da confirmacao
  //    1: transacao nao requer confirmcao, ou ja confirmada
  //    2: transacao requer confirmacao
  //    Se nao encontrado, assumir que a transacao requer confirmacao se houver comprovantes a serem impressos.
  StatusConfirmacao := Trim(LeInformacao(729,0).AsString);
  if (StatusConfirmacao <> '') then
    fpConfirmar := (StatusConfirmacao = '2');

  // 730-000 - Operacao
  Operacao := Trim(LeInformacao(730,0).AsString);
  if (Operacao <> '') then
    fpTipoTransacao := StrToIntDef(Operacao, fpTipoTransacao);
end;

{ TACBrTEFTXTPayGo }

constructor TACBrTEFTXTPayGo.Create;
begin
  inherited Create;
  fSuportaTroco := True;
  fSuportaDesconto := True;
  fSuportaViasDiferentes := True;
  fSuportaCupomReduzido := True;
  fUsarCupomReduzido := False;
  fSuportaReajusteValor := True;
  fNomeAplicacao := '';
  fVersaoAplicacao := '';
  fRegistroCertificacao := '';
  fSoftwareHouse := '';
  fDadosAdicionais1 := '';
  fDadosAdicionais2 := '';
  fIdioma := 0;
  fMoeda := 0;
end;

destructor TACBrTEFTXTPayGo.Destroy;
begin
  inherited Destroy;
end;

function TACBrTEFTXTPayGo.GetModeloTEF: String;
begin
  Result := CACBRTEFTXT_NomeClientPayGo;
end;

function TACBrTEFTXTPayGo.GetVersaoTEF: String;
begin
  Result := IntToStr(CPayGoVersaoInterface);
end;

procedure TACBrTEFTXTPayGo.PrepararRequisicao(const AHeader: String);
begin
  inherited PrepararRequisicao(AHeader);
  AdicionarCamposConfiguracao;
end;

function TACBrTEFTXTPayGo.CRT(Valor: Double; const DocumentoVinculado: String;
  DataHoraFiscal: TDateTime; TipoCartao: Byte; TipoFinanciamento: Byte;
  FormaPagamento: Byte; TipoPessoa: AnsiChar; DocumentoPessoa: String;
  Parcelas: Byte; DataPreDatado: TDateTime; TaxaServico: Double;
  TaxaEmabarque: Double; Rede: String): Boolean;
begin
  PrepararRequisicao(CACBRTEFTXT_CMD_CRT);
  Req.Campo[3,0].AsFloat := Valor;
  if (DocumentoVinculado <> '') then
    Req.Campo[2,0].AsString := DocumentoVinculado;

  if (DataHoraFiscal > 0) then
    Req.Campo[717,0].AsString := FormatDateTime('YYMMDDHHNNSS', DataHoraFiscal);

  if (TipoCartao > 0) then
    Req.Campo[731,0].AsInteger := TipoCartao;

  if (TipoFinanciamento > 0) then
    Req.Campo[732,0].AsInteger := TipoFinanciamento;

  if (FormaPagamento > 0) then
    Req.Campo[749,0].AsInteger := FormaPagamento;

  if (DocumentoPessoa <> '') then
  begin
    Req.Campo[06,0].AsString := TipoPessoa;
    Req.Campo[07,0].AsString := DocumentoPessoa;
  end;

  if (Parcelas > 0) then
    Req.Campo[18,0].AsInteger := Parcelas;

  if (DataPreDatado > 0) then
    Req.Campo[24,0].AsDate :=DataPreDatado;

  if (TaxaServico > 0) then
    Req.Campo[727,0].AsFloat := TaxaServico;

  if (TaxaEmabarque > 0) then
    Req.Campo[728,0].AsFloat := TaxaEmabarque;

  if (Rede <> '') then
    Req.Campo[10,0].AsString := Rede;

  EnviarRequisicao;
  Result := RespostaTransacaoComSucesso;
end;

function TACBrTEFTXTPayGo.CHQ(Valor: Double; const DocumentoVinculado: String;
  CMC7: String; TipoPessoa: AnsiChar; DocumentoPessoa: String;
  DataCheque: TDateTime; Banco: String; Agencia: String; AgenciaDC: String;
  Conta: String; ContaDC: String; Cheque: String; ChequeDC: String;
  Compensacao: String): Boolean;
begin
  DoException(Format(ACBrStr(CErroComandoNaoExisteEmTEF), ['CHQ', ModeloTEF]));
end;

function TACBrTEFTXTPayGo.CPD(TipoPessoa: Char): String;
begin
  Result := '';
  PrepararRequisicao(CACBRTEFTXT_CMD_CDP);
  Req.Campo[06,0].AsString := TipoPessoa;
  EnviarRequisicao;
  if RespostaTransacaoComSucesso then
    Result := Resp.Campo[7,0].AsString;
end;

function TACBrTEFTXTPayGo.QRP(const ConteudoQRCode: String): Boolean;
begin
  PrepararRequisicao(CACBRTEFTXT_CMD_QRP);
  Req.Campo[764,0].AsString := ConteudoQRCode;
  EnviarRequisicao;
  Result := RespostaTransacaoComSucesso;
end;

function TACBrTEFTXTPayGo.FQR: Boolean;
begin
  PrepararRequisicao(CACBRTEFTXT_CMD_FQR);
  EnviarRequisicao;
  Result := RespostaTransacaoComSucesso;
end;

function TACBrTEFTXTPayGo.MNU(const Titulo: String; Opcoes: TStrings): Integer;
var
  i: Integer;
  item: String;
begin
  Result := -1;
  if (Opcoes.Count < 1) then
    Exit;

  PrepararRequisicao(CACBRTEFTXT_CMD_MNU);
  Req.Campo[760,0].AsString := Titulo;
  Req.Campo[761,0].AsInteger := Opcoes.Count;
  for i := 0 to Opcoes.Count-1 do
    Req.Campo[762,i+1].AsString := Opcoes[i];

  EnviarRequisicao;
  if RespostaTransacaoComSucesso then
  begin
    item := Resp.Campo[763,0].AsString;
    if (item = '') then
      item := Resp.Campo[762,0].AsString;

    Result := Opcoes.IndexOf(item);
    if (Result >= 0) then
      Inc(Result);
  end;
end;

function TACBrTEFTXTPayGo.CalcularCapacidadesAutomacao: Integer;
begin
  Result := 4;   // 4: valor fixo, sempre incluir
  if SuportaTroco then
    Inc(Result, 1);  // 1: funcionalidade de troco (ver campo 708-000)

  if SuportaDesconto then
    Inc(Result, 2);  // 2: funcionalidade de desconto (ver campo 709-000)

  if SuportaViasDiferentes then
  begin
    Inc(Result, 8);  // 8: vias diferenciadas do comprovante para Cliente/Estabelecimento (campos 712-000 a 715-000)
    if UsarCupomReduzido then
      Inc(Result, 16); // 16: cupom reduzido (campos 710-000 e 711-000)
  end;

  if SuportaReajusteValor then
    Inc(Result, 32 +  // 32: funcionalidade de valor devido (ver campo 743-000)
                64);  // 64: funcionalidade de valor reajustado (ver campo 744-000)

  Inc(Result, 128);   // 128: suporta NSU com tamanho de ate 40 caracteres (campos 012-000 e 025-000)
  Inc(Result, 256);   // 256: suporta indice da aplicacao com tamanho de ate 4 caracteres (campo 739-000)
end;

procedure TACBrTEFTXTPayGo.AdicionarCamposConfiguracao;
var
  s, h: String;
begin
  // 733-000 Versao da interface n..3 Valor fixo, identificando a versao deste documento
  // implementada pela Automacao Comercial (somente numeros, por exemplo, 210 para ‚Äúv2.10‚Äù)
  Req.Campo[733,0].AsInteger := CPayGoVersaoInterface;

  if (RegistroCertificacao <> '') then
    Req.Campo[738, 0].AsString := RegistroCertificacao;

  h := UpperCase(Trim(Req.Campo[0,0].AsString));
  if (pos(h, 'ATV,CNF,NCN') > 0) then
    Exit;

  // 706-000 Capacidades da Automacao
  Req.Campo[706,0].AsInteger := CalcularCapacidadesAutomacao;

  if (SoftwareHouse <> '') then
    Req.Campo[716, 0].AsString := SoftwareHouse;


  if (NomeAplicacao  <> '') then
    Req.Campo[735, 0].AsString := NomeAplicacao;

  if (VersaoAplicacao <> '') then
    Req.Campo[736, 0].AsString := VersaoAplicacao;

  if (DadosAdicionais1 <> '') then
    Req.Campo[722, 0].AsString := DadosAdicionais1;

  if (DadosAdicionais2 <> '') then
    Req.Campo[723, 0].AsString := DadosAdicionais2;

  Req.Campo[725, 0].AsString := CACBRTEFTXT_ACBrID;    // Dados adicionais #4

  case fIdioma of
    1: s:= 'en';
    2: s:= 'es';
  else
    s := 'pt';
  end;
  Req.Campo[726, 0].AsString := s;   // Idioma do Cliente

  if (pos(h, 'CRT,ADM,CNC') > 0) then
  begin
    Req.Campo[4, 0].AsInteger := fMoeda;
  end;
end;

end.

