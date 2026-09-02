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

unit ACBrLibBPeRespostas;

interface

uses
  Classes, SysUtils, Contnrs, pcnConversao, ACBrDfe.Conversao,
  ACBrBPeEventoClass, ACBrBPeConversao, ACBrXmlBase, ACBrBase,
  ACBrLibResposta, ACBrLibConfig,
  ACBrLibConsReciDFe, ACBrBPe, ACBrDFeUtil,
  ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.Strings;

type

  { TLibBPeResposta }
  TLibBPeResposta = class(TACBrLibRespostaBase)
  private
    FMsg: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
    const AFormato: TACBrLibCodificacao); reintroduce;
  published
    property Msg: String read FMsg write FMsg;
  end;

  { TLibBPeServiceResposta }
  TLibBPeServiceResposta = class abstract(TACBrLibResposta<TACBrBPe>)
  private
    FMsg: string;
    Fversao: string;
    FtpAmb: string;
    FverAplic: string;
    FcStat: integer;
    FxMotivo: string;
    FcUF: integer;
    FdhRecbto: TDateTime;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;
    procedure Processar(const ACBrBPe: TACBrBPe); virtual; abstract; reintroduce;
  published
    property Msg: string read FMsg write FMsg;
    property Versao: string read Fversao write Fversao;
    property tpAmb: string read FtpAmb write FtpAmb;
    property VerAplic: string read FverAplic write FverAplic;
    property CStat: integer read FcStat write FcStat;
    property XMotivo: string read FxMotivo write FxMotivo;
    property CUF: integer read FcUF write FcUF;
    property DhRecbto: TDateTime read FdhRecbto write FdhRecbto;
  end;

  { TStatusServicoResposta }
  TStatusServicoResposta = class(TLibBPeServiceResposta)
  private
    FTMed: integer;
    FdhRetorno: TDateTime;
    FxObs: string;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    procedure Processar(const ACBrBPe: TACBrBPe); override;
  published
    property TMed: integer read FTMed write FTMed;
    property DhRetorno: TDateTime read FdhRetorno write FdhRetorno;
    property XObs: string read FxObs write FxObs;
  end;

  { TConsultaBPeResposta }
  TConsultaBPeResposta = class(TLibBPeServiceResposta)
  private
    FChBPe: String;
    FNProt: String;
    FDigVal: String;
    FcMsg: Integer;
    FxMsg: String;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const ACBrBPe: TACBrBPe); override;
  published
    property ChBPe: String read FChBPe write FChBPe;
    property NProt: String read FNProt write FNProt;
    property DigVal: String read FDigVal write FDigVal;
    property cMsg: Integer read FcMsg write FcMsg;
    property xMsg: String read FxMsg write FxMsg;
  end;

  { TEnvioResposta }
  TEnvioResposta = class(TLibBPeServiceResposta)
  private
    FtMed: integer;
    FRecibo: String;
    FNProt: String;
    Fversao: String;
    FTpAmb: String;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FItemRetorno: TRetornoItemResposta;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const ACBrBPe: TACBrBPe); override;
  published
    property TMed: integer read FtMed write FtMed;
    property Recibo: string read FRecibo write FRecibo;
    property NProt: String read FNProt write FNProt;
    property versao: String read Fversao write Fversao;
    property TpAmb: String read FTpAmb write FTpAmb;
    property verAplic: String read FverAplic write FverAplic;
    property cStat: Integer read FcStat write FcStat;
    property cUF: Integer read FcUF write FcUF;
    property xMotivo: String read FxMotivo write FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property ItemRetorno: TRetornoItemResposta read FItemRetorno;
  end;

  { TCancelamentoResposta }
  TCancelamentoResposta = class(TLibBPeServiceResposta)
  private
    FchBPe: string;
    FnProt: string;
    FtpEvento: string;
    FxEvento: string;
    FnSeqEvento: integer;
    FCNPJDest: string;
    FemailDest: string;
    Fxml: string;
    FArquivo: String;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    procedure Processar(const ACBrBPe: TACBrBPe); override;
  published
    property chBPe: string read FchBPe write FchBPe;
    property nProt: string read FnProt write FnProt;
    property tpEvento: string read FtpEvento write FtpEvento;
    property xEvento: string read FxEvento write FxEvento;
    property nSeqEvento: integer read FnSeqEvento write FnSeqEvento;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property emailDest: string read FemailDest write FemailDest;
    property XML: string read Fxml write Fxml;
    property Arquivo: string read FArquivo write FArquivo;
  end;

  { TEventoResposta }

  TEventoResposta = class(TLibBPeServiceResposta)
  private
    FidLote: Integer;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: String;
    FVersao: String;
    FXmlEnvio: String;
    FItems: TACBrObjectList;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    procedure Processar(const ACBrBPe: TACBrBPe); override;
    destructor Destroy; override;
  published
    property idLote: Integer read FidLote write FidLote;
    property cStat: Integer read FcStat write FcStat;
    property xMotivo: String read FxMotivo write FxMotivo;
    property TpAmb: String read FTpAmb write FTpAmb;
    property Versao: String read FVersao write FVersao;
    property XmlEnvio: String read FXmlEnvio write FXmlEnvio;
  end;

  { TEventoItemResposta }
  TEventoItemResposta = class(TACBrLibRespostaBase)
  private
    Farquivo: String;
    FchBPe: string;
    FCNPJDest: string;
    FcOrgao: integer;
    FdhRegEvento: TDateTime;
    FemailDest: string;
    FtpAmb: String;
    FverAplic: String;
    FcOrgaoAutor: Integer;
    FId: string;
    FnProt: String;
    FnSeqEvento: Integer;
    FtpEvento: string;
    FxEvento: string;
    FcStat: Integer;
    FxMotivo: String;
    FXML: string;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao);
    procedure Processar(const RetInfEvento: TRetInfEvento);
  published
    property chBPe: string read FchBPe write FchBPe;
    property nProt: String read FnProt write FnProt;
    property arquivo: String read Farquivo write Farquivo;
    property tpAmb: String read FtpAmb write FtpAmb;
    property verAplic: String read FverAplic write FverAplic;
    property cOrgaoAutor: Integer read FcOrgaoAutor write FcOrgaoAutor;
    property Id: string read FId write FId;
    property cOrgao: integer read FcOrgao write FcOrgao;
    property dhRegEvento: TDateTime read FdhRegEvento write FdhRegEvento;
    property tpEvento: string read FtpEvento write FtpEvento;
    property xEvento: string read FxEvento write FxEvento;
    property nSeqEvento: Integer read FnSeqEvento write FnSeqEvento;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property emailDest: string read FemailDest write FemailDest;
    property cStat: Integer read FcStat write FcStat;
    property xMotivo: String read FxMotivo write FxMotivo;
    property XML: string read FXML write FXML;
  end;

  { TDistribuicaoDFeResposta }

  TDistribuicaoDFeResposta = class(TLibBPeResposta)
  private
    Farquivo: string;
    FdhResp: TDateTime;
    FindCont: string;
    FmaxNSU: string;
    FultNSU: string;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;

  published
    property dhResp: TDateTime read FdhResp write FdhResp;
    property ultNSU: string read FultNSU write FultNSU;
    property maxNSU: string read FmaxNSU write FmaxNSU;
    property arquivo: string read Farquivo write Farquivo;
    property indCont: string read FindCont write FindCont;
  end;

  { TDistribuicaoDFeItemResposta }

  TDistribuicaoDFeItemResposta = class(TLibBPeResposta)
  private
    Farquivo: String;
    FCNPJ: string;
    FCNPJDest: string;
    FcOrgao: integer;
    FcOrgaoAutor: integer;
    FcSitBPe: String;
    FBPeChvBPe: String;
    FBPeDhemi: TDateTime;
    FBPeDhRebcto: TDateTime;
    FBPeModal: string;
    FBPeNProt: string;
    FdescEvento: string;
    FdhEmi: TDateTime;
    FdhEvento: TDateTime;
    FdhRegEvento: TDateTime;
    FdigVal: String;
    FdhRecbto: TDateTime;
    FemailDest: string;
    FEmiCNPJ: string;
    FEmiIE: string;
    FEmixNome: string;
    FId: string;
    FIE: String;
    FnProt: String;
    FnSeqEvento: Integer;
    FNSU: string;
    FchBPe: string;
    FCNPJCPF: string;
    Fschema: String;
    FtpEvento: string;
    FtpNF: String;
    FverEvento: string;
    FvNF: Currency;
    FxEvento: string;
    FxJust: string;
    FxMotivo: string;
    FXML: string;
    FxNome: string;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

  published
    property NSU: string read FNSU write FNSU;
    property chBPe: string read FchBPe write FchBPe;
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property IE: String read FIE write FIE;
    property dhEmi: TDateTime read FdhEmi write FdhEmi;
    property tpNF: String read FtpNF write FtpNF;
    property vNF: Currency read FvNF write FvNF;
    property digVal: String read FdigVal write FdigVal;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property cSitBPe: String read FcSitBPe write FcSitBPe;
    property nProt: String read FnProt write FnProt;
    property XML: string read FXML write FXML;
    property arquivo: String read Farquivo write Farquivo;
    property schema: String read Fschema write Fschema;
    property dhEvento: TDateTime read FdhEvento write FdhEvento;
    property tpEvento: string read FtpEvento write FtpEvento;
    property xEvento: string read FxEvento write FxEvento;
    property nSeqEvento: Integer read FnSeqEvento write FnSeqEvento;
    property cOrgao: integer read FcOrgao write FcOrgao;
    property CNPJ: string read FCNPJ write FCNPJ;
    property Id: string read FId write FId;
    property verEvento: string read FverEvento write FverEvento;
    property descEvento: string read FdescEvento write FdescEvento;
    property xJust: string read FxJust write FxJust;
    property xMotivo: string read FxMotivo write FxMotivo;
    property EmiCNPJ: string read FEmiCNPJ write FEmiCNPJ;
    property EmiIE: string read FEmiIE write FEmiIE;
    property EmixNome: string read FEmixNome write FEmixNome;
    property BPeNProt: string read FBPeNProt write FBPeNProt;
    property BPeChvBPe: String read FBPeChvBPe write FBPeChvBPe;
    property BPeDhemi: TDateTime read FBPeDhemi write FBPeDhemi;
    property BPeDhRebcto: TDateTime read FBPeDhRebcto write FBPeDhRebcto;
    property BPeModal: string read FBPeModal write FBPeModal;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property cOrgaoAutor: integer read FcOrgaoAutor write FcOrgaoAutor;
    property dhRegEvento: TDateTime read FdhRegEvento write FdhRegEvento;
    property emailDest: string read FemailDest write FemailDest;
  end;

