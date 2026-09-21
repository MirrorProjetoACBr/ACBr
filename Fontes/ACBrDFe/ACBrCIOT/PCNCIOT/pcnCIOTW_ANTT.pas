{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

unit pcnCIOTW_ANTT;

interface

uses
  SysUtils,
  Classes,
  pcnCIOTW,
  pcnCIOT,
  ACBrCIOTConversao,
  ACBrJSON,
  ACBrUtil.Strings;

type
  { TCIOTW_ANTT }

  TCIOTW_ANTT = class(TCIOTWClass)
  private
    FVersaoDF: TVersaoCIOT;

    function TipoOperacaoANTT: Integer;
    function TipoPagamentoANTT(APagamento: TPagamentoCollectionItem): Integer;
    function IndPagamentoANTT(const AIndicadorPagamento: string): Integer;
    function DataHoraANTT(const AValue: TDateTime): string;
    function FormatarRNTRC(const AValue: string): string;

    procedure GerarOrigemDestino(AJSon: TACBrJSONObject; AViagem: TViagemCollectionItem;
      const AComDistancia: Boolean; const AComQtdViagens: Boolean);

    function GerarConsultarSituacaoTransportador: TACBrJSONObject;
    function GerarConsultarFrotaTransportador: TACBrJSONObject;
    function GerarDeclaracaoOperacaoTransporte: TACBrJSONObject;
    function GerarCancelamentoOperacaoTransporte: TACBrJSONObject;
    function GerarRetificacaoOperacaoTransporte: TACBrJSONObject;
    function GerarEncerramentoOperacaoTransporte: TACBrJSONObject;
    function GerarConsultarExcecao: TACBrJSONObject;
    function GerarConsultarCIOTGerado: TACBrJSONObject;
  public
    constructor Create(ACIOTW: TCIOTW); override;

    property VersaoDF: TVersaoCIOT read FVersaoDF write FVersaoDF;

    function ObterNomeArquivo: String; override;
    function GerarXml: Boolean; override;
  end;

implementation

{ TCIOTW_ANTT }

constructor TCIOTW_ANTT.Create(ACIOTW: TCIOTW);
begin
  inherited Create(ACIOTW);
end;

function TCIOTW_ANTT.ObterNomeArquivo: String;
begin
  Result := '';
end;

function TCIOTW_ANTT.DataHoraANTT(const AValue: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', AValue);
end;

function TCIOTW_ANTT.FormatarRNTRC(const AValue: string): string;
begin
  Result := OnlyNumber(AValue);

  if Result <> '' then
    Result := PadLeft(Result, 9, '0');
end;

function TCIOTW_ANTT.TipoOperacaoANTT: Integer;
begin
  // 1 - Operação Carga Lotação; 2 - Operação Carga Fracionada;
  // 3 - Operação TAC-Agregado
  case CIOT.AdicionarOperacao.TipoViagem of
    Padrao:       Result := 1;
    Fracionado:   Result := 2;
    TAC_Agregado: Result := 3;
  else
    begin
      Result := 0;
      Gerador.wAlerta('', 'TipoOperacao', 'Tipo de Operação',
        'Tipo de viagem inválido para a integradora ANTT. Utilize Padrao, Fracionado ou TAC_Agregado.');
    end;
  end;
end;

function TCIOTW_ANTT.TipoPagamentoANTT(APagamento: TPagamentoCollectionItem): Integer;
begin
  // 1 - IP (cartão pré-pago emitido por IP ou IF); 2 - Conta Corrente;
  // 3 - Conta Poupança; 4 - Conta Pagamento; 5 - Outros; 6 - Pix
  if APagamento.ValorChavePix <> '' then
    Result := 6
  else
  begin
    case APagamento.TipoPagamento of
      TransferenciaBancaria:
        case APagamento.InformacoesBancarias.TipoConta of
          tcContaCorrente:   Result := 2;
          tcContaPoupanca:   Result := 3;
          tcContaPagamentos: Result := 4;
        else
          Result := 2;
        end;

      eFRETE, Parceiro:
        Result := 1;
    else // Outros, DepositoAgendado
      Result := 5;
    end;
  end;
end;

function TCIOTW_ANTT.IndPagamentoANTT(const AIndicadorPagamento: string): Integer;
begin
  // 0 = à vista / 1 = a prazo
  if (AIndicadorPagamento = '1') or SameText(AIndicadorPagamento, 'APrazo') or
     SameText(AIndicadorPagamento, 'A Prazo') then
    Result := 1
  else
    Result := 0;
end;

procedure TCIOTW_ANTT.GerarOrigemDestino(AJSon: TACBrJSONObject;
  AViagem: TViagemCollectionItem; const AComDistancia: Boolean;
  const AComQtdViagens: Boolean);
var
  LOrigem, LDestino: TACBrJSONObject;
begin
  LOrigem := TACBrJSONObject.Create;
  LOrigem
    .AddPair('CodigoMunicipioOrigem', AViagem.CodigoMunicipioOrigem, False)
    .AddPair('CepOrigem', OnlyNumber(AViagem.CepOrigem), False)
    .AddPair('LatitudeOrigem', AViagem.LatitudeOrigem, False)
    .AddPair('LongitudeOrigem', AViagem.LongitudeOrigem, False);
  AJSon.AddPair('Origem', LOrigem);

  LDestino := TACBrJSONObject.Create;
  LDestino
    .AddPair('CodigoMunicipioDestino', AViagem.CodigoMunicipioDestino, False)
    .AddPair('CepDestino', OnlyNumber(AViagem.CepDestino), False)
    .AddPair('LatitudeDestino', AViagem.LatitudeDestino, False)
    .AddPair('LongitudeDestino', AViagem.LongitudeDestino, False);
  AJSon.AddPair('Destino', LDestino);

  if AComDistancia then
    AJSon.AddPair('DistanciaPercorrida', AViagem.DistanciaPercorrida, False);

  if AComQtdViagens then
    AJSon.AddPair('QtdViagens', AViagem.QtdViagens, False);
end;

function TCIOTW_ANTT.GerarConsultarSituacaoTransportador: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.ConsultarTransportador do
  begin
    Result
      .AddPair('CpfCnpjInteressado', OnlyNumber(CpfCnpjInteressado))
      .AddPair('CpfCnpjTransportador', OnlyNumber(CpfCnpjTransportador))
      .AddPair('RNTRCTransportador', FormatarRNTRC(RNTRCTransportador));
  end;
end;

function TCIOTW_ANTT.GerarConsultarFrotaTransportador: TACBrJSONObject;
var
  LPlacas: TACBrJSONArray;
  i: Integer;
begin
  Result := GerarConsultarSituacaoTransportador;

  LPlacas := TACBrJSONArray.Create;

  for i := 0 to CIOT.ConsultarTransportador.Placas.Count - 1 do
    LPlacas.AddElement(CIOT.ConsultarTransportador.Placas[i].Placa);

  Result.AddPair('Placas', LPlacas);
end;

function TCIOTW_ANTT.GerarDeclaracaoOperacaoTransporte: TACBrJSONObject;
var
  LTipoOperacao, i: Integer;
  LVeiculos, LOrigemDestino, LInfPagamento, LContratantes: TACBrJSONArray;
  LVeiculo, LItemOD, LPagamento, LDadosCarga, LIndicadores: TACBrJSONObject;
  LPagto: TPagamentoCollectionItem;
begin
  LTipoOperacao := TipoOperacaoANTT;

  Result := TACBrJSONObject.Create;

  with CIOT.AdicionarOperacao do
  begin
    Result
      .AddPair('IdOperacaoTransporte', IdOperacaoCliente)
      .AddPair('TipoOperacao', LTipoOperacao)
      .AddPair('CpfCnpjContratado', OnlyNumber(Contratado.CpfOuCnpj))
      .AddPair('RNTRCContratado', FormatarRNTRC(Contratado.RNTRC))
      .AddPair('CpfCnpjContratante', OnlyNumber(Contratante.CpfOuCnpj))
      .AddPair('RNTRCContratante', FormatarRNTRC(Contratante.RNTRC), False)
      .AddPair('CpfCnpjDestinatario', OnlyNumber(Destinatario.CpfOuCnpj), False)
      .AddPair('ValorFrete', ValorFrete)
      .AddPair('DataDeclaracao', DataHoraANTT(DataDeclaracao))
      .AddPair('IndContingencia', IndContingencia)
      .AddPair('JustificativaContingencia', JustificativaContingencia, False);

    // Para TAC-Agregado a data de início da viagem não deve ser informada (regra B56).
    if LTipoOperacao <> 3 then
      Result.AddPairISODate('DataInicioViagem', DataInicioViagem, False);

    Result.AddPairISODate('DataFimViagem', DataFimViagem, False);

    LVeiculos := TACBrJSONArray.Create;

    for i := 0 to Veiculos.Count - 1 do
    begin
      LVeiculo := TACBrJSONObject.Create;
      LVeiculo
        .AddPair('Placa', Veiculos[i].Placa)
        .AddPair('RNTRC', FormatarRNTRC(Veiculos[i].RNTRC), False)
        .AddPair('NumeroEixos', Veiculos[i].NumeroEixos, False);

      LVeiculos.AddElementJSON(LVeiculo);
    end;

    Result.AddPair('Veiculos', LVeiculos);

    // Origem/Destino não se aplica a TAC-Agregado na declaração (regra B62).
    if (LTipoOperacao <> 3) and (Viagens.Count > 0) then
    begin
      LOrigemDestino := TACBrJSONArray.Create;

      for i := 0 to Viagens.Count - 1 do
      begin
        LItemOD := TACBrJSONObject.Create;
        GerarOrigemDestino(LItemOD, Viagens[i], True, False);
        LOrigemDestino.AddElementJSON(LItemOD);
      end;

      Result.AddPair('OrigemDestino', LOrigemDestino);
    end;

    if LTipoOperacao <> 3 then
    begin
      LDadosCarga := TACBrJSONObject.Create;
      LDadosCarga
        .AddPair('CodigoNaturezaCarga', CodigoNCMNaturezaCarga, False)
        .AddPair('PesoCarga', PesoCarga, False)
        .AddPair('CodigoTipoCarga', StrToIntDef(TipoCargaToStr(CodigoTipoCarga), 0), False);

      if (LTipoOperacao = 2) and (ContratantesCargaFracionada.Count > 0) then
      begin
        LContratantes := TACBrJSONArray.Create;

        for i := 0 to ContratantesCargaFracionada.Count - 1 do
          LContratantes.AddElement(OnlyNumber(ContratantesCargaFracionada[i].CpfOuCnpj));

        LDadosCarga.AddPair('ContratantesCargaFrac', LContratantes);
      end;

      Result.AddPair('DadosCarga', LDadosCarga);
    end;

    if Pagamentos.Count > 0 then
    begin
      LInfPagamento := TACBrJSONArray.Create;

      for i := 0 to Pagamentos.Count - 1 do
      begin
        LPagto := Pagamentos[i];

        LPagamento := TACBrJSONObject.Create;
        LPagamento
          .AddPair('TipoPagamento', TipoPagamentoANTT(LPagto))
          .AddPair('CodigoInstituicaoFinanceira',
            StrToIntDef(OnlyNumber(LPagto.InformacoesBancarias.InstituicaoBancaria), 0), False)
          .AddPair('NumeroAgencia', LPagto.InformacoesBancarias.Agencia, False)
          .AddPair('NumeroConta', LPagto.InformacoesBancarias.Conta, False)
          .AddPair('ChavePix', LPagto.ValorChavePix, False)
          .AddPair('CpfCnpjCreditado', OnlyNumber(LPagto.CpfCnpjCreditado))
          .AddPair('CodigoPagamento', LPagto.CodigoPagamento, False)
          .AddPair('IdentificadorPix', LPagto.IdentificadorPix, False)
          .AddPair('IndPagamento', IndPagamentoANTT(LPagto.IndicadorPagamento));

        if IndPagamentoANTT(LPagto.IndicadorPagamento) = 1 then
        begin
          LPagamento
            .AddPair('NumeroParcela', LPagto.NumeroParcela)
            .AddPairISODate('DataVencimento', LPagto.DataDeLiberacao)
            .AddPair('ValorParcela', LPagto.Valor);
        end;

        LInfPagamento.AddElementJSON(LPagamento);
      end;

      Result.AddPair('InfPagamento', LInfPagamento);
    end;

    // Indicadores operacionais são obrigatórios somente para Carga Lotação.
    if LTipoOperacao = 1 then
    begin
      LIndicadores := TACBrJSONObject.Create;
      LIndicadores
        .AddPair('IndAltoDesempenho', AltoDesempenho)
        .AddPair('IndRetornoVazio', RetornoVazio)
        .AddPair('ComposicaoVeicular', ComposicaoVeicular);

      Result.AddPair('InfIndicadoresOperacionais', LIndicadores);
    end;
  end;
end;

function TCIOTW_ANTT.GerarCancelamentoOperacaoTransporte: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.CancelarOperacao do
  begin
    Result
      .AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao)
      .AddPair('MotivoCancelamento', Motivo);
  end;
end;

function TCIOTW_ANTT.GerarRetificacaoOperacaoTransporte: TACBrJSONObject;
var
  LOrigemDestino: TACBrJSONArray;
  LItemOD, LOrigem, LDestino, LDadosCarga: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.RetificarOperacao do
  begin
    Result
      .AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao)
      .AddPair('ValorFrete', ValorFrete, False)
      .AddPairISODate('DataFimViagem', DataFimViagem, False);

    if (CodigoMunicipioOrigem > 0) or (CepOrigem <> '') or
       (CodigoMunicipioDestino > 0) or (CepDestino <> '') then
    begin
      LOrigem := TACBrJSONObject.Create;
      LOrigem
        .AddPair('CodigoMunicipioOrigem', CodigoMunicipioOrigem, False)
        .AddPair('CepOrigem', OnlyNumber(CepOrigem), False);

      LDestino := TACBrJSONObject.Create;
      LDestino
        .AddPair('CodigoMunicipioDestino', CodigoMunicipioDestino, False)
        .AddPair('CepDestino', OnlyNumber(CepDestino), False);

      LItemOD := TACBrJSONObject.Create;
      LItemOD
        .AddPair('Origem', LOrigem)
        .AddPair('Destino', LDestino);

      LOrigemDestino := TACBrJSONArray.Create;
      LOrigemDestino.AddElementJSON(LItemOD);

      Result.AddPair('OrigemDestino', LOrigemDestino);
    end;

    if (CodigoNCMNaturezaCarga > 0) or (PesoCarga > 0) then
    begin
      LDadosCarga := TACBrJSONObject.Create;
      LDadosCarga
        .AddPair('CodigoNaturezaCarga', CodigoNCMNaturezaCarga, False)
        .AddPair('PesoCarga', PesoCarga, False)
        .AddPair('CodigoTipoCarga', StrToIntDef(TipoCargaToStr(CodigoTipoCarga), 0), False);

      Result.AddPair('DadosCarga', LDadosCarga);
    end;
  end;
