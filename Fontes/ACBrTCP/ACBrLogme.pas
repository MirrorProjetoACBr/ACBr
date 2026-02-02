{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Elias César Vieira                                                         }
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

unit ACBrLogme;

interface

uses
  Classes, SysUtils, Contnrs,
  ACBrAPIBase, ACBrJSON, ACBrBase, ACBrSocket,
  ACBrCalculadoraConsumo.Schemas,
  ACBrUtil.Base;

const
  cACBrLogmeURL = 'http://api.logmetributos.com.br';
  cACBrLogmeEndpointProdutos = 'produtos';
  cACBrLogmeEndpointConsultarLote = 'consultaLote';
  cACBrLogmeEndpointConsultarProduto = 'consultaProduto';

type

  { TACBrLogmeTipoDestinatario }

  TACBrLogmeTipoDestinatario = (
    ltdNenhum,
    ltdConsumidorFinal,
    ltdDistribuicao
  );

  { TACBrLogmeRegimeTributarioRemetente }

  TACBrLogmeRegimeTributarioRemetente = (
    lrmNenhum,
    lrmSimplesNacional,
    lrmLucroReal,
    lrmLucroPresumido,
    lrmArbitrario,
    lrmEspecial,
    lrmPublico
  );

  { TACBrLogmeProduto }

  TACBrLogmeProduto = class(TACBrAPISchema)
  private
    fEAN: String;
    fDescricao: String;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(Source: TACBrLogmeProduto);

    property ean: String read fEAN write fEAN;
    property descricao: String read fDescricao write fDescricao;
  end;

  { TACBrLogmeProdutos }

  TACBrLogmeProdutos = class(TACBrAPISchemaArray)
  private
    function GetItem(Index: Integer): TACBrLogmeProduto;
    procedure SetItem(Index: Integer; AValue: TACBrLogmeProduto);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrLogmeProduto): Integer;
    procedure Insert(Index: Integer; aItem: TACBrLogmeProduto);
    function New: TACBrLogmeProduto;

    property Items[Index: Integer]: TACBrLogmeProduto read GetItem write SetItem; default;
  end;

  { TACBrLogmeConsultarBase }

  TACBrLogmeConsultarBase = class(TACBrAPISchema)
  private
    fTipoDestinatario: TACBrLogmeTipoDestinatario;
    fUFDestino: String;
    fProdutos: TACBrLogmeProdutos;
    function GetProdutos: TACBrLogmeProdutos;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;

    property tipo_destinatario: TACBrLogmeTipoDestinatario read fTipoDestinatario write fTipoDestinatario;
    property uf_destino: String read fUFDestino write fUFDestino;
    property produtos: TACBrLogmeProdutos read GetProdutos;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(Source: TACBrLogmeConsultarBase);
  end;

  { TACBrLogmeConsultarLote }

  TACBrLogmeConsultarLote = class(TACBrLogmeConsultarBase)
  public
    property tipo_destinatario;
    property uf_destino;
    property produtos;
  end;

  { TACBrLogmeConsultarProduto }

  TACBrLogmeConsultarProduto = class(TACBrLogmeConsultarBase)
  public
    property produtos;
  end;

  { TACBrLogmeConsultarLoteItemResponse }

  TACBrLogmeConsultarLoteItemResponse = class(TACBrAPISchema)
  private
    fEAN: String;
    fDescricao: String;
    fEANVinculado: String;
    fDescricaoVinculado: String;
    fRegimeTributarioRemetente: TACBrLogmeRegimeTributarioRemetente;
    fTipoDestinatario: TACBrLogmeTipoDestinatario;
    fUFOrigem: String;
    fUFDestino: String;
    fNCM: String;
    fCFOP: String;
    fCEST: String;
    fCST: String;
    fAliquotaICMS: Double;
    fRedBaseDeCalculoICMS: Double;
    fRedBaseDeCalculoICMSST: Double;
    fICMSSTAliquotaInterna: Double;
    fMAVAST: Double;
    fMavaAj4: Double;
    fMavaAj12: Double;
    fIPI: Double;
    fCSTIPI: String;
    fPISCST: String;
    fAliquotaPIS: Double;
    fCOFINSCST: String;
    fAliquotaCOFINS: Double;
    fMensagem: String;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(Source: TACBrLogmeConsultarLoteItemResponse);

    property ean: String read fEAN write fEAN;
    property descricao: String read fDescricao write fDescricao;
    property eanVinculado: String read fEANVinculado write fEANVinculado;
    property descricaoVinculado: String read fDescricaoVinculado write fDescricaoVinculado;
    property regime_tributario_remetente: TACBrLogmeRegimeTributarioRemetente read fRegimeTributarioRemetente write fRegimeTributarioRemetente;
    property tipo_destinatario: TACBrLogmeTipoDestinatario read fTipoDestinatario write fTipoDestinatario;
    property uf_origem: String read fUFOrigem write fUFOrigem;
    property uf_destino: String read fUFDestino write fUFDestino;
    property ncm: String read fNCM write fNCM;
    property cfop: String read fCFOP write fCFOP;
    property cest: String read fCEST write fCEST;
    property cst: String read fCST write fCST;
    property aliquota_icms: Double read fAliquotaICMS write fAliquotaICMS;
    property red_base_de_calculo_icms: Double read fRedBaseDeCalculoICMS write fRedBaseDeCalculoICMS;
    property red_base_de_calculo_icms_st: Double read fRedBaseDeCalculoICMSST write fRedBaseDeCalculoICMSST;
    property icms_st_aliquota_interna: Double read fICMSSTAliquotaInterna write fICMSSTAliquotaInterna;
    property mavast: Double read fMAVAST write fMAVAST;
    property mava_aj_4: Double read fMavaAj4 write fMavaAj4;
    property mava_aj_12: Double read fMavaAj12 write fMavaAj12;
    property ipi: Double read fIPI write fIPI;
    property cst_ipi: String read fCSTIPI write fCSTIPI;
    property pis_cst: String read fPISCST write fPISCST;
    property aliquota_pis: Double read fAliquotaPIS write fAliquotaPIS;
    property cofins_cst: String read fCOFINSCST write fCOFINSCST;
    property aliquota_cofins: Double read fAliquotaCOFINS write fAliquotaCOFINS;
    property mensagem: String read fMensagem write fMensagem;
  end;

  { TACBrLogmeConsultarLoteDataResponse }

  TACBrLogmeConsultarLoteDataResponse = class(TACBrAPISchemaArray)
  private
    function GetItem(Index: Integer): TACBrLogmeConsultarLoteItemResponse;
    procedure SetItem(Index: Integer; AValue: TACBrLogmeConsultarLoteItemResponse);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrLogmeConsultarLoteItemResponse): Integer;
    procedure Insert(Index: Integer; aItem: TACBrLogmeConsultarLoteItemResponse);
    function New: TACBrLogmeConsultarLoteItemResponse;
    property Items[Index: Integer]: TACBrLogmeConsultarLoteItemResponse read GetItem write SetItem; default;
  end;

  { TACBrLogmeConsultarProdutoItemResponse }

  TACBrLogmeConsultarProdutoItemResponse = class(TACBrAPISchema)
  private
    fEAN: String;
    fDescricao: String;
    fMarca: String;
    fEmbalagem: String;
    fQuantidadeEmbalagem: Double;
    fPeso: Double;
    fImagem: String; 
    fErro: String;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(Source: TACBrLogmeConsultarProdutoItemResponse);

    property ean: String read fEAN write fEAN;
    property descricao: String read fDescricao write fDescricao;
    property marca: String read fMarca write fMarca;
    property embalagem: String read fEmbalagem write fEmbalagem;
    property quantidade_embalagem: Double read fQuantidadeEmbalagem write fQuantidadeEmbalagem;
    property peso: Double read fPeso write fPeso;
    property imagem: String read fImagem write fImagem;
    property erro: String read fErro write fErro;
  end;

  { TACBrLogmeConsultarProdutoDataResponse }

  TACBrLogmeConsultarProdutoDataResponse = class(TACBrAPISchemaArray)
  private
    function GetItem(Index: Integer): TACBrLogmeConsultarProdutoItemResponse;
    procedure SetItem(Index: Integer; AValue: TACBrLogmeConsultarProdutoItemResponse);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrLogmeConsultarProdutoItemResponse): Integer;
    procedure Insert(Index: Integer; aItem: TACBrLogmeConsultarProdutoItemResponse);
    function New: TACBrLogmeConsultarProdutoItemResponse;
    property Items[Index: Integer]: TACBrLogmeConsultarProdutoItemResponse read GetItem write SetItem; default;
  end;

  { IACBrLogmeConsultarLoteResponse }

  IACBrLogmeConsultarLoteResponse = interface
  ['{9C5DC6FE-ABB6-4C1B-805B-4CFDAE49EEE7}']
    procedure LoadJson(aJson: String);
    function ToJson: String;
    function success: Boolean;
    function data: TACBrLogmeConsultarLoteDataResponse;
  end;

  { TACBrLogmeConsultarLoteResponse }

  TACBrLogmeConsultarLoteResponse = class(TInterfacedObject, IACBrLogmeConsultarLoteResponse)
  private
    fsuccess: Boolean;
    fdata: TACBrLogmeConsultarLoteDataResponse;
  public
    destructor Destroy; override;
    procedure LoadJson(aJson: String);
    function ToJson: String;

    function success: Boolean;
    function data: TACBrLogmeConsultarLoteDataResponse;
  end;

  { IACBrLogmeConsultarProdutoResponse }

  IACBrLogmeConsultarProdutoResponse = interface
  ['{BF862449-CAE7-4372-B310-8C6BE1DEE6CF}']
    procedure LoadJson(aJson: String);
    function ToJson: String;
    function success: Boolean;
    function data: TACBrLogmeConsultarProdutoDataResponse;
  end;

  { TACBrLogmeConsultarProdutoResponse }

  TACBrLogmeConsultarProdutoResponse = class(TInterfacedObject, IACBrLogmeConsultarProdutoResponse)
  private
    fsuccess: Boolean;
    fdata: TACBrLogmeConsultarProdutoDataResponse;
  public
    destructor Destroy; override;
    procedure LoadJson(aJson: String);
    function ToJson: String;

    function success: Boolean;
    function data: TACBrLogmeConsultarProdutoDataResponse;
  end;

  { TACBrLogme }
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrLogme = class(TACBrHTTP)
  private
    fConsultarLoteRequest: TACBrLogmeConsultarLote;
    fConsultarProdutoRequest: TACBrLogmeConsultarProduto;
    fToken: String;
    function GetConsultarLoteRequest: TACBrLogmeConsultarLote;
    function GetConsultarProdutoRequest: TACBrLogmeConsultarProduto;
    function RespostaTratada: AnsiString;
  protected
    procedure PrepararHTTP;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;

    function ConsultarLote(out aResponse: IACBrLogmeConsultarLoteResponse): Boolean;
    function ConsultarProduto(out aResponse: IACBrLogmeConsultarProdutoResponse): Boolean;

    property ConsultarLoteRequest: TACBrLogmeConsultarLote read GetConsultarLoteRequest;
    property ConsultarProdutoRequest: TACBrLogmeConsultarProduto read GetConsultarProdutoRequest;
  published
    property Token: String read fToken write fToken;
  end;

  function LogmeTipoDestinatarioToStr(const ATipo: TACBrLogmeTipoDestinatario): String;
  function LogmeStrToTipoDestinatario(const AValue: String): TACBrLogmeTipoDestinatario;
  function LogmeRegimeTributarioRemetenteToStr(const AValue: TACBrLogmeRegimeTributarioRemetente): String;
  function LogmeStrToRegimeTributarioRemetente(const AValue: String): TACBrLogmeRegimeTributarioRemetente;

