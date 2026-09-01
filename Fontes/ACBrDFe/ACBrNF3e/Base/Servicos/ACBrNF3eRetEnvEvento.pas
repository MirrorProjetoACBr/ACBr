{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit ACBrNF3eRetEnvEvento;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrNF3eEventoClass;

type
  TRetInfEventoCollectionItem = class(TObject)
  private
    FRetInfEvento: TRetInfEvento;
  public
    constructor Create;
    destructor Destroy; override;

    property RetInfEvento: TRetInfEvento read FRetInfEvento write FRetInfEvento;
  end;

  TRetInfEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TRetInfEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfEventoCollectionItem);
  public
    function Add: TRetInfEventoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TRetInfEventoCollectionItem;
    property Items[Index: Integer]: TRetInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  TRetEventoNF3e = class(TObject)
  private
    Fversao: string;
    FretInfEvento: TRetInfEvento;
    FretEvento: TRetInfEventoCollection;
    Fsignature: Tsignature;
    FidLote: Int64;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcOrgao: Integer;
    FcStat: Integer;
    FxMotivo: string;

    FXML: string;
    FXmlRetorno: string;
    FInfEvento: TInfEvento;
  protected
    procedure Ler_InfEvento(const ANode: TACBrXmlNode);
    procedure Ler_DetEvento(const ANode: TACBrXmlNode);
    procedure Ler_Pagamento(const ANode: TACBrXmlNode);
    procedure Ler_RetEvento(const ANode: TACBrXmlNode);
    procedure Ler_RetInfEvento(const ANode: TACBrXmlNode);
  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean;

    property idLote: Int64 read FidLote write FidLote;
    property versao: string read Fversao write Fversao;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cOrgao: Integer read FcOrgao write FcOrgao;
    property cStat: Integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;

    property InfEvento: TInfEvento read FInfEvento write FInfEvento;
    property retInfEvento: TRetInfEvento read FretInfEvento write FretInfEvento;
    property retEvento: TRetInfEventoCollection read FretEvento write FretEvento;
    property signature: Tsignature read Fsignature write Fsignature;

    property XML: string read FXML write FXML;
    property XmlRetorno: string read FXmlRetorno write FXmlRetorno;
  end;

implementation

uses
  ACBrNF3eConversao,
  ACBrUtil.Strings,
  ACBrXmlReader;

{ TRetEventoNF3e }

constructor TRetEventoNF3e.Create;
begin
  inherited Create;

  FInfEvento := TInfEvento.Create;
  FretInfEvento := TRetInfEvento.Create;
  FretEvento := TRetInfEventoCollection.Create;
  Fsignature := Tsignature.Create;
end;

destructor TRetEventoNF3e.Destroy;
begin
  FInfEvento.Free;
  FretInfEvento.Free;
  FretEvento.Free;
  Fsignature.Free;

  inherited;
end;

function TRetEventoNF3e.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode: TACBrXmlNode;
begin
  Document := TACBrXmlDocument.Create;


  try
    try
      Result := False;
      if XmlRetorno = '' then Exit;

      Document.LoadFromXml(XmlRetorno);

      ANode := Document.Root;

      if ANode <> nil then
      begin
        if (ANode.LocalName = 'procEventoNF3e') or (ANode.LocalName = 'envEvento') then
        begin
          versao := ObterConteudoTag(ANode.Attributes.Items['versao']);

          Ler_InfEvento(ANode.Childrens.FindAnyNs('evento').Childrens.FindAnyNs('infEvento'));
          Ler_RetEvento(ANode);
        end;

        if (ANode.LocalName = 'NF3eDFe') then
        begin
          versao := ObterConteudoTag(ANode.Childrens.FindAnyNs('procEventoNF3e').Childrens.FindAnyNs('procEventoNF3e').Attributes.Items['versao']);

          Ler_InfEvento(ANode.Childrens.FindAnyNs('procEventoNF3e').Childrens.FindAnyNs('procEventoNF3e').Childrens.FindAnyNs('evento').Childrens.FindAnyNs('infEvento'));
          Ler_RetEvento(ANode);
        end;

        if (ANode.LocalName = 'retEnvEvento') or (ANode.LocalName = 'retEventoNF3e') then
          Ler_RetEvento(ANode);

        if ANode.LocalName = 'evento' then
          Ler_InfEvento(ANode.Childrens.FindAnyNs('infEvento'));

        LerSignature(ANode.Childrens.Find('Signature'), signature);
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TRetEventoNF3e.Ler_InfEvento(const ANode: TACBrXmlNode);
var
  ok: Boolean;
begin
  if not Assigned(ANode) then Exit;

  infEvento.Id := ObterConteudoTag(ANode.Attributes.Items['Id']);
  infEvento.cOrgao := ObterConteudoTag(ANode.Childrens.FindAnyNs('cOrgao'), tcInt);
  infEvento.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  infEvento.CNPJ := ObterConteudoTagCNPJCPF(ANode);
  infEvento.chNF3e := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNF3e'), tcStr);
  infEvento.dhEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhEvento'), tcDatHor);
  infEvento.tpEvento := StrToTpEventoNF3e(ok, ObterConteudoTag(ANode.Childrens.FindAnyNs('tpEvento'), tcStr));
  infEvento.nSeqEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('nSeqEvento'), tcInt);
