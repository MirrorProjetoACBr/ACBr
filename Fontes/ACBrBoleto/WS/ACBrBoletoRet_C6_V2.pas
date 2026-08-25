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

unit ACBrBoletoRet_C6_V2;

interface

uses
  Classes, SysUtils, ACBrBoleto,ACBrBoletoWS, ACBrBoletoRetorno,
  DateUtils, pcnConversao,ACBrBoletoWS.Rest, ACBrJSON, ACBrUtil.Base,ACBrUtil.FilesIO;

type

{ TRetornoEnvio_C6 }
 TLinhaDigitavelInfo = (TLDNossoNumero,TLDCodigoCarteira,TLDIdentificacaoLayout,TLDCodigoCedente,TLDFatorVencimento, TLDValorDocumento);
 TRetornoEnvio_C6_V2 = class(TRetornoEnvioREST)
 private
   function DateToDateTime(const AValue : String) : TDateTime;
 public
   constructor Create(ABoletoWS: TACBrBoleto); override;
   destructor  Destroy; Override;
   function LinhaDigitavelExplodeInfo(const AValue : string; const ATipoInformacao : TLinhaDigitavelInfo) : string;
   function LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS): Boolean; override;
   function LerListaRetorno: Boolean; override;
   function RetornoEnvio(const AIndex: Integer): Boolean; override;
 end;

implementation

uses
  ACBrBoletoConversao,
  ACBrUtil.Strings;

resourcestring
  C_CANCELADO = 'CANCELLED';
  C_EXPIRADO  = 'EXPIRADO';
  C_VENCIDO   = 'VENCIDO';
  C_EMABERTO  = 'CREATED';
  C_PAGO      = 'PAID';
  C_RECEBIDO          = 'RECEBIDO';
  C_ARECEBER          = 'A_RECEBER';
  C_MARCADO_RECEBIDO  = 'MARCADO_RECEBIDO';
  C_ATRASADO          = 'ATRASADO';

{ TRetornoEnvio }

constructor TRetornoEnvio_C6_V2.Create(ABoletoWS: TACBrBoleto);
begin
  inherited Create(ABoletoWS);
end;

function TRetornoEnvio_C6_V2.DateToDateTime(const AValue: String): TDateTime;
var
  LData, LAno, LMes, LDia:String;
begin
  LAno := Copy( aValue, 0,4 );
  LMes := Copy( aValue, 6,2 );
  LDia := Copy( aValue, 9,2 );
  LData := Format( '%s/%s/%s' , [LDia, LMes, LAno]);
  Result := StrToDateDef(LData , 0);
end;

destructor TRetornoEnvio_C6_V2.Destroy;
begin
  inherited Destroy;
end;

function TRetornoEnvio_C6_V2.LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS): Boolean;
var
  LJsonObject, LJsonBoleto, LJsonPayer, LJsonPaymentMethod,
  LJsonBankSlip, LJsonPix, LJsonFees,
  LJsonListaPaymentsObject: TACBrJSONObject;
  LRejeicaoMensagem: TACBrBoletoRejeicao;
  LJsonArray, LJsonArrayPayments: TACBrJSONArray;
  LTipoOperacao : TOperacao;
  X, I:Integer;
  LSituacao : AnsiString;
  LDataPagamento, LDataCredito: string;