implementation

uses
  StrUtils, synautil,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

function LogmeTipoDestinatarioToStr(const ATipo: TACBrLogmeTipoDestinatario): String;
begin
  Result := IntToStr(Ord(ATipo));
end;

function LogmeStrToTipoDestinatario(const AValue: String): TACBrLogmeTipoDestinatario;
var
  n: Integer;
begin
  n := StrToIntDef(Trim(AValue), 0);
  case n of
    1: Result := ltdConsumidorFinal;
    2: Result := ltdDistribuicao;
  else
    Result := ltdNenhum;
  end;
end;

function LogmeRegimeTributarioRemetenteToStr(const AValue: TACBrLogmeRegimeTributarioRemetente): String;
begin
  Result := IntToStr(Ord(AValue));
end;

function LogmeStrToRegimeTributarioRemetente(const AValue: String): TACBrLogmeRegimeTributarioRemetente;
var
  n: Integer;
begin
  n := StrToIntDef(Trim(AValue), 0);
  case n of
    1: Result := lrmSimplesNacional;
    2: Result := lrmLucroReal;
    3: Result := lrmLucroPresumido;
    4: Result := lrmArbitrario;
    5: Result := lrmEspecial;
    6: Result := lrmPublico;
  else
    Result := lrmNenhum;
  end;
