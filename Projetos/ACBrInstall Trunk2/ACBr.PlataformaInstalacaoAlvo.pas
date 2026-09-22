{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020   Daniel Simoes de Almeida             }
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

unit ACBr.PlataformaInstalacaoAlvo;

// -----------------------------------------------------------------------------
// ACBR_JCL_COM_PERFIS
//
// Habilita a instalação nos perfis de IDE criados com "bds.exe -r <Perfil>".
// Depende de um ajuste na JCL: a classe TJclBorRADToolInstallation usa a MESMA
// chave de registro para ler a configuração do usuário (HKCU) e os dados da
// instalação (HKLM), e num perfil elas ficam em lugares diferentes. O patch
// está em Terceiros\JclIDEUtils-PerfisIDE.patch; leia Terceiros\Leiame.txt.
//
// Sem o patch aplicado e a JCL recompilada, este define NÃO pode ser ligado:
// o construtor usado aqui não existe e a unit não compila.
// -----------------------------------------------------------------------------
{.$DEFINE ACBR_JCL_COM_PERFIS}

interface

uses SysUtils, StrUtils, Windows, Messages, Classes, Forms, Generics.Collections,
  JclIDEUtils, JclCompilerUtils;


const
  PlataformasSuportadasFull = [bpWin32, bpWin64];
  PlataformasSuportadasBeta = [bpAndroid32, bpAndroid64, bpOSX32, bpOSX64, bpLinux64];
  PlataformasSuportadas = PlataformasSuportadasFull + PlataformasSuportadasBeta;

type
  // Modos de compilação dos pacotes (BPL/DCU) suportados pelo instalador
  TModoCompilacao = (mcRelease, mcDebug);
  TModosCompilacao = set of TModoCompilacao;

const
  cNomeModoCompilacao: array[TModoCompilacao] of string = ('Release', 'Debug');

  // Seções/valores da configuração da IDE (registro do Windows)
  cSecaoKnownPackages     = 'Known Packages';
  cSecaoKnownPackagesX64  = 'Known Packages x64';
  cSecaoPackageCache      = 'Package Cache';
  cSecaoPackageCacheX64   = 'Package Cache x64';
  cSecaoLibrary           = 'Library';
  cValorPackageSearchPath = 'Package Search Path';

