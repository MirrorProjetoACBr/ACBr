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

{$I ACBr.inc}

unit ACBrLibBPeConfig;

interface

uses
  Classes, SysUtils, IniFiles, synachar,
  ACBrLibComum, ACBrLibConfig, ACBrBPe,
  //ACBrBPe.DABPeRLClass,
  ACBrBPeConversao, ACBrBPeConfiguracoes, ACBrXmlBase, DFeReportConfig, ACBrDFeReport;

type

  { TDABPeReportConfig }
  TDABPeReportConfig = class(TDFeReportConfig<TACBrDFeReport>)
  private
    FMostraPreview: Boolean;
    FMargemInferior: Double;
    FMargemSuperior: Double;
    FMargemEsquerda: Double;
    FMargemDireita: Double;
  protected
    procedure LerIniChild(const AIni: TCustomIniFile); override;
    procedure GravarIniChild(const AIni: TCustomIniFile); override;
    procedure ApplyChild(const DFeReport: TACBrDFeReport; const Lib: TACBrLib); override;
    procedure DefinirValoresPadroesChild; override;
  public
    constructor Create;
    destructor Destroy; override;

    property MostraPreview: Boolean read FMostraPreview write FMostraPreview;
    property MargemInferior: Double read FMargemInferior write FMargemInferior;
    property MargemSuperior: Double read FMargemSuperior write FMargemSuperior;
    property MargemEsquerda: Double read FMargemEsquerda write FMargemEsquerda;
    property MargemDireita: Double read FMargemDireita write FMargemDireita;
  end;

  { TLibBPeConfig }
  TLibBPeConfig = class(TLibConfig)
  private
    FBPeConfig: TConfiguracoesBPe;
    FDABPeConfig: TDABPeReportConfig;
  protected
    function AtualizarArquivoConfiguracao: Boolean; override;

    procedure INIParaClasse; override;
    procedure ClasseParaINI; override;
    procedure ClasseParaComponentes; override;

    procedure Travar; override;
    procedure Destravar; override;
  public
    constructor Create(AOwner: TObject; ANomeArquivo: String = ''; AChaveCrypt: AnsiString = ''); override;
    destructor Destroy; override;

    property BPeConfig: TConfiguracoesBPe read FBPeConfig;
    property DABPeConfig: TDABPeReportConfig read FDABPeConfig;
  end;

implementation

Uses
  ACBrLibBPeBase, ACBrLibBPeConsts, ACBrLibConsts, ACBrUtil.FilesIO;

{ TDABPeReportConfig }
procedure TDABPeReportConfig.LerIniChild(const AIni: TCustomIniFile);
begin
  FMostraPreview := AIni.ReadBool(CSessaoDABPe, CChaveMostraPreview, FMostraPreview);
  FMargemInferior := AIni.ReadFloat(CSessaoDABPe, CChaveMargemInferior, FMargemInferior);
  FMargemSuperior := AIni.ReadFloat(CSessaoDABPe, CChaveMargemSuperior, FMargemSuperior);
  FMargemEsquerda := AIni.ReadFloat(CSessaoDABPe, CChaveMargemEsquerda, FMargemEsquerda);
  FMargemDireita := AIni.ReadFloat(CSessaoDABPe, CChaveMargemDireita, FMargemDireita);
end;

procedure TDABPeReportConfig.GravarIniChild(const AIni: TCustomIniFile);
begin
  AIni.WriteBool(CSessaoDABPe, CChaveMostraPreview, FMostraPreview);
  AIni.WriteFloat(CSessaoDABPe, CChaveMargemInferior, FMargemInferior);
  AIni.WriteFloat(CSessaoDABPe, CChaveMargemSuperior, FMargemSuperior);
  AIni.WriteFloat(CSessaoDABPe, CChaveMargemEsquerda, FMargemEsquerda);
  AIni.WriteFloat(CSessaoDABPe, CChaveMargemDireita, FMargemDireita);
end;

procedure TDABPeReportConfig.ApplyChild(const DFeReport: TACBrDFeReport;
  const Lib: TACBrLib);
//var
//  LDABPe: TACBrBPeDABPeRL;
begin
  (*
  LDABPe := TACBrBPeDABPeRL(DFeReport);
  with LDABPe do
  begin
    MostraPreview := FMostraPreview;
    MargemInferior := FMargemInferior;
    MargemSuperior := FMargemSuperior;
    MargemEsquerda := FMargemEsquerda;
    MargemDireita  := FMargemDireita;
  end;
  *)
end;

procedure TDABPeReportConfig.DefinirValoresPadroesChild;
begin
  FMostraPreview := False;
  FMargemInferior := 0;
  FMargemSuperior := 0;
  FMargemEsquerda := 0;
  FMargemDireita := 0;
end;

constructor TDABPeReportConfig.Create;
begin
  inherited Create(CSessaoDABPe)
end;

destructor TDABPeReportConfig.Destroy;
begin
  inherited Destroy;
end;

{ TLibBPeConfig }
function TLibBPeConfig.AtualizarArquivoConfiguracao: Boolean;
var
  Versao: String;
begin
  Versao := Ini.ReadString(CSessaoVersao, CLibBPeNome, '0');
  Result := (CompareVersions(CLibBPeVersao, Versao) > 0) or
            (inherited AtualizarArquivoConfiguracao);
end;

procedure TLibBPeConfig.INIParaClasse;
begin
  inherited INIParaClasse;

  FBPeConfig.ChaveCryptINI := ChaveCrypt;
  FBPeConfig.LerIni(Ini);
  FDABPeConfig.LerIni(Ini);
end;

procedure TLibBPeConfig.ClasseParaINI;
begin
  inherited ClasseParaINI;

  FBPeConfig.ChaveCryptINI := ChaveCrypt;
  FBPeConfig.GravarIni(Ini);
  FDABPeConfig.GravarIni(Ini);
end;

procedure TLibBPeConfig.ClasseParaComponentes;
begin
  FBPeConfig.ChaveCryptINI := ChaveCrypt;

  if Assigned(Owner) then
    TACBrLibBPe(Owner).BPeDM.AplicarConfiguracoes;
end;

procedure TLibBPeConfig.Travar;
begin
  if Assigned(Owner) then
    TACBrLibBPe(Owner).BPeDM.Travar;
end;

procedure TLibBPeConfig.Destravar;
begin
  if Assigned(Owner) then
    TACBrLibBPe(Owner).BPeDM.Destravar;
end;

constructor TLibBPeConfig.Create(AOwner: TObject; ANomeArquivo: String;
  AChaveCrypt: AnsiString);
begin
  inherited Create(AOwner, ANomeArquivo, AChaveCrypt);
  FBPeConfig := TConfiguracoesBPe.Create(nil);
  FBPeConfig.ChaveCryptINI := AChaveCrypt;
  FDABPeConfig := TDABPeReportConfig.Create;
end;

destructor TLibBPeConfig.Destroy;
begin
  FBPeConfig.Free;
  FDABPeConfig.Free;
  inherited Destroy;
end;

end.