end;

{ TACBrLogmeProduto }

procedure TACBrLogmeProduto.AssignSchema(aSource: TACBrAPISchema);
begin
  if Assigned(aSource) and (aSource is TACBrLogmeProduto) then
    Assign(TACBrLogmeProduto(aSource));
end;

procedure TACBrLogmeProduto.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  if not Assigned(aJSon) then
    Exit;

  aJSon
    .AddPair('ean', fEAN, False)
    .AddPair('descricao', fDescricao, False);
end;

procedure TACBrLogmeProduto.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  if not Assigned(aJSon) then
    Exit;

  aJSon
    .Value('ean', fEAN)
    .Value('descricao', fDescricao);
end;

procedure TACBrLogmeProduto.Clear;
begin
  fEAN := EmptyStr;
  fDescricao := EmptyStr;
end;

function TACBrLogmeProduto.IsEmpty: Boolean;
begin
  Result := EstaVazio(fEAN) and EstaVazio(fDescricao);
end;

procedure TACBrLogmeProduto.Assign(Source: TACBrLogmeProduto);
begin
  if not Assigned(Source) then
    Exit;
  fEAN := Source.ean;
  fDescricao := Source.descricao;
end;

{ TACBrLogmeProdutos }

function TACBrLogmeProdutos.GetItem(Index: Integer): TACBrLogmeProduto;
begin
  Result := TACBrLogmeProduto(inherited Items[Index]);
end;

procedure TACBrLogmeProdutos.SetItem(Index: Integer; AValue: TACBrLogmeProduto);
begin
  inherited Items[Index] := AValue;
end;

function TACBrLogmeProdutos.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrLogmeProdutos.Add(aItem: TACBrLogmeProduto): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrLogmeProdutos.Insert(Index: Integer; aItem: TACBrLogmeProduto);
begin
  inherited Insert(Index, aItem);
