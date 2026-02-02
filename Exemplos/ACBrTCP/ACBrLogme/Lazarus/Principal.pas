unit Principal;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, Spin, Grids,
  {$IfNDef FPC}ACBrBase,{$EndIf}
  ACBrSocket, ACBrLogme;

const
  CURL_ACBR = 'https://projetoacbr.com.br';
  cRequestExample = 'SaneamentoRequest_Exemplo.txt';

type

  { TfrPrincipal }

  TfrPrincipal = class(TForm)
    ACBrLogme1: TACBrLogme;
    btConfigCancelar: TSpeedButton;
    btConfigLogArq: TSpeedButton;
    btConfigProxySenha: TSpeedButton;
    btConfigSalvar: TSpeedButton;
    btConsultarLoteConsultar: TBitBtn;
    btConsultarProdutoConsultar: TBitBtn;
    btConsultarProdutoPreencher: TBitBtn;
    btConsultarLoteProdutosAdd: TButton;
    btConsultarProdutoAdd: TButton;
    btConsultarLoteProdutosLimpar: TButton;
    btConsultarLotePreencher: TBitBtn;
    btConsultarProdutoLimpar: TButton;
    btEndpointsLimparLog: TSpeedButton;
    cbConfigLogNivel: TComboBox;
    cbConsultarLoteTipoDestinatario: TComboBox;
    edConfigLogArq: TEdit;
    edConfigProxyHost: TEdit;
    edConfigProxyPorta: TSpinEdit;
    edConfigProxySenha: TEdit;
    edConfigProxyUsuario: TEdit;
    edConsultarProdutoDescricao: TEdit;
    edConsultarProdutoEAN: TEdit;
    edConsultarLoteUF: TEdit;
    edConsultarLoteProdutosDescricao: TEdit;
    edConsultarLoteProdutosEAN: TEdit;
    gbConfigLog: TGroupBox;
    gbConfigProxy: TGroupBox;
    gbConsultarProduto: TGroupBox;
    gbEndpointsLog: TGroupBox;
    gbConsultarLote: TGroupBox;
    gpConfigImendes: TGroupBox;
    ImageList1: TImageList;
    lbConfigToken: TLabel;
    lbConfigLogArq: TLabel;
    lbConfigLogNivel: TLabel;
    lbConfigProxyHost: TLabel;
    lbConfigProxyPorta: TLabel;
    lbConfigProxySenha: TLabel;
    lbConfigProxyUsuario: TLabel;
    lbConsultarProdutoDescricao: TLabel;
    lbConsultarProdutoEAN: TLabel;
    lbConsultarLoteUF: TLabel;
    lbConsultarLoteTipoDestinatario: TLabel;
    lbConsultarLoteProdutosDescricao: TLabel;
    lbConsultarLoteProdutosEAN: TLabel;
    mmConfigToken: TMemo;
    mmConsultarProdutoResponse: TMemo;
    mmLog: TMemo;
    mmConsultarLoteResponse: TMemo;
    pnConsultarLoteProdutos: TPanel;
    pnConsultarProdutoProdutos: TPanel;
    pnConsultarProduto: TPanel;
    pnConsultarLote: TPanel;
    pgEndpoints: TPageControl;
    pgImendes: TPageControl;
    pnConfig: TPanel;
    pnConfigIMendes: TPanel;
    pnConfigLog: TPanel;
    pnConfigProxy: TPanel;
    pnConfigRodape: TPanel;
    pnEndpointsLog: TPanel;
    sgConsultarLoteProdutos: TStringGrid;
    sgConsultarProdutoProdutos: TStringGrid;
    tsConsultarProduto: TTabSheet;
    tsConsultarLote: TTabSheet;
    tsEndpoints: TTabSheet;
    tsConfig: TTabSheet;
    procedure btConfigCancelarClick(Sender: TObject);
    procedure btConfigLogArqClick(Sender: TObject);
    procedure btConfigProxySenhaClick(Sender: TObject);
    procedure btConfigSalvarClick(Sender: TObject);
    procedure btConsultarLoteConsultarClick(Sender: TObject);
    procedure btConsultarLotePreencherClick(Sender: TObject);
    procedure btConsultarLoteProdutosAddClick(Sender: TObject);
    procedure btConsultarLoteProdutosLimparClick(Sender: TObject);
    procedure btConsultarProdutoAddClick(Sender: TObject);
    procedure btConsultarProdutoConsultarClick(Sender: TObject);
    procedure btConsultarProdutoLimparClick(Sender: TObject);
    procedure btConsultarProdutoPreencherClick(Sender: TObject);
    procedure btEndpointsLimparLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function NomeArquivoConfiguracao: String;
    function ConfiguracaoValida: Boolean;
    function FormatarJSON(const AJSON: String): String;

    procedure LerConfiguracao;
    procedure GravarConfiguracao;
    procedure AplicarConfiguracao;
    procedure SolicitarConfiguracao;

    procedure InicializarBitmaps;
    procedure InicializarComponentesDefault;
    procedure RegistrarLogTela(aMensagem: String);
  public

  end;

