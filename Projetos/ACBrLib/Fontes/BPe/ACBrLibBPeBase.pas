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

unit ACBrLibBPeBase;

interface

uses
  Classes, SysUtils, Forms, ACBrUtil.FilesIO, synautil,
  ACBrLibComum, ACBrLibBPeDataModule, ACBrDFeException;

type
  { TACBrLibBPe }
  TACBrLibBPe = class(TACBrLib)
  private
    FBPeDM: TLibBPeDM;

    function SetRetornoBPeCarregadas(const NumBPe: Integer): Integer;
    function SetRetornoEventoCarregados(const NumEventos: Integer): Integer;
  protected
    procedure CriarConfiguracao(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    procedure Executar; Override;
  public
    constructor Create(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    destructor Destroy; override;

    property BPeDM: TLibBPeDM read FBPeDM;

    function CarregarXML(const eArquivoOuXML: PAnsiChar): Integer;
    function CarregarINI(const eArquivoOuINI: PAnsiChar): Integer;
    function ObterXml(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GravarXml(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
    function ObterIni(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GravarIni(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
    function CarregarEventoXML(const eArquivoOuXML: PAnsiChar): Integer;
    function CarregarEventoINI(const eArquivoOuINI: PAnsiChar): Integer;
    function LimparLista: Integer;
    function LimparListaEventos: Integer;
    function Assinar: Integer;
    function Validar: Integer;
    function ValidarRegrasdeNegocios(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function VerificarAssinatura(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ObterCertificados(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GetPath(ATipo: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GetPathEvento(ACodEvento: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function StatusServico(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Enviar(AImprimir: Boolean; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Consultar(const eChaveOuBPe: PAnsiChar; AExtrairEventos: Boolean; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Cancelar(const eChave, eJustificativa, eCNPJCPF: PAnsiChar; ALote: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function EnviarEvento(idLote: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function EnviarEmail(const ePara, eXmlBPe: PAnsiChar; const AEnviaPDF: Boolean; const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
    function EnviarEmailEvento(const ePara, eXmlEvento, eXmlBPe: PAnsiChar; const AEnviaPDF: Boolean; const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
    function Imprimir(const cImpressora: PAnsiChar; nNumCopias: Integer; bMostrarPreview: PAnsiChar): Integer;
    function ImprimirPDF: Integer;
    function SalvarPDF(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ImprimirEvento(const eArquivoXmlBPe, eArquivoXmlEvento: PAnsiChar): Integer;
    function ImprimirEventoPDF(const eArquivoXmlBPe, eArquivoXmlEvento: PAnsiChar): Integer;
    function SalvarEventoPDF(const eArquivoXmlBPe, eArquivoXmlEvento, sResposta: PAnsiChar; var esTamanho: Integer): Integer;
  end;

implementation

uses
  ACBrBPe, ACBrUtil.Base, ACBrUtil.Strings, ACBrDFeUtil, ACBrXmlBase,
  ACBrDfe.Conversao, ACBrBPeConversao,
  ACBrLibConsts, ACBrLibConfig, ACBrLibResposta,
  ACBrLibBPeConsts, ACBrLibBPeConfig,
  ACBrLibBPeRespostas, ACBrLibCertUtils;

{ TACBrLibBPe }

function TACBrLibBPe.SetRetornoBPeCarregadas(const NumBPe: Integer): Integer;
begin
  Result := SetRetorno(0, Format(SInfBPeCarregadas, [NumBPe]));
end;

function TACBrLibBPe.SetRetornoEventoCarregados(const NumEventos: Integer): Integer;
begin
  Result := SetRetorno(0, Format(SInfEventosCarregados, [NumEventos]));
end;

procedure TACBrLibBPe.CriarConfiguracao(ArqConfig: string; ChaveCrypt: ansistring);
begin
  fpConfig := TLibBPeConfig.Create(Self, ArqConfig, ChaveCrypt);
end;

procedure TACBrLibBPe.Executar;
begin
  inherited Executar;
  FBPeDM.AplicarConfiguracoes;
end;

constructor TACBrLibBPe.Create(ArqConfig: string; ChaveCrypt: ansistring);
begin
  inherited Create(ArqConfig, ChaveCrypt);

  FBPeDM := TLibBPeDM.Create(nil);
  FBPeDM.Lib := Self;
end;

destructor TACBrLibBPe.Destroy;
begin
  FBPeDM.Free;
  inherited Destroy;
end;

function TACBrLibBPe.CarregarXML(const eArquivoOuXML: PAnsiChar): Integer;
var
  EhArquivo: Boolean;
  ArquivoOuXml: String;
begin
  try
    ArquivoOuXml := ConverterStringEntrada(eArquivoOuXML);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_CarregarXML(' + ArquivoOuXml + ' )', logCompleto, True)
    else
      GravarLog('BPe_CarregarXML', logNormal);

    EhArquivo := StringEhArquivo(ArquivoOuXml);
    if EhArquivo then
      VerificarArquivoExiste(ArquivoOuXml);

    BPeDM.Travar;
    try
      if EhArquivo then
        BPeDM.ACBrBPe1.Bilhetes.LoadFromFile(ArquivoOuXml)
      else
        BPeDM.ACBrBPe1.Bilhetes.LoadFromString(ArquivoOuXml);

      Result := SetRetornoBPeCarregadas(BPeDM.ACBrBPe1.Bilhetes.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.CarregarINI(const eArquivoOuINI: PAnsiChar): Integer;
var
  ArquivoOuINI: String;
begin
  try
    ArquivoOuINI := ConverterStringEntrada(eArquivoOuINI);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_CarregarINI(' + ArquivoOuINI + ' )', logCompleto, True)
    else
      GravarLog('BPe_CarregarINI', logNormal);

    if StringEhArquivo(ArquivoOuINI) then
      VerificarArquivoExiste(ArquivoOuINI);

    BPeDM.Travar;
    try
      BPeDM.ACBrBPe1.Bilhetes.LoadFromIni(ArquivoOuINI);
      Result := SetRetornoBPeCarregadas(BPeDM.ACBrBPe1.Bilhetes.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ObterXml(AIndex: Integer; const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resposta: AnsiString;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_ObterXml(' + IntToStr(AIndex) + ' )', logCompleto, True)
    else
      GravarLog('BPe_ObterXml', logNormal);

    BPeDM.Travar;
    try
      if (BPeDM.ACBrBPe1.Bilhetes.Count < 1) or (AIndex < 0) or
        (AIndex >= BPeDM.ACBrBPe1.Bilhetes.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if EstaVazio(BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].XMLOriginal) then
        BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].GerarXML;

      Resposta := BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].XMLOriginal;
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.GravarXml(AIndex: Integer; const eNomeArquivo,
  ePathArquivo: PAnsiChar): Integer;
var
  ANomeArquivo, APathArquivo: String;
begin
  try
    ANomeArquivo := ConverterStringEntrada(eNomeArquivo);
    APathArquivo := ConverterStringEntrada(ePathArquivo);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_GravarXml(' + IntToStr(AIndex) + ',' + ANomeArquivo + ',' + APathArquivo + ' )', logCompleto, True)
    else
      GravarLog('BPe_GravarXml', logNormal);

    BPeDM.Travar;
    try
      if (BPeDM.ACBrBPe1.Bilhetes.Count < 1) or (AIndex < 0) or
        (AIndex >= BPeDM.ACBrBPe1.Bilhetes.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].GravarXML(ANomeArquivo, APathArquivo) then
        Result := SetRetorno(ErrOK)
      else
        Result := SetRetorno(ErrGerarXml);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ObterIni(AIndex: Integer; const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resposta: AnsiString;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_ObterIni(' + IntToStr(AIndex) + ' )', logCompleto, True)
    else
      GravarLog('BPe_ObterIni', logNormal);

    BPeDM.Travar;
    try
      if (BPeDM.ACBrBPe1.Bilhetes.Count < 1) or (AIndex < 0) or (AIndex >= BPeDM.ACBrBPe1.Bilhetes.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if EstaVazio(BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].XMLOriginal) then
        BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].GerarXML;

      Resposta := BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].GerarBPeIni;
      Resposta := ConverterStringSaida( Resposta );
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.GravarIni(AIndex: Integer; const eNomeArquivo,
  ePathArquivo: PAnsiChar): Integer;
var
  ABPeIni, ANomeArquivo, APathArquivo: String;
begin
  try
    ANomeArquivo := ConverterStringEntrada(eNomeArquivo);
    APathArquivo := ConverterStringEntrada(ePathArquivo);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_GravarIni(' + IntToStr(AIndex) + ',' + ANomeArquivo + ',' + APathArquivo + ' )', logCompleto, True)
    else
      GravarLog('BPe_GravarIni', logNormal);

    BPeDM.Travar;
    try
      if (BPeDM.ACBrBPe1.Bilhetes.Count < 1) or (AIndex < 0) or (AIndex >= BPeDM.ACBrBPe1.Bilhetes.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      ANomeArquivo := ExtractFileName(ANomeArquivo);

      if EstaVazio(ANomeArquivo) then
        raise EACBrLibException.Create(ErrExecutandoMetodo, 'Nome de arquivo não informado');

      if EstaVazio(APathArquivo) then
        APathArquivo := ExtractFilePath(ANomeArquivo);
      if EstaVazio(APathArquivo) then
        APathArquivo := BPeDM.ACBrBPe1.Configuracoes.Arquivos.PathSalvar;

      APathArquivo := PathWithDelim(APathArquivo);

      if EstaVazio(BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].XMLOriginal) then
        BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].GerarXML;

      ABPeIni := BPeDM.ACBrBPe1.Bilhetes.Items[AIndex].GerarBPeIni;
      if not DirectoryExists(APathArquivo) then
        ForceDirectories(APathArquivo);

      WriteToTXT(APathArquivo + ANomeArquivo, ABPeIni, False, False);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.CarregarEventoXML(const eArquivoOuXML: PAnsiChar): Integer;
var
  EhArquivo: Boolean;
  ArquivoOuXml: String;
begin
  try
    ArquivoOuXml := ConverterStringEntrada(eArquivoOuXML);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_CarregarEventoXML(' + ArquivoOuXml + ' )', logCompleto, True)
    else
      GravarLog('BPe_CarregarEventoXML', logNormal);

    EhArquivo := StringEhArquivo(ArquivoOuXml);
    if EhArquivo then
      VerificarArquivoExiste(ArquivoOuXml);

    BPeDM.Travar;
    try
      if EhArquivo then
        BPeDM.ACBrBPe1.EventoBPe.LerXML(ArquivoOuXml)
      else
        BPeDM.ACBrBPe1.EventoBPe.LerXMLFromString(ArquivoOuXml);

      Result := SetRetornoEventoCarregados(BPeDM.ACBrBPe1.EventoBPe.Evento.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.CarregarEventoINI(const eArquivoOuINI: PAnsiChar): Integer;
var
  ArquivoOuINI: String;
begin
  try
    ArquivoOuINI := ConverterStringEntrada(eArquivoOuINI);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_CarregarEventoINI(' + ArquivoOuINI + ' )', logCompleto, True)
    else
      GravarLog('BPe_CarregarEventoINI', logNormal);

    if StringEhArquivo(ArquivoOuINI) then
      VerificarArquivoExiste(ArquivoOuINI);

    BPeDM.Travar;
    try
      BPeDM.ACBrBPe1.EventoBPe.LerFromIni(ArquivoOuINI);
      Result := SetRetornoEventoCarregados(BPeDM.ACBrBPe1.EventoBPe.Evento.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.LimparLista: Integer;
begin
  try
    GravarLog('BPe_LimparLista', logNormal);

    BPeDM.Travar;
    try
      BPeDM.ACBrBPe1.Bilhetes.Clear;
      Result := SetRetornoBPeCarregadas(BPeDM.ACBrBPe1.Bilhetes.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.LimparListaEventos: Integer;
begin
  try
    GravarLog('BPe_LimparListaEventos', logNormal);

    BPeDM.Travar;
    try
      BPeDM.ACBrBPe1.EventoBPe.Evento.Clear;
      Result := SetRetornoEventoCarregados(BPeDM.ACBrBPe1.EventoBPe.Evento.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.Assinar: Integer;
begin
  try
    GravarLog('BPe_Assinar', logNormal);

    BPeDM.Travar;
    try
      try
        BPeDM.ACBrBPe1.Bilhetes.Assinar;
      except
        on E: EACBrBPeException do
          Result := SetRetorno(ErrAssinarBPe, ConverterStringSaida(E.Message));
      end;

      Result := SetRetornoBPeCarregadas(BPeDM.ACBrBPe1.Bilhetes.Count);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.Validar: Integer;
begin
  try
    GravarLog('BPe_Validar', logNormal);

    BPeDM.Travar;
    try
      try
        BPeDM.ACBrBPe1.Bilhetes.Validar;
        Result := SetRetornoBPeCarregadas(BPeDM.ACBrBPe1.Bilhetes.Count);
      except
        on E: EACBrBPeException do
          Result := SetRetorno(ErrValidacaoBPe, ConverterStringSaida(E.Message));
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ValidarRegrasdeNegocios(const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Erros: AnsiString;
begin
  try
    GravarLog('BPe_ValidarRegrasdeNegocios', logNormal);

    BPeDM.Travar;
    try
      Erros := '';
      BPeDM.ACBrBPe1.Bilhetes.ValidarRegrasdeNegocios(Erros);
      Erros := ConverterStringSaida(Erros);
      MoverStringParaPChar(Erros, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Erros);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.VerificarAssinatura(const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Erros: AnsiString;
begin
  try
    GravarLog('BPe_VerificarAssinatura', logNormal);

    BPeDM.Travar;
    try
      Erros := '';
      BPeDM.ACBrBPe1.Bilhetes.VerificarAssinatura(Erros);
      Erros := ConverterStringSaida(Erros);
      MoverStringParaPChar(Erros, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Erros);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ObterCertificados(const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resposta: AnsiString;
begin
  try
    GravarLog('BPe_ObterCertificados', logNormal);

    BPeDM.Travar;
    try
      Resposta := '';
      Resposta := ObterCerticados(BPeDM.ACBrBPe1.SSL);
      Resposta := ConverterStringSaida(Resposta);
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.GetPath(ATipo: Integer; const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resposta: AnsiString;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_GetPath(' + IntToStr(ATipo) + ' )', logCompleto, True)
    else
      GravarLog('BPe_GetPath', logNormal);

    BPeDM.Travar;
    try
      with BPeDM do
      begin
        Resposta := EmptyStr;
        case ATipo of
          0: Resposta := ACBrBPe1.Configuracoes.Arquivos.GetPathBPe();
          1: Resposta := ACBrBPe1.Configuracoes.Arquivos.GetPathEvento(teCancelamento);
        end;

        Resposta := ConverterStringSaida(Resposta);
        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.GetPathEvento(ACodEvento: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  CodEvento: String;
  Resposta: AnsiString;
  ok: Boolean;
begin
  try
    CodEvento := ConverterStringEntrada(ACodEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_GetPathEvento(' + CodEvento + ' )', logCompleto, True)
    else
      GravarLog('BPe_GetPathEvento', logNormal);

    BPeDM.Travar;
    try
      with BPeDM do
      begin
        Resposta := EmptyStr;
        Resposta := ACBrBPe1.Configuracoes.Arquivos.GetPathEvento(StrToTpEventoBPe(ok, CodEvento));
        Resposta := ConverterStringSaida(Resposta);
        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.StatusServico(const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resp: TStatusServicoResposta;
  Resposta: AnsiString;
begin
  try
    GravarLog('BPe_StatusServico', logNormal);

    BPeDM.Travar;
    try
      Resp := TStatusServicoResposta.Create(Config.TipoResposta, Config.CodResposta);
      try
        with BPeDM.ACBrBPe1 do
        begin
          WebServices.StatusServico.Executar;

          Resp.Processar(BPeDM.ACBrBPe1);
          Resposta := Resp.Gerar;
          MoverStringParaPChar(Resposta, sResposta, esTamanho);
          Result := SetRetorno(ErrOK, Resposta);
        end;
      finally
        Resp.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: EACBrDFeExceptionTimeOut do
      Result := SetRetorno(ErrTimeOut, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.Enviar(AImprimir: Boolean; const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resposta: AnsiString;
  RespEnvio: TEnvioResposta;
  ImpResp: TLibImpressaoResposta;
  i, ImpCount: Integer;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_Enviar(' + BoolToStr(AImprimir, ', Imprimir', '') + ' )', logCompleto, True)
    else
      GravarLog('BPe_Enviar', logNormal);

    BPeDM.Travar;
    try
      with BPeDM.ACBrBPe1 do
      begin
        if Bilhetes.Count <= 0 then
          raise EACBrLibException.Create(ErrEnvio, 'ERRO: Nenhuma BPe adicionada ao Lote');

        if Bilhetes.Count > 50 then
           raise EACBrLibException.Create(ErrEnvio, 'ERRO: Conjunto de BPe transmitidas (máximo de 50 BPe)' +
                                                    ' excedido. Quantidade atual: ' + IntToStr(Bilhetes.Count));

        GravarLog('BPe_Enviar, Limpando Resp', logParanoico);
        Resposta := '';
        WebServices.Enviar.Clear;

        GravarLog('BPe_Enviar, Assinando', logCompleto);
        Bilhetes.Assinar;

        try
          GravarLog('BPe_Enviar, Validando', logCompleto);
          Bilhetes.Validar;
        except
          on E: EACBrBPeException do
          begin
            Result := SetRetorno(ErrValidacaoBPe, ConverterStringSaida(E.Message));
            Exit;
          end;
        end;

        GravarLog('BPe_Enviar, Enviando', logCompleto);
        WebServices.Enviar.Executar;

        RespEnvio := TEnvioResposta.Create(Config.TipoResposta, Config.CodResposta);
        try
          GravarLog('BPe_Enviar, Proces.Resp Enviar', logParanoico);
          RespEnvio.Processar(BPeDM.ACBrBPe1);
          Resposta := RespEnvio.Gerar;
        finally
          RespEnvio.Free;
        end;

        if AImprimir then
        begin
          try
            BPeDM.ConfigurarImpressao;

            ImpCount := 0;
            for i := 0 to Bilhetes.Count - 1 do
            begin
              if Bilhetes.Items[i].Confirmada then
                begin
                  GravarLog('BPe_Enviar, Imprimindo BPe['+IntToStr(i+1)+'], '+Bilhetes.Items[i].BPe.infBPe.ID, logNormal);
                  Bilhetes.Items[i].Imprimir;
                  Inc(ImpCount);
                end;
            end;

            if ImpCount > 0 then
              begin
                ImpResp := TLibImpressaoResposta.Create(ImpCount, Config.TipoResposta, Config.CodResposta);
                try
                  GravarLog('BPe_Enviar, Proces.Resp Impressao', logParanoico);
                  Resposta := Resposta + sLineBreak + ImpResp.Gerar;
                finally
                  ImpResp.Free;
                end;
              end;
          finally
            BPeDM.FinalizarImpressao;
          end;
        end;

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: EACBrDFeExceptionTimeOut do
      Result := SetRetorno(ErrTimeOut, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.Consultar(const eChaveOuBPe: PAnsiChar;
  AExtrairEventos: Boolean; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  EhArquivo: Boolean;
  ChaveOuBPe: String;
  Resp: TConsultaBPeResposta;
  Resposta: AnsiString;
begin
  try
    ChaveOuBPe := ConverterStringSaida(eChaveOuBPe);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_Consultar(' + ChaveOuBPe + ',' + BoolToStr(AExtrairEventos, True) + ' )', logCompleto, True)
    else
      GravarLog('BPe_Consultar', logNormal);

    BPeDM.Travar;
    try
      EhArquivo := StringEhArquivo(ChaveOuBPe);

      if EhArquivo and not ValidarChave(ChaveOuBPe) then
      begin
        VerificarArquivoExiste(ChaveOuBPe);
        BPeDM.ACBrBPe1.Bilhetes.LoadFromFile(ChaveOuBPe);
      end;

      if BPeDM.ACBrBPe1.Bilhetes.Count = 0 then
      begin
        if ValidarChave(ChaveOuBPe) then
          BPeDM.ACBrBPe1.WebServices.Consulta.BPeChave := ChaveOuBPe
        else
          raise EACBrLibException.Create(ErrChaveBPe, Format(SErrChaveInvalida, [ChaveOuBPe]));
      end
      else
        BPeDM.ACBrBPe1.WebServices.Consulta.BPeChave := BPeDM.ACBrBPe1.Bilhetes.Items[BPeDM.ACBrBPe1.Bilhetes.Count - 1].NumID;

      BPeDM.ACBrBPe1.WebServices.Consulta.ExtrairEventos := AExtrairEventos;
      Resp := TConsultaBPeResposta.Create(Config.TipoResposta, Config.CodResposta);
      try
        with BPeDM.ACBrBPe1 do
        begin
          WebServices.Consulta.Executar;
          Resp.Processar(BPeDM.ACBrBPe1);

          Resposta := Resp.Gerar;
          MoverStringParaPChar(Resposta, sResposta, esTamanho);
          Result := SetRetorno(ErrOK, Resposta);
        end;
      finally
        Resp.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: EACBrDFeExceptionTimeOut do
      Result := SetRetorno(ErrTimeOut, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.Cancelar(const eChave, eJustificativa,
  eCNPJCPF: PAnsiChar; ALote: Integer; const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  AChave, AJustificativa, ACNPJCPF: String;
  Resp: TCancelamentoResposta;
  Resposta: AnsiString;
begin
  try
    AChave := ConverterStringEntrada(eChave);
    AJustificativa := ConverterStringEntrada(eJustificativa);
    ACNPJCPF := ConverterStringEntrada(eCNPJCPF);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_Cancelar(' + AChave + ',' + AJustificativa + ',' + ACNPJCPF + ',' + IntToStr(ALote) + ' )', logCompleto, True)
    else
      GravarLog('BPe_Cancelar', logNormal);

    BPeDM.Travar;
    try
      if not ValidarChave(AChave) then
        raise EACBrLibException.Create(ErrChaveBPe, Format(SErrChaveInvalida, [AChave]))
      else
        BPeDM.ACBrBPe1.WebServices.Consulta.BPeChave := AChave;

      if not BPeDM.ACBrBPe1.WebServices.Consulta.Executar then
        raise EACBrLibException.Create(ErrConsulta, BPeDM.ACBrBPe1.WebServices.Consulta.Msg);

      BPeDM.ACBrBPe1.EventoBPe.Evento.Clear;
      with BPeDM.ACBrBPe1.EventoBPe.Evento.New do
      begin
        InfEvento.CNPJ := ACNPJCPF;
        if Trim(Infevento.CNPJ) = '' then
          InfEvento.CNPJ := Copy(RemoverLiteralChave(BPeDM.ACBrBPe1.WebServices.Consulta.BPeChave), 7, 14)
        else
        begin
          if not ValidarCNPJouCPF(ACNPJCPF) then
            raise EACBrLibException.Create(ErrCNPJ, Format(SErrCNPJCPFInvalido, [ACNPJCPF]));
        end;

        InfEvento.nSeqEvento := 1;
        InfEvento.tpAmb := TACBrTipoAmbiente(BPeDM.ACBrBPe1.Configuracoes.WebServices.Ambiente);
        InfEvento.cOrgao := StrToIntDef(Copy(RemoverLiteralChave(BPeDM.ACBrBPe1.WebServices.Consulta.BPeChave), 1, 2), 0);
        InfEvento.dhEvento := Now;
        InfEvento.tpEvento := teCancelamento;
        InfEvento.chBPe := BPeDM.ACBrBPe1.WebServices.Consulta.BPeChave;
        InfEvento.detEvento.nProt := BPeDM.ACBrBPe1.WebServices.Consulta.Protocolo;
        InfEvento.detEvento.xJust := AJustificativa;
      end;

      if (ALote = 0) then
        ALote := 1;

      BPeDM.ACBrBPe1.WebServices.EnvEvento.idLote := ALote;
      BPeDM.ACBrBPe1.WebServices.EnvEvento.Executar;

      Resp := TCancelamentoResposta.Create(Config.TipoResposta, Config.CodResposta);
      try
        Resp.Processar(BPeDM.ACBrBPe1);
        Resposta := Resp.Gerar;
      finally
        Resp.Free;
      end;

      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: EACBrDFeExceptionTimeOut do
      Result := SetRetorno(ErrTimeOut, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.EnviarEvento(idLote: Integer;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  i, j: Integer;
  Resp: TEventoResposta;
  Resposta, chBPe: String;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_EnviarEvento(' + IntToStr(idLote) + ' )', logCompleto, True)
    else
      GravarLog('BPe_EnviarEvento', logNormal);

    BPeDM.Travar;
    try
      with BPeDM.ACBrBPe1 do
      begin
        if EventoBPe.Evento.Count = 0 then
          raise EACBrLibException.Create(ErrEnvioEvento, 'ERRO: Nenhum Evento adicionado ao Lote');

        if EventoBPe.Evento.Count > 20 then
          raise EACBrLibException.Create(ErrEnvioEvento,  'ERRO: Conjunto de Eventos transmitidos (máximo de 20) ' +
                                                          'excedido. Quantidade atual: ' + IntToStr(EventoBPe.Evento.Count));

        {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
        for i := 0 to EventoBPe.Evento.Count - 1 do
        begin
          if EventoBPe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
            EventoBPe.Evento.Items[i].InfEvento.nSeqEvento := 1;

          EventoBPe.Evento.Items[i].InfEvento.tpAmb := TACBrTipoAmbiente(Configuracoes.WebServices.Ambiente);

          if Bilhetes.Count > 0 then
          begin
           chBPe := RemoverLiteralChave(EventoBPe.Evento.Items[i].InfEvento.chBPe);

           // Se tem a chave da BPe no Evento, procure por ela nas notas carregadas //
            if NaoEstaVazio(chBPe) then
            begin
              for j := 0 to Bilhetes.Count - 1 do
              begin
                if chBPe = Bilhetes.Items[j].NumID then
                 Break;
              end;

              if j = Bilhetes.Count then
                raise EACBrLibException.Create(ErrEnvioEvento, 'Não existe BPe com a chave [' + chBPe + '] carregada');
            end
            else
             j := 0;

            if trim(EventoBPe.Evento.Items[i].InfEvento.CNPJ) = '' then
              EventoBPe.Evento.Items[i].InfEvento.CNPJ := Bilhetes.Items[j].BPe.Emit.CNPJ;

            if chBPe = '' then
              EventoBPe.Evento.Items[i].InfEvento.chBPe := Bilhetes.Items[j].NumID;

            if Trim(EventoBPe.Evento.Items[i].InfEvento.detEvento.nProt) = '' then
            begin
              if EventoBPe.Evento.Items[i].InfEvento.tpEvento = teCancelamento then
              begin
                EventoBPe.Evento.Items[i].InfEvento.detEvento.nProt := Bilhetes.Items[j].BPe.procBPe.nProt;

                if Trim(EventoBPe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
                begin
                  WebServices.Consulta.BPeChave := EventoBPe.Evento.Items[i].InfEvento.chBPe;

                  if not WebServices.Consulta.Executar then
                    raise EACBrLibException.Create(ErrEnvioEvento, WebServices.Consulta.Msg);

                  EventoBPe.Evento.Items[i].InfEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
                end;
              end;
            end;
           end;
        end;

        if (idLote = 0) then
           idLote := 1;

        WebServices.EnvEvento.idLote := idLote;
        WebServices.EnvEvento.Executar;
      end;

      Resp := TEventoResposta.Create(Config.TipoResposta, Config.CodResposta);
      try
        Resp.Processar(BPeDM.ACBrBPe1);
        Resposta := Resp.Gerar;
      finally
        Resp.Free;
      end;

      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: EACBrDFeExceptionTimeOut do
      Result := SetRetorno(ErrTimeOut, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.EnviarEmail(const ePara, eXmlBPe: PAnsiChar;
  const AEnviaPDF: Boolean; const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar
  ): Integer;
var
  Resposta, APara, AXmlBPe, AAssunto, ACC, AAnexos, AMensagem: String;
  slMensagemEmail, slCC, slAnexos: TStringList;
  EhArquivo, LXmlCarregado: Boolean;
  Resp: TLibBPeResposta;
  LBPeEnviar : TACBrBPe;
begin
  try
    APara := ConverterStringEntrada(ePara);
    AXmlBPe := ConverterStringEntrada(eXmlBPe);
    AAssunto := ConverterStringEntrada(eAssunto);
    ACC := ConverterStringEntrada(eCC);
    AAnexos := ConverterStringEntrada(eAnexos);
    AMensagem := ConverterStringEntrada(eMensagem);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_EnviarEmail(' + APara + ',' + AXmlBPe + ',' + BoolToStr(AEnviaPDF, 'PDF', '') + ',' + AAssunto + ',' + ACC + ',' + AAnexos + ',' + AMensagem + ' )', logCompleto, True)
    else
      GravarLog('BPe_EnviarEmail', logNormal);

    BPeDM.Travar;
    try
      LBPeEnviar := TACBrBPe.Create(BPeDM.ACBrBPe1);
      try
        if (AEnviaPDF) then
          BPeDM.ConfigurarImpressao('', True);

        LBPeEnviar.MAIL := BPeDM.ACBrMail1;
        LBPeEnviar.DABPe := BPeDM.ACBrBPe1.DABPe;

        EhArquivo := StringEhArquivo(AXmlBPe);

        if EhArquivo then
          VerificarArquivoExiste(AXmlBPe);

        if EhArquivo then
          LXmlCarregado := LBPeEnviar.Bilhetes.LoadFromFile(AXmlBPe)
        else
          LXmlCarregado := LBPeEnviar.Bilhetes.LoadFromString(AXmlBPe);

        if not LXmlCarregado then
          raise EACBrLibException.Create(ErrEnvio, 'Erro Caminho ou conteudo do XML inválido, não foi possível fazer a leitura do conteúdo do XML');

        if LBPeEnviar.Bilhetes.Count = 0 then
          raise EACBrLibException.Create(ErrEnvio, Format(SInfBPeCarregadas, [LBPeEnviar.Bilhetes.Count]))
        else
        begin
          slMensagemEmail := TStringList.Create;
          slCC := TStringList.Create;
          slAnexos := TStringList.Create;

          Resp := TLibBPeResposta.Create('EnviaEmail', Config.TipoResposta, Config.CodResposta);
          try
            slMensagemEmail.DelimitedText := sLineBreak;
            slMensagemEmail.Text := StringReplace(AMensagem, ';', sLineBreak, [rfReplaceAll]);

            slCC.DelimitedText := sLineBreak;
            slCC.Text := StringReplace(ACC, ';', sLineBreak, [rfReplaceAll]);

            slAnexos.DelimitedText := sLineBreak;
            slAnexos.Text := StringReplace(AAnexos, ';', sLineBreak, [rfReplaceAll]);

            LBPeEnviar.Bilhetes[0].EnviarEmail(
              APara,
              AAssunto,
              slMensagemEmail,
              AEnviaPDF, // Enviar PDF junto
              slCC,      // Lista com emails que serão enviado cópias - TStrings
              slAnexos); // Lista de slAnexos - TStrings

            Resp.Msg := 'Email enviado com sucesso';
            Resposta := Resp.Gerar;

            Result := SetRetorno(ErrOK, Resposta);
          finally
            Resp.Free;
            slCC.Free;
            slAnexos.Free;
            slMensagemEmail.Free;
            if (AEnviaPDF) then BPeDM.FinalizarImpressao;
          end;
        end;
      finally
        LBPeEnviar.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.EnviarEmailEvento(const ePara, eXmlEvento, eXmlBPe: PAnsiChar; const AEnviaPDF: Boolean;
  const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
var
  APara, AXmlEvento, AXmlBPe, AAssunto, ACC, AAnexos, AMensagem, ArqPDF: string;
  LNomeArq: string;
  LStream: TStream;
  slMensagemEmail, slCC, slAnexos: TStringList;
  EhArquivo: boolean;
  EhArquivoEvento: boolean;
  Resposta: TLibBPeResposta;
  LBPeEnviar : TACBrBPe;
begin
  try
    APara := ConverterStringEntrada(ePara);
    AXmlEvento := ConverterStringEntrada(eXmlEvento);
    AXmlBPe := ConverterStringEntrada(eXmlBPe);
    AAssunto := ConverterStringEntrada(eAssunto);
    ACC := ConverterStringEntrada(eCC);
    AAnexos := ConverterStringEntrada(eAnexos);
    AMensagem := ConverterStringEntrada(eMensagem);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_EnviarEmailEvento(' + APara + ',' + AXmlEvento + ',' + AXmlBPe + ',' +
                 BoolToStr(AEnviaPDF, 'PDF', '') + ',' + AAssunto + ',' + ACC + ',' + AAnexos + ',' + AMensagem +
                 ' )', logCompleto, True)
    else
      GravarLog('BPe_EnviarEmailEvento', logNormal);

    BPeDM.Travar;
    try
      LBPeEnviar := TACBrBPe.Create(nil);
      try
        with LBPeEnviar do
        begin
          EventoBPe.Evento.Clear;
          Bilhetes.Clear;

          EhArquivoEvento := StringEhArquivo(AXmlEvento);

          if EhArquivoEvento then
            VerificarArquivoExiste(AXmlEvento);

          if EhArquivoEvento then
            EventoBPe.LerXML(AXmlEvento)
          else
            EventoBPe.LerXMLFromString(AXmlEvento);

          EhArquivo := StringEhArquivo(AXmlBPe);

          if EhArquivo then
            VerificarArquivoExiste(AXmlBPe);

          if EhArquivo then
            Bilhetes.LoadFromFile(AXmlBPe)
          else
            Bilhetes.LoadFromString(AXmlBPe);

          if Bilhetes.Count <= 0 then
            raise EACBrLibException.Create(ErrEnvio, Format(SInfBPeCarregadas, [Bilhetes.Count]));

          if EventoBPe.Evento.Count = 0 then
            raise EACBrLibException.Create(ErrEnvio, Format(SInfEventosCarregados, [EventoBPe.Evento.Count]))
          else
          begin
            slMensagemEmail := TStringList.Create;
            slCC := TStringList.Create;
            slAnexos := TStringList.Create;
            Resposta := TLibBPeResposta.Create('EnviaEmail', Config.TipoResposta, Config.CodResposta);
            LStream := TMemoryStream.Create;

            try
              LNomeArq := RemoverLiteralChave(EventoBPe.Evento[0].Infevento.id) + '-procEventoBPe';

              if AEnviaPDF then
              begin
                try
                  BPeDM.ConfigurarImpressao('', True, '');
                  ImprimirEventoPDF;

                  ArqPDF := PathWithDelim(DABPe.PathPDF) + LNomeArq + '.pdf';
                except
                  raise EACBrLibException.Create(ErrRetorno, 'Erro ao criar o arquivo PDF');
                end;
              end;

              MAIL := BPeDM.ACBrMail1;
              with MAIL do
              begin
                slMensagemEmail.DelimitedText := sLineBreak;
                slMensagemEmail.Text := StringReplace(AMensagem, ';', sLineBreak, [rfReplaceAll]);

                slCC.DelimitedText := sLineBreak;
                slCC.Text := StringReplace(ACC, ';', sLineBreak, [rfReplaceAll]);

                slAnexos.DelimitedText := sLineBreak;
                slAnexos.Text := StringReplace(AAnexos, ';', sLineBreak, [rfReplaceAll]);

                if EhArquivoEvento then
                  slAnexos.Add(AXmlEvento)
                else
                begin
                  LNomeArq := LNomeArq + '.xml';
                  LStream.Size := 0;
                  WriteStrToStream(LStream, AnsiString(AXmlEvento));
                end;

                if AEnviaPDF then
                  slAnexos.Add(ArqPDF);

                try
                  if EhArquivoEvento then
                  begin
                    EnviarEmail(
                       APara,
                       AAssunto,
                       slMensagemEmail,
                       slCC,
                       slAnexos);
                  end
                  else
                  begin
                    EnviarEmail(
                       APara,
                       AAssunto,
                       slMensagemEmail,
                       slCC,
                       slAnexos,
                       LStream,
                       LNomeArq);
                  end;

                  Resposta.Msg := 'Email enviado com sucesso';
                  Result := SetRetorno(ErrOK, Resposta.Gerar);
                except
                  on E: Exception do
                    raise EACBrLibException.Create(ErrRetorno, 'Erro ao enviar email' + sLineBreak + E.Message);
                end;
              end;
            finally
              LStream.Free;
              Resposta.Free;
              slCC.Free;
              slAnexos.Free;
              slMensagemEmail.Free;
              if (AEnviaPDF) then BPeDM.FinalizarImpressao;
            end;
          end;
        end;
      finally
        LBPeEnviar.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.Imprimir(const cImpressora: PAnsiChar;
  nNumCopias: Integer; bMostrarPreview: PAnsiChar): Integer;
var
  Resposta: TLibImpressaoResposta;
  Impressora, MostrarPreview: String;
begin
  try
    Impressora := ConverterStringEntrada(cImpressora);
    MostrarPreview := ConverterStringEntrada(bMostrarPreview);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_Imprimir('  + Impressora + ',' + IntToStr(nNumCopias) + ',' + MostrarPreview + ')', logCompleto, True)
    else
      GravarLog('BPe_Imprimir', logNormal);

    BPeDM.Travar;
    try
      Resposta := TLibImpressaoResposta.Create(BPeDM.ACBrBPe1.Bilhetes.Count, Config.TipoResposta, Config.CodResposta);
      try
        BPeDM.ConfigurarImpressao(Impressora, False, MostrarPreview);
        if nNumCopias > 0 then
          BPeDM.ACBrBPe1.DABPe.NumCopias := nNumCopias;

        BPeDM.ACBrBPe1.Bilhetes.Imprimir;
        Result := SetRetorno(ErrOK, Resposta.Gerar);
      finally
        BPeDM.FinalizarImpressao;
        Resposta.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ImprimirPDF: Integer;
var
  Resposta: TLibImpressaoResposta;
begin
  try
    GravarLog('BPe_ImprimirPDF', logNormal);

    BPeDM.Travar;
    try
      Resposta := TLibImpressaoResposta.Create(BPeDM.ACBrBPe1.Bilhetes.Count, Config.TipoResposta, Config.CodResposta);
      try
        BPeDM.ConfigurarImpressao('', True);
        try
          BPeDM.ACBrBPe1.Bilhetes.ImprimirPDF;
          Resposta.Msg := BPeDM.ACBrBPe1.DABPe.ArquivoPDF;
          Result := SetRetorno(ErrOK, Resposta.Gerar);
        finally
          BPeDM.FinalizarImpressao;
        end;
      finally
        Resposta.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.SalvarPDF(const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  AStream: TMemoryStream;
  Resposta: AnsiString;
begin
  try
    GravarLog('BPe_SalvarPDF', logNormal);

    BPeDM.Travar;
    try
      AStream := TMemoryStream.Create;
      try
        BPeDM.ConfigurarImpressao('', True);
        BPeDM.ACBrBPe1.Bilhetes.ImprimirPDF;
        Resposta := StreamToBase64(AStream);

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      finally
        BPeDM.FinalizarImpressao;
        AStream.Free;
        BPeDM.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ImprimirEvento(const eArquivoXmlBPe,
  eArquivoXmlEvento: PAnsiChar): Integer;
var
  EhArquivo: Boolean;
  AArquivoXmlBPe: String;
  AArquivoXmlEvento: String;
  Resposta: TLibImpressaoResposta;
begin
  try
    AArquivoXmlBPe := ConverterStringEntrada(eArquivoXmlBPe);
    AArquivoXmlEvento := ConverterStringEntrada(eArquivoXmlEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_ImprimirEvento(' + AArquivoXmlBPe + ',' + AArquivoXmlEvento + ' )', logCompleto, True)
    else
      GravarLog('BPe_ImprimirEvento', logNormal);

    BPeDM.Travar;
    try
      Resposta := TLibImpressaoResposta.Create(BPeDM.ACBrBPe1.EventoBPe.Evento.Count, Config.TipoResposta, Config.CodResposta);
      try
        EhArquivo := StringEhArquivo(AArquivoXmlBPe);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlBPe);

        if EhArquivo then
          BPeDM.ACBrBPe1.Bilhetes.LoadFromFile(AArquivoXmlBPe)
        else
          BPeDM.ACBrBPe1.Bilhetes.LoadFromString(AArquivoXmlBPe);

        EhArquivo := StringEhArquivo(AArquivoXmlEvento);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlEvento);

        if EhArquivo then
          BPeDM.ACBrBPe1.EventoBPe.LerXML(AArquivoXmlEvento)
        else
          BPeDM.ACBrBPe1.EventoBPe.LerXMLFromString(AArquivoXmlEvento);

        BPeDM.ConfigurarImpressao;
        BPeDM.ACBrBPe1.ImprimirEvento;

        Result := SetRetorno(ErrOK, Resposta.Gerar);
      finally
        BPeDM.FinalizarImpressao;
        Resposta.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.ImprimirEventoPDF(const eArquivoXmlBPe,
  eArquivoXmlEvento: PAnsiChar): Integer;
var
  EhArquivo: Boolean;
  AArquivoXmlBPe: String;
  AArquivoXmlEvento: String;
  Resposta: TLibImpressaoResposta;
begin
  try
    AArquivoXmlBPe := ConverterStringEntrada(eArquivoXmlBPe);
    AArquivoXmlEvento := ConverterStringEntrada(eArquivoXmlEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_ImprimirEventoPDF(' + AArquivoXmlBPe + ',' + AArquivoXmlEvento + ' )', logCompleto, True)
    else
      GravarLog('BPe_ImprimirEventoPDF', logNormal);

    BPeDM.Travar;
    try
      Resposta := TLibImpressaoResposta.Create(BPeDM.ACBrBPe1.EventoBPe.Evento.Count, Config.TipoResposta, Config.CodResposta);
      try
        EhArquivo := StringEhArquivo(AArquivoXmlBPe);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlBPe);

        if EhArquivo then
          BPeDM.ACBrBPe1.Bilhetes.LoadFromFile(AArquivoXmlBPe)
        else
          BPeDM.ACBrBPe1.Bilhetes.LoadFromString(AArquivoXmlBPe);

        EhArquivo := StringEhArquivo(AArquivoXmlEvento);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlEvento);

        if EhArquivo then
          BPeDM.ACBrBPe1.EventoBPe.LerXML(AArquivoXmlEvento)
        else
          BPeDM.ACBrBPe1.EventoBPe.LerXMLFromString(AArquivoXmlEvento);

        BPeDM.ConfigurarImpressao('', True);
        BPeDM.ACBrBPe1.ImprimirEventoPDF;

        Resposta.Msg := BPeDM.ACBrBPe1.DABPe.ArquivoPDF;
        Result := SetRetorno(ErrOK, Resposta.Gerar);
      finally
        BPeDM.FinalizarImpressao;
        Resposta.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibBPe.SalvarEventoPDF(const eArquivoXmlBPe,
  eArquivoXmlEvento, sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  EhArquivo: Boolean;
  AArquivoXmlBPe: String;
  AArquivoXmlEvento: String;
  AStream: TMemoryStream;
  Resposta: AnsiString;
begin
  try
    AArquivoXmlBPe := ConverterStringEntrada(eArquivoXmlBPe);
    AArquivoXmlEvento := ConverterStringEntrada(eArquivoXmlEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('BPe_SalvarEventoPDF(' + AArquivoXmlBPe + ',' + AArquivoXmlEvento + ' )', logCompleto, True)
    else
      GravarLog('BPe_SalvarEventoPDF', logNormal);

    BPeDM.Travar;
    try
      AStream := TMemoryStream.Create;
      try
        EhArquivo := StringEhArquivo(AArquivoXmlBPe);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlBPe);

        if EhArquivo then
          BPeDM.ACBrBPe1.Bilhetes.LoadFromFile(AArquivoXmlBPe)
        else
          BPeDM.ACBrBPe1.Bilhetes.LoadFromString(AArquivoXmlBPe);

        EhArquivo := StringEhArquivo(AArquivoXmlEvento);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlEvento);

        if EhArquivo then
          BPeDM.ACBrBPe1.EventoBPe.LerXML(AArquivoXmlEvento)
        else
          BPeDM.ACBrBPe1.EventoBPe.LerXMLFromString(AArquivoXmlEvento);

        BPeDM.ConfigurarImpressao('', True);

        BPeDM.ACBrBPe1.DABPe.ImprimirEventoPDF;

        Resposta := StreamToBase64(AStream);

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      finally
        BPeDM.FinalizarImpressao;
        AStream.Free;
      end;
    finally
      BPeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

end.