end;

function TACBrLogmeProdutos.New: TACBrLogmeProduto;
begin
  Result := TACBrLogmeProduto.Create;
  Self.Add(Result);
end;

{ TACBrLogmeConsultarBase }

function TACBrLogmeConsultarBase.GetProdutos: TACBrLogmeProdutos;
begin
  if not Assigned(fProdutos) then
    fProdutos := TACBrLogmeProdutos.Create('produtos');
  Result := fProdutos;
end;

procedure TACBrLogmeConsultarBase.AssignSchema(aSource: TACBrAPISchema);
begin
  if Assigned(aSource) and (aSource is TACBrLogmeConsultarBase) then
    Assign(TACBrLogmeConsultarBase(aSource));
end;

procedure TACBrLogmeConsultarBase.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  if not Assigned(aJSon) then
    Exit;

  if (fTipoDestinatario <> ltdNenhum) then
    aJSon.AddPair('tipo_destinatario', LogmeTipoDestinatarioToStr(fTipoDestinatario));
  if NaoEstaVazio(fUFDestino) then
    aJSon.AddPair('uf_destino', fUFDestino);
  if Assigned(fProdutos) then
    fProdutos.WriteToJSon(aJSon);
end;

procedure TACBrLogmeConsultarBase.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  sTipo: String;
begin
  if not Assigned(aJSon) then
    Exit;

  sTipo := EmptyStr;
  aJSon
    .Value('tipo_destinatario', sTipo)
    .Value('uf_destino', fUFDestino);

  fTipoDestinatario := LogmeStrToTipoDestinatario(sTipo);
  produtos.ReadFromJSon(aJSon);
end;

destructor TACBrLogmeConsultarBase.Destroy;
begin
  if Assigned(fProdutos) then
    fProdutos.Free;
  inherited Destroy;
end;

procedure TACBrLogmeConsultarBase.Clear;
begin
  fTipoDestinatario := ltdNenhum;
  fUFDestino := EmptyStr;
  if Assigned(fProdutos) then
    fProdutos.Clear;
end;

function TACBrLogmeConsultarBase.IsEmpty: Boolean;
begin
  Result :=
    (fTipoDestinatario = ltdNenhum) and
    EstaVazio(fUFDestino) and
    ((not Assigned(fProdutos)) or (fProdutos.Count = 0));
end;

procedure TACBrLogmeConsultarBase.Assign(Source: TACBrLogmeConsultarBase);
begin
  if not Assigned(Source) then
    Exit;

  fTipoDestinatario := Source.tipo_destinatario;
  fUFDestino := Source.uf_destino;
  produtos.Assign(Source.produtos);
end;

{ TACBrLogmeConsultarLoteItemResponse }

procedure TACBrLogmeConsultarLoteItemResponse.AssignSchema(aSource: TACBrAPISchema);
begin
  if Assigned(aSource) and (aSource is TACBrLogmeConsultarLoteItemResponse) then
    Assign(TACBrLogmeConsultarLoteItemResponse(aSource));
end;

procedure TACBrLogmeConsultarLoteItemResponse.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  if not Assigned(aJSon) then
    Exit;

  aJSon
    .AddPair('ean', fEAN, False)
    .AddPair('descrição', fDescricao, False)
    .AddPair('ean vinculado', fEANVinculado, False)
    .AddPair('descrição vinculado', fDescricaoVinculado, False)
    .AddPair('uf_origem', fUFOrigem, False)
    .AddPair('uf_destino', fUFDestino, False)
    .AddPair('ncm', fNCM, False)
    .AddPair('cfop', fCFOP, False)
    .AddPair('cest', fCEST, False)
    .AddPair('cst', fCST, False)
    .AddPair('aliquota_icms', fAliquotaICMS, False)
    .AddPair('red_base_de_calculo_icms', fRedBaseDeCalculoICMS, False)
    .AddPair('red_base_de_calculo_icms_st', fRedBaseDeCalculoICMSST, False)
    .AddPair('icms_st_aliquota_interna', fICMSSTAliquotaInterna, False)
    .AddPair('mavast', fMAVAST, False)
    .AddPair('mava_aj_4', fMavaAj4, False)
    .AddPair('mava_aj_12', fMavaAj12, False)
    .AddPair('ipi', fIPI, False)
    .AddPair('cst_ipi', fCSTIPI, False)
    .AddPair('pis_cst', fPISCST, False)
    .AddPair('aliquota_pis', fAliquotaPIS, False)
    .AddPair('cofins_cst', fCOFINSCST, False)
    .AddPair('aliquota_cofins', fAliquotaCOFINS, False)
    .AddPair('mensagem', fMensagem, False);

  if (fRegimeTributarioRemetente <> lrmNenhum) then
    aJSon.AddPair('regime_tributario_remetente', LogmeRegimeTributarioRemetenteToStr(fRegimeTributarioRemetente));
  if (fTipoDestinatario <> ltdNenhum) then
    aJSon.AddPair('tipo_destinatario', LogmeTipoDestinatarioToStr(fTipoDestinatario));
