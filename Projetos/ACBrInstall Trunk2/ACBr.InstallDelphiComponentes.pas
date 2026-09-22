{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Daniel Simoes de Almeida             }
{                                         Isaque Pinheiro                      }
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

unit ACBr.InstallDelphiComponentes;

interface

uses
  SysUtils, Windows, Messages, Classes, Forms, System.Generics.Collections,
  JclIDEUtils, JclCompilerUtils, ACBr.Pacotes, ACBr.PlataformaInstalacaoAlvo;

const
  cVersaoConfig = '1.0';

type
  TDestino = (tdSystem, tdDelphi, tdNone);
  TNivelLog = (nlNenhumLog, nlMinimo, nlMedio, nlMaximo);

  TOnIniciaNovaInstalacao = reference to procedure (const MaximoPassosProgresso: Integer;
        const NomeCaminhoArquivoLog: string; const Cabecalho: string);
  // Severidade da mensagem, usada para colorir o log na tela
  TNivelMensagem = (nmInfo, nmDestaque, nmSucesso, nmAviso, nmErro);

  // Andamento de cada modo de compilação, mostrado no cabeçalho
  TStatusEtapa = (seNenhum, seAguardando, seExecutando, seConcluido, seErro);

  TOnInformarSituacao = reference to procedure (const Mensagem: string;
    const ANivel: TNivelMensagem);
  TOnStatusModoCompilacao = reference to procedure (const AModo: TModoCompilacao;
    const AStatus: TStatusEtapa);
  TOnProgresso  = TProc;

  TACBrCompilerOpcoes = record
    DeveInstalarCapicom: Boolean;
    DeveInstalarOpenSSL: Boolean;
    DeveInstalarXMLSec: Boolean;
    DeveInstalarMsXML: Boolean;
    UsarCargaTardiaDLL: Boolean;
    RemoverStringCastWarnings: Boolean;
    DeveSobrescreverDllsExistentes: Boolean;
    UsarExportadorFRSVG: Boolean;
    UsarExportadorFRPNG: Boolean;
    UsarACBrXmlDocument: Boolean;
  public
    procedure DesligarDefines(const ArquivoACBrInc: TFileName);
    procedure RedefinirValoresOpcoesParaPadrao;
    procedure CarregarDeArquivoIni(const ArquivoIni: string);
    procedure SalvarEmArquivoIni(const ArquivoIni: string);
  end;

  TACBrInstallOpcoes = record
  private
    function GetModosCompilacao: TModosCompilacao;
  public
    LimparArquivosACBrAntigos: Boolean;
    DeixarSomentePastasLib: Boolean;
    UsarCpp: Boolean;
    UsarUsarArquivoConfig: Boolean;
    sDestinoDLLs: TDestino;
    DiretorioRaizACBr: string;
    DeveCopiarOutrasDLLs: Boolean;
    // Instalar os pacotes também na IDE de 64 bits, quando a versão do
    // Delphi possuir uma (Delphi 12.3 em diante)
    InstalarNaIDE64Bits: Boolean;

    // Modos (Release/Debug) em que os pacotes são compilados. Não é escolha
    // separada: decorre de DeixarSomentePastasLib, veja GetModosCompilacao.
    property ModosCompilacao: TModosCompilacao read GetModosCompilacao;

    function QuantidadeModosCompilacao: Integer;
    procedure RedefinirValoresOpcoesParaPadrao;
    procedure CarregarDeArquivoIni(const ArquivoIni: string);
    procedure SalvarEmArquivoIni(const ArquivoIni: string);
  end;

  TACBrInstallComponentes = class(TObject)
  private
    FApp: TApplication;
    FOnIniciaNovaInstalacao: TOnIniciaNovaInstalacao;
    FOnProgresso: TOnProgresso;
    FOnInformaSituacao: TOnInformarSituacao;
    FOnStatusModoCompilacao: TOnStatusModoCompilacao;

    FUmaPlataformaDestino: TACBrPlataformaInstalacaoAlvo;

    FPacoteAtual: TFileName;

    FArquivoLog: string;
    FNivelLog: TNivelLog;

    FCountErros: Integer;
    FJaCopiouDLLs: Boolean;
    FJaFezLimpezaArquivoACBrAntigos: Boolean;
    FModoCompilacaoAtual: TModoCompilacao;
    FIDEsLimpasNestaExecucao: TStringList;
    FQtdeOrfaosRemovidos: Integer;
    FIndicePacotes: TStringList;

    function DirLibraryAtual: string;
    function ModoParaInstalacao: TModoCompilacao;
    function LimpezaDaIDEJaFoiFeita: Boolean;
    procedure RemoverRegistrosOrfaosDeTodasIDEs(ListaPlataformas: TListaPlataformasAlvos);

    // Índice nome do .dpk -> diretório, montado uma vez por execução.
    // Antes cada pacote disparava uma busca recursiva em Pacotes\Delphi.
    procedure MontarIndiceDePacotes(const PastaACBr: string);
    function DiretorioDoPacote(const ANomeArquivoDpk: string): string;
    function DependenciasFaltando(const AArquivoDpk: string): string;
    function PodeInstalarPacotesNaIDE: Boolean;
    function InstalarPacoteNaIDE(const ANomeArquivoPacote: string): Boolean;
    function DesinstalarPacoteDaIDE(const ANomeArquivoPacote: string): Boolean;

    procedure ColetarDiretoriosDeFontes(const ADirRaiz: string; ALista: TStrings;
      const ASomenteComFontes: Boolean);
    procedure CopiarArquivoDLLTo(ADestino : TDestino; const ANomeArquivo: String; const APathBin: string);

    procedure InstalarCapicom(ADestino : TDestino; const APathBin: string);
    procedure InstalarDiversos(ADestino: TDestino; const APathBin: string);
    procedure InstalarLibXml2(ADestino: TDestino; const APathBin: string);
    procedure InstalarOpenSSL(ADestino: TDestino; const APathBin: string);
    procedure InstalarXMLSec(ADestino: TDestino; const APathBin: string);

    procedure FazLog(const Texto: string; const ANivelLog: TNivelLog = nlMedio; const ReiniciaArquivo: Boolean = False);
    procedure InformaSituacao(const Mensagem: string;
      const ANivel: TNivelMensagem = nmInfo);
    procedure InformaStatusModo(const AModo: TModoCompilacao; const AStatus: TStatusEtapa);
    procedure InformaProgresso;

    function RetornaPath(const ADestino: TDestino; const APathBin: string): string;
    procedure RemoverPacotesAntigos;
    procedure RemoverDiretoriosACBrDoPath;
    procedure RemoverArquivosAntigosDoDisco;

    procedure RemoverACBrDoPathDaIDE;
    procedure AdicionarPastaDosBplsNoPathDaIDE;
    procedure AddLibrarySearchPath;
    procedure DeixarSomenteLib;

    procedure ApagarOutrosArquivosDaPastaLibrary(const PastarLibrary: string);
    procedure LimparArtefatosDaRaizDaPlataforma;
    procedure CopiarOutrosArquivosParaPastaLibrary;
    procedure BeforeExecute(Sender: TJclBorlandCommandLineTool);
    procedure CompilaPacotePorNomeArquivo(const NomePacote: string);
    procedure OutputCallLine(const Text: string);
    procedure CompilarEInstalarPacotes(ListaPacotes: TPacotes);
    procedure CompilarPacotes(const PastaACBr: string; listaPacotes: TPacotes);
    procedure InstalarPacotes(const PastaACBr: string; listaPacotes: TPacotes);
    function PathArquivoLog(const NomeVersao: string): String;

    procedure FazInstalacaoInicial(ListaPacotes: TPacotes; UmaPlataformaDestino: TACBrPlataformaInstalacaoAlvo);
    procedure InstalarOutrosRequisitos;
    procedure FazInstalacaoDLLs(const APathBin: string);
    procedure ConfiguraMetodosCompiladores;
//    function FazBroadcastDeAlteracaoDeConfiguracao(cs: PWideChar) : Integer;

  public
    OpcoesInstall: TACBrInstallOpcoes;
    OpcoesCompilacao: TACBrCompilerOpcoes;

    constructor Create(app: TApplication);
    destructor Destroy; override;

    procedure LerDeArquivoIni(const ArquivoIni: string);
    procedure SalvarConfiguracoesEmArquivoIni(const ArquivoIni: string);

    function Instalar(ListaPacotes: TPacotes; ListaVersoesInstalacao:TList<Integer>;
      ListaPlataformasInstalacao: TListaPlataformasAlvos): Boolean;

    property OnIniciaNovaInstalacao: TOnIniciaNovaInstalacao read FOnIniciaNovaInstalacao write FOnIniciaNovaInstalacao;
    property OnProgresso: TOnProgresso read FOnProgresso write FonProgresso;
    property OnInformaSituacao: TOnInformarSituacao read FOnInformaSituacao write FOnInformaSituacao;
    property OnStatusModoCompilacao: TOnStatusModoCompilacao read FOnStatusModoCompilacao
      write FOnStatusModoCompilacao;
  end;

  function sVersaoInstalador: string;

implementation

uses
  ShellApi, Types, IOUtils, StrUtils,
  ACBrUtil.FilesIO, ACBrUtil.Strings, ACBr.InstallUtils, IniFiles,
  JvVersionInfo;

function GetSVNRevision(const APath: string): string;
const
  // O svn pode ficar pendurado (rede, credencial, working copy travada). Isso
  // aqui só monta o cabeçalho do log, então não pode segurar a instalação.
  cTempoLimiteSVN = 10000; // ms
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutRead, StdOutWrite: THandle;
  Buffer: array[0..1023] of AnsiChar;
  BytesRead, BytesDisponiveis: DWORD;
  Output: TStringList;
  Command, LastDate, Rev: string;
  LLimite: UInt64;
  LEncerrado: Boolean;
