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

unit ACBrBPeUtilsFPDF;

interface

uses
  SysUtils,
  StrUtils,
  ACBrBPeClass,
  ACBrBPeDABPEClass,
  ACBrXmlBase,
  ACBrDFe.Conversao;

type
  { TBPeUtilsFPDF }
  TBPeUtilsFPDF = class
  private
    FBPe: TBPe;
    FDABPEClassOwner: TACBrBPeDABPEClass;
    FFormatSettings: TFormatSettings;
  public
    constructor Create(ABPe: TBPe; ADABPEClassOwner: TACBrBPeDABPEClass);
    destructor Destroy; override;

    function EmitidoEmHomologacao: Boolean;
    function EmitidoEmContingencia: Boolean;
    function TemProtocoloAutorizacao: Boolean;

    function GetTextoCabecalhoAgencia: string;
    function GetTextoCabecalhoEmitente: string;
    function GetTextoEnderecoAgencia: string;
    function GetTextoEnderecoEmitente: string;
    function GetTextoIdentificacaoBPe(const AViaConsumidor: Boolean): string;
    function GetTextoPassageiro: string;
    function GetChaveAcessoFormatada: string;
    function GetURLConsulta: string;
    function GetQRCodeData: string;
    function GetValorTotalComponentes: Currency;
    function GetValorAPagar: Currency;
    function GetTextoMensagemFiscal(const ACaractereQuebraDeLinha: string): string;
    function GetTextoMensagemContribuinte(const ACaractereQuebraDeLinha: string): string;

    property BPe: TBPe read FBPe;
    property DABPEClassOwner: TACBrBPeDABPEClass read FDABPEClassOwner;
    property FormatSettings: TFormatSettings read FFormatSettings write FFormatSettings;
  end;

implementation

uses
  ACBrBPe,
  ACBrBPeConversao,
  ACBrValidador,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrDFeUtil;

{ TBPeUtilsFPDF }

constructor TBPeUtilsFPDF.Create(ABPe: TBPe;
  ADABPEClassOwner: TACBrBPeDABPEClass);
begin
  inherited Create;

  FBPe := ABPe;
  FDABPEClassOwner := ADABPEClassOwner;
end;

destructor TBPeUtilsFPDF.Destroy;
begin
  inherited Destroy;
end;

function TBPeUtilsFPDF.EmitidoEmHomologacao: Boolean;
begin
  Result := (BPe.Ide.tpAmb = taHomologacao);
end;

function TBPeUtilsFPDF.EmitidoEmContingencia: Boolean;
begin
  Result := (BPe.Ide.tpEmis <> teNormal) and
            EstaVazio(BPe.procBPe.nProt);
end;

function TBPeUtilsFPDF.TemProtocoloAutorizacao: Boolean;
begin
  Result := NaoEstaVazio(Trim(BPe.procBPe.nProt));
end;

function TBPeUtilsFPDF.GetTextoEnderecoAgencia: string;
begin
  Result := Trim(Trim(BPe.Agencia.EnderAgencia.xLgr) +
    IfThen(Trim(BPe.Agencia.EnderAgencia.nro) <> '', ', ' + Trim(BPe.Agencia.EnderAgencia.nro), '') + ' ' +
    IfThen(Trim(BPe.Agencia.EnderAgencia.xCpl) <> '', Trim(BPe.Agencia.EnderAgencia.xCpl) + ' ', '') +
    IfThen(Trim(BPe.Agencia.EnderAgencia.xBairro) <> '', Trim(BPe.Agencia.EnderAgencia.xBairro) + ' ', '') +
    Trim(BPe.Agencia.EnderAgencia.xMun) + '-' + Trim(BPe.Agencia.EnderAgencia.UF));
end;

function TBPeUtilsFPDF.GetTextoCabecalhoAgencia: string;
begin
  Result := '';
  if Trim(BPe.Agencia.xNome) = '' then
    Exit;

  Result := FormatarCNPJ(BPe.Agencia.CNPJ) + '  ' + Trim(BPe.Agencia.xNome) +
            sLineBreak + GetTextoEnderecoAgencia;
end;