end;

function TCIOTW_ANTT.GerarEncerramentoOperacaoTransporte: TACBrJSONObject;
var
  LOrigemDestino: TACBrJSONArray;
  LItemOD, LDadosCarga: TACBrJSONObject;
  i: Integer;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.EncerrarOperacao do
  begin
    Result.AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao);

    // Origem/Destino é obrigatório somente para TAC-Agregado (regra B58).
    if Viagens.Count > 0 then
    begin
      LOrigemDestino := TACBrJSONArray.Create;

      for i := 0 to Viagens.Count - 1 do
      begin
        LItemOD := TACBrJSONObject.Create;
        GerarOrigemDestino(LItemOD, Viagens[i], True, True);
        LOrigemDestino.AddElementJSON(LItemOD);
      end;

      Result.AddPair('OrigemDestino', LOrigemDestino);
    end;

    if PesoCarga > 0 then
    begin
      LDadosCarga := TACBrJSONObject.Create;
      LDadosCarga.AddPair('PesoTotalCarga', PesoCarga);

      Result.AddPair('DadosCarga', LDadosCarga);
    end;
  end;
end;

function TCIOTW_ANTT.GerarConsultarExcecao: TACBrJSONObject;
begin
  // Serviço consumido via GET com query parameter; o JSON gerado aqui serve
  // para registro/log do envio.
  Result := TACBrJSONObject.Create;
  Result.AddPair('CPFCNPJTransportador',
    OnlyNumber(CIOT.ConsultarTransportador.CpfCnpjTransportador));