begin
  Result := 'Não foi possível obter informações SVN.';
  try
    Output := TStringList.Create;
    try
      SA.nLength := SizeOf(SA);
      SA.bInheritHandle := True;
      SA.lpSecurityDescriptor := nil;
      if not CreatePipe(StdOutRead, StdOutWrite, @SA, 0) then
        RaiseLastOSError;

      try
        FillChar(SI, SizeOf(SI), 0);
        SI.cb := SizeOf(SI);
        SI.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
        SI.wShowWindow := SW_HIDE;
        SI.hStdOutput := StdOutWrite;
        SI.hStdError := StdOutWrite;

        Command := 'svn info "\\?\' + APath + '"';

        if not CreateProcess(nil, PChar(Command), nil, nil, True,
          CREATE_NO_WINDOW, nil, nil, SI, PI) then
        begin
          CloseHandle(StdOutWrite);
          RaiseLastOSError;
        end;

        // a ponta de escrita precisa ser fechada aqui, senão a leitura abaixo
        // nunca enxerga o fim do fluxo
        CloseHandle(StdOutWrite);
        try
          LLimite := GetTickCount64 + cTempoLimiteSVN;
          LEncerrado := False;
          repeat
            BytesDisponiveis := 0;
            if PeekNamedPipe(StdOutRead, nil, 0, nil, @BytesDisponiveis, nil) and
               (BytesDisponiveis > 0) then
            begin
              BytesRead := 0;
              if (not ReadFile(StdOutRead, Buffer, SizeOf(Buffer)-1, BytesRead, nil)) or
                 (BytesRead = 0) then
                Break;
              Buffer[BytesRead] := #0;
              Output.Text := Output.Text + string(Buffer);
            end
            else
            begin
              // nada para ler: ou o processo ainda está trabalhando, ou já
              // terminou e o que sobrou no pipe foi todo consumido
              if LEncerrado then
                Break;
              LEncerrado := (WaitForSingleObject(PI.hProcess, 50) = WAIT_OBJECT_0);
            end;
          until (GetTickCount64 > LLimite);

          if (not LEncerrado) and (GetTickCount64 > LLimite) then
          begin
            TerminateProcess(PI.hProcess, 1);
            Result := 'Não foi possível obter informações SVN (tempo esgotado).';
          end;
        finally
          CloseHandle(PI.hThread);
          CloseHandle(PI.hProcess);
        end;
      finally
        CloseHandle(StdOutRead);
      end;

      // Extrai o campo "Revision" e "LastDate"
      for var S in Output do
      begin
        if Pos('Revision:', S) = 1 then
          Rev := 'Revision SVN: '+Trim(Copy(S, 10, MaxInt));

        if Pos('Last Changed Date:', S) = 1 then
          LastDate := 'Last Changed Date: ' + Trim(Copy(S, 20, MaxInt));

        if (Rev <> '') and (LastDate <> '') then
        begin
          Result := Rev + sLineBreak + LastDate;
          Break;
        end;
      end;
    finally
      Output.Free;
    end;
  except
//    on E: EOSError do
//    begin
//      Result := Result + ' Erro:' + E.Message;
//    end;
    on E: Exception do
    begin
      Result := Result + ' Erro:' + E.Message;
    end;
  end;

end;

function sVersaoInstalador: string;
var
  jvVerInfo: TJvVersionInfo;
begin
  jvVerInfo := AppVerInfo;
  try
    Result := jvVerInfo.FileVersion;
  finally
    jvVerInfo.Free;
  end;
end;

{ TACBrInstallComponentes }
constructor TACBrInstallComponentes.Create(app: TApplication);
begin
  inherited Create;
  OpcoesInstall.RedefinirValoresOpcoesParaPadrao;
  OpcoesCompilacao.RedefinirValoresOpcoesParaPadrao;

  FArquivoLog := '';
  FNivelLog  := nlMedio;
  FJaFezLimpezaArquivoACBrAntigos := False;
  FIDEsLimpasNestaExecucao := TStringList.Create;
  FIDEsLimpasNestaExecucao.Sorted := True;
  FIDEsLimpasNestaExecucao.Duplicates := dupIgnore;
  FQtdeOrfaosRemovidos := 0;
  FIndicePacotes := TStringList.Create;

  FApp := app;
//  UmaPlataformaDestino := TPlataformaDestino.Create;
//  oACBr := TJclBorRADToolInstallations.Create;
//  tcpt  := TCompileTargetList.Create;

end;

destructor TACBrInstallComponentes.Destroy;
begin
//  tcpt.Free;
//  oACBr.Free;
//  UmaPlataformaDestino.Free;
  FIDEsLimpasNestaExecucao.Free;
  FIndicePacotes.Free;
  inherited;
end;

procedure TACBrInstallComponentes.ConfiguraMetodosCompiladores;
begin
  // -- Evento disparado antes de iniciar a execução do processo.
  FUmaPlataformaDestino.InstalacaoAtual.DCC32.OnBeforeExecute := BeforeExecute;
  if clDcc64 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCC64.OnBeforeExecute := BeforeExecute;
  if clDccOSX32 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCOSX32.OnBeforeExecute := BeforeExecute;
  if clDccOSX64 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCOSX64.OnBeforeExecute := BeforeExecute;
  if clDcciOSSimulator in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCiOSSimulator.OnBeforeExecute := BeforeExecute;
  if clDcciOS32 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCiOS32.OnBeforeExecute := BeforeExecute;
  if clDcciOS64 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCiOS64.OnBeforeExecute := BeforeExecute;
  if clDccArm32 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCArm32.OnBeforeExecute := BeforeExecute;
  if clDccArm64 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCArm64.OnBeforeExecute := BeforeExecute;
  if clDccLinux64 in FUmaPlataformaDestino.InstalacaoAtual.CommandLineTools then
    (FUmaPlataformaDestino.InstalacaoAtual as TJclBDSInstallation).DCCLinux64.OnBeforeExecute := BeforeExecute;

  // -- Evento para saidas de mensagens.
  FUmaPlataformaDestino.InstalacaoAtual.OutputCallback := OutputCallLine;
end;

procedure TACBrInstallComponentes.OutputCallLine(const Text: string);
begin
  // Evento disparado a cada ação do compilador...

  // remover a warnings de conversão de string (delphi 2010 em diante)
  // as diretivas -W e -H não removem estas mensagens
  if (pos('Warning: W1057', Text) <= 0) and ((pos('Warning: W1058', Text) <= 0)) then
  begin
    FazLog(Text);
  end;

  if (Pos('This version of the product does not support command line compiling', Text) > 0) then
  begin
    //Encontramos um Delphi trial. Precisamos abortar a instalação.
    Inc(FCountErros);
    FazLog('O ACBrInstall precisa usar o compilador por linha de comando. Na sua versão o compilador por linha de comando está desativado.');
    FazLog('Geralmente isso acontece com versões Trial ou Community Edition do Delphi.');
    FazLog('Você precisará instalar os pacotes manualmente.');
  end;
end;

procedure TACBrInstallComponentes.BeforeExecute(Sender: TJclBorlandCommandLineTool);
const
  //VersoesComNamespaces: array[0..14] of string = ('d16', 'd17','d18','d19','d20','d21','d22','d23','d24', 'd25',
  //                                                'd26','d27', 'd28','d29', 'd37');
  NamespacesBase = 'System;Xml;Data;Datasnap;Web;Soap;';
  NamespacesWindows = 'Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Winapi;System.Win;';
  NamespacesOSX = 'Macapi;Posix;System.Mac;';
  NamespacesAndroid = '';
  NamespacesiOS = '';
  NamespacesVCL = 'Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;';
  NamespacesFMX = 'FMX;FMX.ASE;FMX.Bind;FMX.Canvas;FMX.DAE;FMX.DateTimeControls;FMX.EmbeddedControls;FMX.Filter;FMX.ListView;FMX.MediaLibrary;';
var
  LArquivoCfg: TFilename;
  NamespacesTemp: string;
  LDirLibrary: string;

begin
  LDirLibrary := DirLibraryAtual;
  with FUmaPlataformaDestino do
  begin
    // Evento para setar os parâmetros do compilador antes de compilar

    // limpar os parâmetros do compilador
    Sender.Options.Clear;

    // não utilizar o dcc32.cfg
    if (InstalacaoAtual.SupportsNoConfig) and
       // -- Arquivo cfg agora opcional no caso de paths muito extensos
       (not OpcoesInstall.UsarUsarArquivoConfig) then
      Sender.Options.Add('--no-config');

    // -B = Build all units. O -M (make, só o que mudou) era enviado junto, mas
    // um anula o outro: com -B o compilador refaz tudo de qualquer jeito. Ficou
    // só o -B, que é o que já valia na prática -- e é o único seguro aqui, porque
    // na compilação Debug o -U abaixo inclui a pasta do Release e o -M poderia
    // dar por bom um .dcu da outra configuração.
    Sender.Options.Add('-B');
    // -Q = Quiet compile
    Sender.Options.Add('-Q');
    // -H- = não mostrar hints
    Sender.Options.Add('-H-');
    // -W- = não mostrar warnings
    Sender.Options.Add('-W-');

    // As chaves abaixo são sempre informadas explicitamente nos dois modos, para
    // que o resultado não dependa nem do padrão do dcc32 nem do que estiver
    // escrito dentro do .dpk.
    if (FModoCompilacaoAtual = mcDebug) then
    begin
      // O- = Otimização desligada (código na ordem do fonte, facilita o passo a passo)
      Sender.Options.Add('-$O-');
      // W+ = Gera stack frames (pilha de chamadas confiável no depurador)
      Sender.Options.Add('-$W+');
      // D+ = Informação de depuração
      Sender.Options.Add('-$D+');
      // L+ = Símbolos locais
      Sender.Options.Add('-$L+');
      // Y+ = Informação de referência de símbolos
      Sender.Options.Add('-$Y+');
      // C+ = Assertions ligadas
      Sender.Options.Add('-$C+');
      // -V = Informações de depuração no binário gerado
      Sender.Options.Add('-V');
      // -D<syms> = Define conditionals
      Sender.Options.Add('-DDEBUG');
    end
    else
    begin
      // O+ = Otimização ligada. Estava como -$O- (igual ao Debug), o que fazia
      // o "Release" sair sem otimização nenhuma.
      Sender.Options.Add('-$O+');
      // W- = Não gera stack frames. Estava como -$W+, também igual ao Debug.
      Sender.Options.Add('-$W-');
      // D- = Sem informação de depuração
      Sender.Options.Add('-$D-');
      // L- = Sem símbolos locais
      Sender.Options.Add('-$L-');
      // Y- = Sem informação de referência de símbolos
      Sender.Options.Add('-$Y-');
      // C- = Assertions desligadas
      Sender.Options.Add('-$C-');
      // -D<syms> = Define conditionals
      Sender.Options.Add('-DRELEASE');
    end;

    // Q (overflow) e R (range) ficam desligados nos DOIS modos, que é o padrão do
    // dcc32. Ligá-los no Debug faria as rotinas de CRC/hash do ACBr, que contam
    // com o estouro de inteiro, passarem a levantar exceção.
    Sender.Options.Add('-$Q-');
    Sender.Options.Add('-$R-');

    // -U<paths> = Unit directories
    Sender.AddPathOption('U', InstalacaoAtual.LibFolderName[tPlatformAtual]);
    Sender.AddPathOption('U', InstalacaoAtual.LibrarySearchPath[tPlatformAtual]);
    Sender.AddPathOption('U', LDirLibrary);
    if (FModoCompilacaoAtual = mcDebug) then
      Sender.AddPathOption('U', DirLibraryPorModo(mcRelease));
    // -I<paths> = Include directories
    Sender.AddPathOption('I', InstalacaoAtual.LibrarySearchPath[tPlatformAtual]);
    // -R<paths> = Resource directories
    Sender.AddPathOption('R', InstalacaoAtual.LibrarySearchPath[tPlatformAtual]);
    // -N0<path> = unit .dcu output directory
    Sender.AddPathOption('N0', LDirLibrary);
    Sender.AddPathOption('LE', LDirLibrary);
    Sender.AddPathOption('LN', LDirLibrary);

    // ************ C++ Builder *************** //
    if OpcoesInstall.UsarCpp then
    begin
       // -JL compila c++ builder
       Sender.AddPathOption('JL', LDirLibrary);
       // -NO compila .dpi output directory c++ builder
       Sender.AddPathOption('NO', LDirLibrary);
       // -NB compila .lib output directory c++ builder
       Sender.AddPathOption('NB', LDirLibrary);
       // -NH compila .hpp output directory c++ builder
       Sender.AddPathOption('NH', LDirLibrary);
    end;

    //Montar namespaces:
    if (InstalacaoAtual.IDEPackageVersionNumber >= 16) then
    begin
  //    Namespaces := '';

      NamespacesTemp := NamespacesBase;

      if tPlatformAtual in [bpWin32, bpWin64] then
      begin
        NamespacesTemp := NamespacesTemp + NamespacesWindows;

        if tPlatformAtual = bpWin32 then
        begin
          NamespacesTemp := NamespacesTemp + 'Bde;';
        end;
      end;

      if tPlatformAtual in [bpWin32, bpWin64] {and notFMX} then
      begin
        NamespacesTemp := NamespacesTemp + NamespacesVCL;
      end;

      if not (tPlatformAtual in [bpWin32, bpWin64]) {or FMX} then
      begin
        NamespacesTemp := NamespacesTemp + NamespacesFMX;
      end;

      if tPlatformAtual = bpOSX32 then
      begin
        NamespacesTemp := NamespacesTemp + NamespacesOSX;
      end;

      Sender.Options.Add('-NS'+NamespacesTemp);

    end;

    if (OpcoesInstall.UsarUsarArquivoConfig) then
    begin
      LArquivoCfg := ChangeFileExt(FPacoteAtual, '.cfg');
      Sender.Options.SaveToFile(LArquivoCfg);
      Sender.Options.Clear;
    end;
  end;//<---End With Temporário