begin
  Result := True;
  LTipoOperacao := ACBrBoleto.Configuracoes.WebService.Operacao;
  ARetornoWS.HTTPResultCode  := HTTPResultCode;
  ARetornoWS.JSONEnvio       := EnvWs;
  ARetornoWS.Header.Operacao := LTipoOperacao;

  if RetWS <> '' then
  begin
    RetWS := UTF8ToNativeString(RetWS);
    LJsonObject := TACBrJSONObject.Parse(RetWS);
    try
      try
        ARetornoWS.JSON := LJsonObject.ToJSON;

        if HttpResultCode >= 400 then
        begin
          if LJsonObject.ValueExists('status') then
          begin
            LRejeicaoMensagem            := ARetornoWS.CriarRejeicaoLista;
            LRejeicaoMensagem.Codigo     := LJsonObject.AsString['status'];
            LRejeicaoMensagem.Versao     := 'Correlation_id:' + LJsonObject.AsString['correlation_id'];
            LRejeicaoMensagem.Mensagem   := LJsonObject.AsString['title'];
            LRejeicaoMensagem.Campo      := LJsonObject.AsString['type'];
            LRejeicaoMensagem.Ocorrencia := LJsonObject.AsString['detail'];
          end;
        end;

        //retorna quando tiver sucesso
        if (ARetornoWS.ListaRejeicao.Count = 0) then
        begin
          if (LTipoOperacao = tpInclui) then
          begin
            LJSonPaymentMethod  := nil;
            LJsonBankSlip       := nil;
            LJsonPix            := nil;
            if LJSonObject.IsJSONObject('payment_method') then
            begin
              LJSonPaymentMethod := LJSonObject.AsJSONObject['payment_method'];

              if LJSonPaymentMethod.IsJSONObject('bank_slip') then
                LJsonBankSlip := LJSonPaymentMethod.AsJSONObject['bank_slip'];

              if LJSonPaymentMethod.IsJSONObject('pix') then
                LJsonPix := LJSonPaymentMethod.AsJSONObject['pix'];
            end;

            ARetornoWS.DadosRet.IDBoleto.IDBoleto       := LJsonObject.AsString['id'];
            ARetornoWS.DadosRet.TituloRet.NossoNumeroCorrespondente := LJsonObject.AsString['external_reference_id'];
            ARetornoWS.DadosRet.TituloRet.Vencimento    := DateToDateTime(LJsonObject.AsString['due_date']);
            ARetornoWS.DadosRet.TituloRet.ValorDocumento  := LJsonObject.AsCurrency['amount'];
            ARetornoWS.DadosRet.TituloRet.ValorAtual      := LJsonObject.AsCurrency['amount'];
            ARetornoWS.DadosRet.TituloRet.Carteira      := LJsonObject.AsString['billing_scheme'];

            if LJsonObject.AsString['billing_type'] = '3' then
              ARetornoWS.DadosRet.TituloRet.ResponsavelPelaEmissao := tbBancoEmite
            else
              ARetornoWS.DadosRet.TituloRet.ResponsavelPelaEmissao := tbCliEmite;

            if Assigned(LJsonBankSlip) then
            begin
              ARetornoWS.DadosRet.IDBoleto.CodBarras      := LJsonBankSlip.AsString['bar_code'];
              ARetornoWS.DadosRet.IDBoleto.LinhaDig       := LJsonBankSlip.AsString['digitable_line'];
              ARetornoWS.DadosRet.IDBoleto.NossoNum       := LJsonBankSlip.AsString['our_number'];

              ARetornoWS.DadosRet.TituloRet.CodBarras     := ARetornoWS.DadosRet.IDBoleto.CodBarras;
              ARetornoWS.DadosRet.TituloRet.LinhaDig      := ARetornoWS.DadosRet.IDBoleto.LinhaDig;
              ARetornoWS.DadosRet.TituloRet.NossoNumero   := ARetornoWS.DadosRet.IDBoleto.NossoNum;
              ARetornoWS.DadosRet.TituloRet.SeuNumero     := LJsonBankSlip.AsString['your_number'];
            end;

            {PIX}
            ARetornoWS.DadosRet.TituloRet.UrlPix          := '';
            if Assigned(LJsonPix) then
            begin
              ARetornoWS.DadosRet.TituloRet.EMV   := LJsonPix.AsString['qr_code'];
              ARetornoWS.DadosRet.TituloRet.TxId  := LJsonPix.AsString['reference'];
            end;
          end
          else if (LTipoOperacao in [tpConsultaDetalhe{,tpAltera. Não tem endpoint para alteração do boleto}]) then
          begin
            LJSonPaymentMethod := nil;
            LJsonBankSlip       := nil;
            LJsonPix            := nil;

            if LJSonObject.IsJSONObject('payment_method') then
            begin
              LJSonPaymentMethod := LJSonObject.AsJSONObject['payment_method'];

              if LJSonPaymentMethod.IsJSONObject('bank_slip') then
                LJsonBankSlip := LJSonPaymentMethod.AsJSONObject['bank_slip'];

              if LJSonPaymentMethod.IsJSONObject('pix') then
                LJsonPix := LJSonPaymentMethod.AsJSONObject['pix'];
            end;

            ARetornoWS.DadosRet.IDBoleto.IDBoleto       := LJsonObject.AsString['id'];
            ARetornoWS.DadosRet.TituloRet.SeuNumero     := LJsonBankSlip.AsString['your_number'];
            ARetornoWS.DadosRet.TituloRet.NossoNumeroCorrespondente := LJsonObject.AsString['external_reference_id'];
            ARetornoWS.DadosRet.TituloRet.Vencimento    := DateToDateTime(LJsonObject.AsString['due_date']);
            ARetornoWS.DadosRet.TituloRet.ValorDocumento  := LJsonObject.AsCurrency['amount'];
            ARetornoWS.DadosRet.TituloRet.ValorAtual      := LJsonObject.AsCurrency['amount'];
            ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca  := LJsonObject.asString['status'];
            ARetornoWS.DadosRet.TituloRet.Carteira      := LJsonObject.AsString['billing_scheme'];

            if LJsonObject.AsString['billing_type'] = '3' then
              ARetornoWS.DadosRet.TituloRet.ResponsavelPelaEmissao := tbBancoEmite
            else
              ARetornoWS.DadosRet.TituloRet.ResponsavelPelaEmissao := tbCliEmite;

            if Assigned(LJsonBankSlip) then
            begin
              ARetornoWS.DadosRet.IDBoleto.CodBarras      := LJsonBankSlip.AsString['bar_code'];
              ARetornoWS.DadosRet.IDBoleto.LinhaDig       := LJsonBankSlip.AsString['digitable_line'];
              ARetornoWS.DadosRet.IDBoleto.NossoNum       := LJsonBankSlip.AsString['our_number'];
              ARetornoWS.DadosRet.TituloRet.CodBarras     := ARetornoWS.DadosRet.IDBoleto.CodBarras;
              ARetornoWS.DadosRet.TituloRet.LinhaDig      := ARetornoWS.DadosRet.IDBoleto.LinhaDig;
              ARetornoWS.DadosRet.TituloRet.NossoNumero   := ARetornoWS.DadosRet.IDBoleto.NossoNum;
            end;

            {PIX}
            ARetornoWS.DadosRet.TituloRet.UrlPix          := '';
            if Assigned(LJsonPix) then
            begin
              ARetornoWS.DadosRet.TituloRet.EMV   := LJsonPix.AsString['qr_code'];
              ARetornoWS.DadosRet.TituloRet.TxId  := LJsonPix.AsString['reference'];
            end;

            {fees}
            if LJSonObject.IsJSONObject('fees') then
            begin
              LJsonFees := LJSonObject.AsJSONObject['fees'];
              {Multa}
              if LJsonFees.ValueExists('fine_type') then
              begin
                if LJsonFees.AsString['fine_type'] = 'PERCENTAGE' then
                begin
                  ARetornoWS.DadosRet.TituloRet.PercentualMulta       := LJsonFees.AsFloat['fine_value'];
                  ARetornoWS.DadosRet.TituloRet.MultaValorFixo        := False;
                  if LJsonFees.ValueExists('fine_deadline') then
                    ARetornoWS.DadosRet.TituloRet.DataMulta           := IncDay(ARetornoWS.DadosRet.TituloRet.Vencimento, LJsonFees.AsInteger['fine_deadline']);
                end
                else if LJsonFees.AsString['fine_type'] = 'FIXED_VALUE' then
                begin
                  ARetornoWS.DadosRet.TituloRet.PercentualMulta       := LJsonFees.AsCurrency['fine_value'];
                  ARetornoWS.DadosRet.TituloRet.MultaValorFixo        := True;
                  ARetornoWS.DadosRet.TituloRet.ValorMulta            := ARetornoWS.DadosRet.TituloRet.PercentualMulta;
                  if LJsonFees.ValueExists('fine_deadline') then
                    ARetornoWS.DadosRet.TituloRet.DataMulta             := IncDay(ARetornoWS.DadosRet.TituloRet.Vencimento, LJsonFees.AsInteger['fine_deadline']);
                end
                else
                begin
                  ARetornoWS.DadosRet.TituloRet.PercentualMulta       := 0;
                  ARetornoWS.DadosRet.TituloRet.ValorMulta            := 0;
                  ARetornoWS.DadosRet.TituloRet.MultaValorFixo        := False;
                end;
              end;
              {Juros}
              if LJsonFees.ValueExists('interest_type') then
              begin
                if LJsonFees.AsString['interest_type'] = 'MONTHLY_PERCENTAGE' then
                begin
                  ARetornoWS.DadosRet.TituloRet.CodigoMoraJuros := cjTaxaMensal;
                  ARetornoWS.DadosRet.TituloRet.ValorMoraJuros  := LJsonFees.AsCurrency['interest_value'];
                  if LJsonFees.ValueExists('interest_deadline') then
                    ARetornoWS.DadosRet.TituloRet.DataMoraJuros   := IncDay(ARetornoWS.DadosRet.TituloRet.Vencimento, LJsonFees.AsInteger['interest_deadline']);
                end
                else if LJsonFees.AsString['interest_type'] = 'VALUE_PER_DAY' then
                begin
                  ARetornoWS.DadosRet.TituloRet.CodigoMoraJuros :=  cjValorDia;
                  ARetornoWS.DadosRet.TituloRet.ValorMoraJuros  := LJsonFees.AsCurrency['interest_value'];
                  if LJsonFees.ValueExists('interest_deadline') then
                    ARetornoWS.DadosRet.TituloRet.DataMoraJuros   := IncDay(ARetornoWS.DadosRet.TituloRet.Vencimento, LJsonFees.AsInteger['interest_deadline']);
                end
                else
                begin
                  ARetornoWS.DadosRet.TituloRet.CodigoMoraJuros :=  cjIsento;
                  ARetornoWS.DadosRet.TituloRet.ValorMoraJuros   := 0;
                end;
              end;
              {Desconto}
              ARetornoWS.DadosRet.TituloRet.CodigoDesconto := cdSemDesconto;
              if LJsonFees.ValueExists('discount_type') then
              begin
                if LJsonFees.AsString['discount_type'] = 'VALUE_PER_DAY' then
                  ARetornoWS.DadosRet.TituloRet.CodigoDesconto := cdValorFixo;
                if LJsonFees.AsString['discount_type'] = 'MONTHLY_PERCENTAGE' then
                  ARetornoWS.DadosRet.TituloRet.CodigoDesconto := cdPercentual;
                ARetornoWS.DadosRet.TituloRet.ValorDesconto  := LJsonFees.AsCurrency['first_discount_value'];
                if LJsonFees.ValueExists('first_discount_deadline') then
                  ARetornoWS.DadosRet.TituloRet.DataDesconto   := IncDay(ARetornoWS.DadosRet.TituloRet.Vencimento, LJsonFees.AsInteger['first_discount_deadline']);
              end;
            end;

            {payer}
            if LJsonObject.IsJSONObject('payer') then
            begin
              LJsonPayer := LJsonObject.AsJSONObject['payer'];

              ARetornoWS.DadosRet.TituloRet.Sacado.NomeSacado     := LJsonPayer.asString['name'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Cidade         := LJsonPayer.AsJSONObject['address'].asString['city'];
              ARetornoWS.DadosRet.TituloRet.Sacado.UF             := LJsonPayer.AsJSONObject['address'].asString['state'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Bairro         := LJsonPayer.AsJSONObject['address'].asString['neighborhood'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Cep            := LJsonPayer.AsJSONObject['address'].asString['zip_code'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Logradouro     := LJsonPayer.AsJSONObject['address'].asString['address'];
              ARetornoWS.DadosRet.TituloRet.Sacado.CNPJCPF        := LJsonPayer.asString['tax_id'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Email          := LJsonPayer.asString['email'];
            end;
          end;
        end;
      except
        Result := False;
      end;
    finally
       LJsonObject.free;
    end;
  end;
end;

function TRetornoEnvio_C6_V2.LinhaDigitavelExplodeInfo(const AValue : string; const ATipoInformacao : TLinhaDigitavelInfo) : string;
var LValue : string;
begin
  LValue := OnlyNumber(AValue);
  case ATipoInformacao of
    TLDCodigoCedente      : Result := Copy(LValue, 5, 5)  + Copy(LValue, 11, 7);
    TLDNossoNumero        : Result := Copy(LValue, 18, 3) + Copy(LValue, 22, 7);
    TLDCodigoCarteira     : Result := Copy(LValue, 29, 2);
    TLDIdentificacaoLayout: Result := Copy(LValue, 31, 1);
    TLDFatorVencimento    : Result := Copy(LValue, 34, 4);
    TLDValorDocumento     : Result := FloatToStr(StrToInt(Copy(LValue, 38, 10)) / 100);
  end;
end;

function TRetornoEnvio_C6_V2.LerListaRetorno: Boolean;
var
  LListaRetorno: TACBrBoletoRetornoWS;
  LJsonObject, LJsonObjectItem,
  LJsonPaymentMethod, LJsonBankSlip, LJsonPix: TACBrJSONObject;
  LMensagemRejeicao: TACBrBoletoRejeicao;
  LJsonArray, LJsonArrayPayments: TACBrJSONArray;
  I, X: Integer;
  LSituacao : AnsiString;
  LDataPagamento, LDataCredito: string;
begin
  Result := True;

  LListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;
  LListaRetorno.HTTPResultCode := HTTPResultCode;
  LListaRetorno.JSONEnvio      := EnvWs;
  if RetWS <> '' then
  begin
    try
      LJsonObject := TACBrJSONObject.Parse(RetWS);
      try
        case HTTPResultCode of
          400, 404 : begin
          if  NaoEstaVazio( LJsonObject.asString['codigo'] ) then
              begin
                LMensagemRejeicao            := LListaRetorno.CriarRejeicaoLista;
                LMensagemRejeicao.Codigo     := LJsonObject.AsString['codigo'];
                LMensagemRejeicao.Versao     := LJsonObject.AsString['parametro'];
                LMensagemRejeicao.Mensagem   := LJsonObject.AsString['mensagem'];
              end;
          end;
        end;

        LListaRetorno.JSON := LJsonObject.ToJSON;

        if (LListaRetorno.ListaRejeicao.Count = 0) then
          begin

          if (LJsonObject.AsInteger['page'] + 1) < LJsonObject.AsInteger['total_pages'] then
          begin
            LListaRetorno.indicadorContinuidade := True;
            X := Trunc(ACBrBoleto.Configuracoes.WebService.Filtro.indiceContinuidade);
            LListaRetorno.proximoIndice := X + 1;
          end
          else
          begin
            LListaRetorno.indicadorContinuidade := False;
            LListaRetorno.proximoIndice := 0;
          end;

          LJsonArray := LJsonObject.AsJSONArray['content'];
          for I := 0 to Pred(LJsonArray.Count) do
          begin
            if I > 0 then
              LListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;

            LJsonObjectItem  := LJsonArray.ItemAsJSONObject[I];

            LJsonPaymentMethod := nil;
            LJsonBankSlip       := nil;
            LJsonPix            := nil;

            if LJsonObjectItem.IsJSONObject('payment_method') then
            begin
              LJsonPaymentMethod := LJsonObjectItem.AsJSONObject['payment_method'];

              if LJsonPaymentMethod.IsJSONObject('bank_slip') then
                LJsonBankSlip := LJsonPaymentMethod.AsJSONObject['bank_slip'];

              if LJsonPaymentMethod.IsJSONObject('pix') then
                LJsonPix := LJsonPaymentMethod.AsJSONObject['pix'];
            end;

            LListaRetorno.DadosRet.IDBoleto.IDBoleto       := LJsonObjectItem.AsString['id'];
            LListaRetorno.DadosRet.TituloRet.NossoNumeroCorrespondente := LJsonObjectItem.AsString['external_reference_id'];
            LListaRetorno.DadosRet.TituloRet.Vencimento    := DateToDateTime(LJsonObjectItem.AsString['due_date']);
            LListaRetorno.DadosRet.TituloRet.DataRegistro  := DateToDateTime(LJsonObjectItem.AsString['created_at']);

            LListaRetorno.DadosRet.TituloRet.ValorDocumento  := LJsonObjectItem.AsCurrency['amount'];
            LListaRetorno.DadosRet.TituloRet.ValorAtual      := LJsonObjectItem.AsCurrency['amount'];
            LListaRetorno.DadosRet.TituloRet.EstadoTituloCobranca  := LJsonObjectItem.asString['status'];

            if Assigned(LJsonBankSlip) then
            begin
              LListaRetorno.DadosRet.TituloRet.SeuNumero     := LJsonBankSlip.AsString['your_number'];
              LListaRetorno.DadosRet.IDBoleto.CodBarras      := LJsonBankSlip.AsString['bar_code'];
              LListaRetorno.DadosRet.IDBoleto.LinhaDig       := LJsonBankSlip.AsString['digitable_line'];
              LListaRetorno.DadosRet.IDBoleto.NossoNum       := LJsonBankSlip.AsString['our_number'];
              LListaRetorno.DadosRet.TituloRet.CodBarras     := LListaRetorno.DadosRet.IDBoleto.CodBarras;
              LListaRetorno.DadosRet.TituloRet.LinhaDig      := LListaRetorno.DadosRet.IDBoleto.LinhaDig;
              LListaRetorno.DadosRet.TituloRet.NossoNumero   := LListaRetorno.DadosRet.IDBoleto.NossoNum;
              LListaRetorno.DadosRet.TituloRet.Carteira      := LJsonBankSlip.AsString['billing_scheme'];

              if LJsonBankSlip.AsString['billing_type'] = '3' then
                LListaRetorno.DadosRet.TituloRet.ResponsavelPelaEmissao := tbBancoEmite
              else
                LListaRetorno.DadosRet.TituloRet.ResponsavelPelaEmissao := tbCliEmite;
            end;

            {PIX}
            LListaRetorno.DadosRet.TituloRet.UrlPix          := '';
            if Assigned(LJsonPix) then
            begin
              LListaRetorno.DadosRet.TituloRet.EMV   := LJsonPix.AsString['qr_code'];
              LListaRetorno.DadosRet.TituloRet.TxId  := LJsonPix.AsString['reference'];
            end;

            LListaRetorno.DadosRet.TituloRet.ValorPago := 0;

            {payer}
            if LJsonObjectItem.IsJSONObject('payer') then
            begin
              LListaRetorno.DadosRet.TituloRet.Sacado.NomeSacado     := LJsonObjectItem.AsJSONObject['payer'].asString['name'];
              LListaRetorno.DadosRet.TituloRet.Sacado.Cidade         := LJsonObjectItem.AsJSONObject['payer'].AsJSONObject['address'].asString['city'];
              LListaRetorno.DadosRet.TituloRet.Sacado.UF             := LJsonObjectItem.AsJSONObject['payer'].AsJSONObject['address'].asString['state'];
              LListaRetorno.DadosRet.TituloRet.Sacado.Bairro         := LJsonObjectItem.AsJSONObject['payer'].AsJSONObject['address'].asString['neighborhood'];
              LListaRetorno.DadosRet.TituloRet.Sacado.Cep            := LJsonObjectItem.AsJSONObject['payer'].AsJSONObject['address'].asString['zip_code'];
              LListaRetorno.DadosRet.TituloRet.Sacado.Logradouro     := LJsonObjectItem.AsJSONObject['payer'].AsJSONObject['address'].asString['address'];
              LListaRetorno.DadosRet.TituloRet.Sacado.CNPJCPF        := LJsonObjectItem.AsJSONObject['payer'].asString['tax_id'];
              LListaRetorno.DadosRet.TituloRet.Sacado.Email          := LJsonObjectItem.AsJSONObject['payer'].asString['email'];
            end;

            {fees}
            if LJsonObjectItem.IsJSONObject('fees') then
            begin
              {Multa}
              if LJsonObjectItem.AsJSONObject['fees'].ValueExists('fine_type') then
              begin
                if LJsonObjectItem.AsJSONObject['fees'].AsString['fine_type'] = 'PERCENTAGE' then
                begin
                  LListaRetorno.DadosRet.TituloRet.PercentualMulta       := LJsonObjectItem.AsJSONObject['fees'].AsFloat['fine_value'];
                  LListaRetorno.DadosRet.TituloRet.MultaValorFixo        := False;
                  if LJsonObjectItem.AsJSONObject['fees'].ValueExists('fine_deadline') then
                    LListaRetorno.DadosRet.TituloRet.DataMulta           := IncDay(LListaRetorno.DadosRet.TituloRet.Vencimento,
                    LJsonObjectItem.AsJSONObject['fees'].AsInteger['fine_deadline']);
                end
                else if LJsonObjectItem.AsJSONObject['fees'].AsString['fine_type'] = 'FIXED_VALUE' then
                begin
                  LListaRetorno.DadosRet.TituloRet.PercentualMulta       := LJsonObjectItem.AsJSONObject['fees'].AsCurrency['fine_value'];
                  LListaRetorno.DadosRet.TituloRet.MultaValorFixo        := True;
                  LListaRetorno.DadosRet.TituloRet.ValorMulta            := LListaRetorno.DadosRet.TituloRet.PercentualMulta;
                  if LJsonObjectItem.AsJSONObject['fees'].ValueExists('fine_deadline') then
                    LListaRetorno.DadosRet.TituloRet.DataMulta             := IncDay(LListaRetorno.DadosRet.TituloRet.Vencimento,
                    LJsonObjectItem.AsJSONObject['fees'].AsInteger['fine_deadline']);
                end
                else
                begin
                  LListaRetorno.DadosRet.TituloRet.PercentualMulta       := 0;
                  LListaRetorno.DadosRet.TituloRet.ValorMulta            := 0;
                  LListaRetorno.DadosRet.TituloRet.MultaValorFixo        := False;
                end;
              end;
              {Juros}
              if LJsonObjectItem.AsJSONObject['fees'].ValueExists('interest_type') then
              begin
                if LJsonObjectItem.AsJSONObject['fees'].AsString['interest_type'] = 'MONTHLY_PERCENTAGE' then
                begin
                  LListaRetorno.DadosRet.TituloRet.CodigoMoraJuros := cjTaxaMensal;
                  LListaRetorno.DadosRet.TituloRet.ValorMoraJuros  := LJsonObjectItem.AsJSONObject['fees'].AsCurrency['interest_value'];
                  if LJsonObjectItem.AsJSONObject['fees'].ValueExists('interest_deadline') then
                    LListaRetorno.DadosRet.TituloRet.DataMoraJuros   := IncDay(LListaRetorno.DadosRet.TituloRet.Vencimento,
                    LJsonObjectItem.AsJSONObject['fees'].AsInteger['interest_deadline']);
                end
                else if LJsonObjectItem.AsJSONObject['fees'].AsString['interest_type'] = 'VALUE_PER_DAY' then
                begin
                  LListaRetorno.DadosRet.TituloRet.CodigoMoraJuros :=  cjValorDia;
                  LListaRetorno.DadosRet.TituloRet.ValorMoraJuros  := LJsonObjectItem.AsJSONObject['fees'].AsCurrency['interest_value'];
                  if LJsonObjectItem.AsJSONObject['fees'].ValueExists('interest_deadline') then
                    LListaRetorno.DadosRet.TituloRet.DataMoraJuros   := IncDay(LListaRetorno.DadosRet.TituloRet.Vencimento,
                    LJsonObjectItem.AsJSONObject['fees'].AsInteger['interest_deadline']);
                end
                else
                begin
                  LListaRetorno.DadosRet.TituloRet.CodigoMoraJuros :=  cjIsento;
                  LListaRetorno.DadosRet.TituloRet.ValorMoraJuros   := 0;
                end;
              end;
              {Desconto}
              LListaRetorno.DadosRet.TituloRet.CodigoDesconto := cdSemDesconto;
              if LJsonObjectItem.AsJSONObject['fees'].ValueExists('discount_type') then
              begin
                if LJsonObjectItem.AsJSONObject['fees'].AsString['discount_type'] = 'VALUE_PER_DAY' then
                  LListaRetorno.DadosRet.TituloRet.CodigoDesconto := cdValorFixo;
                if LJsonObjectItem.AsJSONObject['fees'].AsString['discount_type'] = 'MONTHLY_PERCENTAGE' then
                  LListaRetorno.DadosRet.TituloRet.CodigoDesconto := cdPercentual;
                LListaRetorno.DadosRet.TituloRet.ValorDesconto  := LJsonObjectItem.AsJSONObject['fees'].AsCurrency['first_discount_value'];
                if LJsonObjectItem.AsJSONObject['fees'].ValueExists('first_discount_deadline') then
                  LListaRetorno.DadosRet.TituloRet.DataDesconto   := IncDay(LListaRetorno.DadosRet.TituloRet.Vencimento,
                  LJsonObjectItem.AsJSONObject['fees'].AsInteger['first_discount_deadline']);
              end;
            end;

            if LJsonObjectItem.AsString['status'] = C_PAGO then
            begin
              if LJsonObjectItem.isJSONArray('payments') then
              begin
                LJsonArrayPayments := LJsonObjectItem.AsJSONArray['payments'];
                if LJsonArrayPayments.Count > 0 then
                begin//Pega apenas o primeiro resultado
                  LDataPagamento :=  LJsonArrayPayments.ItemAsJSONObject[0].AsString['payment_date'];
                  if LDataPagamento = '' then
                    LDataPagamento :=  LJsonArrayPayments.ItemAsJSONObject[0].AsString['date'];
                  LDataCredito :=  LJsonArrayPayments.ItemAsJSONObject[0].AsString['credit_date'];
                  if LDataCredito = '' then
                    LDataCredito := LDataPagamento;

                  LListaRetorno.DadosRet.TituloRet.DataCredito     := DateToDateTime(LDataCredito);
                  LListaRetorno.DadosRet.TituloRet.DataBaixa       := DateToDateTime(LDataPagamento);
                  LListaRetorno.DadosRet.TituloRet.DataMovimento   := DateToDateTime(LDataPagamento);
                  LListaRetorno.DadosRet.TituloRet.ValorPago       := LJsonArrayPayments.ItemAsJSONObject[0].AsCurrency['amount'];
                  LListaRetorno.DadosRet.TituloRet.ValorRecebido   := LJsonArrayPayments.ItemAsJSONObject[0].AsCurrency['amount'];
                end;
              end
              else
              begin
                LListaRetorno.DadosRet.TituloRet.ValorPago       := 0;
                LListaRetorno.DadosRet.TituloRet.ValorRecebido   := 0;
              end;
            end;
          end;
        end;
      finally
        LJsonObject.free;
      end;
    except
      Result := False;
    end;
  end;
end;

function TRetornoEnvio_C6_V2.RetornoEnvio(const AIndex: Integer): Boolean;
begin
  Result := inherited RetornoEnvio(AIndex);
end;

end.