end;

procedure TACBrLogmeConsultarLoteItemResponse.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  sTipo, sRegime, sAliquotaCOFINS, sAliquotaPIS: String;
  sRedBaseDeCalculoICMSST, sRedBaseDeCalculoICMS, sAliquotaICMS: String;
  sIPI, sMavaAj12, sMavaAj4, sMAVAST, sICMSSTAliquotaInterna: String;
begin
  if not Assigned(aJSon) then
    Exit;

  sTipo := EmptyStr;
  sRegime := EmptyStr;
  sAliquotaICMS := EmptyStr;
  sRedBaseDeCalculoICMS := EmptyStr;
  sICMSSTAliquotaInterna := EmptyStr;
  sICMSSTAliquotaInterna := EmptyStr;
  sMAVAST := EmptyStr;
  sMavaAj4 := EmptyStr;
  sMavaAj12 := EmptyStr;
  sIPI := EmptyStr;
  sAliquotaPIS := EmptyStr;
  sAliquotaCOFINS := EmptyStr;
  sRedBaseDeCalculoICMSST := EmptyStr;
  aJSon
    .Value('ean', fEAN)
    .Value('descrição', fDescricao)
    .Value('ean vinculado', fEANVinculado)
    .Value('descrição vinculado', fDescricaoVinculado)
    .Value('regime_tributario_remetente', sRegime)
    .Value('tipo_destinatario', sTipo)
    .Value('uf_origem', fUFOrigem)
    .Value('uf_destino', fUFDestino)
    .Value('ncm', fNCM)
    .Value('cfop', fCFOP)
    .Value('cest', fCEST)
    .Value('cst', fCST)
    .Value('aliquota_icms', sAliquotaICMS)
    .Value('red_base_de_calculo_icms', sRedBaseDeCalculoICMS)
    .Value('red_base_de_calculo_icms_st', sRedBaseDeCalculoICMSST)
    .Value('icms_st_aliquota_interna', sICMSSTAliquotaInterna)
    .Value('mavast', sMAVAST)
    .Value('mava_aj_4', sMavaAj4)
    .Value('mava_aj_12', sMavaAj12)
    .Value('ipi', sIPI)
    .Value('cst_ipi', fCSTIPI)
    .Value('pis_cst', fPISCST)
    .Value('aliquota_pis', sAliquotaPIS)
    .Value('cofins_cst', fCOFINSCST)
    .Value('aliquota_cofins', sAliquotaCOFINS)
    .Value('mensagem', fMensagem);

  if NaoEstaVazio(sAliquotaICMS) then
    fAliquotaICMS := StrToFloatDef(sAliquotaICMS, 0);
  if NaoEstaVazio(sRedBaseDeCalculoICMS) then
    fRedBaseDeCalculoICMS := StrToFloatDef(sRedBaseDeCalculoICMS, 0);
  if NaoEstaVazio(sICMSSTAliquotaInterna) then
    fICMSSTAliquotaInterna := StrToFloatDef(sICMSSTAliquotaInterna, 0);
  if NaoEstaVazio(sICMSSTAliquotaInterna) then
    fICMSSTAliquotaInterna := StrToFloatDef(sICMSSTAliquotaInterna, 0);
  if NaoEstaVazio(sMAVAST) then
    fMAVAST := StrToFloatDef(sMAVAST, 0);
  if NaoEstaVazio(sMavaAj4) then
    fMavaAj4 := StrToFloatDef(sMavaAj4, 0);
  if NaoEstaVazio(sMavaAj12) then
    fMavaAj12 := StrToFloatDef(sMavaAj12, 0);
  if NaoEstaVazio(sIPI) then
    fIPI := StrToFloatDef(sIPI, 0);
  if NaoEstaVazio(sAliquotaPIS) then
    fAliquotaPIS := StrToFloatDef(sAliquotaPIS, 0);
  if NaoEstaVazio(sAliquotaCOFINS) then
    fAliquotaCOFINS := StrToFloatDef(sAliquotaCOFINS, 0);
  if NaoEstaVazio(sRedBaseDeCalculoICMSST) then
    fRedBaseDeCalculoICMSST := StrToFloatDef(sRedBaseDeCalculoICMSST, 0);

  fTipoDestinatario := LogmeStrToTipoDestinatario(sTipo);
  fRegimeTributarioRemetente := LogmeStrToRegimeTributarioRemetente(sRegime);
end;

{ TACBrLogmeConsultarProdutoItemResponse }

procedure TACBrLogmeConsultarProdutoItemResponse.AssignSchema(aSource: TACBrAPISchema);
begin
  if Assigned(aSource) and (aSource is TACBrLogmeConsultarProdutoItemResponse) then
    Assign(TACBrLogmeConsultarProdutoItemResponse(aSource));
end;