end;

procedure TACBrInstallComponentes.DeixarSomenteLib;
var
  LDiretorios: TStringList;
begin
  // remove do Library Search Path todas as pastas de fontes, deixando apenas
  // a pasta da combinação instalada (o Browsing Path é mantido, para o
  // Ctrl+Click continuar abrindo os fontes)
  LDiretorios := TStringList.Create;
  try
    ColetarDiretoriosDeFontes(OpcoesInstall.DiretorioRaizACBr + 'Fontes', LDiretorios, False);
    FUmaPlataformaDestino.RemoverDoLibrarySearchPath(LDiretorios);
  finally
    LDiretorios.Free;
  end;
end;

procedure TACBrInstallComponentes.FazInstalacaoInicial(ListaPacotes: TPacotes; UmaPlataformaDestino:
   TACBrPlataformaInstalacaoAlvo);
var
  Cabecalho: string;
  NomeVersao: string;
  ModosCompilados: string;
  LModo: TModoCompilacao;
begin

  with UmaPlataformaDestino do
  begin
    NomeVersao := VersionNumberToNome(InstalacaoAtual.VersionNumberStr);
    // dois perfis da mesma IDE gravariam no mesmo arquivo de log
    if (NomePerfil <> '') then
      NomeVersao := NomeVersao + ' [' + NomePerfil + ']';

    ModosCompilados := '';
    for LModo := Low(TModoCompilacao) to High(TModoCompilacao) do
    begin
      if (LModo in OpcoesInstall.ModosCompilacao) then
      begin
        if ModosCompilados <> '' then
          ModosCompilados := ModosCompilados + ', ';
        ModosCompilados := ModosCompilados + cNomeModoCompilacao[LModo];
      end;
    end;

    FArquivoLog := PathArquivoLog(NomeVersao+ ' ' + sPlatform);
    Cabecalho := 'Versao Instalador: ' + sVersaoInstalador + sLineBreak +
                 'Executado em: ' + DateTimeToStr(Now) + sLineBreak +
                 'Versão do delphi: ' + NomeVersao + ' ' + sPlatform + sLineBreak +
                 'Dir. Instalação : ' + OpcoesInstall.DiretorioRaizACBr + sLineBreak +
                 'Dir. Bibliotecas: ' + sDirLibrary + '\<Configuração>' + sLineBreak +
                 'Modos de compilação: ' + ModosCompilados + sLineBreak +
                 'Registros órfãos removidos: ' + IntToStr(FQtdeOrfaosRemovidos) + sLineBreak +
                 'Instala pacotes na IDE: ' + BoolToStr(Self.PodeInstalarPacotesNaIDE, True) + sLineBreak +
                 GetSVNRevision( ExtractFilePath(ParamStr(0)) );

    FazLog(Cabecalho + sLineBreak, nlMinimo, True);

    if Assigned(OnIniciaNovaInstalacao) then
      FOnIniciaNovaInstalacao(
        (ListaPacotes.Count * (OpcoesInstall.QuantidadeModosCompilacao + 1)) + 6,
        FArquivoLog, Cabecalho);

    // cabeçalho começa com todos os modos selecionados na fila
    for LModo := Low(TModoCompilacao) to High(TModoCompilacao) do
    begin
      if (LModo in OpcoesInstall.ModosCompilacao) then
        InformaStatusModo(LModo, seAguardando);
    end;

    FCountErros := 0;

    InformaSituacao('-- Pré Instalação...', nmDestaque);
    // limpar arquivos antigos somente ao iniciar o procedimento de instalação
    if (OpcoesInstall.LimparArquivosACBrAntigos) and (not FJaFezLimpezaArquivoACBrAntigos)  then
    begin
      FJaFezLimpezaArquivoACBrAntigos := True;
      InformaSituacao('Removendo arquivos ACBr antigos dos discos...');
      RemoverArquivosAntigosDoDisco;
      InformaSituacao('...OK', nmSucesso);
    end;
    //se a opção não estiver marcada deve informar o progresso também...
    InformaProgresso;

    ConfiguraMetodosCompiladores;

    InformaSituacao('Removendo librarypaths da instalação anterior do ACBr na IDE...');
    RemoverDiretoriosACBrDoPath;
    InformaSituacao('...OK', nmSucesso);

    if not LimpezaDaIDEJaFoiFeita then
    begin
      InformaSituacao('Removendo pacotes da instalação anterior do ACBr na IDE...');
      RemoverPacotesAntigos;
      RemoverACBrDoPathDaIDE;
      InformaSituacao('...OK', nmSucesso);
    end;
    InformaProgresso;

    // *************************************************************************
    // Cria diretório de biblioteca da versão do delphi selecionada,
    // só será criado se não existir
    // *************************************************************************
    InformaSituacao('Criando diretórios de bibliotecas para ' + sPlatform + '...');
    // a raiz da plataforma é apenas o container das configurações
    ForceDirectories(sDirLibrary);
    LimparArtefatosDaRaizDaPlataforma;

    for LModo := Low(TModoCompilacao) to High(TModoCompilacao) do
    begin
      if (LModo in OpcoesInstall.ModosCompilacao) then
        ForceDirectories(DirLibraryPorModo(LModo));
    end;
    ApagarOutrosArquivosDaPastaLibrary(sDirLibrary);
    InformaSituacao('...OK', nmSucesso);
    InformaProgresso;

    // *************************************************************************
    // Adiciona os paths dos fontes na versão do delphi selecionada
    // *************************************************************************
    InformaSituacao('Adicionando library paths para ' + sPlatform + '...');
    AddLibrarySearchPath;
    InformaSituacao('...OK', nmSucesso);
    InformaProgresso;

    // -- adicionar ao environment variables do delphi
    // Vale para as duas plataformas: a IDE de 64 bits usa o mesmo PATH, e o
    // loader do Windows escolhe a DLL da arquitetura certa.
    InformaSituacao('Adicionando a pasta dos BPLs ' + sPlatform + ' ao PATH do Delphi...');
    AdicionarPastaDosBplsNoPathDaIDE;
    InformaSituacao('...OK', nmSucesso);
    InformaProgresso;

    if OpcoesCompilacao.UsarExportadorFRSVG then
      InformaSituacao('Habilitado Diretiva de Exportação SVG para Fast Reports...');

    if OpcoesCompilacao.UsarExportadorFRPNG then
      InformaSituacao('Habilitado Diretiva de Exportação PNG para Fast Reports...');

    CompilarEInstalarPacotes(ListaPacotes);

  end; //<---- endwith
end;

// retornar o caminho completo para o arquivo de logs
function TACBrInstallComponentes.PathArquivoLog(const NomeVersao: string): String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
            'log_' + StringReplace(NomeVersao, ' ', '_', [rfReplaceAll]) + '.txt';
end;

procedure TACBrInstallComponentes.FazLog(const Texto: string; const ANivelLog: TNivelLog = nlMedio; const
    ReiniciaArquivo: Boolean = False);
begin
  if ANivelLog > FNivelLog then
  begin
    Exit
  end;

  if FArquivoLog <> EmptyStr then
    WriteToTXT(FArquivoLog, AnsiString(Texto), not ReiniciaArquivo);
end;

function TACBrInstallComponentes.RetornaPath(const ADestino: TDestino; const APathBin: string): string;
begin
  case ADestino of
    tdSystem: Result := '"'+ PathSystem + '"';
    tdDelphi: Result := '"'+ APathBin + '"';
    tdNone:   Result := 'Tipo de destino "nenhum" não aceito!';
  else
    Result := 'Tipo de destino desconhecido!'
  end;
end;