implementation

uses
  ACBrLibBPeConsts;

{ TDistribuicaoDFeItemResposta }

constructor TDistribuicaoDFeItemResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

{ TDistribuicaoDFeResposta }

constructor TDistribuicaoDFeResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespDistribuicaoDFe, ATipo, AFormato);
end;

{ TEventoItemResposta }

constructor TEventoItemResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TEventoItemResposta.Processar(const RetInfEvento: TRetInfEvento);
begin
  Self.Id := RetInfEvento.Id;
  Self.Arquivo := RetInfEvento.NomeArquivo;
  Self.tpAmb := TipoAmbienteToStr(RetInfEvento.TpAmb);
  Self.verAplic := RetInfEvento.verAplic;
  Self.cOrgao := RetInfEvento.cOrgao;
  Self.cStat := RetInfEvento.cStat;
  Self.xMotivo := RetInfEvento.xMotivo;
  Self.chBPe := RetInfEvento.chBPe;
  Self.tpEvento := TpEventoToStr(RetInfEvento.tpEvento);
  Self.xEvento := RetInfEvento.xEvento;
  Self.nSeqEvento := RetInfEvento.nSeqEvento;
  Self.CNPJDest := RetInfEvento.CNPJDest;
  Self.emailDest := RetInfEvento.emailDest;
  Self.cOrgaoAutor := RetInfEvento.cOrgaoAutor;
  Self.dhRegEvento := RetInfEvento.dhRegEvento;
  Self.nProt := RetInfEvento.nProt;
  Self.XML := RetInfEvento.XML;
