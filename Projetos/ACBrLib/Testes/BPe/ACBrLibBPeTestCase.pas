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

unit ACBrLibBPeTestCase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestACBrBPeLib }

  TTestACBrBPeLib = class(TTestCase)
  private
    fCaminhoExec: string;
  public
    procedure SetUp; override;
  published
    procedure Test_BPe_Inicializar_Com_DiretorioInvalido;
    procedure Test_BPe_Inicializar;
    procedure Test_BPe_Inicializar_Ja_Inicializado;
    procedure Test_BPe_Finalizar;
    procedure Test_BPe_Finalizar_Ja_Finalizado;
    procedure Test_BPe_Nome_Obtendo_LenBuffer;
    procedure Test_BPe_Nome_Lendo_Buffer_Tamanho_Identico;
    procedure Test_BPe_Nome_Lendo_Buffer_Tamanho_Maior;
    procedure Test_BPe_Nome_Lendo_Buffer_Tamanho_Menor;
    procedure Test_BPe_Versao;
    procedure Test_BPe_ConfigLerValor;
    procedure Test_BPe_ConfigGravarValor;
  end;

implementation

uses
  ACBrLibBPeStaticImportMT, ACBrLibBPeConsts, ACBrLibConsts, Dialogs;

{ TTestACBrBPeLib }

procedure TTestACBrBPeLib.SetUp;
begin
  inherited SetUp;
end;

procedure TTestACBrBPeLib.Test_BPe_Inicializar_Com_DiretorioInvalido;
var
  Handle: THandle;
begin
  try
    //BPe_Inicializar(Handle);
    AssertEquals(ErrDiretorioNaoExiste, BPe_Inicializar(Handle, 'C:\NAOEXISTE\ACBrLib.ini',''));
  except
    on E: Exception do
     ShowMessage( 'Error: '+ E.ClassName + #13#10 + E.Message );
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_Inicializar;
var
  Handle: THandle;
begin
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '', ''));
  AssertEquals(ErrOK, BPe_Finalizar(Handle));
end;

procedure TTestACBrBPeLib.Test_BPe_Inicializar_Ja_Inicializado;
var
  Handle: THandle;
  HandleOriginal: THandle;
begin
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '', ''));
  // Armazenado HandleOriginal para finalizar e não ficar com a Lib presa
  HandleOriginal := Handle;
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '',''));
  AssertEquals(ErrOK, BPe_Finalizar(Handle));
  AssertEquals(ErrOK, BPe_Finalizar(HandleOriginal));
end;

procedure TTestACBrBPeLib.Test_BPe_Finalizar;
var
  Handle: THandle;
begin
  AssertEquals(ErrOk, BPe_Inicializar(Handle,'',''));
  AssertEquals(ErrOk, BPe_Finalizar(Handle));
end;

procedure TTestACBrBPeLib.Test_BPe_Finalizar_Ja_Finalizado;
var
  Handle: THandle;
begin
  AssertEquals(ErrOk, BPe_Inicializar(Handle,'',''));
  AssertEquals(ErrOk, BPe_Finalizar(Handle));
end;

procedure TTestACBrBPeLib.Test_BPe_Nome_Obtendo_LenBuffer;
var
  Handle: THandle;
  Bufflen: Integer;
  AStr: String;
begin
  // Obtendo o Tamanho //
  AssertEquals(ErrOk, BPe_Inicializar(Handle,'',''));

  try
    Bufflen := 0;
    AssertEquals(ErrOk, BPe_Nome(Handle,Nil, Bufflen));
    AssertEquals(Length(CLibBPeNome), Bufflen);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_Nome_Lendo_Buffer_Tamanho_Identico;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '',''));

  try
    Bufflen := Length(CLibBPeNome);
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, BPe_Nome(Handle, PChar(AStr), Bufflen));
    AssertEquals(Length(CLibBPeNome), Bufflen);
    AssertEquals(CLibBPeNome, AStr);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_Nome_Lendo_Buffer_Tamanho_Maior;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '', ''));

  try
    Bufflen := Length(CLibBPeNome)*2;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, BPe_Nome(Handle, PChar(AStr), Bufflen));
    AStr := copy(AStr, 1, Bufflen);
    AssertEquals(Length(CLibBPeNome), Bufflen);
    AssertEquals(CLibBPeNome, AStr);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_Nome_Lendo_Buffer_Tamanho_Menor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  AssertEquals(ErrOK, BPe_Inicializar(Handle,  '', ''));

  try
    Bufflen := 11;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, BPe_Nome(Handle,  PChar(AStr), Bufflen));
    AssertEquals(11, Bufflen);
    AssertEquals(Copy(CLibBPeNome,1,11), AStr);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_Versao;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  // Obtendo o Tamanho //
  AssertEquals(ErrOK, BPe_Inicializar(Handle,  '', ''));

  try
    Bufflen := 0;
    AssertEquals(ErrOk, BPe_Versao(Handle, nil, Bufflen));
    AssertEquals(Length(CLibBPeVersao), Bufflen);

    // Lendo a resposta //
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, BPe_Versao(Handle, PChar(AStr), Bufflen));
    AssertEquals(Length(CLibBPeVersao), Bufflen);
    AssertEquals(CLibBPeVersao, AStr);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_ConfigLerValor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  // Obtendo o Tamanho //
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '', ''));

  try
    Bufflen := 255;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, BPe_ConfigLerValor(Handle, CSessaoVersao, CLibBPeNome, PChar(AStr), Bufflen));
    AStr := copy(AStr,1,Bufflen);
    AssertEquals(CLibBPeVersao, AStr);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;

procedure TTestACBrBPeLib.Test_BPe_ConfigGravarValor;
var
  AStr: String;
  Bufflen: Integer;
  Handle: THandle;
begin
  // Gravando o valor
  AssertEquals(ErrOK, BPe_Inicializar(Handle, '', ''));

  try
    AssertEquals('Erro ao Mudar configuração', ErrOk, BPe_ConfigGravarValor(Handle, CSessaoPrincipal, CChaveLogNivel, '4'));

    // Checando se o valor foi atualizado //
    Bufflen := 255;
    AStr := Space(Bufflen);
    AssertEquals(ErrOk, BPe_ConfigLerValor(Handle, CSessaoPrincipal, CChaveLogNivel, PChar(AStr), Bufflen));
    AStr := copy(AStr,1,Bufflen);
    AssertEquals('Erro ao Mudar configuração', '4', AStr);
  finally
    AssertEquals(ErrOK, BPe_Finalizar(Handle));
  end;
end;


initialization

  RegisterTest(TTestACBrBPeLib);
end.