function f: integer;

var
  frPrincipal: TfrPrincipal;

implementation

uses 
  {$IfDef FPC}
   fpjson, jsonparser, jsonscanner,
  {$Else}
    {$IFDEF DELPHIXE6_UP}JSON,{$ENDIF}
  {$EndIf}
  IniFiles, synacode, TypInfo,
  ACBrUtil.Base,
  ACBrUtil.FilesIO;
     
  {$IfDef FPC}
    {$R *.lfm}
  {$Else}
    {$R *.dfm}
  {$EndIf}

  { TfrPrincipal }

procedure TfrPrincipal.FormCreate(Sender: TObject);
begin
  InicializarBitmaps;
  InicializarComponentesDefault;
  LerConfiguracao;
  if ConfiguracaoValida then
    pgImendes.ActivePage := tsEndpoints
  else
    pgImendes.ActivePage := tsConfig;
end;

function TfrPrincipal.NomeArquivoConfiguracao: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

procedure TfrPrincipal.LerConfiguracao;
var
  wIni: TIniFile;
  a: LongInt;
begin
  RegistrarLogTela('- LerConfiguracao: ' + NomeArquivoConfiguracao);
  wIni := TIniFile.Create(NomeArquivoConfiguracao);
  try
    mmConfigToken.Lines.Text := wIni.ReadString('Logme', 'Token', EmptyStr);

    edConfigProxyHost.Text := wIni.ReadString('Proxy', 'Host', EmptyStr);
    edConfigProxyPorta.Value := wIni.ReadInteger('Proxy', 'Porta', 0);
    edConfigProxyUsuario.Text := wIni.ReadString('Proxy', 'Usuario', EmptyStr);
    edConfigProxySenha.Text :=
      StrCrypt(DecodeBase64(wIni.ReadString('Proxy', 'Senha', EmptyStr)), CURL_ACBR);

    edConfigLogArq.Text := wIni.ReadString('Log', 'Arquivo', EmptyStr);
    cbConfigLogNivel.ItemIndex := wIni.ReadInteger('Log', 'Nivel', 0);
  finally
    wIni.Free;
  end;
  AplicarConfiguracao;
end;

procedure TfrPrincipal.GravarConfiguracao;
var
  wIni: TIniFile;
begin
  RegistrarLogTela('- GravarConfiguracao: ' + NomeArquivoConfiguracao);
  wIni := TIniFile.Create(NomeArquivoConfiguracao);
  try
    wIni.WriteString('Logme', 'Token', mmConfigToken.Lines.Text);

    wIni.WriteString('Proxy', 'Host', edConfigProxyHost.Text);
    wIni.WriteInteger('Proxy', 'Porta', edConfigProxyPorta.Value);
    wIni.WriteString('Proxy', 'Usuario', edConfigProxyUsuario.Text);
    wIni.WriteString('Proxy', 'Senha', EncodeBase64(StrCrypt(edConfigProxySenha.Text, CURL_ACBR)));

    wIni.WriteString('Log', 'Arquivo', edConfigLogArq.Text);
    wIni.WriteInteger('Log', 'Nivel', cbConfigLogNivel.ItemIndex);
  finally
    wIni.Free;
  end;
  AplicarConfiguracao;