//  infEvento.VersaoEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('verEvento'), tcStr);

  Ler_DetEvento(ANode.Childrens.FindAnyNs('detEvento'));
end;

procedure TRetEventoNF3e.Ler_DetEvento(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  infEvento.DetEvento.descEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('descEvento'), tcStr);
  infEvento.DetEvento.nProt := ObterConteudoTag(ANode.Childrens.FindAnyNs('nProt'), tcStr);
  infEvento.DetEvento.xJust := ObterConteudoTag(ANode.Childrens.FindAnyNs('xJust'), tcStr);

  // teCancVinculoPgto
  infEvento.detEvento.nProtVincPgto := ObterConteudoTag(ANode.Childrens.FindAnyNs('nProtVincPgto'), tcStr);

  Ler_Pagamento(ANode.Childrens.FindAnyNs('pgto'));
end;

procedure TRetEventoNF3e.Ler_Pagamento(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  // teVinculoPgto
  infEvento.detEvento.pgto.nPag := ObterConteudoTag(ANode.Childrens.FindAnyNs('nPag'), tcInt);
  infEvento.detEvento.pgto.idTransacao := ObterConteudoTag(ANode.Childrens.FindAnyNs('idTransacao'), tcStr);
  infEvento.detEvento.pgto.tpMeioPgto := ObterConteudoTag(ANode.Childrens.FindAnyNs('tpMeioPgto'), tcStr);
  infEvento.detEvento.pgto.CNPJReceb := ObterConteudoTag(ANode.Childrens.FindAnyNs('CNPJReceb'), tcStr);
  infEvento.detEvento.pgto.CNPJBasePSP := ObterConteudoTag(ANode.Childrens.FindAnyNs('CNPJBasePSP'), tcStr);
end;

procedure TRetEventoNF3e.Ler_RetEvento(const ANode: TACBrXmlNode);
var
  aValor: string;
begin
  if not Assigned(ANode) then Exit;

  versao := ObterConteudoTag(ANode.Attributes.Items['versao']);
  idLote := ObterConteudoTag(ANode.Childrens.FindAnyNs('idLote'), tcInt64);

  aValor := ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr);
  if aValor <> '' then
    tpAmb := StrToTipoAmbiente(aValor);

  verAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
  cOrgao := ObterConteudoTag(ANode.Childrens.FindAnyNs('cOrgao'), tcInt);
  cStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
  xMotivo := ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr);

  Ler_RetInfEvento(ANode.Childrens.FindAnyNs('retEvento'));
end;

procedure TRetEventoNF3e.Ler_RetInfEvento(const ANode: TACBrXmlNode);
var
  ok: Boolean;
  AuxNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  AuxNode := ANode.Childrens.FindAnyNs('infEvento');
  if not Assigned(AuxNode) then Exit;

  retInfEvento.Id := ObterConteudoTag(AuxNode.Attributes.Items['Id']);
  retInfEvento.tpAmb := StrToTipoAmbiente(ObterConteudoTag(AuxNode.Childrens.FindAnyNs('tpAmb'), tcStr));
  retInfEvento.verAplic := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('verAplic'), tcStr);
  retInfEvento.cOrgao := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('cOrgao'), tcInt);
  retInfEvento.cStat := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('cStat'), tcInt);
  retInfEvento.xMotivo := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('xMotivo'), tcStr);
  retInfEvento.chNF3e := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('chNF3e'), tcStr);
  retInfEvento.tpEvento := StrToTpEventoNF3e(ok, ObterConteudoTag(AuxNode.Childrens.FindAnyNs('tpEvento'), tcStr));
  retInfEvento.xEvento := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('xEvento'), tcStr);
  retInfEvento.nSeqEvento := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nSeqEvento'), tcInt);
  retInfEvento.dhRegEvento := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('dhRegEvento'), tcDatHor);
  retInfEvento.nProt := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nProt'), tcStr);
end;

{ TRetInfEventoCollectionItem }

constructor TRetInfEventoCollectionItem.Create;
begin
  inherited Create;

  FRetInfEvento := TRetInfEvento.Create;
end;

destructor TRetInfEventoCollectionItem.Destroy;
begin
  FRetInfEvento.Free;

  inherited;
end;

{ TRetInfEventoCollection }

function TRetInfEventoCollection.Add: TRetInfEventoCollectionItem;
begin
  Result := Self.New;
end;

function TRetInfEventoCollection.GetItem(
  Index: Integer): TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem(inherited Items[Index]);
end;

function TRetInfEventoCollection.New: TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem.Create;
  Self.Add(Result);
end;

procedure TRetInfEventoCollection.SetItem(Index: Integer;
  Value: TRetInfEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

end.