procedure TACBrLogmeConsultarProdutoItemResponse.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  if not Assigned(aJSon) then
    Exit;

  aJSon
    .AddPair('ean', fEAN, False)
    .AddPair('descrição', fDescricao, False)
    .AddPair('marca', fMarca, False)
    .AddPair('embalagem', fEmbalagem, False)
    .AddPair('quantidade_embalagem', fQuantidadeEmbalagem, False)
    .AddPair('peso', fPeso, False)
    .AddPair('imagem', fImagem, False)
    .AddPair('erro', fErro, False);
end;

procedure TACBrLogmeConsultarProdutoItemResponse.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  sPeso, sQtd: String;
begin
  if not Assigned(aJSon) then
    Exit;

  sPeso := EmptyStr;
  sQtd := EmptyStr;
  aJSon
    .Value('ean', fEAN)
    .Value('descrição', fDescricao)
    .Value('marca', fMarca)
    .Value('embalagem', fEmbalagem)
    .Value('quantidade_embalagem', sQtd)
    .Value('peso', sPeso)
    .Value('imagem', fImagem)
    .Value('erro', fErro);

  if NaoEstaVazio(sPeso) then
    fPeso := StrToFloatDef(sPeso, 0);
  if NaoEstaVazio(sQtd) then
    fQuantidadeEmbalagem := StrToFloatDef(sQtd, 0);
end;

procedure TACBrLogmeConsultarProdutoItemResponse.Clear;
begin
  fEAN := EmptyStr;
  fDescricao := EmptyStr;
  fMarca := EmptyStr;
  fEmbalagem := EmptyStr;
  fQuantidadeEmbalagem := 0;
  fPeso := 0;
  fImagem := EmptyStr;
  fErro := EmptyStr;
end;

function TACBrLogmeConsultarProdutoItemResponse.IsEmpty: Boolean;
begin
  Result :=
    EstaVazio(fEAN) and
    EstaVazio(fDescricao) and
    EstaVazio(fMarca) and
    EstaVazio(fEmbalagem) and
    EstaZerado(fQuantidadeEmbalagem) and
    EstaZerado(fPeso) and
    EstaVazio(fImagem) and
    EstaVazio(fErro);
end;

procedure TACBrLogmeConsultarProdutoItemResponse.Assign(Source: TACBrLogmeConsultarProdutoItemResponse);
begin
  if not Assigned(Source) then
    Exit;

  fEAN := Source.ean;
  fDescricao := Source.descricao;
  fMarca := Source.marca;
  fEmbalagem := Source.embalagem;
  fQuantidadeEmbalagem := Source.quantidade_embalagem;
  fPeso := Source.peso;
  fImagem := Source.imagem;
  fErro := Source.erro;
end;

{ TACBrLogmeConsultarProdutoDataResponse }

function TACBrLogmeConsultarProdutoDataResponse.GetItem(Index: Integer): TACBrLogmeConsultarProdutoItemResponse;
begin
  Result := TACBrLogmeConsultarProdutoItemResponse(inherited Items[Index]);
end;

procedure TACBrLogmeConsultarProdutoDataResponse.SetItem(Index: Integer; AValue: TACBrLogmeConsultarProdutoItemResponse);
begin
  inherited Items[Index] := AValue;
end;

function TACBrLogmeConsultarProdutoDataResponse.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrLogmeConsultarProdutoDataResponse.Add(aItem: TACBrLogmeConsultarProdutoItemResponse): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrLogmeConsultarProdutoDataResponse.Insert(Index: Integer; aItem: TACBrLogmeConsultarProdutoItemResponse);
begin
  inherited Insert(Index, aItem);
end;

function TACBrLogmeConsultarProdutoDataResponse.New: TACBrLogmeConsultarProdutoItemResponse;
begin
  Result := TACBrLogmeConsultarProdutoItemResponse.Create;
  Self.Add(Result);
end;

{ TACBrLogmeConsultarProdutoResponse }

function TACBrLogmeConsultarProdutoResponse.success: Boolean;
begin
  Result := fsuccess;
end;

destructor TACBrLogmeConsultarProdutoResponse.Destroy;
begin
  if Assigned(fdata) then
    fdata.Free;
  inherited Destroy;
end;

procedure TACBrLogmeConsultarProdutoResponse.LoadJson(aJson: String);
var
  jo: TACBrJSONObject;
begin
  jo := TACBrJSONObject.Parse(aJson);
  try
    jo.Value('success', fsuccess);
    data.ReadFromJSon(jo);
  finally
    jo.Free;
  end;
end;

function TACBrLogmeConsultarProdutoResponse.ToJson: String;
var
  jo: TACBrJSONObject;
begin
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('success', fsuccess);
    if Assigned(fdata) then
      fdata.WriteToJSon(jo);
    Result := jo.ToJSON;
  finally
    jo.Free;
  end;
end;

function TACBrLogmeConsultarProdutoResponse.data: TACBrLogmeConsultarProdutoDataResponse;
begin
  if not Assigned(fdata) then
    fdata := TACBrLogmeConsultarProdutoDataResponse.Create('data');
  Result := fdata;
end;