end;

function TCIOTW_ANTT.GerarConsultarCIOTGerado: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.ObterCodigoOperacaoTransporte do
  begin
    Result
      .AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao)
      .AddPair('AnoDeclaracao', AnoDeclaracao, False);
  end;
end;

function TCIOTW_ANTT.GerarXml: Boolean;
var
  LJSon: TACBrJSONObject;
begin
  Gerador.ListaDeAlertas.Clear;
  Gerador.ArquivoFormatoXML := '';
  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoTXT := '';

  LJSon := nil;

  case CIOT.Integradora.Operacao of
    opConsultarSituacaoTransportador:
      LJSon := GerarConsultarSituacaoTransportador;

    opConsultarFrota:
      LJSon := GerarConsultarFrotaTransportador;

    opAdicionar:
      LJSon := GerarDeclaracaoOperacaoTransporte;

    opCancelar:
      LJSon := GerarCancelamentoOperacaoTransporte;

    opRetificar:
      LJSon := GerarRetificacaoOperacaoTransporte;

    opEncerrar:
      LJSon := GerarEncerramentoOperacaoTransporte;

    opConsultarExcecao:
      LJSon := GerarConsultarExcecao;

    opObterCodigoIOT,
    opConsultarCIOTGerado:
      LJSon := GerarConsultarCIOTGerado;
  else
    Gerador.wAlerta('', 'Operacao', 'Operação',
      'Operação não disponível para a integradora ANTT.');
  end;

  if Assigned(LJSon) then
  begin
    try
      Gerador.ArquivoFormatoXML := LJSon.ToJSON;
    finally
      LJSon.Free;
    end;
  end;

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.
