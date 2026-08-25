{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  Victor Hugo Gonzales - Panda                   }
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
unit ACBrBoletoW_C6_V2;

interface

uses
  Classes, SysUtils, ACBrBoletoWS, pcnConversao, ACBrBoletoConversao,
  synacode, strutils, DateUtils, ACBrDFeSSL, synautil, ACBrBoleto, httpsend, Math,
  ACBrBoletoWS.Rest, ACBrJSON;

type

  { TBoletoW_C6_V2 }
  TBoletoW_C6_V2 = class(TBoletoWSREST)
  private
    function DatetoDateTime(const AValue: String): TDateTime;
    function DateTimeToDate( const AValue:TDateTime ):String;
    function ValidarExternalReferenceId(const AValue: string): Boolean;
    function ValidaSeuNossoNumero(const ANumero: string): Boolean;
  protected
    procedure DefinirURL; override;
    procedure DefinirContentType; override;
    procedure GerarHeader; override;
    procedure GerarDados; override;
    procedure DefinirAuthorization; override;
    function GerarTokenAutenticacao: string; override;
    function DefinirParametros: String;
    procedure DefinirParamOAuth; override;
    procedure DefinirKeyUser;
    procedure RequisicaoJson;
    procedure RequisicaoAltera;
  public
    constructor Create(ABoletoWS: TBoletoWS); override;

    function GerarRemessa: string; override;
    function Enviar: boolean; override;
  end;

const
  C_URL               = 'https://baas-api.c6bank.info/v2/bank_slips';
  C_URL_HOM           = 'https://baas-api-sandbox.c6bank.info/v2/bank_slips';

  C_URL_OAUTH_PROD    = 'https://baas-api.c6bank.info/v1/auth';
  C_URL_OAUTH_HOM     = 'https://baas-api-sandbox.c6bank.info/v1/auth';

  C_CONTENT_TYPE      = 'application/json';
  C_ACCEPT            = 'application/json';
  C_AUTHORIZATION     = 'Authorization';

  C_ACCEPT_ENCODING   = 'gzip, deflate, br';

  C_CHARSET           = 'utf-8';
  C_ACCEPT_CHARSET    = 'utf-8';


implementation

uses
  ACBrUtil.FilesIO,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.Base,
  ACBrUtil.Math,
  ACBrValidador;

{ TBoletoW_C6_V2 }

procedure TBoletoW_C6_V2.DefinirURL;
var
  LNossoNumeroCorrespondente: string;
begin
  if Assigned(Atitulo) then
    LNossoNumeroCorrespondente := ATitulo.NossoNumeroCorrespondente;

  case Boleto.Configuracoes.WebService.Ambiente of
    tawsProducao    : FPURL.URLProducao    := C_URL;
    tawsHomologacao : FPURL.URLHomologacao := C_URL_HOM;
  end;

  case Boleto.Configuracoes.WebService.Operacao of
    tpInclui           :    FPURL.SetPathURI( '/' );
    tpAltera           :    FPURL.SetPathURI( '/' + LNossoNumeroCorrespondente );
    tpConsulta         :    FPURL.SetPathURI( DefinirParametros);
    tpConsultaDetalhe  :    FPURL.SetPathURI( '/' + LNossoNumeroCorrespondente );
    tpCancelar,
    tpBaixa            :    FPURL.SetPathURI( '/' + LNossoNumeroCorrespondente + '/cancel' );
  end;
end;

procedure TBoletoW_C6_V2.DefinirContentType;
begin
  FPContentType := C_CONTENT_TYPE;
end;

procedure TBoletoW_C6_V2.GerarHeader;
begin
  ClearHeaderParams;
  DefinirContentType;
  DefinirKeyUser;
  AddHeaderParam('partner-software-name', 'ProjetoACBr');
end;