function TBPeUtilsFPDF.GetTextoEnderecoEmitente: string;
begin
  Result := Trim(Trim(BPe.Emit.EnderEmit.xLgr) +
    IfThen(Trim(BPe.Emit.EnderEmit.nro) <> '', ', ' + Trim(BPe.Emit.EnderEmit.nro), '') + ' ' +
    IfThen(Trim(BPe.Emit.EnderEmit.xCpl) <> '', Trim(BPe.Emit.EnderEmit.xCpl) + ' ', '') +
    IfThen(Trim(BPe.Emit.EnderEmit.xBairro) <> '', Trim(BPe.Emit.EnderEmit.xBairro) + ' ', '') +
    Trim(BPe.Emit.EnderEmit.xMun) + '-' + Trim(BPe.Emit.EnderEmit.UF));
end;

function TBPeUtilsFPDF.GetTextoCabecalhoEmitente: string;
begin
  Result :=
    Trim(BPe.Emit.xNome) + sLineBreak +
    FormatarCNPJ(BPe.Emit.CNPJ) + '  IE: ' + FormatarIE(BPe.Emit.IE, BPe.Emit.EnderEmit.UF) + sLineBreak +
    GetTextoEnderecoEmitente;

  if NaoEstaVazio(BPe.Emit.EnderEmit.fone) then
    Result := Result + sLineBreak + 'Fone: ' + FormatarFone(BPe.Emit.EnderEmit.fone);
end;

function TBPeUtilsFPDF.GetTextoIdentificacaoBPe(
  const AViaConsumidor: Boolean): string;
var
  Via: string;
begin
  if EstaVazio(Trim(BPe.procBPe.nProt)) then
    Via := IfThen(AViaConsumidor, ' - Via Passageiro', ' - Via Empresa')
  else
    Via := '';

  Result := 'BP-e nº ' + IntToStrZero(BPe.Ide.nBP, 9) +
            '  Série ' + IntToStrZero(BPe.Ide.serie, 3) +
            '  ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', BPe.Ide.dhEmi) +
            Via;
end;

function TBPeUtilsFPDF.GetTextoPassageiro: string;
begin
  if Trim(BPe.infPassagem.infPassageiro.xNome) = '' then
    Result := 'PASSAGEIRO NÃO IDENTIFICADO'
  else
    Result := 'PASSAGEIRO: ' + tpDocumentoToDesc(BPe.infPassagem.infPassageiro.tpDoc) +
              ' ' + BPe.infPassagem.infPassageiro.nDoc +
              ' - ' + BPe.infPassagem.infPassageiro.xNome;
end;

function TBPeUtilsFPDF.GetChaveAcessoFormatada: string;
begin
  Result := FormatarChaveAcesso(RemoverLiteralChave(BPe.infBPe.ID));
end;

function TBPeUtilsFPDF.GetURLConsulta: string;
begin
  Result := '';
  if Assigned(DABPEClassOwner) and Assigned(DABPEClassOwner.ACBrBPe) then
    Result := TACBrBPe(DABPEClassOwner.ACBrBPe).GetURLConsultaBPe(BPe.Ide.cUF, BPe.Ide.tpAmb);
end;

function TBPeUtilsFPDF.GetQRCodeData: string;
begin
  if NaoEstaVazio(Trim(BPe.infBPeSupl.qrCodBPe)) then
    Result := BPe.infBPeSupl.qrCodBPe
  else if Assigned(DABPEClassOwner) and Assigned(DABPEClassOwner.ACBrBPe) then
    Result := TACBrBPe(DABPEClassOwner.ACBrBPe).GetURLQRCode(BPe)
  else
    Result := '';
end;

function TBPeUtilsFPDF.GetValorTotalComponentes: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to BPe.infValorBPe.Comp.Count - 1 do
    Result := Result + BPe.infValorBPe.Comp.Items[I].vComp;
end;

function TBPeUtilsFPDF.GetValorAPagar: Currency;
begin
  Result := GetValorTotalComponentes - BPe.infValorBPe.vDesconto;
end;

function TBPeUtilsFPDF.GetTextoMensagemFiscal(
  const ACaractereQuebraDeLinha: string): string;
begin
  Result := Trim(BPe.InfAdic.infAdFisco);
  if Result <> '' then
    Result := StringReplace(Result, ACaractereQuebraDeLinha, sLineBreak, [rfReplaceAll]);
end;

function TBPeUtilsFPDF.GetTextoMensagemContribuinte(
  const ACaractereQuebraDeLinha: string): string;
begin
  Result := Trim(BPe.InfAdic.infCpl);
  if Result <> '' then
    Result := StringReplace(Result, ACaractereQuebraDeLinha, sLineBreak, [rfReplaceAll]);
end;

end.
