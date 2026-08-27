{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
{ Colaboradores nesse arquivo:  Willian Delan                                  }
{ Delmar de Lima, Jhonlenon Ribeiro                                            }
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
//incluido em COLOCAR A DATA

{$I ACBr.inc}

unit ACBrBoletoRet_Bradesco;

interface

uses
  Classes,
  SysUtils,
  DateUtils,
  StrUtils,


  ACBrBoleto,
  ACBrBoletoWS,
  ACBrBoletoRetorno,
  ACBrBoletoWS.Rest,
  pcnConversao ;

type

{ TRetornoEnvio_Sicoob_API }

 TRetornoEnvio_Bradesco = class(TRetornoEnvioREST)
 private
   function DateBradescoToDateTime(Const AValue : String) : TDateTime;
   function CodigoBaixaToDescricao(Const AValue : Integer): string;
   function CodigoStatusTituloToDescricao(Const AValue : Integer): string;
   function ValorInteiroParaDouble(Const AValue : integer) : Real;
   function CodigoFormaDeCreditoToDescricao(Const AValue : Integer): string;
 public
   constructor Create(ABoletoWS: TACBrBoleto); override;
   destructor  Destroy; Override;
   function LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS): Boolean; override;
   function LerListaRetorno: Boolean; override;
   function RetornoEnvio(const AIndex: Integer): Boolean; override;
 end;

implementation

uses
  ACBrBoletoConversao,
  ACBrUtil.Strings,
  ACBrUtil.Base,
  ACBrJSON;

resourcestring
  C_CANCELADO = 'CANCELADO';
  C_BAIXADO   = 'BAIXADO';
  C_EXPIRADO  = 'EXPIRADO';
  C_VENCIDO   = 'VENCIDO';
  C_EMABERTO  = 'EM ABERTO';
  C_PAGO      = 'Liquidado';

{ TRetornoEnvio }

constructor TRetornoEnvio_Bradesco.Create(ABoletoWS: TACBrBoleto);
begin
  inherited Create(ABoletoWS);
end;

function TRetornoEnvio_Bradesco.DateBradescoToDateTime(const AValue: String): TDateTime;
var
  LData, LAno, LMes, LDia : String;
begin
  if ACBrBoleto.Configuracoes.WebService.UseCertificateHTTP then
  begin //portal developers
    LData := OnlyNumber(AValue); 
    if Length(LData)<8 then       //a dt de pagto vem com erro, vem 6042026 em vez de 06042026
      LData := Poem_Zeros(LData,8);
    LAno := Copy(LData, Length(LData) - 3, 4); //ano sempre 4 ultimos digitos
    LMes := Copy(LData, Length(LData) - 5, 2); //mes 2 digitos antes do ano
    LDia := Copy(LData, 1, Length(LData) - 6); //dia = resto (trata dia sem zero a esquerda ex 5062026)
    LData := Format('%s/%s/%s', [LDia, LMes, LAno]);
  end else
  begin //legado
    LAno := Copy(AValue, 0, 4);
    LMes := Copy(AValue, 6, 2);
    LDia := Copy(AValue, 9, 2);
    LData := Format('%s/%s/%s', [LDia, LMes, LAno]);
  end;
  Result := StrToDateDef(LData, 0);
end;

destructor TRetornoEnvio_Bradesco.Destroy;
begin
  inherited Destroy;
end;

function TRetornoEnvio_Bradesco.LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS): Boolean;
var
  LJsonObject: TACBrJSONObject;
  LMensagemRejeicao: TACBrBoletoRejeicao;
  LJsonViolacao, LjsonDetalhe, LjsonTitulo, LjsonTituloCedente, LJsonTitulosBaixa, LjsonTituloSacado:TACBrJSONObject;
  LJsonViolacoes, LJsonDetalhes: TACBrJSONArray;
  LTipoOperacao : TOperacao;
  i :Integer;
  LcodStatus: Integer;
  LdtPagto, LdtBaixa: Integer;
  LvalorPago : Double;