procedure TBoletoW_C6_V2.GerarDados;
begin
  if Assigned(Boleto) then
    DefinirURL;

  case Boleto.Configuracoes.WebService.Operacao of
    tpInclui:
      begin
        FMetodoHTTP := htPOST; // Define Método POST para Incluir
        RequisicaoJson;
      end;
    tpAltera:
      begin
        FMetodoHTTP := htPUT; // Define Método PUT para Baixa
        RequisicaoAltera;
      end;
    tpConsulta,
    tpConsultaDetalhe:
      begin
        FMetodoHTTP := htGET; // Define Método GET Consulta Detalhe
        FPAccept    := '*/*';
        // Sem Payload
      end;
    tpBaixa, tpCancelar:
      begin
        FMetodoHTTP := htPUT; // Define Método PUT para Baixa
        // Sem Payload
      end;
  else
    raise EACBrBoletoWSException.Create
      (ClassName + Format(S_OPERACAO_NAO_IMPLEMENTADO,
      [TipoOperacaoToStr(Boleto.Configuracoes.WebService.Operacao)]));
  end;

end;

procedure TBoletoW_C6_V2.DefinirAuthorization;
begin
  FPAuthorization := C_AUTHORIZATION + ': Bearer ' + GerarTokenAutenticacao;
end;

function TBoletoW_C6_V2.GerarTokenAutenticacao: string;
begin
  OAuth.Payload := True;
  Result := inherited GerarTokenAutenticacao;
end;

procedure TBoletoW_C6_V2.DefinirKeyUser;
begin
  if Assigned(aTitulo) then
    FPKeyUser := '';
end;

function TBoletoW_C6_V2.DefinirParametros: String;
var
  LConsulta: TStringList;
  LDataInicio, LDataFinal : string;
begin
  Result := '';
  if Assigned(Boleto.Configuracoes.WebService.Filtro) then
  begin
    LConsulta := TStringList.Create;
    try
      LConsulta.Delimiter := '&';
      case Boleto.Configuracoes.WebService.Filtro.indicadorSituacao of
        isbBaixado:
        begin
          if (Boleto.Configuracoes.WebService.Filtro.dataMovimento.DataInicio = 0) or (Boleto.Configuracoes.WebService.Filtro.dataMovimento.DataFinal = 0) then
            raise Exception.Create(ACBrStr('Para consultas isbBaixado, utilizar os filtros: '+LineBreak+
                           'dataMovimento DataInicio'+LineBreak+'dataMovimento DataFinal'));

          LDataInicio := FormatDateBr(Boleto.Configuracoes.WebService.Filtro.dataMovimento.DataInicio, 'YYYY-MM-DD');
          LDataFinal := FormatDateBr(Boleto.Configuracoes.WebService.Filtro.dataMovimento.DataFinal, 'YYYY-MM-DD');
          LConsulta.Add('?payment_date_from=' + LDataInicio);
          LConsulta.Add('payment_date_to=' + LDataFinal);
          LConsulta.Add('status=PAID');
        end;
        isbCancelado:
        begin
          if (Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataInicio = 0) or (Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataFinal = 0) then
            raise Exception.Create(ACBrStr('Para consultas isbCancelado, utilizar os filtros: '+LineBreak+
                           'dataVencimento DataInicio'+LineBreak+'dataVencimento DataFinal'));

          LDataInicio := FormatDateBr(Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataInicio, 'YYYY-MM-DD');
          LDataFinal := FormatDateBr(Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataFinal, 'YYYY-MM-DD');
          LConsulta.Add('?due_date_from=' + LDataInicio);
          LConsulta.Add('due_date_to=' + LDataFinal);
          LConsulta.Add('status=CANCELED');
        end;
        isbAberto:
        begin
          if (Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataInicio = 0) or (Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataFinal = 0) then
            raise Exception.Create(ACBrStr('Para consultas isbAberto, utilizar os filtros: '+LineBreak+
                           'dataVencimento DataInicio'+LineBreak+'dataVencimento DataFinal'));

          LDataInicio := FormatDateBr(Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataInicio, 'YYYY-MM-DD');
          LDataFinal := FormatDateBr(Boleto.Configuracoes.WebService.Filtro.dataVencimento.DataFinal, 'YYYY-MM-DD');
          LConsulta.Add('?due_date_from=' + LDataInicio);
          LConsulta.Add('due_date_to=' + LDataFinal);
          LConsulta.Add('status=CREATED');
        end;
        isbNenhum:
        begin
          raise Exception.Create('Consulta isbNenhum não implementada.');
        end;
      end;
      if Assigned(Atitulo) then
      begin
        if  NaoEstaVazio(Trim(ATitulo.NossoNumeroCorrespondente)) then
        begin
          if not ValidarExternalReferenceId(ATitulo.NossoNumeroCorrespondente) then
              raise Exception.Create('Campo NossoNumeroCorrespondente (external_reference_id) inválido! ' +
      '                     Deve conter exatamente 26 caracteres, apenas letras maiusculas (A-Z) e números (0-9).');
          LConsulta.Add('external_reference_id=' + ATitulo.NossoNumeroCorrespondente);
        end;
      end;
      LConsulta.Add('page=' + IntToStr(Trunc(Boleto.Configuracoes.WebService.Filtro.indiceContinuidade)));
      LConsulta.Add('size=20');//Padrão: 20, Minimo: 1, Máximo: 100
      Result := LConsulta.DelimitedText;
    finally
      LConsulta.Free;
    end;
  end;