type

  TACBrPlataformaInstalacaoAlvo = class(TObject)
  private
    { private declarations }
    function EhIDEComSuporteAPlataformas: Boolean;
    function GetPackageSearchPath: string;
    procedure SetPackageSearchPath(const AValor: string);
    procedure CarregarListaDePath(const AValor: string; ALista: TStrings);
    function MontarPathDaLista(ALista: TStrings): string;
  public
    InstalacaoAtual: TJclBorRADToolInstallation;
    tPlatformAtual: TJclBDSPlatform;
    sPlatform: string;
    sDirLibrary: string;
    // Perfil da IDE (bds.exe -r <Perfil>). Vazio = perfil padrão.
    NomePerfil: string;
    function GetNomeAlvo: string;
    function GetDirLibrary: string;
    function EhSuportadaPeloACBr: Boolean;
    function EhSuportadaPeloACBrBeta: Boolean;
    procedure ConfiguraDCCPelaPlataformaAtual;

    // Ajusta o PATH que a IDE usa para localizar os BPLs de runtime exigidos
    // pelos pacotes de design. O PATH é único para as IDEs de 32 e 64 bits, mas
    // o loader do Windows ignora a DLL de arquitetura errada e continua
    // procurando nas pastas seguintes -- a própria Delphi conta com isso ao
    // deixar Bpl e Bpl\Win64 juntos no PATH do sistema. Por isso as pastas das
    // duas plataformas podem conviver aqui.
    // ATextoRemover vazio = não remove nada; ADiretorio vazio = não acrescenta.
    procedure AjustarEnvironmentPath(const ADiretorio, ATextoRemover: string;
      const ExpandirPathSeNecessario: Boolean);

    // -- Suporte a Release/Debug -------------------------------------------
    // Cada combinação Delphi + Plataforma + Configuração tem a sua própria
    // pasta, e todos os artefatos dela (BPL, DCP, DCU) ficam juntos ali:
    //   Lib\Delphi\LibD<versao>\<Plataforma>\<Configuracao>
    // sDirLibrary aponta para a raiz da plataforma; nada é gravado nela.
    function DirLibraryPorModo(const AModo: TModoCompilacao): string;

    // Nomes explícitos para os artefatos. Hoje todos moram na mesma pasta da
    // combinação, o que já garante o isolamento; os métodos existem para
    // deixar a intenção clara e permitir separar no futuro sem caçar chamadas.
    function DirBplPorModo(const AModo: TModoCompilacao): string;
    function DirDcpPorModo(const AModo: TModoCompilacao): string;
    function DirDcuPorModo(const AModo: TModoCompilacao): string;

    // -- Suporte a IDE de 32 e 64 bits -------------------------------------
    // A IDE de 64 bits (bin64\bds.exe) e os pacotes de design para Win64
    // (designide) só existem nas versões mais recentes do Delphi.
    function SuportaIDE64Bits: Boolean;
    function SuportaPacotesDesignTime: Boolean;

    function SecaoKnownPackages: string;
    function SecaoLibraryDaPlataforma: string;

    procedure LimparPackageCache(const ANomeArquivoBpl: string);
    procedure RegistrarPacoteNaIDE(const ANomeArquivoBpl, ADescricao: string);
    procedure RemoverPacoteDaIDE(const ANomeArquivoBpl: string);
    // Remove os registros do ACBr de uma das listas de pacotes da IDE.
    // ApenasOrfaos = True remove somente os que apontam para arquivos que não
    // existem mais. Retorna a quantidade removida.
    function RemoverPacotesACBrDaIDE(const ASecao: string; const ApenasOrfaos: Boolean): Integer;

    // Alterações de Library/Browsing Path em lote: a JCL regrava o
    // EnvOptions.proj a cada diretório, o que fica lento com centenas deles.
    procedure AdicionarNosPathsDeBiblioteca(ADiretorios: TStrings);
    procedure RemoverDoLibrarySearchPath(ADiretorios: TStrings);
    // Remove de Search/Browsing/Debug DCU Path tudo que contenha o texto
    // informado, com uma única gravação por path.
    procedure RemoverDosPathsDeBiblioteca(const ATextoProcurar: string);

    // Caminho onde a IDE procura os BPLs de runtime exigidos pelos pacotes de
    // design. É mantido por plataforma, evitando conflito entre Win32 e Win64.
    procedure AdicionarPackageSearchPath(const ADiretorio: string);
    procedure RemoverPackageSearchPathACBr;

    constructor CreateNew(AInstalacao: TJclBorRADToolInstallation; UmaPlatform: TJclBDSPlatform;
          const UmasPlatform: string);
  end;

  TListaPlataformasAlvosBase = TList<TACBrPlataformaInstalacaoAlvo>;

  TListaPlataformasAlvos = class(TListaPlataformasAlvosBase)
  private
    // Instalações criadas por nós para os perfis da IDE. A JCL só enumera o
    // perfil padrão, então estas ficam por nossa conta -- inclusive liberá-las.
    FInstalacoesDePerfis: TObjectList<TJclBorRADToolInstallation>;
  public
    FoACBr: TJclBorRADToolInstallations;
    constructor Create;
    destructor Destroy; override;
  end;

  function GeraListaPlataformasAlvos: TListaPlataformasAlvos;


implementation

{$IFDEF ACBR_JCL_COM_PERFIS}
uses
  JclRegistry;
{$ENDIF ACBR_JCL_COM_PERFIS}