procedure TACBrLogmeConsultarLoteItemResponse.Clear;
begin
  fEAN := EmptyStr;
  fDescricao := EmptyStr;
  fEANVinculado := EmptyStr;
  fDescricaoVinculado := EmptyStr;
  fRegimeTributarioRemetente := lrmNenhum;
  fTipoDestinatario := ltdNenhum;
  fUFOrigem := EmptyStr;
  fUFDestino := EmptyStr;
  fNCM := EmptyStr;
  fCFOP := EmptyStr;
  fCEST := EmptyStr;
  fCST := EmptyStr;
  fAliquotaICMS := 0;
  fRedBaseDeCalculoICMS := 0;
  fRedBaseDeCalculoICMSST := 0;
  fICMSSTAliquotaInterna := 0;
  fMAVAST := 0;
  fMavaAj4 := 0;
  fMavaAj12 := 0;
  fIPI := 0;
  fCSTIPI := EmptyStr;
  fPISCST := EmptyStr;
  fAliquotaPIS := 0;
  fCOFINSCST := EmptyStr;
  fAliquotaCOFINS := 0;
  fMensagem := EmptyStr;
end;

function TACBrLogmeConsultarLoteItemResponse.IsEmpty: Boolean;
begin
  Result :=
    EstaVazio(fEAN) and
    EstaVazio(fDescricao) and
    EstaVazio(fEANVinculado) and
    EstaVazio(fDescricaoVinculado) and
    (fRegimeTributarioRemetente = lrmNenhum) and
    (fTipoDestinatario = ltdNenhum) and
    EstaVazio(fUFOrigem) and
    EstaVazio(fUFDestino) and
    EstaVazio(fNCM) and
    EstaVazio(fCFOP) and
    EstaVazio(fCEST) and
    EstaVazio(fCST) and
    EstaZerado(fAliquotaICMS) and
    EstaZerado(fRedBaseDeCalculoICMS) and
    EstaZerado(fRedBaseDeCalculoICMSST) and
    EstaZerado(fICMSSTAliquotaInterna) and
    EstaZerado(fMAVAST) and
    EstaZerado(fMavaAj4) and
    EstaZerado(fMavaAj12) and
    EstaZerado(fIPI) and
    EstaVazio(fCSTIPI) and
    EstaVazio(fPISCST) and
    EstaZerado(fAliquotaPIS) and
    EstaVazio(fCOFINSCST) and
    EstaZerado(fAliquotaCOFINS) and
    EstaVazio(fMensagem);
end;

procedure TACBrLogmeConsultarLoteItemResponse.Assign(Source: TACBrLogmeConsultarLoteItemResponse);
begin
  if not Assigned(Source) then
    Exit;

  fEAN := Source.ean;
  fDescricao := Source.descricao;
  fEANVinculado := Source.eanVinculado;
  fDescricaoVinculado := Source.descricaoVinculado;
  fRegimeTributarioRemetente := Source.regime_tributario_remetente;
  fTipoDestinatario := Source.tipo_destinatario;
  fUFOrigem := Source.uf_origem;
  fUFDestino := Source.uf_destino;
  fNCM := Source.ncm;
  fCFOP := Source.cfop;
  fCEST := Source.cest;
  fCST := Source.cst;
  fAliquotaICMS := Source.aliquota_icms;
  fRedBaseDeCalculoICMS := Source.red_base_de_calculo_icms;
  fRedBaseDeCalculoICMSST := Source.red_base_de_calculo_icms_st;
  fICMSSTAliquotaInterna := Source.icms_st_aliquota_interna;
  fMAVAST := Source.mavast;
  fMavaAj4 := Source.mava_aj_4;
  fMavaAj12 := Source.mava_aj_12;
  fIPI := Source.ipi;
  fCSTIPI := Source.cst_ipi;
  fPISCST := Source.pis_cst;
  fAliquotaPIS := Source.aliquota_pis;
  fCOFINSCST := Source.cofins_cst;
  fAliquotaCOFINS := Source.aliquota_cofins;
  fMensagem := Source.mensagem;
end;

{ TACBrLogmeConsultarLoteDataResponse }

function TACBrLogmeConsultarLoteDataResponse.GetItem(Index: Integer): TACBrLogmeConsultarLoteItemResponse;
begin
  Result := TACBrLogmeConsultarLoteItemResponse(inherited Items[Index]);
end;

procedure TACBrLogmeConsultarLoteDataResponse.SetItem(Index: Integer; AValue: TACBrLogmeConsultarLoteItemResponse);
begin
  inherited Items[Index] := AValue;
end;

function TACBrLogmeConsultarLoteDataResponse.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrLogmeConsultarLoteDataResponse.Add(aItem: TACBrLogmeConsultarLoteItemResponse): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrLogmeConsultarLoteDataResponse.Insert(Index: Integer; aItem: TACBrLogmeConsultarLoteItemResponse);
begin
  inherited Insert(Index, aItem);
end;

function TACBrLogmeConsultarLoteDataResponse.New: TACBrLogmeConsultarLoteItemResponse;
begin
  Result := TACBrLogmeConsultarLoteItemResponse.Create;
  Self.Add(Result);