end;

procedure TBoletoW_C6_V2.DefinirParamOAuth;
begin
  FParamsOAuth := Format( 'client_id=%s&client_secret=%s&grant_type=client_credentials',
                   [Boleto.Cedente.CedenteWS.ClientID,
                    Boleto.Cedente.CedenteWS.ClientSecret] );
end;

function TBoletoW_C6_V2.DatetoDateTime(const AValue: String): TDateTime;
begin
  Result := StrToDateDef( StringReplace( AValue,'.','/', [rfReplaceAll] ),0);
end;

function TBoletoW_C6_V2.DateTimeToDate(const AValue: TDateTime): String;
begin
  result := FormatDateBr( aValue, 'YYYY-MM-DD');
end;

procedure TBoletoW_C6_V2.RequisicaoJson;
var
  LPayer, LJson, LFees, LDesconto, LBankSlip: TACBrJSONObject;
  LMensagem: TACBrJSONArray;
  I, LCarteira: Integer;
  LValorMoraJuros : Double;
  LCNPJCPFPayer, LEmailPayer,
  LNumeroLogradouro : string;
begin
  if Assigned(ATitulo) then
  begin

    if ATitulo.NossoNumero = '' then
      ATitulo.NossoNumero := '0';

    LCarteira := StrToIntDef(ATitulo.Carteira,0);

    if LCarteira in[15,21] then
    begin
      if not ((ATitulo.NossoNumero = '0') or
              (ATitulo.NossoNumero = Poem_Zeros('',Boleto.Banco.TamanhoMaximoNossoNum)) ) then
        raise Exception.Create('Campo NossoNumero é inválido obrigatóriamente deve ser informado valor 0!');
    end;

    if not LCarteira in[15,16,21] then
      raise Exception.Create('Campo Carteira é inválido obrigatóriamente deve ser informado valor 15, 16 ou 21. Não previsto outra carteira na API!');

    case StrToIntDef(ATitulo.Carteira,0) of
      15,21 : ATitulo.ACBrBoleto.Cedente.ResponEmissao := tbBancoEmite;
      16    : ATitulo.ACBrBoleto.Cedente.ResponEmissao := tbCliEmite;
    end;

    LCNPJCPFPayer := OnlyCPFCNPJAlphaNum(ATitulo.Sacado.CNPJCPF);
    case Length(LCNPJCPFPayer) of
      11 : if ValidarCPF(LCNPJCPFPayer) <> '' then
             raise Exception.Create('Campo CNPJCPF (CPF) do Pagador é inválido!');
      14 : if ValidarCNPJ(LCNPJCPFPayer) <> '' then
             raise Exception.Create('Campo CNPJCPF (CNPJ) do Pagador é inválido!');
    end;

    LEmailPayer := Trim(Copy(ATitulo.Sacado.Email, 1, 70));
    if (LEmailPayer <> '') and (ValidarEmail(LEmailPayer) <> '') then
      raise Exception.Create('Campo Email do Pagador é inválido !');

    LJson := TACBrJSONObject.Create
      .AddPair('amount', ATitulo.ValorDocumento)
      .AddPair('due_date', DateTimeToDate(ATitulo.Vencimento))
      .AddPair('description', Copy(ATitulo.Detalhamento.Text, 1, 100))
      .AddPair('days_after_due_date', IfThen(ATitulo.DataLimitePagto > 0, Trunc(ATitulo.DataLimitePagto - ATitulo.Vencimento), 0));

    if NaoEstaVazio(ATitulo.NossoNumeroCorrespondente) then
      LJson.AddPair('external_reference_id', ATitulo.NossoNumeroCorrespondente);

    LNumeroLogradouro := '';
    if (StrToInt64Def(ATitulo.Sacado.Numero, 0) <> 0) then
      LNumeroLogradouro := ', '+ ATitulo.Sacado.Numero;

    try
      LPayer := TACBrJSONObject.Create
         .AddPair('name', Copy(Trim(ATitulo.Sacado.NomeSacado), 1, 40))
         .AddPair('tax_id', LCNPJCPFPayer)
         .AddPair('address',
         TACBrJSONObject.Create
            .AddPair('city', Copy(Trim(ATitulo.Sacado.Cidade), 1, 40))
            .AddPair('state', AnsiUpperCase(Trim(ATitulo.Sacado.UF)))
            .AddPair('address', Copy(Trim(ATitulo.Sacado.Logradouro) + LNumeroLogradouro, 1, 40))
            .AddPair('zip_code', Copy(OnlyNumber(ATitulo.Sacado.CEP), 1, 8))
            .AddPair('neighborhood', Copy(Trim(ATitulo.Sacado.Bairro), 1, 40))
         );
      if LEmailPayer <> '' then
         LPayer.AddPair('email', LEmailPayer);//Máximo de 70 caracteres. Não usar Copy, deixar retornar rejeição caso atinja o limite
      LJson.AddPair('payer', LPayer);

      LBankSlip := TACBrJSONObject.Create
        .AddPair('billing_scheme', ATitulo.Carteira);

      if StrToInt64Def(ATitulo.NossoNumero,0) > 0 then
      begin
        if not ValidaSeuNossoNumero(ATitulo.NossoNumero) then
          raise Exception.Create('Campo NossoNumero é Numérico,Minimo 1 e máximo 10 posições !');

        LBankSlip.AddPair('our_number', ATitulo.NossoNumero);
      end;

      if NaoEstaVazio(ATitulo.SeuNumero) then
      begin
        if not ValidaSeuNossoNumero(ATitulo.SeuNumero) then
          raise Exception.Create('Campo SeuNumero é Numérico,Minimo 1 e máximo 10 posições !');
        LBankSlip.AddPair('your_number', ATitulo.SeuNumero);
      end;

      if (Trim(ATitulo.Mensagem.Text) <> '') then
      begin
        LMensagem := TACBrJSONArray.Create;

        for I := 0 to 3 do
        begin
          if I > Pred(ATitulo.Mensagem.Count) then
            Break;

          LMensagem.AddElement(Trim(Copy(ATitulo.Mensagem[I], 1, 80)));
        end;

        LBankSlip.AddPair('instructions', LMensagem);
      end;

      LJson.AddPair('payment_method',
          TACBrJSONObject.Create
            .AddPair('bank_slip', LBankSlip)
        );

      if (Boleto.Cedente.CedenteWS.IndicadorPix) and NaoEstaVazio(Boleto.Cedente.PIX.Chave) then
        LJson.AsJSONObject['payment_method']
          .AddPair('pix',
            TACBrJSONObject.Create
              .AddPair('key', Boleto.Cedente.PIX.Chave)// Aceita apenas chave do tipo aleatória. Mesmo enviando chave inválida, é criado o título, mas sem o pix
              .AddPair('type', 'EVP')//Atualmente só é suportado EVP
           );

      LFees:= nil;//Se não tiver multa, juros ou desconto, não envia o grupo fees
      if (ATitulo.PercentualMulta > 0) then
      begin
        if not Assigned(LFees) then
          LFees := TACBrJSONObject.Create;

        LFees.AddPair('fine_type', IfThen(ATitulo.MultaValorFixo, 'FIXED_VALUE', 'PERCENTAGE'));
        LFees.AddPair('fine_value', ATitulo.PercentualMulta);
        LFees.AddPair('fine_deadline', IfThen(ATitulo.DataMulta > ATitulo.Vencimento, DaysBetween(ATitulo.Vencimento, ATitulo.DataMulta), 1));
      end;

      if (ATitulo.ValorMoraJuros > 0) then
      begin
        //LValorMoraJuros := ATitulo.ValorMoraJuros;
        //Valor ou percentual dos juros por atraso.
        //Se o tipo for "V", esse valor será fixo por dia.
        //Se for "P", o valor é um percentual do título, e será dividido por 30 para calcular o valor diário.
        //(quem faz a divisão é a API, o valor enviado é integral)
        case ATitulo.CodigoMoraJuros of
          cjValorDia    : LValorMoraJuros := ATitulo.ValorMoraJuros;
          cjValorMensal : LValorMoraJuros := ATitulo.ValorMoraJuros / 30;
          cjTaxaDiaria  : LValorMoraJuros := RoundABNT(ATitulo.ValorMoraJuros * 30,2);
          cjTaxaMensal  : LValorMoraJuros := ATitulo.ValorMoraJuros;
          else
            LValorMoraJuros := 0;
        end;

        if not Assigned(LFees) then
          LFees := TACBrJSONObject.Create;

        LFees.AddPair('interest_type', IfThen(ATitulo.CodigoMoraJuros in [cjValorDia, cjValorMensal], 'VALUE_PER_DAY', 'MONTHLY_PERCENTAGE'));
        LFees.AddPair('interest_value', LValorMoraJuros );
        LFees.AddPair('interest_deadline', IfThen(ATitulo.DataMoraJuros > ATitulo.Vencimento, DaysBetween(ATitulo.Vencimento, ATitulo.DataMoraJuros), 1));
      end;

      if (ATitulo.ValorDesconto > 0) then
      begin
        if not Assigned(LFees) then
          LFees := TACBrJSONObject.Create;

        LFees.AddPair('discount_type', IfThen(ATitulo.CodigoDesconto = cdValorFixo, 'VALUE_PER_DAY', 'MONTHLY_PERCENTAGE'));
        LFees.AddPair('first_discount_value', ATitulo.ValorDesconto);
        LFees.AddPair('first_discount_deadline', IfThen(ATitulo.DataDesconto > 0, DaysBetween(ATitulo.Vencimento, ATitulo.DataDesconto), 0));
      end;

      if Assigned(LFees) then
        LJson.AddPair('fees', LFees);

      FPDadosMsg := LJson.ToJSON;
    finally
      LJson.Free;
    end;
  end;