function PossuiOutrasPlataformas(UmaInstalacao: TJclBorRADToolInstallation): Boolean;
begin
  Result := (UmaInstalacao is TJclBDSInstallation) and (UmaInstalacao.IDEVersionNumber >= 9) and
            (not UmaInstalacao.IsTurboExplorer);
end;

// Acrescenta um alvo por plataforma suportada pela instalação informada.
// ANomePerfil vazio = perfil padrão da IDE.
procedure AdicionarAlvosDaInstalacao(ALista: TListaPlataformasAlvos;
  AInstalacao: TJclBorRADToolInstallation; const ANomePerfil: string);

  procedure Acrescentar(UmaPlatform: TJclBDSPlatform; const UmasPlatform: string);
  var
    LAlvo: TACBrPlataformaInstalacaoAlvo;
  begin
    LAlvo := TACBrPlataformaInstalacaoAlvo.CreateNew(AInstalacao, UmaPlatform, UmasPlatform);
    LAlvo.NomePerfil := ANomePerfil;
    ALista.Add(LAlvo);
  end;

begin
  //sempre tem a Win32
  Acrescentar(bpWin32, BDSPlatformWin32);

  if not PossuiOutrasPlataformas(AInstalacao) then
    Exit;

  if (bpDelphi64 in AInstalacao.Personalities) then
    Acrescentar(bpWin64, BDSPlatformWin64);

  if (bpDelphiOSX32 in AInstalacao.Personalities) then
    Acrescentar(bpOSX32, BDSPlatformOSX32);

  if (bpDelphiOSX64 in AInstalacao.Personalities) then
    Acrescentar(bpOSX64, BDSPlatformOSX64);

  if (bpDelphiAndroid32 in AInstalacao.Personalities) then
    Acrescentar(bpAndroid32, BDSPlatformAndroid32);

  if (bpDelphiAndroid64 in AInstalacao.Personalities) then
    Acrescentar(bpAndroid64, BDSPlatformAndroid64);

  if (bpDelphiLinux64 in AInstalacao.Personalities) then
    Acrescentar(bpLinux64, BDSPlatformLinux64);

end;

{$IFDEF ACBR_JCL_COM_PERFIS}
// Procura os perfis já existentes desta IDE. O instalador nunca cria perfil:
// quem cria é a IDE, na primeira vez que roda com "bds.exe -r <Perfil>".
procedure ColetarPerfisDaInstalacao(AInstalacao: TJclBorRADToolInstallation;
  ALista: TStrings);
var
  LCaminho, LRaiz, LNomeIDE, LVersao: string;
  LChaves: TStringList;
  I, P: Integer;