end;

{ TEventoResposta }

constructor TEventoResposta.Create(const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespEvento, ATipo, AFormato);
  FItems := TACBrObjectList.Create(True);
end;

destructor TEventoResposta.Destroy;
begin
  FItems.Destroy;
  inherited Destroy;
end;

procedure TEventoResposta.Processar(const ACBrBPe: TACBrBPe);
begin
  with ACBrBPe.WebServices do
  begin
    Self.idLote   := EnvEvento.idLote;
    Self.cStat    := EnvEvento.cStat;
    Self.xMotivo  := EnvEvento.xMotivo;
    Self.TpAmb    := TipoAmbienteToStr(EnvEvento.TpAmb);
    Self.Versao   := EnvEvento.EventoRetorno.versao;
    Self.XmlEnvio := EnvEvento.EventoRetorno.XmlRetorno;
  end;
end;

{ TCancelamentoResposta }

constructor TCancelamentoResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespCancelamento, ATipo, AFormato);
end;

procedure TCancelamentoResposta.Processar(const ACBrBPe: TACBrBPe);
begin
  with ACBrBPe.WebServices.EnvEvento.EventoRetorno do
  begin
    Self.Arquivo := RetInfEvento.NomeArquivo;
    Self.Versao := RetInfEvento.verAplic;
    Self.tpAmb := TipoAmbienteToStr(RetInfEvento.tpAmb);
    Self.VerAplic := RetInfEvento.verAplic;
    Self.CStat := RetInfevento.cStat;
    Self.XMotivo := RetInfEvento.xMotivo;
    Self.CUF := RetInfEvento.cOrgao;
    Self.chBPe := RetInfEvento.chBPe;
    Self.DhRecbto := RetInfEvento.dhRegEvento;
    Self.nProt := RetInfEvento.nProt;
    Self.tpEvento := TpEventoToStr(RetInfEvento.tpEvento);
    Self.xEvento := RetInfEvento.xEvento;
    Self.nSeqEvento := RetInfEvento.nSeqEvento;
    Self.CNPJDest := RetInfEvento.CNPJDest;
    Self.emailDest := RetInfEvento.emailDest;
    Self.XML := RetInfEvento.XML;
  end;
