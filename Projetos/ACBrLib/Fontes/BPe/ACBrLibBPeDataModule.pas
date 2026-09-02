{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Rafael Teno Dias, Renato Rubinho                }
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

unit ACBrLibBPeDataModule;

{$IfDef FPC}
{$mode delphi}
{$EndIf}

interface

uses
  Classes, SysUtils, FileUtil, ACBrLibComum, ACBrLibDataModule,
  pcnConversao,
  //ACBrBPe.DABPeRLClass,
  ACBrBPe,
  ACBrMail;

type
  { TLibBPeDM }

  TLibBPeDM = class(TLibDataModule)
    ACBrMail1: TACBrMail;
    ACBrBPe1: TACBrBPe;
//    FDABPeFortes: TACBrBPeDABPeRL;
  protected
    procedure FreeReports;
  public
    procedure AplicarConfiguracoes; override;
    procedure AplicarConfigMail;
    procedure ConfigurarImpressao(NomeImpressora: String = ''; GerarPDF: Boolean = False;
                                  MostrarPreview: String = '');
    procedure FinalizarImpressao;
  end;

var
  LibBPeDM: TLibBPeDM;

implementation

uses
  ACBrLibConfig, ACBrLibBPeConfig, ACBrUtil.Base, ACBrUtil.FilesIO;

{$R *.lfm}

{ TLibBPeDM }

procedure TLibBPeDM.FreeReports;
begin
//  ACBrBPe1.DABPe := nil;
//  if Assigned(FDABPeFortes) then FreeAndNil(FDABPeFortes);
end;

procedure TLibBPeDM.AplicarConfiguracoes;
var
  pLibBPeConfig: TLibBPeConfig;
begin
  ACBrBPe1.SSL.DescarregarCertificado;
  pLibBPeConfig := TLibBPeConfig(Lib.Config);
  ACBrBPe1.Configuracoes.Assign(pLibBPeConfig.BPeConfig);
 // ACBrBPe1.DABPe := FDABPeFortes;

  {$IFDEF Demo}
  GravarLog('Modo DEMO - Forçando ambiente para Homologação', logNormal);
  ACBrBPe1.Configuracoes.WebServices.Ambiente := taHomologacao;
  {$ENDIF}

  AplicarConfigMail;
end;

procedure TLibBPeDM.AplicarConfigMail;
begin
  with ACBrMail1 do
  begin
    Attempts             := Lib.Config.Email.Tentativas;
    SetTLS               := Lib.Config.Email.TLS;
    DefaultCharset       := Lib.Config.Email.Codificacao;
    From                 := Lib.Config.Email.Conta;
    FromName             := Lib.Config.Email.Nome;
    SetSSL               := Lib.Config.Email.SSL;
    Host                 := Lib.Config.Email.Servidor;
    IDECharset           := Lib.Config.Email.Codificacao;
    IsHTML               := Lib.Config.Email.IsHTML;
    Password             := Lib.Config.Email.Senha;
    Port                 := IntToStr(Lib.Config.Email.Porta);
    Priority             := Lib.Config.Email.Priority;
    ReadingConfirmation  := Lib.Config.Email.Confirmacao;
    DeliveryConfirmation := Lib.Config.Email.ConfirmacaoEntrega;
    TimeOut              := Lib.Config.Email.TimeOut;
    Username             := Lib.Config.Email.Usuario;
    UseThread            := Lib.Config.Email.SegundoPlano;
  end;
end;

procedure TLibBPeDM.ConfigurarImpressao(NomeImpressora: String;
  GerarPDF: Boolean; MostrarPreview: String);
var
  LibConfig: TLibBPeConfig;
begin
  LibConfig := TLibBPeConfig(Lib.Config);

  GravarLog('ConfigurarImpressao - Iniciado', logNormal);

  GravarLog('Método não implementado', logNormal);
(*)
  FDABPeFortes := TACBrBPeDABPeRL.Create(Nil);
  ACBrBPe1.DABPe := FDABPeFortes;

  if GerarPDF then
  begin
    if (LibConfig.DABPeConfig.PathPDF <> '') then
      if not DirectoryExists(PathWithDelim(LibConfig.DABPeConfig.PathPDF))then
        ForceDirectories(PathWithDelim(LibConfig.DABPeConfig.PathPDF));
  end;

  LibConfig.DABPeConfig.Apply(FDABPeFortes, Lib);

  if NaoEstaVazio(NomeImpressora) then
    FDABPeFortes.Impressora := NomeImpressora;

  if NaoEstaVazio(MostrarPreview) then
    FDABPeFortes.MostraPreview := StrToBoolDef(MostrarPreview, False);
*)

  GravarLog('ConfigurarImpressao - Feito', logNormal);
end;

procedure TLibBPeDM.FinalizarImpressao;
begin
  GravarLog('FinalizarImpressao - Iniciado', logNormal);
  FreeReports;
  GravarLog('FinalizarImpressao - Feito', logNormal);
end;

end.