end;

procedure TfrPrincipal.AplicarConfiguracao;
begin
  ACBrLogme1.Token := mmConfigToken.Lines.Text;

  ACBrLogme1.ProxyHost := edConfigProxyHost.Text;
  ACBrLogme1.ProxyPort := edConfigProxyPorta.Text;
  ACBrLogme1.ProxyUser := edConfigProxyUsuario.Text;
  ACBrLogme1.ProxyPass := edConfigProxySenha.Text;

  ACBrLogme1.ArqLOG := edConfigLogArq.Text;
  ACBrLogme1.NivelLog := cbConfigLogNivel.ItemIndex;
end;

procedure TfrPrincipal.SolicitarConfiguracao;
begin
  pgImendes.ActivePage := tsConfig;
  ShowMessage('Efetue a configuração do componente ACBrLogme');
  Abort;
end;

procedure TfrPrincipal.InicializarBitmaps;
begin
  ImageList1.GetBitmap(7, btConfigProxySenha.Glyph);
  ImageList1.GetBitmap(9, btConfigLogArq.Glyph);
  ImageList1.GetBitmap(10, btConfigSalvar.Glyph);
  ImageList1.GetBitmap(12, btConfigCancelar.Glyph);
  ImageList1.GetBitmap(18, btEndpointsLimparLog.Glyph);

  ImageList1.GetBitmap(29, btConsultarLotePreencher.Glyph);
  ImageList1.GetBitmap(8, btConsultarLoteConsultar.Glyph); 

  ImageList1.GetBitmap(29, btConsultarProdutoPreencher.Glyph);
  ImageList1.GetBitmap(8, btConsultarProdutoConsultar.Glyph);
end;

function TfrPrincipal.ConfiguracaoValida: Boolean;
begin
  Result := NaoEstaVazio(ACBrLogme1.Token);
end;

function TfrPrincipal.FormatarJSON(const AJSON: String): String;
{$IfDef FPC}
var
  jpar: TJSONParser;
  jdata: TJSONData;
  ms: TMemoryStream;
{$ELSE}
  {$IFDEF DELPHIXE6_UP}
  var
    wJsonValue: TJSONValue;
  {$ENDIF}
{$ENDIF}
begin
  Result := AJSON;
  try
    {$IFDEF FPC}
    ms := TMemoryStream.Create;
    try
      ms.Write(Pointer(AJSON)^, Length(AJSON));
      ms.Position := 0;
      jpar := TJSONParser.Create(ms, [joUTF8]);
      jdata := jpar.Parse;
      if Assigned(jdata) then
        Result := jdata.FormatJSON;
    finally
      ms.Free;
      if Assigned(jpar) then
        jpar.Free;
      if Assigned(jdata) then
        jdata.Free;
    end;
    {$ELSE}
      {$IFDEF DELPHIXE6_UP}
      wJsonValue := TJSONObject.ParseJSONValue(AJSON);
      try
        if Assigned(wJsonValue) then
        begin
          Result := wJsonValue.Format(2);
        end;
      finally
        wJsonValue.Free;
      end;
      {$ENDIF}
    {$ENDIF}
  except
    Result := AJSON;
  end;
end;

procedure TfrPrincipal.InicializarComponentesDefault;
var
  i: TACBrLogmeTipoDestinatario;
begin
  cbConsultarLoteTipoDestinatario.Items.Clear;
  for i := Low(TACBrLogmeTipoDestinatario) to High(TACBrLogmeTipoDestinatario) do
    cbConsultarLoteTipoDestinatario.Items.Add(GetEnumName(TypeInfo(TACBrLogmeTipoDestinatario), Integer(i)));

  //if EstaVazio(edConfigCNPJ.Text) or EstaVazio(edConfigSenha.Text) then
  //  pgImendes.ActivePage := tsConfig
  //else
  //begin
  //  pgImendes.ActivePage := tsEndpoints;
  //  pgEndpoints.ActivePage := tsConsultarLote;
  //end;