end;

{ TEnvioResposta }

constructor TEnvioResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespEnvio, ATipo, AFormato);
end;

destructor TEnvioResposta.Destroy;
begin
  if Assigned(FItemRetorno) then FreeAndNil(FItemRetorno);
end;

procedure TEnvioResposta.Processar(const ACBrBPe: TACBrBPe);
var
  NumeroNota: String;
begin
  if Assigned(FItemRetorno) then FreeAndNil(FItemRetorno);

  with ACBrBPe.WebServices do
  begin
    Versao := Enviar.versao;
    tpAmb := TipoAmbienteToStr(Enviar.TpAmb);
    VerAplic := Enviar.verAplic;
    CStat := Enviar.cStat;
    XMotivo := Enviar.xMotivo;
    CUF := Enviar.cUF;
    DhRecbto := Enviar.dhRecbto;
    tMed := Enviar.TMed;
    Msg := Enviar.Msg;
  end;

  if (ACBrBPe.Bilhetes.Count > 0) then
  begin
    NumeroNota := IntToStr(ExtrairNumeroChaveAcesso(ACBrBPe.Bilhetes.Items[0].BPe.procBPe.chDFe));

    if Trim(NumeroNota) = '' then
      Exit;

    if Trim(ACBrBPe.Bilhetes.Items[0].BPe.procBPe.nProt) = '' then
      Exit;

    FItemRetorno := TRetornoItemResposta.Create('BPe' + NumeroNota, Tipo, Codificacao);
    FItemRetorno.Id := 'ID' + ACBrBPe.Bilhetes.Items[0].BPe.procBPe.nProt;
    FItemRetorno.tpAmb := TipoAmbienteToStr(ACBrBPe.Bilhetes.Items[0].BPe.procBPe.tpAmb);
    FItemRetorno.verAplic := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.verAplic;
    FItemRetorno.chDFe := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.chDFe;
    FItemRetorno.dhRecbto := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.dhRecbto;
    FItemRetorno.nProt := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.nProt;
    FItemRetorno.digVal := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.digVal;
    FItemRetorno.cStat := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.cStat;
    FItemRetorno.xMotivo := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.xMotivo;
    FItemRetorno.XML := ACBrBPe.Bilhetes.Items[0].BPe.procBPe.XML_prot;
    FItemRetorno.NomeArq := ACBrBPe.Bilhetes.Items[0].NomeArq;
  end;
end;

{ TStatusServicoResposta }
constructor TStatusServicoResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespStatus, ATipo, AFormato);
end;

procedure TStatusServicoResposta.Processar(const ACBrBPe: TACBrBPe);
begin
  with ACBrBPe.WebServices do
  begin
    Msg := StatusServico.Msg;
    Versao := StatusServico.versao;
    TpAmb := TipoAmbienteToStr(StatusServico.TpAmb);
    VerAplic := StatusServico.VerAplic;
    CStat := StatusServico.CStat;
    XMotivo := StatusServico.XMotivo;
    CUF := StatusServico.CUF;
    DhRecbto := StatusServico.DhRecbto;
    TMed := StatusServico.TMed;
    DhRetorno := StatusServico.DhRetorno;
    XObs := StatusServico.XObs;
  end;
end;

{ TConsultaBPeResposta }
constructor TConsultaBPeResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespConsulta, ATipo, AFormato);
end;

destructor TConsultaBPeResposta.Destroy;
begin
  inherited Destroy;
end;

procedure TConsultaBPeResposta.Processar(const ACBrBPe: TACBrBPe);
begin
  with ACBrBPe.WebServices do
  begin
    Msg := Consulta.Msg;
    Versao := Consulta.versao;
    tpAmb := TipoAmbienteToStr(Consulta.TpAmb);
    VerAplic := Consulta.verAplic;
    CStat := Consulta.cStat;
    XMotivo := Consulta.XMotivo;
    CUF := Consulta.cUF;
    DhRecbto := Consulta.DhRecbto;
    ChBPe := Consulta.BPeChave;
    NProt := Consulta.Protocolo;
    DigVal := Consulta.protBPe.digVal;
    cMsg := Consulta.protBPe.cMsg;
    xMsg := Consulta.protBPe.xMsg;
  end;
end;

{ TLibBPeResposta }

constructor TLibBPeResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

{ TLibBPeServiceResposta }
constructor TLibBPeServiceResposta.Create(const ASessao: String;
  const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

end.