begin
  Result := True;
  LTipoOperacao := ACBrBoleto.Configuracoes.WebService.Operacao;
  ARetornoWs.JSONEnvio      := EnvWs;
  ARetornoWS.HTTPResultCode := HTTPResultCode;
  LCodStatus := 0;
  LdtPagto := 0;
  LdtBaixa := 0;
  LvalorPago := 0;

  // Quando na consulta nao devolver o nosso numero, pegar do titulo.
  If Assigned(ACBrTitulo) then
     ARetornoWS.DadosRet.TituloRet.NossoNumero := ACBrTitulo.NossoNumero;

  if RetWS <> '' then
  begin
    try
      LJsonObject := TACBrJSONObject.Parse(RetWS);
      try
        ARetornoWS.JSON           := LJsonObject.ToJSON;
        case HttpResultCode of
          404:
          begin
            LMensagemRejeicao            := ARetornoWS.CriarRejeicaoLista;
            LMensagemRejeicao.Codigo     := LJsonObject.AsString['codMensagem'];
            LMensagemRejeicao.mensagem   := LJsonObject.AsString['mensagem'];
          end;
          207, 400, 406, 500:
          begin
            LJsonViolacoes := LJsonObject.AsJSONArray['details'];
            if LJsonViolacoes.Count > 0 then
            begin
               for i := 0 to Pred(LJsonViolacoes.Count) do
               begin
                 LJsonViolacao        := LJsonViolacoes.ItemAsJSONObject[i];
                 LMensagemRejeicao            := ARetornoWS.CriarRejeicaoLista;

                 LMensagemRejeicao.Codigo     := LJsonViolacao.AsString['name'];
                 LMensagemRejeicao.mensagem   := LJsonViolacao.AsString['value'];
               end;
            end
            else
            begin
               LMensagemRejeicao            := ARetornoWS.CriarRejeicaoLista;

               LMensagemRejeicao.Codigo     := LJsonObject.AsString['code'];
               LMensagemRejeicao.mensagem   := LJsonObject.AsString['message'];
            end;
          end;
        end;
        //retorna quando tiver sucesso
        if (ARetornoWS.ListaRejeicao.Count = 0) then
        begin
          if (LTipoOperacao = tpInclui) then
          begin
            ARetornoWS.DadosRet.TituloRet.NossoNumero                 := LJsonObject.AsString['ctitloCobrCdent'];
            ARetornoWS.DadosRet.TituloRet.CodBarras                   := ConverterEBCDICToCodigoBarras(LJsonObject.AsString['codBarras10']);
            ARetornoWS.DadosRet.TituloRet.LinhaDig                    := OnlyNumber(LJsonObject.AsString['linhaDig10']);
            ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca        := LJsonObject.AsString['codStatus10'];//Ex. A Vencer/Vencido
            ARetornoWS.DadosRet.TituloRet.CodigoEstadoTituloCobranca  := LJsonObject.AsString['codStatus10'];//Ex 01.
            ARetornoWS.DadosRet.TituloRet.SeuNumero                   := LJsonObject.AsString['snumero10'];
            ARetornoWS.DadosRet.TituloRet.DataRegistro                := DateBradescoToDateTime(LJsonObject.AsString['dataReg10']);
            ARetornoWS.DadosRet.TituloRet.DataProcessamento           := DateBradescoToDateTime(LJsonObject.AsString['dataImpressao10']);
            ARetornoWS.DadosRet.TituloRet.DataDocumento               := DateBradescoToDateTime(LJsonObject.AsString['dataEmis10']);
            ARetornoWS.DadosRet.TituloRet.ValorDocumento              := LJsonObject.AsCurrency['valMoeda10'];
            if ACBrBoleto.Configuracoes.WebService.UseCertificateHTTP then // Portal Developers
              ARetornoWS.DadosRet.TituloRet.ValorDocumento            := ARetornoWS.DadosRet.TituloRet.ValorDocumento / 100;
            ARetornoWS.DadosRet.TituloRet.Vencimento                  := DateBradescoToDateTime(LJsonObject.AsString['dataVencto10']);
            ARetornoWS.DadosRet.TituloRet.TxId                        := LJsonObject.AsString['iconcPgtoSpi'];
            ARetornoWS.DadosRet.TituloRet.EMV                         := LJsonObject.AsString['wqrcdPdraoMercd'];
          end
          else
          if (LTipoOperacao = tpConsultaDetalhe) then
          begin
            if (ACBrBoleto.Cedente.CedenteWS.IndicadorPix) and (ACBrBoleto.Configuracoes.WebService.UseCertificateHTTP) then
            begin
              //Boleto com qrcode
              ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca        := CodigoStatusTituloToDescricao(LJsonObject.AsInteger['codStatus']);
              ARetornoWS.DadosRet.TituloRet.CodigoEstadoTituloCobranca  := LJsonObject.AsString['codStatus'];//Ex. A Vencer/Vencido
              ARetornoWS.DadosRet.TituloRet.Sacado.NomeSacado           := LJsonObject.AsString['nomeSacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Logradouro           := LJsonObject.AsString['endSacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Bairro               := LJsonObject.AsString['baiSacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.CNPJCPF              := LJsonObject.AsString['cnpjSacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Cidade               := LJsonObject.AsString['cidSacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.UF                   := LJsonObject.AsString['ufSacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.CEP                  := LJsonObject.AsString['cepSacado']+LJsonObject.AsString['cepcSacado'];
              ARetornoWS.DadosRet.TituloRet.SeuNumero                   := LJsonObject.AsString['snumero'];
              ARetornoWS.DadosRet.TituloRet.DataRegistro                := DateBradescoToDateTime(LJsonObject.AsString['dataReg']);
              ARetornoWS.DadosRet.TituloRet.DataProcessamento           := DateBradescoToDateTime(LJsonObject.AsString['dataEmis']);
              ARetornoWS.DadosRet.TituloRet.Vencimento                  := DateBradescoToDateTime(LJsonObject.AsString['dataVencto']);
              ARetornoWS.DadosRet.TituloRet.DataDocumento               := DateBradescoToDateTime(LJsonObject.AsString['dataEmis']);
              ARetornoWS.DadosRet.TituloRet.DataMovimento               := DateBradescoToDateTime(LJsonObject.AsString['dtPagto']);
              ARetornoWS.DadosRet.TituloRet.DataBaixa                   := DateBradescoToDateTime(LJsonObject.AsString['dtPagto']);
              ARetornoWS.DadosRet.TituloRet.DataCredito	                := DateBradescoToDateTime(LJsonObject.AsString['dtPagto']);

              ARetornoWS.DadosRet.TituloRet.ValorDocumento              := ValorInteiroParaDouble(LJsonObject.AsInteger['valorMoedaBol']);

              LcodStatus := LJsonObject.AsInteger['codStatus'];
              LdtPagto   := LJsonObject.AsInteger['dtPagto'];
              LdtBaixa   := LJsonObject.AsInteger['dtBaixa'];

              if LcodStatus = 61 then
                LvalorPago := StrToFloatDef(StringReplace(LJsonObject.AsString['vlrPagto'], ',', '.', [rfReplaceAll]), 0)
              else if LDtPagto > 0 then
                LValorPago := ValorInteiroParaDouble(LJsonObject.AsInteger['valMoeda'])
              else if (LCodStatus = 51) and (LDtBaixa > 0) then
                LvalorPago := ValorInteiroParaDouble(LJsonObject.AsInteger['valMoeda'])
              else
                LValorPago := 0;

              ARetornoWS.DadosRet.TituloRet.ValorPago                   := LValorPago;
              ARetornoWS.DadosRet.TituloRet.ValorAbatimento             := ValorInteiroParaDouble(LJsonObject.AsInteger['valAbat']);
              ARetornoWS.DadosRet.TituloRet.DataMulta                   := DateBradescoToDateTime(LJsonObject.AsString['dataMulta']);
              // 'codValMul' = 2 indica que 'valMulta' e taxa percentual, nao valor em reais
              if LJsonObject.AsInteger['codValMul'] = 2 then
              begin
                ARetornoWS.DadosRet.TituloRet.PercentualMulta           := ValorInteiroParaDouble(LJsonObject.AsInteger['valMulta']);
                ARetornoWS.DadosRet.TituloRet.MultaValorFixo            := False;
              end
              else
              begin
                ARetornoWS.DadosRet.TituloRet.ValorMulta                := ValorInteiroParaDouble(LJsonObject.AsInteger['valMulta']);
                ARetornoWS.DadosRet.TituloRet.MultaValorFixo            := True;
              end;
              ARetornoWS.DadosRet.TituloRet.DataMoraJuros               := DateBradescoToDateTime(LJsonObject.AsString['dataPerm']);
              ARetornoWS.DadosRet.TituloRet.ValorMoraJuros              := ValorInteiroParaDouble(LJsonObject.AsInteger['valPerm']);
              ARetornoWS.DadosRet.TituloRet.DataDesconto                := DateBradescoToDateTime(LJsonObject.AsString['dataDesc1']);
              ARetornoWS.DadosRet.TituloRet.ValorDesconto               := ValorInteiroParaDouble(LJsonObject.AsInteger['valDesc1']);
              ARetornoWS.DadosRet.TituloRet.DataDesconto2               := DateBradescoToDateTime(LJsonObject.AsString['dataDesc2']);
              ARetornoWS.DadosRet.TituloRet.ValorDesconto2              := ValorInteiroParaDouble(LJsonObject.AsInteger['valDesc2']);
              ARetornoWS.DadosRet.TituloRet.DataDesconto3               := DateBradescoToDateTime(LJsonObject.AsString['dataDesc3']);
              ARetornoWS.DadosRet.TituloRet.ValorDesconto3              := ValorInteiroParaDouble(LJsonObject.AsInteger['valDesc3']);

              ARetornoWS.DadosRet.TituloRet.CodBarras                   := ConverterEBCDICToCodigoBarras(LJsonObject.AsString['codBarras']);
              ARetornoWS.DadosRet.TituloRet.LinhaDig                    := OnlyNumber(LJsonObject.AsString['linhaDig']);
              ARetornoWS.DadosRet.TituloRet.EMV                         := LJsonObject.AsString['semvQrcode'];
              if LJsonObject.AsInteger['codStatus'] >= 51 then
              begin
                ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca        := CodigoBaixaToDescricao(LJsonObject.AsInteger['codStatus']);
                ARetornoWS.DadosRet.TituloRet.CodigoEstadoTituloCobranca  := LJsonObject.AsString['codStatus'];
                ARetornoWS.DadosRet.TituloRet.DataMovimento               := DateBradescoToDateTime(LJsonObject.AsString['dtBaixa']);
                ARetornoWS.DadosRet.TituloRet.DataBaixa                   := DateBradescoToDateTime(LJsonObject.AsString['dtBaixa']);
              end;
            end
            else
            begin
              //Boleto sem qrcode
              LjsonTitulo := LJsonObject.AsJSONObject['titulo'];
              ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca        := CodigoStatusTituloToDescricao(LjsonTitulo.AsInteger['codStatus']);
              ARetornoWS.DadosRet.TituloRet.CodigoEstadoTituloCobranca  := LjsonTitulo.AsString['codStatus'];//Ex. A Vencer/Vencido

              LjsonTituloSacado := LjsonTitulo.AsJSONObject['sacado'];
              ARetornoWS.DadosRet.TituloRet.Sacado.NomeSacado           := LjsonTituloSacado.AsString['nome'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Logradouro           := LjsonTituloSacado.AsString['endereco'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Bairro               := LjsonTituloSacado.AsString['bairro'];
              ARetornoWS.DadosRet.TituloRet.Sacado.CNPJCPF              := LjsonTituloSacado.AsString['cnpj'];
              ARetornoWS.DadosRet.TituloRet.Sacado.Cidade               := LjsonTituloSacado.AsString['cidade'];
              ARetornoWS.DadosRet.TituloRet.Sacado.UF                   := LjsonTituloSacado.AsString['uf'];
              ARetornoWS.DadosRet.TituloRet.Sacado.CEP                  := LjsonTituloSacado.AsString['cep']+LjsonTituloSacado.AsString['cepc'];

              ARetornoWS.DadosRet.TituloRet.SeuNumero                   := LjsonTitulo.AsString['snumero'];
              ARetornoWS.DadosRet.TituloRet.DataRegistro                := DateBradescoToDateTime(LjsonTitulo.AsString['dataReg']);
              ARetornoWS.DadosRet.TituloRet.DataProcessamento           := DateBradescoToDateTime(LjsonTitulo.AsString['dataEmis']);
              ARetornoWS.DadosRet.TituloRet.Vencimento                  := DateBradescoToDateTime(LjsonTitulo.AsString['dataVencto']);
              ARetornoWS.DadosRet.TituloRet.DataDocumento               := DateBradescoToDateTime(LjsonTitulo.AsString['dataEmis']);
              ARetornoWS.DadosRet.TituloRet.DataMovimento               := DateBradescoToDateTime(LjsonTitulo.AsString['dtPagto']);
              ARetornoWS.DadosRet.TituloRet.DataBaixa                   := DateBradescoToDateTime(LjsonTitulo.AsString['dtPagto']);
              ARetornoWS.DadosRet.TituloRet.CodBarras                   := ConverterEBCDICToCodigoBarras(LJsonObject.AsString['codBarras']);
              ARetornoWS.DadosRet.TituloRet.LinhaDig                    := OnlyNumber(LjsonTitulo.AsString['linhaDig']);
              ARetornoWS.DadosRet.TituloRet.ValorDocumento              := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valMoeda']);
              ARetornoWS.DadosRet.TituloRet.ValorPago                   := LjsonTitulo.AsFloat['vlrPagto'];
              ARetornoWS.DadosRet.TituloRet.ValorAbatimento             := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valAbat']);
              ARetornoWS.DadosRet.TituloRet.DataMulta                   := DateBradescoToDateTime(LjsonTitulo.AsString['dataMulta']);
              // 'codValMul' = 2 indica que 'valMulta' e taxa percentual, nao valor em reais
              if LjsonTitulo.AsInteger['codValMul'] = 2 then
              begin
                ARetornoWS.DadosRet.TituloRet.PercentualMulta           := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valMulta']);
                ARetornoWS.DadosRet.TituloRet.MultaValorFixo            := False;
              end
              else
              begin
                ARetornoWS.DadosRet.TituloRet.ValorMulta                := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valMulta']);
                ARetornoWS.DadosRet.TituloRet.MultaValorFixo            := True;
              end;
              ARetornoWS.DadosRet.TituloRet.DataMoraJuros               := DateBradescoToDateTime(LjsonTitulo.AsString['dataPerm']);
              ARetornoWS.DadosRet.TituloRet.ValorMoraJuros              := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valPerm']);
              ARetornoWS.DadosRet.TituloRet.DataDesconto                := DateBradescoToDateTime(LjsonTitulo.AsString['dataDesc1']);
              ARetornoWS.DadosRet.TituloRet.ValorDesconto               := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valDesc1']);
              ARetornoWS.DadosRet.TituloRet.DataDesconto2               := DateBradescoToDateTime(LjsonTitulo.AsString['dataDesc2']);
              ARetornoWS.DadosRet.TituloRet.ValorDesconto2              := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valDesc2']);
              ARetornoWS.DadosRet.TituloRet.DataDesconto3               := DateBradescoToDateTime(LjsonTitulo.AsString['dataDesc3']);
              ARetornoWS.DadosRet.TituloRet.ValorDesconto3              := ValorInteiroParaDouble(LjsonTitulo.AsInteger['valDesc3']);
            end;

            if LjsonTitulo.IsJSONObject('baixa') then
            begin
              LJsonTitulosBaixa := LjsonTitulo.AsJSONObject['baixa'];
              if LJsonTitulosBaixa.AsInteger['codigo'] >= 51 then
              begin
                ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca        := CodigoBaixaToDescricao(LJsonTitulosBaixa.AsInteger['codigo']);
                ARetornoWS.DadosRet.TituloRet.CodigoEstadoTituloCobranca  := LJsonTitulosBaixa.AsString['codigo'];
                ARetornoWS.DadosRet.TituloRet.DataMovimento               := DateBradescoToDateTime(LJsonTitulosBaixa.AsString['data']);
                ARetornoWS.DadosRet.TituloRet.DataBaixa                   := DateBradescoToDateTime(LJsonTitulosBaixa.AsString['data']);
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

function TRetornoEnvio_Bradesco.LerListaRetorno: Boolean;
var
  LListaRetorno: TACBrBoletoRetornoWS;
  LJsonObject: TACBrJSONObject;
  LJSonObjectItem: TACBrJSONObject;
  LMensagemRejeicao: TACBrBoletoRejeicao;
  LJsonBoletos: TACBrJSONArray;
  LMora, LMulta, LPagador : TACBrJSONObject;
  LSituacao, LDescricaoOrigemPagamento:string;
  I: Integer;
  LTipoOperacao : TOperacao;
begin
  Result := True;

  LTipoOperacao := ACBrBoleto.Configuracoes.WebService.Operacao;
  LListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;
  LListaRetorno.HTTPResultCode := HTTPResultCode;
  LListaRetorno.JSONEnvio      := EnvWs;

  if RetWS <> '' then
  begin
    try
      LJsonObject := TACBrJSONObject.Parse(RetWS);
      try
        case HTTPResultCode of
          400, 404 :
          begin
            if( LJsonObject.AsString['codigo'] <> '' ) then
            begin
              LMensagemRejeicao            := LListaRetorno.CriarRejeicaoLista;

              LMensagemRejeicao.Codigo     := LJsonObject.AsString['codigo'];
              LMensagemRejeicao.Versao     := LJsonObject.AsString['parametro'];
              LMensagemRejeicao.Mensagem   := LJsonObject.AsString['mensagem'];
            end;
          end;
        end;
        //retorna quando tiver sucesso
        if (LListaRetorno.ListaRejeicao.Count = 0) then
        begin
          if (LTipoOperacao = tpConsulta) and  (ACBrBoleto.Cedente.CedenteWS.IndicadorPix) then
          begin
            // No novo JSON, a lista está na chave 'titulos' em vez de 'content'
            LJsonBoletos := LJsonObject.AsJSONArray['titulos'];

            for I := 0 to Pred(LJsonBoletos.Count) do
            begin
              if I > 0 then
                LListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;

              LJSonObjectItem := LJsonBoletos.ItemAsJSONObject[I];

              LListaRetorno.indicadorContinuidade := (LJsonObject.AsString['indMaisPagina'] = 'S');

              // Mapeamento dos Identificadores
              LListaRetorno.DadosRet.IDBoleto.NossoNum  := LJSonObjectItem.AsString['nossoNumero'];
              // O novo JSON não traz código de barras ou linha digitável explicitamente em cada item,
              // comumente usa-se o NossoNumero se necessário ou deixa-se em branco.
              LListaRetorno.DadosRet.TituloRet.NossoNumero := LListaRetorno.DadosRet.IDBoleto.NossoNum;

              // Valores e Datas
              LListaRetorno.DadosRet.TituloRet.SeuNumero       := LJSonObjectItem.AsString['seuNumero'];
              LListaRetorno.DadosRet.TituloRet.Vencimento       := DateBradescoToDateTime(LJSonObjectItem.AsString['dataVencimento']);
              LListaRetorno.DadosRet.TituloRet.DataRegistro     := DateBradescoToDateTime(LJSonObjectItem.AsString['dataMovimento']);
              LListaRetorno.DadosRet.TituloRet.ValorDocumento   := LJSonObjectItem.AsCurrency['valorTitulo'] / 100; // Se o JSON vier em centavos
              LListaRetorno.DadosRet.TituloRet.ValorPago        := LJSonObjectItem.AsCurrency['valorPagamento'] / 100;

              // Datas de Movimentação
              LListaRetorno.DadosRet.TituloRet.DataMovimento    := DateBradescoToDateTime(LJSonObjectItem.AsString['dataMovimento']);
              LListaRetorno.DadosRet.TituloRet.DataCredito      := DateBradescoToDateTime(LJSonObjectItem.AsString['dataPagamento']);

              // Pagador (No novo JSON o pagador está na raiz do item, não em um objeto aninhado)
              LListaRetorno.DadosRet.TituloRet.Sacado.NomeSacado := LJSonObjectItem.AsString['nomePagador'];

              // Tratamento de Situação/Baixa
              // Como o novo JSON não tem o campo "situacao" explícito como o anterior,
              // validamos pela data de pagamento ou valor pago.
              if (LJSonObjectItem.AsCurrency['valorPagamento'] > 0) then
              begin
                LListaRetorno.DadosRet.TituloRet.DataBaixa := DateBradescoToDateTime(LJSonObjectItem.AsString['dataPagamento']);
              end;

              if LJSonObjectItem.ValueExists('codigoFormaCredito') then
              begin
                LListaRetorno.DadosRet.TituloRet.CodigoEstadoTituloCobranca  := IntToStr(LJSonObjectItem.AsInteger['codigoFormaCredito']);
                LDescricaoOrigemPagamento := '';
                if LJSonObjectItem.ValueExists('descricaoOrigemPagamento') then
                  LDescricaoOrigemPagamento := LJSonObjectItem.AsString['descricaoOrigemPagamento'];

                LListaRetorno.DadosRet.TituloRet.EstadoTituloCobranca := CodigoFormaDeCreditoToDescricao(LJSonObjectItem.AsInteger['codigoFormaCredito']) + ' - '+
                                                                                                              LDescricaoOrigemPagamento;
              end;



              // Obs: Se o JSON novo não traz Mora/Multa detalhado por item nesta consulta específica,
              // esses campos do código anterior foram omitidos ou devem ser zerados.
            end;
          end
          else
          begin
            LJsonBoletos := LJsonObject.AsJSONArray['content'];
            for I := 0 to Pred(LJsonBoletos.Count) do
            begin

              if I > 0 then
                LListaRetorno := ACBrBoleto.CriarRetornoWebNaLista;

              LJSonObjectItem  := LJsonBoletos.ItemAsJSONObject[I];

              LListaRetorno.indicadorContinuidade                   := false;

              LListaRetorno.DadosRet.TituloRet.CodBarras            := LListaRetorno.DadosRet.IDBoleto.CodBarras;
              LListaRetorno.DadosRet.TituloRet.LinhaDig             := LListaRetorno.DadosRet.IDBoleto.LinhaDig;
              LListaRetorno.DadosRet.TituloRet.NossoNumero          := LListaRetorno.DadosRet.IDBoleto.NossoNum;


              LListaRetorno.DadosRet.IDBoleto.CodBarras             := LJSonObjectItem.AsString['codigoBarras'];
              LListaRetorno.DadosRet.IDBoleto.LinhaDig              := LJSonObjectItem.AsString['linhaDigitavel'];
              LListaRetorno.DadosRet.IDBoleto.NossoNum              := LJSonObjectItem.AsString['nossoNumero'];
              LListaRetorno.DadosRet.TituloRet.Vencimento           := DateBradescoToDateTime(LJSonObjectItem.AsString['dataVencimento']);
              LListaRetorno.DadosRet.TituloRet.ValorDocumento       := LJSonObjectItem.AsCurrency['valorNominal'];
              LListaRetorno.DadosRet.TituloRet.ValorAtual           := LJSonObjectItem.AsCurrency['valorNominal'];
              LListaRetorno.DadosRet.TituloRet.ValorPago            := LJSonObjectItem.AsCurrency['valorTotalRecebimento'];

              LMora := LJSonObjectItem.AsJSONObject['mora'];
              if LMora <>nil then
                LListaRetorno.DadosRet.TituloRet.ValorMoraJuros       := LMora.AsCurrency['valor'];

              LMulta := LJSonObjectItem.AsJSONObject['multa'];
              if LMulta <> nil then
                LListaRetorno.DadosRet.TituloRet.PercentualMulta      := LMulta.AsCurrency['taxa'];

              LListaRetorno.DadosRet.TituloRet.SeuNumero            := LJSonObjectItem.AsString['seuNumero'];
              LListaRetorno.DadosRet.TituloRet.DataRegistro         := DateBradescoToDateTime( LJSonObjectItem.AsString['dataEmissao']);
              LListaRetorno.DadosRet.TituloRet.Vencimento           := DateBradescoToDateTime( LJSonObjectItem.AsString['dataVencimento'] );
              LListaRetorno.DadosRet.TituloRet.EstadoTituloCobranca := LJSonObjectItem.AsString['situacao'];
              LListaRetorno.DadosRet.TituloRet.DataMovimento        := DateBradescoToDateTime( LJSonObjectItem.AsString['dataHoraSituacao']);
              LListaRetorno.DadosRet.TituloRet.DataCredito          := DateBradescoToDateTime( LJSonObjectItem.AsString['dataHoraSituacao']);

              LPagador := LJSonObjectItem.AsJSONObject['pagador'];
              if LPagador <> nil then
              begin
                LListaRetorno.DadosRet.TituloRet.Sacado.NomeSacado    := LPagador.AsString['nome'];
                LListaRetorno.DadosRet.TituloRet.Sacado.Cidade        := LPagador.AsString['cidade'];
                LListaRetorno.DadosRet.TituloRet.Sacado.UF            := LPagador.AsString['uf'];
                LListaRetorno.DadosRet.TituloRet.Sacado.Bairro        := LPagador.AsString['bairro'];
                LListaRetorno.DadosRet.TituloRet.Sacado.Cep           := LPagador.AsString['cep'];
                LListaRetorno.DadosRet.TituloRet.Sacado.Numero        := LPagador.AsString['numero'];
                LListaRetorno.DadosRet.TituloRet.Sacado.Logradouro    := LPagador.AsString['logradouro'];
                LListaRetorno.DadosRet.TituloRet.Sacado.CNPJCPF       := LPagador.AsString['cpfCnpj'];
              end;

              LSituacao:= LJSonObjectItem.AsString['situacao'];
              if( LSituacao = C_CANCELADO ) or
                ( LSituacao = C_EXPIRADO ) or
                ( LSituacao = C_PAGO ) or
                ( LSituacao = C_EXPIRADO ) then
              begin
                LListaRetorno.DadosRet.TituloRet.ValorPago                   := LJSonObjectItem.AsCurrency['valorNominal'];
                LListaRetorno.DadosRet.TituloRet.DataBaixa                   := DateBradescoToDateTime( LJSonObjectItem.AsString['dataHoraSituacao'])
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

function TRetornoEnvio_Bradesco.RetornoEnvio(const AIndex: Integer): Boolean;
begin
  Result:=inherited RetornoEnvio(AIndex);
end;

function TRetornoEnvio_Bradesco.CodigoBaixaToDescricao(
  const AValue: Integer): string;
begin
  case AValue of
    51: Result := 'POR ACERTO (QUANDO PAGAMENTO ocorrer VIA QR CODE)';
    52: Result := 'BAIXA POR REGISTRO DUPLICADO';
    53: Result := 'POR DECURSO DE PRAZO';
    54: Result := 'POR MEDIDA JUDICIAL';
    55: Result := 'POR REMESSA (CEB)';
    56: Result := 'COBRADO - POR RASTREAMENTO';
    57: Result := 'CONFORME SEU PEDIDO';
    58: Result := 'PROTESTADO';
    59: Result := 'DEVOLVIDO';
    60: Result := 'ENTREGUE FRANCO DE PAGAMENTO';
    61: Result := 'PAGO';
    62: Result := 'PAGO EM CARTORIO';
    63: Result := 'SUSTADO RETIRADO DE CARTORIO';
    64: Result := 'SUSTADO SEM REMESSA A CARTORIO';
    66: Result := 'CREDITO EXDD';
    67: Result := 'CREDITO EXDD - PAGO EM CARTORIO';
    68: Result := 'COBRADO - POR BAIXA MANUAL';
    69: Result := 'COBRADO - POR BAIXA MANUAL - PAGO EM CARTORIO';
  else
    Result := 'CÓDIGO DESCONHECIDO';
  end;

end;


function TRetornoEnvio_Bradesco.CodigoFormaDeCreditoToDescricao(
  const AValue: Integer): string;
begin
  case AValue of
    1: Result := 'DISP VARIOS CHEQUES E DINHEIRO';
    2: Result := 'DISP CHEQUE BRADESCO E DINHEIRO';
    3: Result := 'DISP MEIO ELETRONICO';
    4: Result := 'DISP VARIOS CHEQUES BRADESCO/ORGANIZACAO';
    5: Result := 'DISP CHEQUE OUTRO BANCO';
    6: Result := 'DISP OUTRO BANCO';
    7: Result := 'INDISP MEIO ELETRONICO';
    8: Result := 'INDISP VRS CHEQUES BRADESCO/ORGANIZACAO';
    9: Result := 'INDISP CHEQUE OUTRO BANCO';
    10: Result := 'INDISP OUTRO BANCO';
  else
    Result := 'CÓDIGO INVÁLIDO';
  end;
end;

function TRetornoEnvio_Bradesco.CodigoStatusTituloToDescricao(
  const AValue: Integer): string;
begin
  case AValue of
    01: Result := 'A VENCER / VENCIDO';
    02: Result := 'COM PAGAMENTO VINCULADO';
    03: Result := 'COM PAGTO VINCULADO E INSTRUCAO AGENDADA';
    04: Result := 'COM INSTRUCAO DE PROTESTO';
    05: Result := 'COM INSTR. DE PROTESTO E PAGTO VINCULADO';
    06: Result := 'EM PODER DO CARTORIO';
    07: Result := 'COM INSTR. E PEDIDO SUSTACAO - SEM BAIXA';
    08: Result := 'COM INSTR. E PEDIDO SUSTACAO - COM BAIXA';
    09: Result := 'EM CARTORIO E PEDIDO SUSTACAO - S/ BAIXA';
    10: Result := 'EM CARTORIO E PEDIDO SUSTACAO - C/ BAIXA';
    11: Result := 'COM BAIXA SOLICITADA';
    12: Result := 'COM EXECUCAO SOLICITADA';
    13: Result := 'PAGO NO DIA';
    14: Result := 'EM CARTORIO COM PAGAMENTO VINCULADO';
    15: Result := 'INSTR. PED. SUST. - S/ BAIXA - PGTO VINC';
    16: Result := 'INSTR. PED. SUST. - C/ BAIXA - PGTO VINC';
    17: Result := 'CARTORIO PED. SUST.-S/ BAIXA - PGTO VINC';
    18: Result := 'CARTORIO PED. SUST.-C/ BAIXA - PGTO VINC';
    19: Result := 'SUSTADO SEM REMESSA AO CARTORIO';
    20: Result := 'SUSTADO RETIRADO DE CARTORIO';
    21: Result := 'SUSTADO JUDICIALMENTE';
    22: Result := 'PENDENTE NO DISTRIBUIDOR';
    23: Result := 'TITULO COM IRREGULARIDADE';
    24: Result := 'AGUARDANDO APONTAMENTO DE IRREGULARIDADE';
    25: Result := 'AGUARDANDO SOLICIT. DE SUSTACAO C/ BAIXA';
    26: Result := 'AGUARDANDO SOLICIT. DE SUSTACAO S/BAIXA';
    27: Result := 'SOLIC. SUSTACAO C/ENVIO CARTOR. C/BAIXA';
    28: Result := 'SOLIC. SUSTACAO C/ENVIO CARTOR. S/BAIXA';
    29: Result := 'EM CARTORIO COM EDITAL';
    30: Result := 'COM PAGAMENTO RETIDO';
    31: Result := 'COM INSTR NEGATIVACAO';
    32: Result := 'EM PROC NEGATIVACAO';
    33: Result := 'NEGATIVADO';
    34: Result := 'EXCL NEG S/BAIXA';
    35: Result := 'EXCL NEG C/BAIXA';
    51: Result := 'POR ACERTO (QUANDO PAGAMENTO ocorrer VIA QR CODE)';
    52: Result := 'BAIXA POR REGISTRO DUPLICADO';
    53: Result := 'POR DECURSO DE PRAZO';
    54: Result := 'POR MEDIDA JUDICIAL';
    55: Result := 'POR REMESSA (CEB)';
    56: Result := 'COBRADO - POR RASTREAMENTO';
    57: Result := 'CONFORME SEU PEDIDO';
    58: Result := 'PROTESTADO';
    59: Result := 'DEVOLVIDO';
    60: Result := 'ENTREGUE FRANCO DE PAGAMENTO';
    61: Result := 'PAGO';
    62: Result := 'PAGO EM CARTORIO';
    63: Result := 'SUSTADO RETIRADO DE CARTORIO';
    64: Result := 'SUSTADO SEM REMESSA A CARTORIO';
    65: Result := 'TRANSFERIDO PARA DESCONTO';
    66: Result := 'CREDITO EXDD';
    67: Result := 'CREDITO EXDD - PAGO EM CARTORIO';
    68: Result := 'COBRADO - POR BAIXA MANUAL';
    69: Result := 'COBRADO-POR BAIXA MANUAL-PAGO EM CARTORIO';
    70: Result := 'TRANSFERENCIA RECEBIVEIS';
    71: Result := 'DEVOLUCAO TRANSF RECEBIVEIS';
    72: Result := 'TRANSF. FUNDOS RECEB./COBRANCA';
    73: Result := 'DEV. FUNDOS RECEB./COBRANCA';
    98: Result := 'POR REGISTRO DUPLICADO';
    99: Result := 'COM REATIVACAO SOLICITADA';
  else
    Result := 'CÓDIGO DESCONHECIDO';
  end;
end;

function TRetornoEnvio_Bradesco.ValorInteiroParaDouble(
  const AValue: integer): Real;
begin
  Result := AValue / 100 ;
end;


end.