end;

procedure TfrPrincipal.RegistrarLogTela(aMensagem: String);
begin
  mmLog.Lines.Add(aMensagem);
end;

procedure TfrPrincipal.btConfigProxySenhaClick(Sender: TObject);
begin
  {$IfDef FPC}
  if btConfigProxySenha.Down then
    edConfigProxySenha.EchoMode := emNormal
  else
    edConfigProxySenha.EchoMode := emPassword;
  {$Else}
  if btConfigProxySenha.Down then
    edConfigProxySenha.PasswordChar := #0
  else
    edConfigProxySenha.PasswordChar := '*';
  {$EndIf}
end;

procedure TfrPrincipal.btConfigSalvarClick(Sender: TObject);
begin
  GravarConfiguracao;
end;

procedure TfrPrincipal.btConsultarLoteConsultarClick(Sender: TObject);
var
  response: IACBrLogmeConsultarLoteResponse;
  i: Integer;
begin 
  if (not ConfiguracaoValida) then
    SolicitarConfiguracao;

  if (sgConsultarLoteProdutos.RowCount = 1) then
  begin
    ShowMessage('Inclua produtos para consultar!');
    Exit;
  end;

  ACBrLogme1.ConsultarLoteRequest.uf_destino := edConsultarLoteUF.Text;
  ACBrLogme1.ConsultarLoteRequest.tipo_destinatario := TACBrLogmeTipoDestinatario(cbConsultarLoteTipoDestinatario.ItemIndex);
  for i := 1 to sgConsultarLoteProdutos.RowCount - 1 do
  begin
    with ACBrLogme1.ConsultarLoteRequest.produtos.New do
    begin
      ean := sgConsultarLoteProdutos.Cells[0, i];
      descricao := sgConsultarLoteProdutos.Cells[1, i];
    end;
  end;

  if ACBrLogme1.ConsultarLote(response) then
    mmConsultarLoteResponse.Lines. Text := FormatarJSON(response.ToJson)
  else
    RegistrarLogTela('Erro ao consultar');
end;

procedure TfrPrincipal.btConsultarLotePreencherClick(Sender: TObject);
begin
  cbConsultarLoteTipoDestinatario.ItemIndex := 1;
  edConsultarLoteUF.Text := 'SP';

  {$IfDef FPC}
  sgConsultarLoteProdutos.ClearRows;
  {$EndIf}
  sgConsultarLoteProdutos.RowCount := 2;
  sgConsultarLoteProdutos.Cells[0, 0] := 'EAN';
  sgConsultarLoteProdutos.Cells[1, 0] := 'Descricao';
  sgConsultarLoteProdutos.Cells[0, 1] := '7894900011609';
  sgConsultarLoteProdutos.Cells[1, 1] := 'REFRIGERANTE COCA-COLA GARRAFA 600ML';
end;

procedure TfrPrincipal.btConsultarLoteProdutosAddClick(Sender: TObject);
var
  i: Integer;
begin
  i := sgConsultarLoteProdutos.RowCount;
  sgConsultarLoteProdutos.RowCount := i+1;
  sgConsultarLoteProdutos.Cells[0, i] := edConsultarLoteProdutosEAN.Text;
  sgConsultarLoteProdutos.Cells[1, i] := edConsultarLoteProdutosDescricao.Text;
  edConsultarLoteProdutosEAN.Text := EmptyStr;
  edConsultarLoteProdutosDescricao.Text := EmptyStr;
end;