procedure TACBrInstallComponentes.FazInstalacaoDLLs(const APathBin: string);
begin
  // *************************************************************************
  // instalar capicom
  // *************************************************************************
  try
    if OpcoesCompilacao.DeveInstalarCapicom then
    begin
      InstalarCapicom(OpcoesInstall.sDestinoDLLs, APathBin);
      InformaSituacao('CAPICOM instalado com sucesso em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin), nmSucesso);
    end;
  except
    on E: Exception do
    begin
      Inc(FCountErros);
      InformaSituacao('Ocorreu erro ao instalar a CAPICOM em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin) + sLineBreak +
            'Erro: ' + E.Message, nmErro);
    end;
  end;

  // *************************************************************************
  // instalar OpenSSL
  // *************************************************************************
  try
    if OpcoesCompilacao.DeveInstalarOpenSSL then
    begin
      InstalarOpenSSL(OpcoesInstall.sDestinoDLLs, APathBin);
      InformaSituacao('OPENSSL instalado com sucesso em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin), nmSucesso);
    end;
  except
    on E: Exception do
    begin
      Inc(FCountErros);
      InformaSituacao('Ocorreu erro ao instalar a OPENSSL em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin) + sLineBreak +
            'Erro: ' + E.Message, nmErro);
    end;
  end;

  // *************************************************************************
  //instalar todas as "OUTRAS" DLLs
  // *************************************************************************
  if OpcoesInstall.DeveCopiarOutrasDLLs then
  begin
    try
      InstalarLibXml2(OpcoesInstall.sDestinoDLLs, APathBin);
      InformaSituacao('LibXml2 instalado com sucesso em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin), nmSucesso);

      InstalarDiversos(OpcoesInstall.sDestinoDLLs, APathBin);
      InformaSituacao('DLLs diversas instalado com sucesso em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin), nmSucesso);

      if OpcoesCompilacao.DeveInstalarXMLSec then
      begin
        InstalarXMLSec(OpcoesInstall.sDestinoDLLs, APathBin);
        InformaSituacao('XMLSec instalado com sucesso em '+ RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin), nmSucesso);
      end;
    except
      on E: Exception do
      begin
        Inc(FCountErros);
        InformaSituacao(
          'Ocorreu erro ao instalar Outras DLL´s em '+
          RetornaPath(OpcoesInstall.sDestinoDLLs, APathBin) + sLineBreak +
          'Erro: ' + E.Message, nmErro);
      end;
    end;
  end;
end;

procedure TACBrInstallComponentes.InformaProgresso;
begin
  if Assigned(FOnProgresso) then
    FOnProgresso;
end;

// Percorre a pasta de fontes do ACBr e devolve os diretórios encontrados, sem
// tocar na configuração da IDE. A gravação dos paths é feita depois, de uma vez
// só: a JCL regrava o EnvOptions.proj inteiro a cada diretório adicionado.
procedure TACBrInstallComponentes.ColetarDiretoriosDeFontes(const ADirRaiz: string;
  ALista: TStrings; const ASomenteComFontes: Boolean);

  function ExisteArquivoPasNoDir(const ADir: string): Boolean;
  var
    oDirList: TSearchRec;
  begin
    Result := False;
    if FindFirst(IncludeTrailingPathDelimiter(ADir) + '*.pas', faNormal, oDirList) = 0 then
    begin
      try
        Result := True;
      finally
        SysUtils.FindClose(oDirList)
      end;
    end;
  end;

  function EProibido(const ADir: String): Boolean;
  const
    LISTA_PROIBIDOS: ARRAY[0..14] OF STRING = (
      'quick', 'rave', 'laz', 'VerificarNecessidade', '__history', '__recovery', 'backup',
      'Logos', 'Colorido', 'PretoBranco', 'Imagens', 'bmp', 'logotipos', 'PerformanceTest', 'test'
    );
  var
    Str: String;
  begin
    Result := False;
    for str in LISTA_PROIBIDOS do
    begin
      if Pos(AnsiUpperCase(str), AnsiUpperCase(ADir)) > 0 then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
  oDirList: TSearchRec;
  LDirRaiz, LSubDir: string;
begin
  LDirRaiz := IncludeTrailingPathDelimiter(ADirRaiz);

  if FindFirst(LDirRaiz + '*.*', faDirectory, oDirList) <> 0 then
    Exit;

  try
    repeat
      if ((oDirList.Attr and faDirectory) = 0) or
         (oDirList.Name = '.') or (oDirList.Name = '..') then
        Continue;

      LSubDir := LDirRaiz + oDirList.Name;

      if ASomenteComFontes then
      begin
        if EProibido(oDirList.Name) then
          Continue;

        if ExisteArquivoPasNoDir(LSubDir) then
          ALista.Add(LSubDir);
      end
      else
        ALista.Add(LSubDir);

      ColetarDiretoriosDeFontes(LSubDir, ALista, ASomenteComFontes);
    until FindNext(oDirList) <> 0;
  finally
    SysUtils.FindClose(oDirList);
  end;
end;

procedure TACBrInstallComponentes.AddLibrarySearchPath;
var
  InstalacaoAtualCpp: TJclBDSInstallation;
  LDirLibrary: string;
  LDiretorios: TStringList;
begin
  // adicionar o paths ao library path do delphi
  with FUmaPlataformaDestino do
  begin
    LDirLibrary := DirLibraryPorModo(ModoParaInstalacao);

    LDiretorios := TStringList.Create;
    try
      LDiretorios.Add(LDirLibrary);
      ColetarDiretoriosDeFontes(OpcoesInstall.DiretorioRaizACBr + 'Fontes', LDiretorios, True);

      // uma única gravação por path, em vez de uma por diretório
      AdicionarNosPathsDeBiblioteca(LDiretorios);
      FazLog(Format('Adicionados %d diretórios ao Library Path de %s.',
                    [LDiretorios.Count, sPlatform]), nlMedio);
    finally
      LDiretorios.Free;
    end;

    // os .dcu com informações de depuração ficam na pasta do modo Debug
    if (mcDebug in OpcoesInstall.ModosCompilacao) then
      InstalacaoAtual.AddToDebugDCUPath(DirLibraryPorModo(mcDebug), tPlatformAtual)
    else
      InstalacaoAtual.AddToDebugDCUPath(LDirLibrary, tPlatformAtual);

    // caminho onde a IDE (32 ou 64 bits) procura os BPLs de runtime do ACBr
    if Self.PodeInstalarPacotesNaIDE then
      AdicionarPackageSearchPath(LDirLibrary);

    //-- ************ C++ Builder *************** //
    if OpcoesInstall.UsarCpp then
    begin
       if InstalacaoAtual is TJclBDSInstallation then
       begin
         InstalacaoAtualCpp := TJclBDSInstallation(InstalacaoAtual);
         InstalacaoAtualCpp.AddToCppSearchPath(LDirLibrary, tPlatformAtual);
         InstalacaoAtualCpp.AddToCppLibraryPath(LDirLibrary, tPlatformAtual);
         InstalacaoAtualCpp.AddToCppBrowsingPath(LDirLibrary, tPlatformAtual);
         InstalacaoAtualCpp.AddToCppIncludePath(LDirLibrary, tPlatformAtual);
       end;
    end;
  end;//---endwith
end;

procedure TACBrInstallComponentes.RemoverDiretoriosACBrDoPath();
begin
  with FUmaPlataformaDestino do
  begin
    // Search Path, Browsing Path e Debug DCU Path
    RemoverDosPathsDeBiblioteca('ACBR');
    // caminho de procura dos BPLs de runtime
    RemoverPackageSearchPathACBr;
  end;//---endwith
end;

// Remove TODOS os registros do ACBr desta IDE, nas duas listas (32 e 64 bits),
// independente da plataforma/configuração que está sendo instalada agora.
// Limpar somente a combinação atual deixaria para trás registros de uma
// combinação anterior apontando para BPLs que mudaram de pasta ou sumiram,
// que é o que faz a IDE reclamar de pacote inexistente ao abrir.
procedure TACBrInstallComponentes.RemoverPacotesAntigos;
var
  I: Integer;
  LRemovidos: Integer;
begin
  with FUmaPlataformaDestino do
  begin
    // Lista de 32 bits: pela JCL, para manter o cache interno dela consistente
    for I := InstalacaoAtual.IdePackages.Count[False] - 1 downto 0 do
    begin
      if Pos('ACBR', AnsiUpperCase(InstalacaoAtual.IdePackages.PackageFileNames[I, False])) > 0 then
        InstalacaoAtual.IdePackages.RemovePackage(InstalacaoAtual.IdePackages.PackageFileNames[I, False], False);
    end;

    // Lista de 64 bits: a JCL não a conhece
    LRemovidos := RemoverPacotesACBrDaIDE(cSecaoKnownPackagesX64, False);
    if LRemovidos > 0 then
      FazLog(Format('Removidos %d registros do ACBr de "%s".',
                    [LRemovidos, cSecaoKnownPackagesX64]), nlMedio);
  end;//---endwith
end;

// A limpeza vale para a IDE inteira, então só pode acontecer uma vez por
// execução. Repetir a cada plataforma apagaria o que a plataforma anterior
// acabou de registrar nesta mesma execução.
function TACBrInstallComponentes.LimpezaDaIDEJaFoiFeita: Boolean;
var
  LChave: string;
begin
  LChave := AnsiUpperCase(FUmaPlataformaDestino.InstalacaoAtual.ConfigDataLocation);
  Result := (FIDEsLimpasNestaExecucao.IndexOf(LChave) >= 0);
  if not Result then
    FIDEsLimpasNestaExecucao.Add(LChave);
end;

// Registros apontando para BPLs inexistentes fazem a IDE exibir
// "Can't load package ... Não foi possível encontrar o arquivo especificado".
// Eles sobram em IDEs/plataformas que não participam desta execução, por isso a
// varredura cobre todas as instalações detectadas e não só as selecionadas.
procedure TACBrInstallComponentes.RemoverRegistrosOrfaosDeTodasIDEs(
  ListaPlataformas: TListaPlataformasAlvos);
var
  I: Integer;
  LIDEs: TStringList;
  LChave: string;
begin
  LIDEs := TStringList.Create;
  try
    LIDEs.Sorted := True;
    LIDEs.Duplicates := dupIgnore;

    for I := 0 to ListaPlataformas.Count - 1 do
    begin
      LChave := AnsiUpperCase(ListaPlataformas[I].InstalacaoAtual.ConfigDataLocation);
      if LIDEs.IndexOf(LChave) >= 0 then
        Continue;
      LIDEs.Add(LChave);

      try
        Inc(FQtdeOrfaosRemovidos,
            ListaPlataformas[I].RemoverPacotesACBrDaIDE(cSecaoKnownPackages, True));
        Inc(FQtdeOrfaosRemovidos,
            ListaPlataformas[I].RemoverPacotesACBrDaIDE(cSecaoKnownPackagesX64, True));
      except
        on E: Exception do
        begin
          // O registro do Windows costuma guardar IDEs que já foram
          // desinstaladas; nenhuma delas pode impedir a instalação.
          // LChave (ConfigDataLocation) é usada no lugar de Name porque ler o
          // nome de uma instalação incompleta pode disparar outra exceção.
          InformaSituacao('Aviso: não foi possível limpar registros órfãos de ' +
                          LChave + ': ' + E.Message, nmAviso);
        end;
      end;
    end;
  finally
    LIDEs.Free;
  end;
end;

procedure TACBrInstallComponentes.CopiarArquivoDLLTo(ADestino : TDestino; const ANomeArquivo: String;
     const APathBin: string);
var
  PathOrigem: String;
  PathDestino: String;
  DirSystem: String;
  VaiSobrescrever: Boolean;
begin
  VaiSobrescrever := OpcoesCompilacao.DeveSobrescreverDllsExistentes;

  case ADestino of
    tdSystem: DirSystem := Trim(PathSystem);
    tdDelphi: DirSystem := APathBin;
  end;

  if DirSystem <> EmptyStr then
    DirSystem := IncludeTrailingPathDelimiter(DirSystem)
  else
    raise EFileNotFoundException.Create('Diretório de sistema não encontrado.');

  PathOrigem  := OpcoesInstall.DiretorioRaizACBr + 'DLLs\' + ANomeArquivo;
  PathDestino := DirSystem + ExtractFileName(ANomeArquivo);

  if (FileExists(PathDestino)) and (not VaiSobrescrever) then
  begin
    InformaSituacao(Format('AVISO: Arquivo já se encontra no destino. Não sobrescrito: "%s"', [PathDestino]), nmAviso);
    Exit;
  end;

  if not FileExists(PathOrigem) then
  begin
    InformaSituacao(Format('ERRO: Arquivo não encontrado na origem: "%s"', [PathOrigem]), nmErro);
    raise EFileNotFoundException.Create(Format('ERRO: Arquivo não encontrado na origem: "%s"', [PathOrigem]));
  end;

  if not CopyFile(PWideChar(PathOrigem), PWideChar(PathDestino), (not VaiSobrescrever)) then
  begin
    raise EFilerError.CreateFmt(
      'Ocorreu o seguinte erro ao tentar copiar o arquivo "%s": %d - %s', [
      ANomeArquivo, GetLastError, SysErrorMessage(GetLastError)
    ]);
  end;
end;

procedure TACBrInstallComponentes.InformaStatusModo(const AModo: TModoCompilacao;
  const AStatus: TStatusEtapa);
begin
  if Assigned(FOnStatusModoCompilacao) then
    FOnStatusModoCompilacao(AModo, AStatus);
end;

procedure TACBrInstallComponentes.InformaSituacao(const Mensagem: string;
  const ANivel: TNivelMensagem = nmInfo);
begin
  FazLog(Mensagem);

  if Assigned(OnInformaSituacao) then
    OnInformaSituacao(Mensagem, ANivel);
end;

function TACBrInstallComponentes.Instalar(ListaPacotes: TPacotes; ListaVersoesInstalacao:TList<Integer>;
    ListaPlataformasInstalacao: TListaPlataformasAlvos): Boolean;
var
  I: Integer;
begin
  OpcoesCompilacao.DesligarDefines(OpcoesInstall.DiretorioRaizACBr + 'Fontes\ACBrComum\ACBr.inc');
  FJaCopiouDLLs := False;
  FJaFezLimpezaArquivoACBrAntigos := False;
  FIDEsLimpasNestaExecucao.Clear;
  FQtdeOrfaosRemovidos := 0;

  MontarIndiceDePacotes(OpcoesInstall.DiretorioRaizACBr);

  // antes de qualquer coisa, tirar do caminho registros quebrados de execuções
  // anteriores, inclusive de IDEs que não fazem parte desta instalação
  RemoverRegistrosOrfaosDeTodasIDEs(ListaPlataformasInstalacao);

  for I := 0 to ListaVersoesInstalacao.Count -1 do
  begin
    FUmaPlataformaDestino := ListaPlataformasInstalacao[ListaVersoesInstalacao[i]];
    FUmaPlataformaDestino.sDirLibrary := OpcoesInstall.DiretorioRaizACBr + FUmaPlataformaDestino.GetDirLibrary;

    FazInstalacaoInicial(ListaPacotes, FUmaPlataformaDestino);

    // Um alvo que falha normalmente indica um problema que vai se repetir nos
    // demais (fonte quebrado, define errado, dependência faltando). Seguir a
    // fila só enterraria o erro no meio de um log enorme, então para aqui.
    if (FCountErros <> 0) then
    begin
      InformaSituacao(Format('Instalação interrompida: o alvo "%s" terminou com erros.',
                             [FUmaPlataformaDestino.GetNomeAlvo]), nmErro);
      Break;
    end;

    InstalarOutrosRequisitos;
  end;

  Result := (FCountErros = 0);
end;

//function TACBrInstallComponentes.FazBroadcastDeAlteracaoDeConfiguracao(cs: PWideChar) : Integer;
//var
//  wParam: Integer;
//  lParam: Integer;
//  lpdwResult: PDWORD_PTR;
//begin
//  // enviar um broadcast de atualização para o windows
//  wParam := 0;
//  lParam := LongInt(cs);
//  lpdwResult := nil;
//  Result := SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, wParam, lParam, SMTO_NORMAL, 4000, lpdwResult);
//end;

procedure TACBrInstallComponentes.InstalarCapicom(ADestino : TDestino; const APathBin: string);
begin
// copia as dlls da pasta capcom para a pasta escolhida pelo usuario e registra a dll
  if ADestino <> tdNone then
  begin
    CopiarArquivoDLLTo(ADestino, 'Capicom\capicom.dll', APathBin);
    CopiarArquivoDLLTo(ADestino, 'Capicom\msxml5.dll',  APathBin);
    CopiarArquivoDLLTo(ADestino, 'Capicom\msxml5r.dll', APathBin);

    if ADestino = tdDelphi then
    begin
      RegistrarActiveXServer(APathBin + 'capicom.dll', True);
      RegistrarActiveXServer(APathBin + 'msxml5.dll', True);
    end
    else
    begin
      RegistrarActiveXServer('capicom.dll', True);
      RegistrarActiveXServer('msxml5.dll', True);
    end;
  end;
end;

//copia as dlls da pasta Diversoso para a pasta escolhida pelo usuario
procedure TACBrInstallComponentes.InstalarDiversos(ADestino: TDestino; const APathBin: string);
begin
  if ADestino <> tdNone then
  begin
    CopiarArquivoDLLTo(ADestino,'Diversos\x86\iconv.dll',    APathBin);
    CopiarArquivoDLLTo(ADestino,'Diversos\x86\inpout32.dll', APathBin);
    CopiarArquivoDLLTo(ADestino,'Diversos\x86\msvcr71.dll',  APathBin);
  end;
end;

procedure TACBrInstallComponentes.InstalarLibXml2(ADestino: TDestino; const APathBin: string);
begin
  if ADestino <> tdNone then
  begin
    CopiarArquivoDLLTo(ADestino,'LibXml2\x86\libexslt.dll', APathBin);
    CopiarArquivoDLLTo(ADestino,'LibXml2\x86\libiconv.dll', APathBin);
    CopiarArquivoDLLTo(ADestino,'LibXml2\x86\libxml2.dll',  APathBin);
    CopiarArquivoDLLTo(ADestino,'LibXml2\x86\libxslt.dll',  APathBin);
  end;
end;

procedure TACBrInstallComponentes.InstalarOpenSSL(ADestino: TDestino; const APathBin: string);
begin
// copia as dlls da pasta openssl, estas dlls são utilizadas para assinar
// arquivos e outras coisas mais
  if ADestino <> tdNone then
  begin
    CopiarArquivoDLLTo(ADestino,'OpenSSL\1.1.1.10\x86\libcrypto-1_1.dll', APathBin);
    CopiarArquivoDLLTo(ADestino,'OpenSSL\1.1.1.10\x86\libssl-1_1.dll', APathBin);
  end;
end;

procedure TACBrInstallComponentes.InstalarOutrosRequisitos;
begin
  with FUmaPlataformaDestino do
  begin
    InformaSituacao(sLineBreak+'INSTALANDO OUTROS REQUISITOS...', nmDestaque);
    // *************************************************************************
    // deixar somente a pasta lib se for configurado assim
    // *************************************************************************
    // Vale para Win32 e Win64 igualmente. As demais plataformas ficam de fora
    // porque os pacotes delas nem chegam a ser compilados: tirar os fontes do
    // Library Path deixaria os projetos do usuário sem units e sem .dcu.
    if OpcoesInstall.DeixarSomentePastasLib and
       (tPlatformAtual in PlataformasSuportadasFull) then
    begin
      try
        DeixarSomenteLib;
        InformaSituacao('Limpeza library path com sucesso', nmSucesso);
      except
        on E: Exception do
        begin
          InformaSituacao('Ocorreu erro ao limpar o path: ' + sLineBreak + E.Message, nmErro);
        end;
      end;

      try
        CopiarOutrosArquivosParaPastaLibrary;
        InformaSituacao('Cópia dos arquivos necessário feita com sucesso para: '+
                        DirLibraryPorModo(ModoParaInstalacao), nmSucesso);
      except
        on E: Exception do
        begin
          InformaSituacao(
            'Ocorreu erro ao copiar arquivos para: '+ DirLibraryPorModo(ModoParaInstalacao) + sLineBreak +
            'Erro:'+ E.Message);
        end;
      end;
    end;


    if (FCountErros = 0) then
    begin
      // Copiar apenas dlls na plataforma da IDE Win32.
      if (tPlatformAtual = bpWin32) and
         ((OpcoesInstall.sDestinoDLLs = tdDelphi) or (not FJaCopiouDLLs)) then
      begin
        FazInstalacaoDLLs(IncludeTrailingPathDelimiter(InstalacaoAtual.BinFolderName));
        FJaCopiouDLLs := True;
      end;
    end;
  end;//---endwith
end;

procedure TACBrInstallComponentes.InstalarXMLSec(ADestino: TDestino; const APathBin: string);
begin
  //copia as dlls da pasta XMLSec para a pasta escolhida pelo usuario
  if ADestino <> tdNone then
  begin
    CopiarArquivoDLLTo(ADestino, 'XMLSec\iconv.dll', APathBin);
    CopiarArquivoDLLTo(ADestino, 'XMLSec\libxml2.dll', APathBin);
    CopiarArquivoDLLTo(ADestino, 'XMLSec\libxmlsec.dll', APathBin);
    CopiarArquivoDLLTo(ADestino, 'XMLSec\libxmlsec-openssl.dll', APathBin);
    CopiarArquivoDLLTo(ADestino, 'XMLSec\libxslt.dll', APathBin);
    CopiarArquivoDLLTo(ADestino, 'XMLSec\zlib1.dll', APathBin);
  end;
end;

procedure TACBrInstallComponentes.LerDeArquivoIni(const ArquivoIni: string);
begin
  OpcoesInstall.CarregarDeArquivoIni(ArquivoIni);
  OpcoesCompilacao.CarregarDeArquivoIni(ArquivoIni);
end;

procedure TACBrInstallComponentes.SalvarConfiguracoesEmArquivoIni(const ArquivoIni: string);
begin
  OpcoesInstall.SalvarEmArquivoIni(ArquivoIni);
  OpcoesCompilacao.SalvarEmArquivoIni(ArquivoIni);
end;

procedure TACBrInstallComponentes.RemoverACBrDoPathDaIDE;
begin
  // feito uma vez por IDE, antes de qualquer plataforma acrescentar a sua pasta
  FUmaPlataformaDestino.AjustarEnvironmentPath('', 'acbr', False);
end;

procedure TACBrInstallComponentes.AdicionarPastaDosBplsNoPathDaIDE;
begin
  // É por aqui que a IDE encontra os BPLs de runtime de que os pacotes de
  // design dependem. O Package Search Path serve para os projetos, e não para
  // o carregamento dos pacotes da própria IDE.
  FUmaPlataformaDestino.AjustarEnvironmentPath(
    FUmaPlataformaDestino.DirLibraryPorModo(ModoParaInstalacao), '', False);
end;

procedure TACBrInstallComponentes.CompilaPacotePorNomeArquivo(const NomePacote: string);
var
  LDirLibrary: string;
begin
  LDirLibrary := DirLibraryAtual;

  if FUmaPlataformaDestino.InstalacaoAtual.RadToolKind = brBorlandDevStudio then
  begin
    FUmaPlataformaDestino.LimparPackageCache(BinaryFileName(LDirLibrary, FPacoteAtual));
  end;
  if FUmaPlataformaDestino.InstalacaoAtual.CompilePackage(FPacoteAtual, LDirLibrary, LDirLibrary) then
  begin
    InformaSituacao(Format('Pacote "%s" compilado com sucesso.', [NomePacote]), nmSucesso)
  end
  else
  begin
    Inc(FCountErros);
    InformaSituacao(Format('Erro ao compilar o pacote "%s".', [NomePacote]), nmErro);
    Exit;
  end;
end;

procedure TACBrInstallComponentes.MontarIndiceDePacotes(const PastaACBr: string);

  procedure Varrer(const ADir: string);
  var
    LBusca: TSearchRec;
    LNome, LDir: string;
  begin
    LDir := IncludeTrailingPathDelimiter(ADir);
    if FindFirst(LDir + '*.*', faAnyFile, LBusca) <> 0 then
      Exit;
    try
      repeat
        LNome := LBusca.Name;
        if (LNome = '.') or (LNome = '..') then
          Continue;

        if ((LBusca.Attr and faDirectory) <> 0) then
        begin
          if (not SameText(LNome, '__history')) and
             (not SameText(LNome, '__recovery')) and
             (not SameText(LNome, 'backup')) then
            Varrer(LDir + LNome);
        end
        else
        if SameText(ExtractFileExt(LNome), '.dpk') then
          FIndicePacotes.Values[AnsiUpperCase(LNome)] := LDir;
      until FindNext(LBusca) <> 0;
    finally
      SysUtils.FindClose(LBusca);
    end;
  end;

begin
  FIndicePacotes.Clear;
  Varrer(IncludeTrailingPathDelimiter(PastaACBr) + 'Pacotes\Delphi');
  FazLog(Format('Índice de pacotes montado: %d arquivos .dpk localizados.',
                [FIndicePacotes.Count]), nlMedio);
end;

function TACBrInstallComponentes.DiretorioDoPacote(const ANomeArquivoDpk: string): string;
begin
  Result := FIndicePacotes.Values[AnsiUpperCase(ANomeArquivoDpk)];
end;

// Remove comentários e diretivas de compilação. Vários .dpk do ACBr têm
// {$IFDEF ...} no meio do "requires", que sem isso seria lido como nome de
// pacote.
function RemoverComentariosPascal(const ATexto: string): string;
var
  I, LTamanho: Integer;
begin
  Result := '';
  I := 1;
  LTamanho := Length(ATexto);

  while I <= LTamanho do
  begin
    if (ATexto[I] = '{') then
    begin
      while (I <= LTamanho) and (ATexto[I] <> '}') do
        Inc(I);
      Inc(I);
      Result := Result + ' ';
    end
    else if (ATexto[I] = '(') and (I < LTamanho) and (ATexto[I + 1] = '*') then
    begin
      Inc(I, 2);
      while (I < LTamanho) and not ((ATexto[I] = '*') and (ATexto[I + 1] = ')')) do
        Inc(I);
      Inc(I, 2);
      Result := Result + ' ';
    end
    else if (ATexto[I] = '/') and (I < LTamanho) and (ATexto[I + 1] = '/') then
    begin
      while (I <= LTamanho) and not CharInSet(ATexto[I], [#10, #13]) do
        Inc(I);
      Result := Result + ' ';
    end
    else
    begin
      Result := Result + ATexto[I];
      Inc(I);
    end;
  end;
end;

// Lê a cláusula "requires" do .dpk e confere se cada dependência que o próprio
// ACBr compila tem o BPL correspondente na MESMA pasta (mesma versão do Delphi,
// mesma plataforma e mesma configuração). Se faltar, o pacote compila mas a IDE
// não consegue carregá-lo. Devolve os nomes faltantes separados por vírgula.
function TACBrInstallComponentes.DependenciasFaltando(const AArquivoDpk: string): string;
var
  LDpk, LLista: TStringList;
  LTexto, LBloco, LDependencia, LArquivoBpl: string;
  LInicio, LFim, I: Integer;
begin
  Result := '';
  if not FileExists(AArquivoDpk) then
    Exit;

  LDpk := TStringList.Create;
  LLista := TStringList.Create;
  try
    LDpk.LoadFromFile(AArquivoDpk);
    LTexto := RemoverComentariosPascal(LDpk.Text);

    LInicio := Pos('REQUIRES', AnsiUpperCase(LTexto));
    if LInicio <= 0 then
      Exit;

    Inc(LInicio, Length('REQUIRES'));
    LFim := PosEx(';', LTexto, LInicio);
    if LFim <= 0 then
      Exit;

    LBloco := Copy(LTexto, LInicio, LFim - LInicio);
    LBloco := StringReplace(LBloco, sLineBreak, ' ', [rfReplaceAll]);
    LBloco := StringReplace(LBloco, #9, ' ', [rfReplaceAll]);

    LLista.Delimiter := ',';
    LLista.StrictDelimiter := True;
    LLista.DelimitedText := LBloco;

    for I := 0 to LLista.Count - 1 do
    begin
      LDependencia := Trim(LLista[I]);
      if LDependencia = '' then
        Continue;

      // só dá para conferir o que o próprio ACBr compila; rtl, vcl, designide e
      // pacotes de terceiros são resolvidos pela IDE
      if DiretorioDoPacote(LDependencia + '.dpk') = '' then
        Continue;

      LArquivoBpl := IncludeTrailingPathDelimiter(DirLibraryAtual) + LDependencia + '.bpl';
      if not FileExists(LArquivoBpl) then
      begin
        if Result <> '' then
          Result := Result + ', ';
        Result := Result + LDependencia + '.bpl';
      end;
    end;
  finally
    LLista.Free;
    LDpk.Free;
  end;
end;

function TACBrInstallComponentes.DirLibraryAtual: string;
begin
  Result := FUmaPlataformaDestino.DirLibraryPorModo(FModoCompilacaoAtual);
end;

function TACBrInstallComponentes.PodeInstalarPacotesNaIDE: Boolean;
begin
  Result := FUmaPlataformaDestino.SuportaPacotesDesignTime;

  // instalar na IDE de 64 bits e opcional
  if Result and (FUmaPlataformaDestino.tPlatformAtual = bpWin64) then
    Result := OpcoesInstall.InstalarNaIDE64Bits;
end;

function TACBrInstallComponentes.ModoParaInstalacao: TModoCompilacao;
begin
  // Os BPL registrados na IDE são sempre os de Release, e o Release é compilado
  // em qualquer configuração (veja TACBrInstallOpcoes.GetModosCompilacao).
  Result := mcRelease;
end;

function TACBrInstallComponentes.InstalarPacoteNaIDE(const ANomeArquivoPacote: string): Boolean;
var
  LRunOnly: Boolean;
  LNaoUsado, LDescricao, LArquivoBpl: string;
begin
  // O BPL já foi gerado na etapa de compilação; aqui ele é apenas registrado
  // na IDE. Usar InstallPackage da JCL recompilaria todos os pacotes de novo.
  GetDPKFileInfo(ANomeArquivoPacote, LRunOnly, @LNaoUsado, @LDescricao);
  LArquivoBpl := BinaryFileName(DirLibraryAtual, ANomeArquivoPacote);

  Result := FileExists(LArquivoBpl);
  if not Result then
  begin
    InformaSituacao(Format('BPL não encontrado para registrar na IDE: "%s"', [LArquivoBpl]), nmAviso);
    Exit;
  end;

  if (FUmaPlataformaDestino.tPlatformAtual = bpWin64) then
    // Grava direto na lista "Known Packages x64". As versões antigas da JCL,
    // que o instalador ainda precisa suportar, não conhecem essa lista.
    FUmaPlataformaDestino.RegistrarPacoteNaIDE(LArquivoBpl, LDescricao)
  else
    Result := FUmaPlataformaDestino.InstalacaoAtual.RegisterPackage(LArquivoBpl, LDescricao);
end;

function TACBrInstallComponentes.DesinstalarPacoteDaIDE(const ANomeArquivoPacote: string): Boolean;
begin
  if (FUmaPlataformaDestino.tPlatformAtual = bpWin64) then
  begin
    FUmaPlataformaDestino.RemoverPacoteDaIDE(BinaryFileName(DirLibraryAtual, ANomeArquivoPacote));
    Result := True;
  end
  else
    Result := FUmaPlataformaDestino.InstalacaoAtual.UninstallPackage(ANomeArquivoPacote,
                DirLibraryAtual, DirLibraryAtual);
end;

// Versões anteriores do instalador gravavam os artefatos direto na pasta da
// plataforma. Agora cada configuração tem a sua subpasta, então o que estiver
// solto na raiz é sobra de instalação antiga e pode fazer o compilador ou a IDE
// pegarem um artefato de outra configuração.
procedure TACBrInstallComponentes.LimparArtefatosDaRaizDaPlataforma;
var
  LArquivos: TStringDynArray;
  I, LRemovidos: Integer;
begin
  if not DirectoryExists(FUmaPlataformaDestino.sDirLibrary) then
    Exit;

  LRemovidos := 0;
  LArquivos := TDirectory.GetFiles(
                 IncludeTrailingPathDelimiter(FUmaPlataformaDestino.sDirLibrary),
                 '*.*', TSearchOption.soTopDirectoryOnly);

  for I := Low(LArquivos) to High(LArquivos) do
  begin
    if DeleteFile(PWideChar(LArquivos[I])) then
    begin
      Inc(LRemovidos);
      FazLog('Removido artefato de layout antigo: ' + LArquivos[I], nlMaximo);
    end;
  end;

  if LRemovidos > 0 then
    InformaSituacao(Format('Removidos %d arquivos soltos na raiz de "%s" (layout antigo).',
                           [LRemovidos, FUmaPlataformaDestino.sDirLibrary]));
end;

procedure TACBrInstallComponentes.ApagarOutrosArquivosDaPastaLibrary(const PastarLibrary: string);
  procedure ApagarArquivosDaPastaLibrary(const Mascara : string);
  var
    ListArquivos: TStringDynArray;
    Arquivo : string;
    i: integer;
  begin
    ListArquivos := TDirectory.GetFiles(IncludeTrailingPathDelimiter(PastarLibrary), Mascara, TSearchOption.soAllDirectories);
    for i := Low(ListArquivos) to High(ListArquivos) do
    begin
      Arquivo := ExtractFileName(ListArquivos[i]);
      DeleteFile(PWideChar(ListArquivos[i]));
    end;
  end;
begin
  ApagarArquivosDaPastaLibrary('*.dcr');
  ApagarArquivosDaPastaLibrary('*.res');
  ApagarArquivosDaPastaLibrary('*.dfm');
  ApagarArquivosDaPastaLibrary('*.ini');
  ApagarArquivosDaPastaLibrary('*.inc');
end;

procedure TACBrInstallComponentes.CopiarOutrosArquivosParaPastaLibrary;
  procedure CopiarArquivosParaPastaLibrary(const Mascara : string);
  var
    ListArquivos: TStringDynArray;
    Arquivo : string;
    i: integer;
  begin
    with FUmaPlataformaDestino do
    begin
      ListArquivos := TDirectory.GetFiles(OpcoesInstall.DiretorioRaizACBr + 'Fontes', Mascara, TSearchOption.soAllDirectories ) ;
      for i := Low(ListArquivos) to High(ListArquivos) do
      begin
        Arquivo := ExtractFileName(ListArquivos[i]);
        CopyFile(PWideChar(ListArquivos[i]),
                 PWideChar(IncludeTrailingPathDelimiter(DirLibraryPorModo(ModoParaInstalacao)) + Arquivo),
                 False);
      end;
    end;//----endwith
  end;
begin
  CopiarArquivosParaPastaLibrary('*.dcr');
  CopiarArquivosParaPastaLibrary('*.res');
  CopiarArquivosParaPastaLibrary('*.dfm');
  CopiarArquivosParaPastaLibrary('*.ini');
  CopiarArquivosParaPastaLibrary('*.inc');
end;

procedure TACBrInstallComponentes.RemoverArquivosAntigosDoDisco;
const
  SMascaraArquivoQueSeraoRemovidos = 'ACBr*.bpl ACBr*.dcp ACBr*.dcu DCLACBr*.bpl  DCLACBr*.dcp DCLACBr*.dcu '+
    'PCN*.bpl PCN*.dcp PCN*.dcu '+
    'pnfs*.dcu pcte*.bpl pcte*.dcp pcte*.dcu pmdfe*.bpl pmdfe*.dcp pmdfe*.dcu pgnre*.dcp '+
    'pgnre*.bpl pces*.bpl pgnre*.dcu pces*.dcp pces*.dcu pca*.dcp pca*.dcu';

var
  PathBat: String;
  DriverList: TStringList;
  ConteudoArquivo: String;
  I: Integer;
begin
  PathBat := ExtractFilePath(ParamStr(0)) + 'apagarACBr.bat';

  // listar driver para montar o ConteudoArquivo
  DriverList := TStringList.Create;
  try
    GetDriveLetters(DriverList);
    ConteudoArquivo := '@echo off' + sLineBreak;
    for I := 0 to DriverList.Count -1 do
    begin
      ConteudoArquivo := ConteudoArquivo + StringReplace(DriverList[I], '\', '', []) + sLineBreak;
      ConteudoArquivo := ConteudoArquivo + 'cd\' + sLineBreak;
      ConteudoArquivo := ConteudoArquivo + 'del '+ SMascaraArquivoQueSeraoRemovidos +' /s' + sLineBreak;
      ConteudoArquivo := ConteudoArquivo + sLineBreak;
    end;

    WriteToTXT(PathBat, AnsiString(ConteudoArquivo), False);
  finally
    DriverList.Free;
  end;

  RunAsAdminAndWaitForCompletion(FApp.Handle, PathBat, FApp);
end;

procedure TACBrInstallComponentes.CompilarEInstalarPacotes(ListaPacotes: TPacotes);
var
  LModo: TModoCompilacao;
begin
  with FUmaPlataformaDestino do
  begin
    // *************************************************************************
    // compilar os pacotes primeiramente
    // *************************************************************************
    if not (tPlatformAtual in PlataformasSuportadasFull) then
    begin
      InformaSituacao(sLineBreak+'No momento não estamos compilando os pacotes da plataforma ' + sPlatform +'.', nmAviso);
      Exit;
    end;

    // -- Compila em todos os modos marcados (Release e/ou Debug)
    for LModo := Low(TModoCompilacao) to High(TModoCompilacao) do
    begin
      if not (LModo in OpcoesInstall.ModosCompilacao) then
        Continue;

      FModoCompilacaoAtual := LModo;
      ForceDirectories(DirLibraryAtual);

      InformaStatusModo(LModo, seExecutando);
      InformaSituacao(sLineBreak + 'COMPILANDO OS PACOTES ' + sPlatform + ' em ' +
                      cNomeModoCompilacao[LModo] + '...', nmDestaque);
      CompilarPacotes(OpcoesInstall.DiretorioRaizACBr, ListaPacotes);

      // *********************************************************************
      // instalar os pacotes somente se não ocorreu erro na compilação
      // *********************************************************************
      if FCountErros > 0 then
      begin
        InformaStatusModo(LModo, seErro);
        InformaSituacao('Abortando... Ocorreram erros na compilação dos pacotes.', nmErro);
        Exit;
      end;

      InformaStatusModo(LModo, seConcluido);
    end;

    FModoCompilacaoAtual := ModoParaInstalacao;

    if Self.PodeInstalarPacotesNaIDE then
    begin
      InformaSituacao(sLineBreak+'INSTALANDO OS PACOTES NA IDE ' + sPlatform + '...', nmDestaque);
      InstalarPacotes(OpcoesInstall.DiretorioRaizACBr, ListaPacotes);
    end
    else
    if (tPlatformAtual = bpWin64) and (not SuportaIDE64Bits) then
    begin
      InformaSituacao('Esta versão do Delphi não possui IDE de 64 bits; ' +
                      'os pacotes Win64 foram somente compilados.', nmAviso);
    end
    else
    if (tPlatformAtual = bpWin64) then
    begin
      InformaSituacao('Instalação na IDE de 64 bits não marcada; ' +
                      'os pacotes Win64 foram somente compilados.', nmAviso);
    end
    else
    begin
      InformaSituacao('Para a plataforma ' + sPlatform + ' os pacotes são somente compilados.', nmAviso);
    end;

  end;//---endwith
end;

procedure TACBrInstallComponentes.CompilarPacotes(const PastaACBr: string; listaPacotes: TPacotes);
var
  iDpk: Integer;
  NomePacote: string;
  sDirPackage: string;
begin
  FUmaPlataformaDestino.ConfiguraDCCPelaPlataformaAtual;

  for iDpk := 0 to listaPacotes.Count - 1 do
  begin
    if (not listaPacotes[iDpk].MarcadoParaInstalar) then
    begin
      InformaProgresso;
      Continue;
    end;

    NomePacote := listaPacotes[iDpk].GetNome;
    if not (IsDelphiPackage(NomePacote)) then
    begin
      FazLog(Format('"%s" não é um pacote Delphi. Pulando pacote.', [NomePacote]));
      InformaProgresso;
      Continue;
    end;

    if not (listaPacotes[iDpk].SuportaVersao(FUmaPlataformaDestino.InstalacaoAtual.IDEPackageVersionNumber)) then
    begin
      FazLog(Format('Versão "%s" não suportada para o pacote "%s". Pulando pacote.',
                    [IntToStr(FUmaPlataformaDestino.InstalacaoAtual.VersionNumber), NomePacote]) );
      InformaProgresso;
      Continue;
    end;
    FazLog('');

    // Busca diretório completo do pacote
    sDirPackage := DiretorioDoPacote(NomePacote);
    FPacoteAtual := sDirPackage + NomePacote;

    CompilaPacotePorNomeArquivo(NomePacote);
    if FCountErros> 0 then
    begin
      // Parar no primeiro erro para evitar de compilar outros pacotes que
      // dependem desse que ocasionou erro.
      Break;
    end;

    //Compilar também o pacote Design Time se a plataforma tiver IDE correspondente
    if FUmaPlataformaDestino.SuportaPacotesDesignTime and FileExists(sDirPackage + 'DCL'+ NomePacote) then
    begin
      FazLog('');
      FPacoteAtual := sDirPackage + 'DCL'+ NomePacote;
      CompilaPacotePorNomeArquivo('DCL'+ NomePacote);
      if FCountErros> 0 then
      begin
        // Parar no primeiro erro para evitar de compilar outros pacotes que
        // dependem desse que ocasionou erro.
        Break;
      end;
    end;
    InformaProgresso;
  end;
end;

procedure TACBrInstallComponentes.InstalarPacotes(const PastaACBr: string; listaPacotes: TPacotes);
var
  iDpk: Integer;
  NomePacote: string;
  bRunOnly: Boolean;
  sDirPackage: string;
  LFaltando: string;
begin
  for iDpk := 0 to listaPacotes.Count - 1 do
  begin
    NomePacote := listaPacotes[iDpk].GetNome;
    if not IsDelphiPackage(NomePacote) then
    begin
      InformaProgresso;
      Continue;
    end;

    if not (listaPacotes[iDpk].SuportaVersao(FUmaPlataformaDestino.InstalacaoAtual.IDEPackageVersionNumber)) then
    begin
      FazLog(Format('Info: Versão "%s" não suportada para o pacote "%s". Pulando pacote.',
                    [IntToStr(FUmaPlataformaDestino.InstalacaoAtual.VersionNumber), NomePacote]) );
      InformaProgresso;
      Continue;
    end;

    // Busca diretório do pacote
    sDirPackage := DiretorioDoPacote(NomePacote);
    if (sDirPackage = '') and (not listaPacotes[iDpk].MarcadoParaInstalar) then
    begin
      FazLog(Format('Info: Pacote "%s" não localizado. Mas não marcado para instalar... Pulando pacote.',
                    [NomePacote]) );
      InformaProgresso;
      Continue;
    end;

    FPacoteAtual := sDirPackage + NomePacote;
    GetDPKFileInfo(FPacoteAtual, bRunOnly);

    if bRunOnly then
    begin
      //Encontrar o pacote DesignTime correspondente caso exista
      if FileExists(sDirPackage + 'DCL'+ NomePacote) then
      begin
        FPacoteAtual := sDirPackage + 'DCL'+ NomePacote;
        GetDPKFileInfo(FPacoteAtual, bRunOnly);
      end;
    end;

    // Se continuou Runonly, instalar somente os pacotes de designtime
    if bRunOnly then
    begin
      InformaProgresso;
      Continue;
    end;

    // se o pacote estiver marcado instalar, senão desinstalar
    if listaPacotes[iDpk].MarcadoParaInstalar then
    begin
      LFaltando := DependenciasFaltando(FPacoteAtual);
      if LFaltando <> '' then
        InformaSituacao(Format(
          'AVISO: o pacote "%s" depende de BPLs que não estão em "%s": %s. ' +
          'A IDE não conseguirá carregá-lo.',
          [ExtractFileName(FPacoteAtual), DirLibraryAtual, LFaltando]), nmAviso);

      if InstalarPacoteNaIDE(FPacoteAtual) then
        InformaSituacao(Format('Pacote "%s" instalado com sucesso.', [NomePacote]), nmSucesso)
      else
      begin
        Inc(FCountErros);
        InformaSituacao(Format('Ocorreu um erro ao instalar o pacote "%s".', [NomePacote]), nmErro);
        Break;
      end;
    end
    else
    begin
      if DesinstalarPacoteDaIDE(FPacoteAtual) then
        InformaSituacao(Format('Pacote "%s" removido com sucesso...', [NomePacote]), nmSucesso);
    end;
    InformaProgresso;
  end;
end;

{ TACBrCompilerOpcoes }

procedure TACBrCompilerOpcoes.CarregarDeArquivoIni(const ArquivoIni: string);
var
  ArqIni: TIniFile;
begin
  RedefinirValoresOpcoesParaPadrao;
  ArqIni := TIniFile.Create(ArquivoIni);
  try
    DeveInstalarCapicom       := ArqIni.ReadBool('CONFIG','InstalaCapicom', DeveInstalarCapicom);
    DeveInstalarOpenSSL       := True;
//    DeveInstalarOpenSSL       := ArqIni.ReadBool('CONFIG','InstalaOpenSSL', DeveInstalarOpenSSL);
//    DeveInstalarXMLSec        := False;
    DeveInstalarMsXML         := ArqIni.ReadBool('CONFIG','InstalaMsXML', DeveInstalarMsXML);
    UsarCargaTardiaDLL        := ArqIni.ReadBool('CONFIG','CargaDllTardia', True);
    RemoverStringCastWarnings := ArqIni.ReadBool('CONFIG','RemoverCastWarnings', RemoverStringCastWarnings);
    DeveSobrescreverDllsExistentes := ArqIni.ReadBool('CONFIG','SobrescreverDLL', DeveSobrescreverDllsExistentes);;
    UsarExportadorFRPNG       := ArqIni.ReadBool('CONFIG','UsarExportadorFRPNG', UsarExportadorFRPNG);
    UsarExportadorFRSVG       := ArqIni.ReadBool('CONFIG','UsarExportadorFRSVG', UsarExportadorFRSVG);
    UsarACBrXmlDocument       := ArqIni.ReadBool('CONFIG','UsarACBrXmlDocument', UsarACBrXmlDocument);
  finally
    ArqIni.Free;
  end;

end;

procedure TACBrCompilerOpcoes.SalvarEmArquivoIni(const ArquivoIni: string);
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create(ArquivoIni);
  try
    ArqIni.WriteBool('CONFIG','InstalaOpenSSL', DeveInstalarOpenSSL);
    ArqIni.WriteBool('CONFIG','InstalaCapicom', DeveInstalarCapicom);
//    ArqIni.WriteBool('CONFIG','InstalaXmlSec', DeveInstalarXMLSec);
    ArqIni.WriteBool('CONFIG','InstalaMsXML', DeveInstalarMsXML);
    ArqIni.WriteBool('CONFIG','CargaDllTardia', UsarCargaTardiaDLL);
    ArqIni.WriteBool('CONFIG','RemoverCastWarnings', RemoverStringCastWarnings);
    ArqIni.WriteBool('CONFIG','SobrescreverDLL', DeveSobrescreverDllsExistentes);
    ArqIni.WriteBool('CONFIG','UsarExportadorFRPNG', UsarExportadorFRPNG);
    ArqIni.WriteBool('CONFIG','UsarExportadorFRSVG', UsarExportadorFRSVG);
    ArqIni.WriteBool('CONFIG','UsarACBrXmlDocument', UsarACBrXmlDocument);
  finally
    ArqIni.Free;
  end;

end;

procedure TACBrCompilerOpcoes.DesligarDefines(const ArquivoACBrInc: TFileName);
var
  LTempFile: TStringList;
  LConteudoOriginal: string;
begin
  LTempFile := TStringList.Create;
  try
    LTempFile.LoadFromFile(ArquivoACBrInc);
    LConteudoOriginal := LTempFile.Text;
    DesligarDefineACBrInc(LTempFile, 'DFE_SEM_OPENSSL', not DeveInstalarOpenSSL);
    DesligarDefineACBrInc(LTempFile, 'DFE_SEM_CAPICOM', not DeveInstalarCapicom);
    DesligarDefineACBrInc(LTempFile, 'DFE_SEM_XMLSEC', not DeveInstalarXMLSec);
    DesligarDefineACBrInc(LTempFile, 'DFE_SEM_MSXML', not DeveInstalarMsXML);
    DesligarDefineACBrInc(LTempFile, 'USE_DELAYED', UsarCargaTardiaDLL);
    DesligarDefineACBrInc(LTempFile, 'REMOVE_CAST_WARN', RemoverStringCastWarnings);
    DesligarDefineACBrInc(LTempFile, 'USE_EXPORT_FR_SVG', UsarExportadorFRSVG);
    DesligarDefineACBrInc(LTempFile, 'USE_EXPORT_FR_PNG', UsarExportadorFRPNG);
    DesligarDefineACBrInc(LTempFile, 'USE_ACBr_XMLDOCUMENT', UsarACBrXmlDocument);

    // Regravar sem necessidade muda a data do ACBr.inc e obriga o compilador a
    // refazer todas as units que o incluem.
    if (LTempFile.Text <> LConteudoOriginal) then
      LTempFile.SaveToFile(ArquivoACBrInc);
  finally
    LTempFile.Free
  end;
end;

procedure TACBrCompilerOpcoes.RedefinirValoresOpcoesParaPadrao;
begin
  DeveInstalarCapicom            := False;
  DeveInstalarOpenSSL            := True;
  DeveInstalarXMLSec             := False;
  DeveInstalarMsXML              := False;
  UsarCargaTardiaDLL             := True;
  RemoverStringCastWarnings      := True;
  DeveSobrescreverDllsExistentes := False;
  UsarExportadorFRSVG            := False;
  UsarExportadorFRPNG            := False;
  UsarACBrXmlDocument            := False;
end;


{ TACBrInstallOpcoes }

// Quem decide os modos é o destino dos binários, e não uma escolha à parte:
//
//   Deixando somente a pasta Lib no Library Path, os projetos do usuário passam
//   a compilar contra os .dcu prontos. Aí eles precisam do Release para o build
//   normal e do Debug para quem marca "use debug .dcus" -- os dois fazem falta.
//
//   Deixando os fontes no Library Path, cada projeto recompila o ACBr com as
//   opções dele e ignora os .dcu daqui. O único consumidor dos binários passa a
//   ser a IDE, que carrega os BPL de Release. Compilar Debug nesse caso seria
//   dobrar o tempo de instalação para gerar algo que ninguém abre.
function TACBrInstallOpcoes.GetModosCompilacao: TModosCompilacao;
begin
  if DeixarSomentePastasLib then
    Result := [mcRelease, mcDebug]
  else
    Result := [mcRelease];
end;

function TACBrInstallOpcoes.QuantidadeModosCompilacao: Integer;
var
  LModo: TModoCompilacao;
begin
  Result := 0;
  for LModo := Low(TModoCompilacao) to High(TModoCompilacao) do
  begin
    if (LModo in ModosCompilacao) then
      Inc(Result);
  end;
end;

procedure TACBrInstallOpcoes.RedefinirValoresOpcoesParaPadrao;
begin
  LimparArquivosACBrAntigos := False;
  DeixarSomentePastasLib    := True;
  UsarCpp                   := False;
  UsarUsarArquivoConfig     := True;
  sDestinoDLLs              := tdSystem;
  DiretorioRaizACBr         := ExtractFilePath(ParamStr(0));
  DeveCopiarOutrasDLLs      := True;
  InstalarNaIDE64Bits       := True;
end;

procedure TACBrInstallOpcoes.SalvarEmArquivoIni(const ArquivoIni: string);
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create(ArquivoIni);
  try
    ArqIni.WriteString('CONFIG','VersaoArquivoIniConfig', cVersaoConfig);

    ArqIni.WriteString('CONFIG', 'DiretorioInstalacao', DiretorioRaizACBr);
    ArqIni.WriteBool('CONFIG','DexarSomenteLib', DeixarSomentePastasLib);
    ArqIni.WriteBool('CONFIG','C++Builder', UsarCpp);
    ArqIni.WriteBool('CONFIG','InstalarNaIDE64Bits', InstalarNaIDE64Bits);
    case sDestinoDLLs of
      tdSystem:
      begin
        ArqIni.WriteInteger('CONFIG','DestinoDLL', 0);
      end;
      tdDelphi:
      begin
        ArqIni.WriteInteger('CONFIG','DestinoDLL', 1);
      end;
      tdNone:
      begin
        ArqIni.WriteInteger('CONFIG','DestinoDLL', 2);
      end;
    end;
  finally
    ArqIni.Free;
  end;

end;

procedure TACBrInstallOpcoes.CarregarDeArquivoIni(const ArquivoIni: string);
var
  ArqIni: TIniFile;
begin
  RedefinirValoresOpcoesParaPadrao;

  ArqIni := TIniFile.Create(ArquivoIni);
  try
//  LimparArquivosACBrAntigos := False;
    DeixarSomentePastasLib    := ArqIni.ReadBool('CONFIG','DexarSomenteLib', DeixarSomentePastasLib);
    UsarCpp                   := ArqIni.ReadBool('CONFIG','C++Builder', UsarCpp);

    InstalarNaIDE64Bits := ArqIni.ReadBool('CONFIG','InstalarNaIDE64Bits', InstalarNaIDE64Bits);
//    UsarUsarArquivoConfig     := True;
    case ArqIni.ReadInteger('CONFIG','DestinoDLL', 0) of
      0 : sDestinoDLLs := tdSystem;
      1 : sDestinoDLLs := tdDelphi;
      2 : sDestinoDLLs := tdNone;
    else
      sDestinoDLLs     := tdSystem;
    end;

    DiretorioRaizACBr := ArqIni.ReadString('CONFIG', 'DiretorioInstalacao', DiretorioRaizACBr);
//    DeveCopiarOutrasDLLs      := True;
  finally
    ArqIni.Free;
  end;
end;

end.