end;

procedure TBoletoW_C6_V2.RequisicaoAltera;
begin
  raise Exception.Create('Não há endpoints disponíveis para alteração na v2, apenas geração, consulta/listagem, pdf e cancelamento');
end;

constructor TBoletoW_C6_V2.Create(ABoletoWS: TBoletoWS);
begin
  inherited Create(ABoletoWS);

  FPAccept := C_ACCEPT;

  if Assigned(OAuth) then
  begin
    case OAuth.Ambiente of
      tawsProducao    : OAuth.URL.URLProducao    := C_URL_OAUTH_PROD;
      tawsHomologacao : OAuth.URL.URLHomologacao := C_URL_OAUTH_HOM;
    end;

    OAuth.Payload := True;
  end;
end;

function TBoletoW_C6_V2.GerarRemessa: string;
begin
  DefinirCertificado;
  result := inherited GerarRemessa;
end;

function TBoletoW_C6_V2.Enviar: boolean;
var
  LJsonObject : TACBrJSONObject;
begin
  DefinirCertificado;
  Result := inherited Enviar;
end;

function TBoletoW_C6_V2.ValidarExternalReferenceId(const AValue: string): Boolean;
var
  I: Integer;
begin
  Result := (Length(AValue) = 26);

  if Result then
    for I := 1 to Length(AValue) do
    begin
      if not (AValue[I] in ['A'..'Z', '0'..'9']) then
      begin
        Result := False;
        Break;
      end;
    end;
end;

function TBoletoW_C6_V2.ValidaSeuNossoNumero(const ANumero: string): Boolean;
begin
  Result := (Length(ANumero) >= 1) and
    (Length(ANumero) <= 10) and
    (ANumero = OnlyNumber(ANumero));
end;

end.