end;

{ TACBrLogmeConsultarLoteResponse }

function TACBrLogmeConsultarLoteResponse.success: Boolean;
begin
  Result := fsuccess;
end;

destructor TACBrLogmeConsultarLoteResponse.Destroy;
begin
  if Assigned(fdata) then
    fdata.Free;
  inherited Destroy;
end;

procedure TACBrLogmeConsultarLoteResponse.LoadJson(aJson: String);
var
  jo: TACBrJSONObject;
begin
  jo := TACBrJSONObject.Parse(aJson);
  try
    jo.Value('success', fsuccess);
    data.ReadFromJSon(jo);
  finally
    jo.Free;
  end;
end;

function TACBrLogmeConsultarLoteResponse.ToJson: String;
var
  jo: TACBrJSONObject;
begin
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('success', fsuccess);
    if Assigned(fdata) then
      fdata.WriteToJSon(jo);
    Result := jo.ToJSON;
  finally
    jo.Free;
  end;
end;

function TACBrLogmeConsultarLoteResponse.data: TACBrLogmeConsultarLoteDataResponse;
begin
  if not Assigned(fdata) then
    fdata := TACBrLogmeConsultarLoteDataResponse.Create('data');
  Result := fdata;
end;

{ TACBrLogme }

function TACBrLogme.GetConsultarLoteRequest: TACBrLogmeConsultarLote;
begin
  if (not Assigned(fConsultarLoteRequest)) then
    fConsultarLoteRequest := TACBrLogmeConsultarLote.Create;
  Result := fConsultarLoteRequest;
end;

function TACBrLogme.GetConsultarProdutoRequest: TACBrLogmeConsultarProduto;
begin
  if (not Assigned(fConsultarProdutoRequest)) then
    fConsultarProdutoRequest := TACBrLogmeConsultarProduto.Create;
  Result := fConsultarProdutoRequest;
end;

function TACBrLogme.RespostaTratada: AnsiString;
begin
  Result := UTF8ToNativeString(HTTPResponse);
end;

procedure TACBrLogme.PrepararHTTP;
begin
  //RespostaErro.Clear;
  RegistrarLog('PrepararHTTP', 3);
  LimparHTTP;
end;

constructor TACBrLogme.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Clear;
end;

destructor TACBrLogme.Destroy;
begin
  if Assigned(fConsultarLoteRequest) then
    fConsultarLoteRequest.Free;
  inherited Destroy;
end;

procedure TACBrLogme.Clear;
begin
  if Assigned(fConsultarLoteRequest) then
    fConsultarLoteRequest.Clear;
end;

function TACBrLogme.ConsultarLote(out aResponse: IACBrLogmeConsultarLoteResponse): Boolean;
begin
  Result := False;
  if ConsultarLoteRequest.IsEmpty then
    raise EACBrAPIException.Create(ACBrStr(Format(sErroObjetoNaoPrenchido, ['ConsultarLoteRequest'])));
  
  aResponse := TACBrLogmeConsultarLoteResponse.Create;
  PrepararHTTP;
  HttpSend.Protocol := '1.1';
  HttpSend.MimeType := cContentTypeApplicationJSon;
  HTTPSend.Headers.Add('Accept: */*');
  HTTPSend.Headers.Add(cHTTPHeaderAuthorization + ' ' + cHTTPAuthorizationBearer + ' ' + Token);
  URLPathParams.Add(cACBrLogmeEndpointProdutos);
  URLPathParams.Add(cACBrLogmeEndpointConsultarLote);

  WriteStrToStream(HTTPSend.Document, ConsultarLoteRequest.AsJSON);
  ConsultarLoteRequest.Clear;

  HTTPMethod(cHTTPMethodGET, cACBrLogmeURL);
  Result := (HTTPResultCode = HTTP_OK);
  if Result then
    aResponse.LoadJson(RespostaTratada);
end;

function TACBrLogme.ConsultarProduto(out aResponse: IACBrLogmeConsultarProdutoResponse): Boolean;
begin
  Result := False;
  aResponse := TACBrLogmeConsultarProdutoResponse.Create;
  PrepararHTTP;
  HttpSend.Protocol := '1.1';
  HttpSend.MimeType := cContentTypeApplicationJSon;
  HTTPSend.Headers.Add('Accept: */*');
  HTTPSend.Headers.Add(cHTTPHeaderAuthorization + ' ' + cHTTPAuthorizationBearer + ' ' + Token);
  URLPathParams.Add(cACBrLogmeEndpointProdutos);
  URLPathParams.Add(cACBrLogmeEndpointConsultarProduto);

  WriteStrToStream(HTTPSend.Document, ConsultarProdutoRequest.AsJSON);
  ConsultarProdutoRequest.Clear;

  HTTPMethod(cHTTPMethodGET, cACBrLogmeURL);
  Result := (HTTPResultCode = HTTP_OK);
  if Result then
    aResponse.LoadJson(RespostaTratada);
end;

end. 