begin
  // ex.: \SOFTWARE\Embarcadero\BDS\37.0
  LCaminho := AInstalacao.ConfigDataLocation;

  P := LastDelimiter('\', LCaminho);
  if (P <= 1) then
    Exit;
  LVersao  := Copy(LCaminho, P + 1, MaxInt);   // 37.0
  LCaminho := Copy(LCaminho, 1, P - 1);        // \SOFTWARE\Embarcadero\BDS

  P := LastDelimiter('\', LCaminho);
  if (P <= 1) then
    Exit;
  LNomeIDE := Copy(LCaminho, P + 1, MaxInt);   // BDS
  LRaiz    := Copy(LCaminho, 1, P - 1);        // \SOFTWARE\Embarcadero

  LChaves := TStringList.Create;
  try
    if not RegGetKeyNames(HKCU, LRaiz, LChaves) then
      Exit;

    for I := 0 to LChaves.Count - 1 do
    begin
      // a chave da própria IDE não é perfil
      if SameText(LChaves[I], LNomeIDE) then
        Continue;

      // Debaixo de \SOFTWARE\Embarcadero moram vários produtos. Um perfil de
      // IDE se reconhece por ter a subchave da versão e, dentro dela, a seção
      // Library que a IDE grava logo na primeira execução.
      if RegKeyExists(HKCU, LRaiz + '\' + LChaves[I] + '\' + LVersao +
                            '\' + cSecaoLibrary) then
        ALista.Add(LChaves[I]);
    end;
  finally
    LChaves.Free;
  end;
end;

procedure AdicionarAlvosDosPerfis(ALista: TListaPlataformasAlvos;
  AInstalacaoPadrao: TJclBorRADToolInstallation);
var
  LPerfis: TStringList;
  LInstalacao: TJclBorRADToolInstallation;
  LCaminhoPadrao, LPrefixo, LVersao: string;
  I, P: Integer;
begin
  LPerfis := TStringList.Create;
  try
    ColetarPerfisDaInstalacao(AInstalacaoPadrao, LPerfis);
    if (LPerfis.Count = 0) then
      Exit;

    LCaminhoPadrao := AInstalacaoPadrao.ConfigDataLocation;
    P := LastDelimiter('\', LCaminhoPadrao);
    LVersao  := Copy(LCaminhoPadrao, P + 1, MaxInt);      // 37.0
    LPrefixo := Copy(LCaminhoPadrao, 1, P - 1);           // ...\Embarcadero\BDS
    LPrefixo := Copy(LPrefixo, 1, LastDelimiter('\', LPrefixo));  // ...\Embarcadero\

    for I := 0 to LPerfis.Count - 1 do
    begin
      // A configuração vem do perfil (HKCU); RootDir e personalidades continuam
      // vindo da chave real da instalação (HKLM).
      LInstalacao := TJclBorRADToolInstallationClass(AInstalacaoPadrao.ClassType).Create(
                       LPrefixo + LPerfis[I] + '\' + LVersao, 0, LCaminhoPadrao);
      if not LInstalacao.Valid then
      begin
        LInstalacao.Free;
        Continue;
      end;

      ALista.FInstalacoesDePerfis.Add(LInstalacao);
      AdicionarAlvosDaInstalacao(ALista, LInstalacao, LPerfis[I]);
    end;
  finally
    LPerfis.Free;
  end;
end;
{$ENDIF ACBR_JCL_COM_PERFIS}

function GeraListaPlataformasAlvos: TListaPlataformasAlvos;
var
  InstalacaoAlvo: TJclBorRADToolInstallation;
  i: Integer;
begin
  Result := TListaPlataformasAlvos.Create;
  for i := 0 to Result.FoACBr.Count - 1 do
  begin
    InstalacaoAlvo := Result.FoACBr.Installations[i];
    AdicionarAlvosDaInstalacao(Result, InstalacaoAlvo, '');
    {$IFDEF ACBR_JCL_COM_PERFIS}
    AdicionarAlvosDosPerfis(Result, InstalacaoAlvo);
    {$ENDIF ACBR_JCL_COM_PERFIS}
  end;
end;

{ TListaPlataformasAlvos }

constructor TListaPlataformasAlvos.Create;
begin
  inherited;
  FoACBr := TJclBorRADToolInstallations.Create;
  FInstalacoesDePerfis := TObjectList<TJclBorRADToolInstallation>.Create(True);
end;

destructor TListaPlataformasAlvos.Destroy;
var
  I: Integer;
begin
  // A lista base é um TList, que não é dona dos itens: sem isto os alvos
  // ficavam para trás na memória.
  for I := Count - 1 downto 0 do
    Items[I].Free;
  Clear;

  // depois dos alvos, porque eles apontam para estas instalações
  FInstalacoesDePerfis.Free;
  FoACBr.Free;
  inherited;
end;

{ TACBrPlataformaInstalacaoAlvo }

function TACBrPlataformaInstalacaoAlvo.EhSuportadaPeloACBr: Boolean;
begin
  Result := (not MatchText(InstalacaoAtual.VersionNumberStr, ['d3', 'd4', 'd5', 'd6'])) and
            (tPlatformAtual in PlataformasSuportadas);
end;

function TACBrPlataformaInstalacaoAlvo.EhSuportadaPeloACBrBeta: Boolean;
begin
  Result := (not MatchText(InstalacaoAtual.VersionNumberStr, ['d3', 'd4', 'd5', 'd6'])) and
            (tPlatformAtual in PlataformasSuportadasBeta);
end;

function TACBrPlataformaInstalacaoAlvo.GetDirLibrary: string;
begin
  Result := {OpcoesInstall.DiretorioRaizACBr + }
            'Lib\Delphi\Lib' + AnsiUpperCase(InstalacaoAtual.VersionNumberStr)+ '\' + sPlatform;
end;

function TACBrPlataformaInstalacaoAlvo.GetNomeAlvo: string;
begin
  Result := InstalacaoAtual.Name;
  // Sem o nome do perfil, dois alvos da mesma IDE ficariam indistinguíveis na
  // tela, no arquivo de log e no ini de configuração.
  if (NomePerfil <> '') then
    Result := Result + ' [' + NomePerfil + ']';
  Result := Result + ' ' + sPlatform;
end;

function TACBrPlataformaInstalacaoAlvo.DirLibraryPorModo(const AModo: TModoCompilacao): string;
begin
  Result := ExcludeTrailingPathDelimiter(sDirLibrary) + '\' + cNomeModoCompilacao[AModo];
end;

function TACBrPlataformaInstalacaoAlvo.DirBplPorModo(const AModo: TModoCompilacao): string;
begin
  Result := DirLibraryPorModo(AModo);
end;

function TACBrPlataformaInstalacaoAlvo.DirDcpPorModo(const AModo: TModoCompilacao): string;
begin
  Result := DirLibraryPorModo(AModo);
end;

function TACBrPlataformaInstalacaoAlvo.DirDcuPorModo(const AModo: TModoCompilacao): string;
begin
  Result := DirLibraryPorModo(AModo);
end;

function TACBrPlataformaInstalacaoAlvo.EhIDEComSuporteAPlataformas: Boolean;
begin
  // A partir do BDS 2007 (IDEVersionNumber 5) o Delphi passou a separar as
  // configurações por plataforma. A JCL usa o mesmo critério.
  Result := (InstalacaoAtual is TJclBDSInstallation) and (InstalacaoAtual.IDEVersionNumber >= 9);
end;

function TACBrPlataformaInstalacaoAlvo.SuportaIDE64Bits: Boolean;
var
  LRaiz: string;
begin
  Result := False;
  if not (InstalacaoAtual is TJclBDSInstallation) then
    Exit;

  if not (bpDelphi64 in InstalacaoAtual.Personalities) then
    Exit;

  LRaiz := IncludeTrailingPathDelimiter(InstalacaoAtual.RootDir);

  // Detectado pelos arquivos e não pelo número da versão, assim novas versões
  // do Delphi passam a ser suportadas sem alterar o instalador.
  Result := FileExists(LRaiz + 'bin64\bds.exe') and
            FileExists(LRaiz + 'lib\win64\release\designide.dcp');
end;

function TACBrPlataformaInstalacaoAlvo.SuportaPacotesDesignTime: Boolean;
begin
  Result := (tPlatformAtual = bpWin32) or
            ((tPlatformAtual = bpWin64) and SuportaIDE64Bits);
end;

function TACBrPlataformaInstalacaoAlvo.SecaoKnownPackages: string;
begin
  if (tPlatformAtual = bpWin64) then
    Result := cSecaoKnownPackagesX64
  else
    Result := cSecaoKnownPackages;
end;

function TACBrPlataformaInstalacaoAlvo.SecaoLibraryDaPlataforma: string;
begin
  if EhIDEComSuporteAPlataformas then
    Result := cSecaoLibrary + '\' + sPlatform
  else
    Result := cSecaoLibrary;
end;

procedure TACBrPlataformaInstalacaoAlvo.LimparPackageCache(const ANomeArquivoBpl: string);
var
  LNomeArquivo: string;
begin
  if not (InstalacaoAtual is TJclBDSInstallation) then
    Exit;

  LNomeArquivo := ExtractFileName(ANomeArquivoBpl);
  try
    InstalacaoAtual.ConfigData.EraseSection(cSecaoPackageCache + '\' + LNomeArquivo);
    InstalacaoAtual.ConfigData.EraseSection(cSecaoPackageCacheX64 + '\' + LNomeArquivo);
  except
    // o cache pode não existir, o que não é um problema
  end;
end;

procedure TACBrPlataformaInstalacaoAlvo.RegistrarPacoteNaIDE(const ANomeArquivoBpl, ADescricao: string);
var
  LDescricao: string;
begin
  LDescricao := Trim(ADescricao);
  if LDescricao = '' then
    LDescricao := ChangeFileExt(ExtractFileName(ANomeArquivoBpl), '');

  LimparPackageCache(ANomeArquivoBpl);
  InstalacaoAtual.ConfigData.WriteString(SecaoKnownPackages, ANomeArquivoBpl, LDescricao);
end;

procedure TACBrPlataformaInstalacaoAlvo.RemoverPacoteDaIDE(const ANomeArquivoBpl: string);
begin
  LimparPackageCache(ANomeArquivoBpl);
  InstalacaoAtual.ConfigData.DeleteKey(SecaoKnownPackages, ANomeArquivoBpl);
end;

function TACBrPlataformaInstalacaoAlvo.RemoverPacotesACBrDaIDE(const ASecao: string;
  const ApenasOrfaos: Boolean): Integer;
var
  LPacotes: TStringList;
  I: Integer;
  LArquivo: string;
begin
  Result := 0;
  LPacotes := TStringList.Create;
  try
    InstalacaoAtual.ConfigData.ReadSection(ASecao, LPacotes);
    for I := LPacotes.Count - 1 downto 0 do
    begin
      LArquivo := LPacotes[I];

      if Pos('ACBR', AnsiUpperCase(LArquivo)) <= 0 then
        Continue;

      // caminhos com macro da IDE ($(BDSBIN)...) são dos pacotes dela
      if Pos('$(', LArquivo) > 0 then
        Continue;

      if ApenasOrfaos and FileExists(LArquivo) then
        Continue;

      LimparPackageCache(LArquivo);
      InstalacaoAtual.ConfigData.DeleteKey(ASecao, LArquivo);
      Inc(Result);
    end;
  finally
    LPacotes.Free;
  end;
end;

procedure TACBrPlataformaInstalacaoAlvo.AdicionarNosPathsDeBiblioteca(ADiretorios: TStrings);

  procedure Acrescentar(const AValorAtual: string; out ANovoValor: string);
  var
    LLista: TStringList;
    I: Integer;
  begin
    LLista := TStringList.Create;
    try
      CarregarListaDePath(AValorAtual, LLista);
      for I := 0 to ADiretorios.Count - 1 do
      begin
        if LLista.IndexOf(ADiretorios[I]) < 0 then
          LLista.Add(ADiretorios[I]);
      end;
      ANovoValor := MontarPathDaLista(LLista);
    finally
      LLista.Free;
    end;
  end;

var
  LNovo: string;
begin
  if (ADiretorios = nil) or (ADiretorios.Count = 0) then
    Exit;

  Acrescentar(InstalacaoAtual.RawLibrarySearchPath[tPlatformAtual], LNovo);
  InstalacaoAtual.RawLibrarySearchPath[tPlatformAtual] := LNovo;

  Acrescentar(InstalacaoAtual.RawLibraryBrowsingPath[tPlatformAtual], LNovo);
  InstalacaoAtual.RawLibraryBrowsingPath[tPlatformAtual] := LNovo;
end;

procedure TACBrPlataformaInstalacaoAlvo.RemoverDosPathsDeBiblioteca(const ATextoProcurar: string);

  function SemOcorrencias(const AValor: string): string;
  var
    LLista: TStringList;
    I: Integer;
  begin
    LLista := TStringList.Create;
    try
      CarregarListaDePath(AValor, LLista);
      for I := LLista.Count - 1 downto 0 do
      begin
        if Pos(AnsiUpperCase(ATextoProcurar), AnsiUpperCase(LLista[I])) > 0 then
          LLista.Delete(I);
      end;
      Result := MontarPathDaLista(LLista);
    finally
      LLista.Free;
    end;
  end;

begin
  InstalacaoAtual.RawLibrarySearchPath[tPlatformAtual] :=
    SemOcorrencias(InstalacaoAtual.RawLibrarySearchPath[tPlatformAtual]);
  InstalacaoAtual.RawLibraryBrowsingPath[tPlatformAtual] :=
    SemOcorrencias(InstalacaoAtual.RawLibraryBrowsingPath[tPlatformAtual]);
  InstalacaoAtual.RawDebugDCUPath[tPlatformAtual] :=
    SemOcorrencias(InstalacaoAtual.RawDebugDCUPath[tPlatformAtual]);
end;

procedure TACBrPlataformaInstalacaoAlvo.RemoverDoLibrarySearchPath(ADiretorios: TStrings);
var
  LLista: TStringList;
  I, LIndice: Integer;
begin
  if (ADiretorios = nil) or (ADiretorios.Count = 0) then
    Exit;

  LLista := TStringList.Create;
  try
    CarregarListaDePath(InstalacaoAtual.RawLibrarySearchPath[tPlatformAtual], LLista);
    for I := 0 to ADiretorios.Count - 1 do
    begin
      LIndice := LLista.IndexOf(ADiretorios[I]);
      if LIndice >= 0 then
        LLista.Delete(LIndice);
    end;
    InstalacaoAtual.RawLibrarySearchPath[tPlatformAtual] := MontarPathDaLista(LLista);
  finally
    LLista.Free;
  end;
end;

procedure TACBrPlataformaInstalacaoAlvo.CarregarListaDePath(const AValor: string; ALista: TStrings);
var
  I: Integer;
begin
  // Não usamos DelimitedText para não inserir aspas em caminhos com espaços
  ALista.Text := StringReplace(AValor, ';', sLineBreak, [rfReplaceAll]);
  for I := ALista.Count - 1 downto 0 do
  begin
    ALista[I] := Trim(ALista[I]);
    if ALista[I] = '' then
      ALista.Delete(I);
  end;
end;

function TACBrPlataformaInstalacaoAlvo.MontarPathDaLista(ALista: TStrings): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to ALista.Count - 1 do
  begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + ALista[I];
  end;
end;

function TACBrPlataformaInstalacaoAlvo.GetPackageSearchPath: string;
begin
  Result := InstalacaoAtual.ConfigData.ReadString(SecaoLibraryDaPlataforma, cValorPackageSearchPath, '');
end;

procedure TACBrPlataformaInstalacaoAlvo.SetPackageSearchPath(const AValor: string);
begin
  InstalacaoAtual.ConfigData.WriteString(SecaoLibraryDaPlataforma, cValorPackageSearchPath, AValor);
end;

procedure TACBrPlataformaInstalacaoAlvo.AdicionarPackageSearchPath(const ADiretorio: string);
var
  LLista: TStringList;
begin
  if not EhIDEComSuporteAPlataformas then
    Exit;

  LLista := TStringList.Create;
  try
    CarregarListaDePath(GetPackageSearchPath, LLista);
    if LLista.IndexOf(ADiretorio) < 0 then
    begin
      LLista.Insert(0, ADiretorio);
      SetPackageSearchPath(MontarPathDaLista(LLista));
    end;
  finally
    LLista.Free;
  end;
end;

procedure TACBrPlataformaInstalacaoAlvo.RemoverPackageSearchPathACBr;
var
  LLista: TStringList;
  I: Integer;
begin
  if not EhIDEComSuporteAPlataformas then
    Exit;

  LLista := TStringList.Create;
  try
    CarregarListaDePath(GetPackageSearchPath, LLista);
    for I := LLista.Count - 1 downto 0 do
    begin
      if Pos('ACBR', AnsiUpperCase(LLista[I])) > 0 then
        LLista.Delete(I);
    end;
    SetPackageSearchPath(MontarPathDaLista(LLista));
  finally
    LLista.Free;
  end;
end;

procedure TACBrPlataformaInstalacaoAlvo.AjustarEnvironmentPath(const ADiretorio, ATextoRemover: string;
  const ExpandirPathSeNecessario: Boolean);
var
  PathsAtuais: string;
  ListaPaths: TStringList;
  I: Integer;
const
  cs: PChar = 'Environment Variables';
begin

  PathsAtuais := InstalacaoAtual.ConfigData.ReadString(cs, 'PATH', '$(PATH)');
  if ExpandirPathSeNecessario then
  begin
    // tentar ler o path configurado na ide do delphi, se não existir ler
    // a atual para complementar e fazer o override
    if PathsAtuais = '$(PATH)' then
      PathsAtuais := Trim(InstalacaoAtual.EnvironmentVariables.Values['PATH']);
    if PathsAtuais = '' then
      PathsAtuais := GetEnvironmentVariable('PATH');
  end;

  // manipular as strings
  ListaPaths := TStringList.Create;
  try
    ListaPaths.Clear;
    ListaPaths.Delimiter := ';';
    ListaPaths.StrictDelimiter := True;
    ListaPaths.DelimitedText := PathsAtuais;
    // remover as entradas antigas do ACBr, de qualquer plataforma
    if (Trim(ATextoRemover) <> '') then
    begin
      for I := ListaPaths.Count - 1 downto 0 do
      begin
        if Pos(AnsiUpperCase(ATextoRemover), AnsiUpperCase(ListaPaths[I])) > 0 then
          ListaPaths.Delete(I);
      end;
    end;

    // adicionar ao path a pasta da biblioteca desta plataforma, sem duplicar
    if (Trim(ADiretorio) <> '') and (ListaPaths.IndexOf(ADiretorio) < 0) then
      ListaPaths.Insert(0, ADiretorio);
    InstalacaoAtual.ConfigData.WriteString(cs, 'PATH', ListaPaths.DelimitedText);

  finally
    ListaPaths.Free;
  end;
end;

procedure TACBrPlataformaInstalacaoAlvo.ConfiguraDCCPelaPlataformaAtual;
begin
  if (InstalacaoAtual is TJclBDSInstallation) and (InstalacaoAtual.IDEVersionNumber >= 9) then
  begin
    case tPlatformAtual of
      bpWin32:
      begin
        InstalacaoAtual.DCC := InstalacaoAtual.DCC32;
      end;
      bpWin64:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCC64;
      end;
      bpOSX32:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCOSX32;
      end;
      bpOSX64:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCOSX64;
      end;
      bpAndroid32:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCArm32;
      end;
      bpAndroid64:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCArm64;
      end;
      bpiOSDevice32:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCiOS32;
      end;
      bpiOSDevice64:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCiOS64;
      end;
      bpiOSSimulator:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCiOSSimulator;
      end;
      bpLinux64:
      begin
        InstalacaoAtual.DCC := (InstalacaoAtual as TJclBDSInstallation).DCCLinux64;
      end;
    else
      InstalacaoAtual.DCC := InstalacaoAtual.DCC32;
    end;
  end else
    InstalacaoAtual.DCC := InstalacaoAtual.DCC32;
end;

constructor TACBrPlataformaInstalacaoAlvo.CreateNew(AInstalacao: TJclBorRADToolInstallation;
  UmaPlatform: TJclBDSPlatform; const UmasPlatform: string);
begin
  inherited Create;

  InstalacaoAtual := AInstalacao;
  tPlatformAtual  := UmaPlatform;
  sPlatform       := UmasPlatform;
end;

end.