procedure TfrPrincipal.btConsultarLoteProdutosLimparClick(Sender: TObject);
begin
  {$IfDef FPC}
  sgConsultarLoteProdutos.ClearRows;
  {$EndIf}
  sgConsultarLoteProdutos.RowCount := 1;
  sgConsultarLoteProdutos.Cells[0, 0] := 'EAN';
  sgConsultarLoteProdutos.Cells[1, 0] := 'Descricao';
end;

procedure TfrPrincipal.btConsultarProdutoAddClick(Sender: TObject);
var
  i: Integer;
begin
  i := sgConsultarProdutoProdutos.RowCount;
  sgConsultarProdutoProdutos.RowCount := i+1;
  sgConsultarProdutoProdutos.Cells[0, i] := edConsultarProdutoEAN.Text;
  sgConsultarProdutoProdutos.Cells[1, i] := edConsultarProdutoDescricao.Text;
  edConsultarProdutoEAN.Text := EmptyStr;
  edConsultarProdutoDescricao.Text := EmptyStr;
end;

procedure TfrPrincipal.btConsultarProdutoConsultarClick(Sender: TObject);
var
  response: IACBrLogmeConsultarProdutoResponse;
  i: Integer;
begin
  if (not ConfiguracaoValida) then
    SolicitarConfiguracao;

  if (sgConsultarProdutoProdutos.RowCount = 1) then
  begin
    ShowMessage('Inclua produtos para consultar!');
    Exit;
  end;

  for i := 1 to sgConsultarProdutoProdutos.RowCount - 1 do
  begin
    with ACBrLogme1.ConsultarProdutoRequest.produtos.New do
    begin
      ean := sgConsultarProdutoProdutos.Cells[0, i];
      descricao := sgConsultarProdutoProdutos.Cells[1, i];
    end;
  end;

  if ACBrLogme1.ConsultarProduto(response) then
    mmConsultarProdutoResponse.Lines. Text := FormatarJSON(response.ToJson)
  else
    RegistrarLogTela('Erro ao consultar');
end;

procedure TfrPrincipal.btConsultarProdutoLimparClick(Sender: TObject);
begin
  {$IfDef FPC}
  sgConsultarProdutoProdutos.ClearRows;
  {$EndIf}
  sgConsultarProdutoProdutos.RowCount := 1;
  sgConsultarProdutoProdutos.Cells[0, 0] := 'EAN';
  sgConsultarProdutoProdutos.Cells[1, 0] := 'Descricao';
end;

procedure TfrPrincipal.btConsultarProdutoPreencherClick(Sender: TObject);
begin
  {$IfDef FPC}
  sgConsultarProdutoProdutos.ClearRows;
  {$EndIf}
  sgConsultarProdutoProdutos.RowCount := 2;
  sgConsultarProdutoProdutos.Cells[0, 0] := 'EAN';
  sgConsultarProdutoProdutos.Cells[1, 0] := 'Descricao';
  sgConsultarProdutoProdutos.Cells[0, 1] := '7894900011609';
  sgConsultarProdutoProdutos.Cells[1, 1] := 'REFRIGERANTE COCA-COLA GARRAFA 600ML';
end;

procedure TfrPrincipal.btEndpointsLimparLogClick(Sender: TObject);
begin
  mmLog.Clear;
end;

procedure TfrPrincipal.btConfigLogArqClick(Sender: TObject);
var
  wFileLog: String;
begin
  if EstaVazio(edConfigLogArq.Text) then
  begin
    MessageDlg('Arquivo de Log não informado', mtError, [mbOK], 0);
    Exit;
  end;

  if (Pos(PathDelim, edConfigLogArq.Text) = 0) then
    wFileLog := ApplicationPath + edConfigLogArq.Text
  else
    wFileLog := edConfigLogArq.Text;

  if (not FileExists(wFileLog)) then
    MessageDlg('Arquivo ' + wFileLog + ' não encontrado', mtError, [mbOK], 0)
  else
    OpenURL(wFileLog);
end;

procedure TfrPrincipal.btConfigCancelarClick(Sender: TObject);
begin

  LerConfiguracao;
end;

function f(): integer;
begin
  Result := 0;
end;

end.
