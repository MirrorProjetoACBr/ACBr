{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFe.RTC.Classes;

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
  ACBrDFe.Conversao;

type

  { TgPagAntecipadoProd }

  TgPagAntecipadoProd = class(TObject)
  private
    FchDFePagAnt: string;
    FnItemPagAnt: Integer;
  public
    procedure Assign(Source: TgPagAntecipadoProd);

    property chDFePagAnt: string read FchDFePagAnt write FchDFePagAnt;
    property nItemPagAnt: Integer read FnItemPagAnt write FnItemPagAnt;
  end;

  { TrefDFePagAntCollectionItem }

  TrefDFePagAntCollectionItem = class(TObject)
  private
    FrefDFEChave: string;
  public
    procedure Assign(Source: TrefDFePagAntCollectionItem);

    property refDFEChave: string read FrefDFEChave write FrefDFeChave;
  end;

  { TrefDFePagAntCollection }

  TrefDFePagAntCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TrefDFePagAntCollectionItem;
    procedure SetItem(Index: Integer; Value: TrefDFePagAntCollectionItem);
  public
    function New: TrefDFePagAntCollectionItem;
    property Items[Index: Integer]: TrefDFePagAntCollectionItem read GetItem write SetItem; default;
  end;

  { TgPagAntecipado }

  TgPagAntecipado = class(TObject)
  private
    FrefNFe: TrefDFePagAntCollection;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgPagAntecipado);

    property refNFe: TrefDFePagAntCollection read FrefNFe write FrefNFe;
  end;

  { TDFeReferenciado }

  TDFeReferenciado = class(TObject)
  private
    FchaveAcesso: string;
    FnItem: Integer;
  public
    procedure Assign(Source: TDFeReferenciado);
    property chaveAcesso: string read FchaveAcesso write FchaveAcesso;
    property nItem: Integer read FnItem write FnItem;
  end;

  { TrefDFeAntCollectionItem }

  TrefDFeAntCollectionItem = class(TObject)
  private
    FrefDFeAnt: string;
  public
    procedure Assign(Source: TrefDFeAntCollectionItem);

    property refDFeAnt: string read FrefDFeAnt write FrefDFeAnt;
  end;

  { TrefDFeAntCollection }

  TrefDFeAntCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TrefDFeAntCollectionItem;
    procedure SetItem(Index: Integer; Value: TrefDFeAntCollectionItem);
  public
    function New: TrefDFeAntCollectionItem;
    property Items[Index: Integer]: TrefDFeAntCollectionItem read GetItem write SetItem; default;
  end;

  { TgCompraGovReduzido }
  {Usado por: BPe, CTe, NF3e, NFAg, NFCom, NFGas}

  TgCompraGovReduzido = class(TObject)
  private
    FtpEnteGov: TtpEnteGov;
    FpRedutor: Double;
    FtpOperGov: TtpOperGov;
    FrefDFe: TrefDFeAntCollection;

    procedure SetrefDFe(const Value: TrefDFeAntCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCompraGovReduzido);

    property tpEnteGov: TtpEnteGov read FtpEnteGov write FtpEnteGov;
    property pRedutor: Double read FpRedutor write FpRedutor;
    property tpOperGov: TtpOperGov read FtpOperGov write FtpOperGov;
    property refDFe: TrefDFeAntCollection read FrefDFe write SetrefDFe;
  end;

  { TDFErefCollectionItem }

  TDFErefCollectionItem = class(TObject)
  private
    FrefDFeChave: string;
  public
    procedure Assign(Source: TDFErefCollectionItem);

    property refDFeChave: string read FrefDFeChave write FrefDFeChave;
  end;

  { TDFErefCollection }

  TDFErefCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TDFErefCollectionItem;
    procedure SetItem(Index: Integer; Value: TDFErefCollectionItem);
  public
    function New: TDFErefCollectionItem;
    property Items[Index: Integer]: TDFErefCollectionItem read GetItem write SetItem; default;
  end;

  { TgCompraGov }
  {Usado por: NFe}

  TgCompraGov = class(TObject)
  private
    FtpEnteGov: TtpEnteGov;
    FpRedutor: Double;
    FtpOperGov: TtpOperGov;
    FrefDFeAnt: TDFerefCollection;

    procedure SetrefDFeAnt(const Value: TDFerefCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCompraGov);

    property tpEnteGov: TtpEnteGov read FtpEnteGov write FtpEnteGov;
    property pRedutor: Double read FpRedutor write FpRedutor;
    property tpOperGov: TtpOperGov read FtpOperGov write FtpOperGov;
    property refDFeAnt: TDFerefCollection read FrefDFeAnt write SetrefDFeAnt;
  end;

  { TgALCZFMCBS }

  TgALCZFMCBS = class(TObject)
  private
    FnProcSuframa: String;
    FpAliqEfetRegCBS: Double;
    FtpALCZFMCBS: TtpALCZFMCBS;
    FvTribRegCBS: Double;
  public
    property tpALCZFMCBS: TtpALCZFMCBS read FtpALCZFMCBS write FtpALCZFMCBS;
    property nProcSuframa: String read FnProcSuframa write FnProcSuframa;
    property pAliqEfetRegCBS: Double read FpAliqEfetRegCBS write FpAliqEfetRegCBS;
    property vTribRegCBS: Double read FvTribRegCBS write FvTribRegCBS;
  end;

  { TgDif }

  TgDif = class(TObject)
  private
    FpDif: Double;
    FvDif: Double;
  public
    property pDif: Double read FpDif write FpDif;
    property vDif: Double read FvDif write FvDif;
  end;

  { TgDevTrib }

  TgDevTrib = class(TObject)
  private
    FvDevTrib: Double;
    FpDevTrib: Double;
  public
    property pDevTrib: Double read FpDevTrib write FpDevTrib;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
  end;

  { TgRed }

  TgRed = class(TObject)
  private
    FpRedAliq: Double;
    FpAliqEfet: Double;
  public
    property pRedAliq: Double read FpRedAliq write FpRedAliq;
    property pAliqEfet: Double read FpAliqEfet write FpAliqEfet;
  end;

  { TgIBSUFValores }

  TgIBSUFValores = class(TObject)
  private
    FpIBSUF: Double;
    FgDif: TgDif;
    FgDevTrib: TgDevTrib;
    FgRed: TgRed;
    FvIBSUF: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property pIBSUF: Double read FpIBSUF write FpIBSUF;
    property gDif: TgDif read FgDif write FgDif;
    property gDevTrib: TgDevTrib read FgDevTrib write FgDevTrib;
    property gRed: TgRed read FgRed write FgRed;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
  end;

  { TgIBSMunValores }

  TgIBSMunValores = class(TObject)
  private
    FpIBSMun: Double;
    FgDif: TgDif;
    FgDevTrib: TgDevTrib;
    FgRed: TgRed;
    FvIBSMun: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property pIBSMun: Double read FpIBSMun write FpIBSMun;
    property gDif: TgDif read FgDif write FgDif;
    property gDevTrib: TgDevTrib read FgDevTrib write FgDevTrib;
    property gRed: TgRed read FgRed write FgRed;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
  end;

  { TgCBSValores }

  TgCBSValores = class(TObject)
  private
    FpCBS: Double;
    FgDif: TgDif;
    FgDevTrib: TgDevTrib;
    FgRed: TgRed;
    FvCBS: Double;
    FgALCZFMCBS: TgALCZFMCBS;
  public
    constructor Create;
    destructor Destroy; override;

    property pCBS: Double read FpCBS write FpCBS;
    property gDif: TgDif read FgDif write FgDif;
    property gDevTrib: TgDevTrib read FgDevTrib write FgDevTrib;
    property gRed: TgRed read FgRed write FgRed;
    property vCBS: Double read FvCBS write FvCBS;
    property gALCZFMCBS: TgALCZFMCBS read FgALCZFMCBS write FgALCZFMCBS;
  end;

  { TgTribRegular }

  TgTribRegular = class(TObject)
  private
    FCSTReg: TCSTIBSCBS;
    FcClassTribReg: string;
    FpAliqEfetRegIBSUF: Double;
    FvTribRegIBSUF: Double;
    FpAliqEfetRegIBSMun: Double;
    FvTribRegIBSMun: Double;
    FpAliqEfetRegCBS: Double;
    FvTribRegCBS: Double;
  public
    property CSTReg: TCSTIBSCBS read FCSTReg write FCSTReg;
    property cClassTribReg: string read FcClassTribReg write FcClassTribReg;
    property pAliqEfetRegIBSUF: Double read FpAliqEfetRegIBSUF write FpAliqEfetRegIBSUF;
    property vTribRegIBSUF: Double read FvTribRegIBSUF write FvTribRegIBSUF;
    property pAliqEfetRegIBSMun: Double read FpAliqEfetRegIBSMun write FpAliqEfetRegIBSMun;
    property vTribRegIBSMun: Double read FvTribRegIBSMun write FvTribRegIBSMun;
    property pAliqEfetRegCBS: Double read FpAliqEfetRegCBS write FpAliqEfetRegCBS;
    property vTribRegCBS: Double read FvTribRegCBS write FvTribRegCBS;
  end;

  { TgTribCompraGov }

  TgTribCompraGov = class(TObject)
  private
    FpAliqIBSUF: Double;
    FvTribIBSUF: Double;
    FpAliqIBSMun: Double;
    FvTribIBSMun: Double;
    FpAliqCBS: Double;
    FvTribCBS: Double;
  public
    property pAliqIBSUF: Double read FpAliqIBSUF write FpAliqIBSUF;
    property vTribIBSUF: Double read FvTribIBSUF write FvTribIBSUF;
    property pAliqIBSMun: Double read FpAliqIBSMun write FpAliqIBSMun;
    property vTribIBSMun: Double read FvTribIBSMun write FvTribIBSMun;
    property pAliqCBS: Double read FpAliqCBS write FpAliqCBS;
    property vTribCBS: Double read FvTribCBS write FvTribCBS;
  end;

  { TgIBSCBS }

  TgIBSCBS = class(TObject)
  private
    FvBC: Double;
    FvIBS: Double;
    FgIBSUF: TgIBSUFValores;
    FgIBSMun: TgIBSMunValores;
    FgCBS: TgCBSValores;
    FgTribRegular: TgTribRegular;
    FgTribCompraGov: TgTribCompraGov;
  public
    constructor Create;
    destructor Destroy; override;

    property vBC: Double read FvBC write FvBC;
    property vIBS: Double read FvIBS write FvIBS;
    property gIBSUF: TgIBSUFValores read FgIBSUF write FgIBSUF;
    property gIBSMun: TgIBSMunValores read FgIBSMun write FgIBSMun;
    property gCBS: TgCBSValores read FgCBS write FgCBS;
    property gTribRegular: TgTribRegular read FgTribRegular write FgTribRegular;
    property gTribCompraGov: TgTribCompraGov read FgTribCompraGov write FgTribCompraGov;
  end;

  { TgMonoPadraoIBSQtde }

  TgMonoPadraoIBSQtde = class(TObject)
  private
    FqBCMono: Double;
    FadRemIBS: Double;
    FvIBSMono: Double;
  public
    procedure Assign(Source: TgMonoPadraoIBSQtde);

    property qBCMono: Double read FqBCMono write FqBCMono;
    property adRemIBS: Double read FadRemIBS write FadRemIBS;
    property vIBSMono: Double read FvIBSMono write FvIBSMono;
  end;

  { TgMonoRetenIBSQtde }

  TgMonoRetenIBSQtde = class(TObject)
  private
    FqBCMonoReten: Double;
    FadRemIBSReten: Double;
    FvIBSMonoReten: Double;
  public
    procedure Assign(Source: TgMonoRetenIBSQtde);

    property qBCMonoReten: Double read FqBCMonoReten write FqBCMonoReten;
    property adRemIBSReten: Double read FadRemIBSReten write FadRemIBSReten;
    property vIBSMonoReten: Double read FvIBSMonoReten write FvIBSMonoReten;
  end;

  { TgpBioDiferencaIBS }

  TgpBioDiferencaIBS = class(TObject)
  private
    FqBCBioComb: Double;
    FvIBSDiferenca: Double;
  public
    procedure Assign(Source: TgpBioDiferencaIBS);

    property qBCBioComb: Double read FqBCBioComb write FqBCBioComb;
    property vIBSDiferenca: Double read FvIBSDiferenca write FvIBSDiferenca;
  end;

  { TgMonoRetIBS }

  TgMonoRetIBS = class(TObject)
  private
    FvIBSMonoRet: Double;
  public
    procedure Assign(Source: TgMonoRetIBS);

    property vIBSMonoRet: Double read FvIBSMonoRet write FvIBSMonoRet;
  end;

  { TgIBSMonoAdRem }

  TgIBSMonoAdRem = class(TObject)
  private
    FgMonoPadrao: TgMonoPadraoIBSQtde;
    FgMonoReten: TgMonoRetenIBSQtde;
    FgMonoRet: TgMonoRetIBS;
    FgpBioDiferenca: TgpBioDiferencaIBS;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgIBSMonoAdRem);

    property gMonoPadrao: TgMonoPadraoIBSQtde read FgMonoPadrao write FgMonoPadrao;
    property gMonoReten: TgMonoRetenIBSQtde read FgMonoReten write FgMonoReten;
    property gMonoRet: TgMonoRetIBS read FgMonoRet write FgMonoRet;
    property gpBioDiferenca: TgpBioDiferencaIBS read FgpBioDiferenca write FgpBioDiferenca;
  end;

  { TgMonoPadraoIBSAliq }

  TgMonoPadraoIBSAliq = class(TObject)
  private
    FvBCMono: Double;
    FpAliqMonoUF: Double;
    FvIBSMonoUF: Double;
    FpAliqMonoMun: Double;
    FvIBSMonoMun: Double;
    FvIBSMono: Double;
  public
    procedure Assign(Source: TgMonoPadraoIBSAliq);

    property vBCMono: Double read FvBCMono write FvBCMono;
    property pAliqMonoUF: Double read FpAliqMonoUF write FpAliqMonoUF;
    property vIBSMonoUF: Double read FvIBSMonoUF write FvIBSMonoUF;
    property pAliqMonoMun: Double read FpAliqMonoMun write FpAliqMonoMun;
    property vIBSMonoMun: Double read FvIBSMonoMun write FvIBSMonoMun;
    property vIBSMono: Double read FvIBSMono write FvIBSMono;
  end;

  { TgMonoRetenIBSAliq }

  TgMonoRetenIBSAliq = class(TObject)
  private
    FvBCMonoReten: Double;
    FpAliqMonoReten: Double;
    FvIBSMonoReten: Double;
  public
    procedure Assign(Source: TgMonoRetenIBSAliq);

    property vBCMonoReten: Double read FvBCMonoReten write FvBCMonoReten;
    property pAliqMonoReten: Double read FpAliqMonoReten write FpAliqMonoReten;
    property vIBSMonoReten: Double read FvIBSMonoReten write FvIBSMonoReten;
  end;

  { TgIBSMonoAdValorem }

  TgIBSMonoAdValorem = class(TObject)
  private
    FgMonoPadrao: TgMonoPadraoIBSAliq;
    FgMonoReten: TgMonoRetenIBSAliq;
    FgMonoRet: TgMonoRetIBS;
    FgpBioDiferenca: TgpBioDiferencaIBS;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgIBSMonoAdValorem);

    property gMonoPadrao: TgMonoPadraoIBSAliq read FgMonoPadrao write FgMonoPadrao;
    property gMonoReten: TgMonoRetenIBSAliq read FgMonoReten write FgMonoReten;
    property gMonoRet: TgMonoRetIBS read FgMonoRet write FgMonoRet;
    property gpBioDiferenca: TgpBioDiferencaIBS read FgpBioDiferenca write FgpBioDiferenca;
  end;

  { TgMonoPadraoCBSQtde }

  TgMonoPadraoCBSQtde = class(TObject)
  private
    FqBCMono: Double;
    FadRemCBS: Double;
    FvCBSMono: Double;
  public
    procedure Assign(Source: TgMonoPadraoCBSQtde);

    property qBCMono: Double read FqBCMono write FqBCMono;
    property adRemCBS: Double read FadRemCBS write FadRemCBS;
    property vCBSMono: Double read FvCBSMono write FvCBSMono;
  end;

  { TgMonoRetenCBSQtde }

  TgMonoRetenCBSQtde = class(TObject)
  private
    FqBCMonoReten: Double;
    FadRemCBSReten: Double;
    FvCBSMonoReten: Double;
  public
    procedure Assign(Source: TgMonoRetenCBSQtde);

    property qBCMonoReten: Double read FqBCMonoReten write FqBCMonoReten;
    property adRemCBSReten: Double read FadRemCBSReten write FadRemCBSReten;
    property vCBSMonoReten: Double read FvCBSMonoReten write FvCBSMonoReten;
  end;

  { TgpBioDiferencaCBS }

  TgpBioDiferencaCBS = class(TObject)
  private
    FqBCBioComb: Double;
    FvCBSDiferenca: Double;
  public
    procedure Assign(Source: TgpBioDiferencaCBS);

    property qBCBioComb: Double read FqBCBioComb write FqBCBioComb;
    property vCBSDiferenca: Double read FvCBSDiferenca write FvCBSDiferenca;
  end;

  { TgMonoRetCBS }

  TgMonoRetCBS = class(TObject)
  private
    FvCBSMonoRet: Double;
  public
    procedure Assign(Source: TgMonoRetCBS);

    property vCBSMonoRet: Double read FvCBSMonoRet write FvCBSMonoRet;
  end;

  { TgCBSMonoAdRem }

  TgCBSMonoAdRem = class(TObject)
  private
    FgMonoPadrao: TgMonoPadraoCBSQtde;
    FgMonoReten: TgMonoRetenCBSQtde;
    FgMonoRet: TgMonoRetCBS;
    FgpBioDiferenca: TgpBioDiferencaCBS;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCBSMonoAdRem);

    property gMonoPadrao: TgMonoPadraoCBSQtde read FgMonoPadrao write FgMonoPadrao;
    property gMonoReten: TgMonoRetenCBSQtde read FgMonoReten write FgMonoReten;
    property gMonoRet: TgMonoRetCBS read FgMonoRet write FgMonoRet;
    property gpBioDiferenca: TgpBioDiferencaCBS read FgpBioDiferenca write FgpBioDiferenca;
  end;

  { TgMonoPadraoCBSAliq }

  TgMonoPadraoCBSAliq = class(TObject)
  private
    FvBCMono: Double;
    FpAliqMonoCBS: Double;
    FvCBSMono: Double;
  public
    procedure Assign(Source: TgMonoPadraoCBSAliq);

    property vBCMono: Double read FvBCMono write FvBCMono;
    property pAliqMonoCBS: Double read FpAliqMonoCBS write FpAliqMonoCBS;
    property vCBSMono: Double read FvCBSMono write FvCBSMono;
  end;

  { TgMonoRetenCBSAliq }

  TgMonoRetenCBSAliq = class(TObject)
  private
    FvBCMonoReten: Double;
    FpAliqMonoReten: Double;
    FvCBSMonoReten: Double;
  public
    procedure Assign(Source: TgMonoRetenCBSAliq);

    property vBCMonoReten: Double read FvBCMonoReten write FvBCMonoReten;
    property pAliqMonoReten: Double read FpAliqMonoReten write FpAliqMonoReten;
    property vCBSMonoReten: Double read FvCBSMonoReten write FvCBSMonoReten;
  end;

  { TgCBSMonoAdValorem }

  TgCBSMonoAdValorem = class(TObject)
  private
    FgMonoPadrao: TgMonoPadraoCBSAliq;
    FgMonoReten: TgMonoRetenCBSAliq;
    FgMonoRet: TgMonoRetCBS;
    FgpBioDiferenca: TgpBioDiferencaCBS;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCBSMonoAdValorem);

    property gMonoPadrao: TgMonoPadraoCBSAliq read FgMonoPadrao write FgMonoPadrao;
    property gMonoReten: TgMonoRetenCBSAliq read FgMonoReten write FgMonoReten;
    property gMonoRet: TgMonoRetCBS read FgMonoRet write FgMonoRet;
    property gpBioDiferenca: TgpBioDiferencaCBS read FgpBioDiferenca write FgpBioDiferenca;
  end;

  { TgIBSCBSMono }

  TgIBSCBSMono = class(TObject)
  private
    FgIBSMonoAdRem: TgIBSMonoAdRem;
    FgIBSMonoAdValorem: TgIBSMonoAdValorem;
    FgCBSMonoAdRem: TgCBSMonoAdRem;
    FgCBSMonoAdValorem: TgCBSMonoAdValorem;

    FvTotIBSMonoItem: Double;
    FvTotCBSMonoItem: Double;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgIBSCBSMono);

    property gIBSMonoAdRem: TgIBSMonoAdRem read FgIBSMonoAdRem write FgIBSMonoAdRem;
    property gIBSMonoAdValorem: TgIBSMonoAdValorem read FgIBSMonoAdValorem write FgIBSMonoAdValorem;
    property gCBSMonoAdRem: TgCBSMonoAdRem read FgCBSMonoAdRem write FgCBSMonoAdRem;
    property gCBSMonoAdValorem: TgCBSMonoAdValorem read FgCBSMonoAdValorem write FgCBSMonoAdValorem;

    property vTotIBSMonoItem: Double read FvTotIBSMonoItem write FvTotIBSMonoItem;
    property vTotCBSMonoItem: Double read FvTotCBSMonoItem write FvTotCBSMonoItem;
  end;

  { TgTransfCred }

  TgTransfCred = class(TObject)
  private
    FvCBS: Double;
    FvIBS: Double;
  public
    procedure Assign(Source: TgTransfCred);

    property vIBS: Double read FvIBS write FvIBS;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TgAjusteCompet }

  TgAjusteCompet = class(TObject)
  private
    FcompetApur: TDateTime;
    FvCBS: Double;
    FvIBS: Double;
  public
    procedure Assign(Source: TgAjusteCompet);

    property competApur: TDateTime read FcompetApur write FcompetApur;
    property vIBS: Double read FvIBS write FvIBS;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TgEstornoCred }

  TgEstornoCred = class(TObject)
  private
    FvIBSEstCred: Double;
    FvCBSEstCred: Double;
  public
    property vIBSEstCred: Double read FvIBSEstCred write FvIBSEstCred;
    property vCBSEstCred: Double read FvCBSEstCred write FvCBSEstCred;
  end;

  { TgIBSCBSCredPres }

  TgIBSCBSCredPres = class(TObject)
  private
    FpCredPres: Double;
    FvCredPres: Double;
    FvCredPresCondSus: Double;
  public
    procedure Assign(Source: TgIBSCBSCredPres);

    property pCredPres: Double read FpCredPres write FpCredPres;
    property vCredPres: Double read FvCredPres write FvCredPres;
    property vCredPresCondSus: Double read FvCredPresCondSus write FvCredPresCondSus;
  end;

  { TgCredPresOper }

  TgCredPresOper = class(TObject)
  private
    FvBCCredPres: Double;
    FcCredPres: TcCredPres;
    FgIBSCredPres: TgIBSCBSCredPres;
    FgCBSCredPres: TgIBSCBSCredPres;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgCredPresOper);

    property vBCCredPres: Double read FvBCCredPres write FvBCCredPres;
    property cCredPres: TcCredPres read FcCredPres write FcCredPres;
    property gIBSCredPres: TgIBSCBSCredPres read FgIBSCredPres write FgIBSCredPres;
    property gCBSCredPres: TgIBSCBSCredPres read FgCBSCredPres write FgCBSCredPres;
  end;

  { TCredPresIBSZFM }

  TCredPresIBSZFM = class(TObject)
  private
    FcompetApur: TDateTime;
    FtpCredPresIBSZFM: TTpCredPresIBSZFM;
    FvCredPresIBSZFM: Double;
  public
    procedure Assign(Source: TCredPresIBSZFM);

    property competApur: TDateTime read FcompetApur write FcompetApur;
    property tpCredPresIBSZFM: TTpCredPresIBSZFM read FtpCredPresIBSZFM write FtpCredPresIBSZFM;
    property vCredPresIBSZFM: Double read FvCredPresIBSZFM write FvCredPresIBSZFM;
  end;

  { TIBSCBS }

  TIBSCBS = class(TObject)
  private
    FCST: TCSTIBSCBS;
    FcClassTrib: string;
    FindDoacao: TIndicadorEx;
    FgIBSCBS: TgIBSCBS;
    FgIBSCBSMono: TgIBSCBSMono;
    FgTransfCred: TgTransfCred;
    FgAjusteCompet: TgAjusteCompet;
    FgEstornoCred: TgEstornoCred;
    FgCredPresOper: TgCredPresOper;
    FgCredPresIBSZFM: TCredPresIBSZFM;
  public
    constructor Create;
    destructor Destroy; override;

    property CST: TCSTIBSCBS read FCST write FCST;
    property cClassTrib: string read FcClassTrib write FcClassTrib;
    property indDoacao: TIndicadorEx read FindDoacao write FindDoacao;

    property gIBSCBS: TgIBSCBS read FgIBSCBS write FgIBSCBS;
    property gIBSCBSMono: TgIBSCBSMono read FgIBSCBSMono write FgIBSCBSMono;
    property gTransfCred: TgTransfCred read FgTransfCred write FgTransfCred;
    property gAjusteCompet: TgAjusteCompet read FgAjusteCompet write FgAjusteCompet;
    property gEstornoCred: TgEstornoCred read FgEstornoCred write FgEstornoCred;
    property gCredPresOper: TgCredPresOper read FgCredPresOper write FgCredPresOper;
    property gCredPresIBSZFM: TCredPresIBSZFM read FgCredPresIBSZFM write FgCredPresIBSZFM;
  end;

  { TgIS }

  TgIS = class(TObject)
  private
    //Usar string até a publicação de uma tabela de CSTs oficial para o IS
    //FCSTIS: TCSTIS;
    FCSTIS: string;
    FcClassTribIS: string;
    FvBCIS: Double;
    FpIS: Double;
    FpISEspec: Double;
    FuTrib: string;
    FqTrib: Double;
    FvIS: Double;
  public
    procedure Assign(Source: TgIS);
    //Usar string até a publicação de uma tabela de CSTs oficial para o IS
    //property CSTIS: TCSTIS read FCSTIS write FCSTIS;
    property CSTIS: string read FCSTIS write FCSTIS;
    property cClassTribIS: string read FcClassTribIS write FcClassTribIS;
    property vBCIS: Double read FvBCIS write FvBCIS;
    property pIS: Double read FpIS write FpIS;
    property pISEspec: Double read FpISEspec write FpISEspec;
    property uTrib: string read FuTrib write FuTrib;
    property qTrib: Double read FqTrib write FqTrib;
    property vIS: Double read FvIS write FvIS;
  end;

  { TISTot }

  TISTot = class(TObject)
  private
    FvIS: Double;
  public
    procedure Assign(Source: TISTot);

    property vIS: Double read FvIS write FvIS;
  end;

  { TgIBSUFTot }

  TgIBSUFTot = class(TObject)
  private
    FvDif: Double;
    FvDevTrib: Double;
    FvIBSUF: Double;
  public
    property vDif: Double read FvDif write FvDif;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
  end;

  { TgIBSMunTot }

  TgIBSMunTot = class(TObject)
  private
    FvDif: Double;
    FvDevTrib: Double;
    FvIBSMun: Double;
  public
    property vDif: Double read FvDif write FvDif;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
  end;

  { TgIBS }

  TgIBS = class(TObject)
  private
    FgIBSUFTot: TgIBSUFTot;
    FgIBSMunTot: TgIBSMunTot;
    FvIBS: Double;
    FvCredPres: Double;
    FvCredPresCondSus: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property gIBSUFTot: TgIBSUFTot read FgIBSUFTot write FgIBSUFTot;
    property gIBSMunTot: TgIBSMunTot read FgIBSMunTot write FgIBSMunTot;
    property vIBS: Double read FvIBS write FvIBS;
    property vCredPres: Double read FvCredPres write FvCredPres;
    property vCredPresCondSus: Double read FvCredPresCondSus write FvCredPresCondSus;
  end;

  { TgCBS }

  TgCBS = class(TObject)
  private
    FvDif: Double;
    FvDevTrib: Double;
    FvCBS: Double;
    FvCredPres: Double;
    FvCredPresCondSus: Double;
  public
    property vDif: Double read FvDif write FvDif;
    property vDevTrib: Double read FvDevTrib write FvDevTrib;
    property vCBS: Double read FvCBS write FvCBS;
    property vCredPres: Double read FvCredPres write FvCredPres;
    property vCredPresCondSus: Double read FvCredPresCondSus write FvCredPresCondSus;
  end;

  { TgMono }

  TgMono = class(TObject)
  private
    FvIBSMono: Double;
    FvCBSMono: Double;
    FvIBSMonoReten: Double;
    FvCBSMonoReten: Double;
    FvIBSMonoRet: Double;
    FvCBSMonoRet: Double;
  public
    procedure Assign(Source: TgMono);
    property vIBSMono: Double read FvIBSMono write FvIBSMono;
    property vCBSMono: Double read FvCBSMono write FvCBSMono;
    property vIBSMonoReten: Double read FvIBSMonoReten write FvIBSMonoReten;
    property vCBSMonoReten: Double read FvCBSMonoReten write FvCBSMonoReten;
    property vIBSMonoRet: Double read FvIBSMonoRet write FvIBSMonoRet;
    property vCBSMonoRet: Double read FvCBSMonoRet write FvCBSMonoRet;
  end;

  { TIBSCBSTot }

  TIBSCBSTot = class(TObject)
  private
    FvBCIBSCBS: Double;
    FgIBS: TgIBS;
    FgCBS: TgCBS;
    FgEstornoCred: TgEstornoCred;
    FgMono: TgMono;
  public
    constructor Create;
    destructor Destroy; override;

    property vBCIBSCBS: Double read FvBCIBSCBS write FvBCIBSCBS;
    property gIBS: TgIBS read FgIBS write FgIBS;
    property gCBS: TgCBS read FgCBS write FgCBS;
    property gMono: TgMono read FgMono write FgMono;
    property gEstornoCred: TgEstornoCred read FgEstornoCred write FgEstornoCred;
  end;

  { TpgtoCollectionItem }

  TpgtoCollectionItem = class(TObject)
  private
    FtpMeioPgto: string;
    FCNPJReceb: string;
    FCNPJBasePSP: string;
    FnPag: Integer;
    FidTransacao: string;
  public
    procedure Assign(Source: TpgtoCollectionItem);

    property tpMeioPgto: string read FtpMeioPgto write FtpMeioPgto;
    property CNPJReceb: string read FCNPJReceb write FCNPJReceb;
    property CNPJBasePSP: string read FCNPJBasePSP write FCNPJBasePSP;
    property nPag: Integer read FnPag write FnPag;
    property idTransacao: string read FidTransacao write FidTransacao;
  end;

  TpgtoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TpgtoCollectionItem;
    procedure SetItem(Index: Integer; Value: TpgtoCollectionItem);
  public
    function Add: TpgtoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TpgtoCollectionItem;
    property Items[Index: Integer]: TpgtoCollectionItem read GetItem write SetItem; default;
  end;

  { TpgtoVinc }

  TpgtoVinc = class(TObject)
  private
    Fpgto: TpgtoCollection;

    procedure Setpgto(const Value: TpgtoCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TpgtoVinc);

    property pgto: TpgtoCollection read Fpgto write Setpgto;
  end;

implementation

{ TgCompraGovReduzido }

procedure TgCompraGovReduzido.Assign(Source: TgCompraGovReduzido);
begin
  tpEnteGov := Source.tpEnteGov;
  pRedutor := Source.pRedutor;
  tpOperGov := Source.tpOperGov;
  refDFe.Assign(Source.refDFe);
end;

constructor TgCompraGovReduzido.Create;
begin
  inherited Create;

  FrefDFe := TrefDFeAntCollection.Create;
end;

destructor TgCompraGovReduzido.Destroy;
begin
  FrefDFe.Free;

  inherited;
end;

procedure TgCompraGovReduzido.SetrefDFe(const Value: TrefDFeAntCollection);
begin
  FrefDFe := Value;
end;

{ TrefDFeAntCollection }

function TrefDFeAntCollection.GetItem(Index: Integer): TrefDFeAntCollectionItem;
begin
  Result := TrefDFeAntCollectionItem(inherited Items[Index]);
end;

function TrefDFeAntCollection.New: TrefDFeAntCollectionItem;
begin
  Result := TrefDFeAntCollectionItem.Create;
  Self.Add(Result);
end;

procedure TrefDFeAntCollection.SetItem(Index: Integer;
  Value: TrefDFeAntCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TrefDFeAntCollectionItem }

procedure TrefDFeAntCollectionItem.Assign(Source: TrefDFeAntCollectionItem);
begin
  refDFeAnt := Source.refDFeAnt;
end;

{ TIBSCBS }

constructor TIBSCBS.Create;
begin
  inherited Create;

  FgIBSCBS := TgIBSCBS.Create;
  FgIBSCBSMono := TgIBSCBSMono.Create;
  FgTransfCred := TgTransfCred.Create;
  FgAjusteCompet := TgAjusteCompet.Create;
  FgEstornoCred := TgEstornoCred.Create;
  FgCredPresOper := TgCredPresOper.Create;
  FgCredPresIBSZFM := TCredPresIBSZFM.Create;
end;

destructor TIBSCBS.Destroy;
begin
  FgIBSCBS.Free;
  FgIBSCBSMono.Free;
  FgTransfCred.Free;
  FgAjusteCompet.Free;
  FgEstornoCred.Free;
  FgCredPresOper.Free;
  FgCredPresIBSZFM.Free;

  inherited Destroy;
end;

{ TgIBSCBS }

constructor TgIBSCBS.Create;
begin
  inherited Create;

  FgIBSUF := TgIBSUFValores.Create;
  FgIBSMun := TgIBSMunValores.Create;
  FgCBS := TgCBSValores.Create;
  FgTribRegular := TgTribRegular.Create;
  FgTribCompraGov := TgTribCompraGov.Create;
end;

destructor TgIBSCBS.Destroy;
begin
  FgIBSUF.Free;
  FgIBSMun.Free;
  FgCBS.Free;
  FgTribRegular.Free;
  FgTribCompraGov.Free;

  inherited Destroy;
end;

{ TgIBSUFValores }

constructor TgIBSUFValores.Create;
begin
  inherited Create;

  FgDif := TgDif.Create;
  FgDevTrib := TgDevTrib.Create;
  FgRed := TgRed.Create;
end;

destructor TgIBSUFValores.Destroy;
begin
  FgDif.Free;
  FgDevTrib.Free;
  FgRed.Free;

  inherited Destroy;
end;

{ TgIBSMunValores }

constructor TgIBSMunValores.Create;
begin
  inherited Create;

  FgDif := TgDif.Create;
  FgDevTrib := TgDevTrib.Create;
  FgRed := TgRed.Create;
end;

destructor TgIBSMunValores.Destroy;
begin
  FgDif.Free;
  FgDevTrib.Free;
  FgRed.Free;

  inherited Destroy;
end;

{ TgCBSValores }

constructor TgCBSValores.Create;
begin
  inherited Create;

  FgDif := TgDif.Create;
  FgDevTrib := TgDevTrib.Create;
  FgRed := TgRed.Create;
  FgALCZFMCBS := TgALCZFMCBS.Create;
end;

destructor TgCBSValores.Destroy;
begin
  FgDif.Free;
  FgDevTrib.Free;
  FgRed.Free;
  FgALCZFMCBS.Free;

  inherited Destroy;
end;

{ TIBSCBSTot }

constructor TIBSCBSTot.Create;
begin
  inherited Create;

  FgIBS := TgIBS.Create;
  FgCBS := TgCBS.Create;
  FgMono := TgMono.Create;
  FgEstornoCred := TgEstornoCred.Create;
end;

destructor TIBSCBSTot.Destroy;
begin
  FgIBS.Free;
  FgCBS.Free;
  FgMono.Free;
  FgEstornoCred.Free;

  inherited Destroy;
end;

{ TgIBS }

constructor TgIBS.Create;
begin
  inherited Create;

  FgIBSUFTot := TgIBSUFTot.Create;
  FgIBSMunTot := TgIBSMunTot.Create;
end;

destructor TgIBS.Destroy;
begin
  FgIBSUFTot.Free;
  FgIBSMunTot.Free;

  inherited Destroy;
end;

{ TpgtoVinc }

procedure TpgtoVinc.Assign(Source: TpgtoVinc);
begin
  pgto.Assign(Source.pgto);
end;

constructor TpgtoVinc.Create;
begin
  inherited Create;

  Fpgto := TpgtoCollection.Create;
end;

destructor TpgtoVinc.Destroy;
begin
  Fpgto.Free;

  inherited;
end;

procedure TpgtoVinc.Setpgto(const Value: TpgtoCollection);
begin
  Fpgto := Value;
end;

{ TpgtoCollection }

function TpgtoCollection.Add: TpgtoCollectionItem;
begin
  Result := Self.New;
end;

function TpgtoCollection.GetItem(Index: Integer): TpgtoCollectionItem;
begin
  Result := TpgtoCollectionItem(inherited Items[Index]);
end;

function TpgtoCollection.New: TpgtoCollectionItem;
begin
  Result := TpgtoCollectionItem.Create;
  Self.Add(Result);
end;

procedure TpgtoCollection.SetItem(Index: Integer; Value: TpgtoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TpgtoCollectionItem }

procedure TpgtoCollectionItem.Assign(Source: TpgtoCollectionItem);
begin
  tpMeioPgto := Source.tpMeioPgto;
  CNPJReceb := Source.CNPJReceb;
  CNPJBasePSP := Source.CNPJBasePSP;
  nPag := Source.nPag;
  idTransacao := Source.idTransacao;
end;

{ TgCompraGov }

procedure TgCompraGov.Assign(Source: TgCompraGov);
begin
  tpEnteGov := Source.tpEnteGov;
  pRedutor := Source.pRedutor;
  tpOperGov := Source.tpOperGov;
  refDFeAnt.Assign(Source.refDFeAnt);
end;

constructor TgCompraGov.Create;
begin
  inherited Create;

  FrefDFeAnt := TDFerefCollection.Create;
end;

destructor TgCompraGov.Destroy;
begin
  FrefDFeAnt.Free;

  inherited;
end;

procedure TgCompraGov.SetrefDFeAnt(const Value: TDFerefCollection);
begin
  FrefDFeAnt := Value;
end;

{ TgIS }

procedure TgIS.Assign(Source: TgIS);
begin
  CSTIS := Source.CSTIS;
  cClassTribIS := Source.cClassTribIS;
  vBCIS := Source.vBCIS;
  pIS := Source.pIS;
  pISEspec := Source.pISEspec;
  uTrib := Source.uTrib;
  qTrib := Source.qTrib;
  vIS := Source.vIS;
end;

{ TgMonoPadraoIBSQtde }

procedure TgMonoPadraoIBSQtde.Assign(Source: TgMonoPadraoIBSQtde);
begin
  qBCMono := Source.qBCMono;
  adRemIBS := Source.adRemIBS;
  vIBSMono := Source.vIBSMono;
end;

{ TgMonoRetenIBSQtde }

procedure TgMonoRetenIBSQtde.Assign(Source: TgMonoRetenIBSQtde);
begin
  qBCMonoReten := Source.qBCMonoReten;
  adRemIBSReten := Source.adRemIBSReten;
  vIBSMonoReten := Source.vIBSMonoReten;
end;

{ TgMonoRetIBS }

procedure TgMonoRetIBS.Assign(Source: TgMonoRetIBS);
begin
  vIBSMonoRet := Source.vIBSMonoRet;
end;

{ TgpBioDiferenca }

procedure TgpBioDiferencaIBS.Assign(Source: TgpBioDiferencaIBS);
begin
  qBCBioComb := Source.qBCBioComb;
  vIBSDiferenca := Source.vIBSDiferenca;
end;

{ TgIBSCBSMono }

procedure TgIBSCBSMono.Assign(Source: TgIBSCBSMono);
begin
  gIBSMonoAdRem.Assign(Source.gIBSMonoAdRem);
  gIBSMonoAdValorem.Assign(Source.gIBSMonoAdValorem);
  gCBSMonoAdRem.Assign(Source.gCBSMonoAdRem);
  gCBSMonoAdValorem.Assign(Source.gCBSMonoAdValorem);

  vTotIBSMonoItem := Source.vTotIBSMonoItem;
  vTotCBSMonoItem := Source.vTotCBSMonoItem;
end;

constructor TgIBSCBSMono.Create;
begin
  inherited Create;

  FgIBSMonoAdRem := TgIBSMonoAdRem.Create;
  FgIBSMonoAdValorem := TgIBSMonoAdValorem.Create;
  FgCBSMonoAdRem := TgCBSMonoAdRem.Create;
  FgCBSMonoAdValorem := TgCBSMonoAdValorem.Create;
end;

destructor TgIBSCBSMono.Destroy;
begin
  FgIBSMonoAdRem.Free;
  FgIBSMonoAdValorem.Free;
  FgCBSMonoAdRem.Free;
  FgCBSMonoAdValorem.Free;

  inherited;
end;

{ TgTransfCred }

procedure TgTransfCred.Assign(Source: TgTransfCred);
begin
  vIBS := Source.vIBS;
  vCBS := Source.vCBS;
end;

{ TgAjusteCompet }

procedure TgAjusteCompet.Assign(Source: TgAjusteCompet);
begin
  FcompetApur := Source.competApur;
  FvCBS := Source.vCBS;
  FvIBS := Source.vIBS;
end;

{ TgIBSCBSCredPres }

procedure TgIBSCBSCredPres.Assign(Source: TgIBSCBSCredPres);
begin
  FpCredPres := Source.pCredPres;
  FvCredPres := Source.vCredPres;
  FvCredPresCondSus := Source.vCredPresCondSus;
end;

{ TgCredPresOper }

procedure TgCredPresOper.Assign(Source: TgCredPresOper);
begin
  FvBCCredPres := Source.vBCCredPres;
  FcCredPres := Source.cCredPres;
  gIBSCredPres.Assign(Source.gIBSCredPres);
  gCBSCredPres.Assign(Source.gCBSCredPres);
end;

constructor TgCredPresOper.Create;
begin
  inherited Create;

  FgIBSCredPres := TgIBSCBSCredPres.Create;
  FgCBSCredPres := TgIBSCBSCredPres.Create;
end;

destructor TgCredPresOper.Destroy;
begin
  FgIBSCredPres.Free;
  FgCBSCredPres.Free;

  inherited;
end;

{ TISTot }

procedure TISTot.Assign(Source: TISTot);
begin
  vIS := Source.vIS;
end;

{ TgMono }

procedure TgMono.Assign(Source: TgMono);
begin
  FvIBSMono := Source.vIBSMono;
  FvCBSMono := Source.vCBSMono;
  FvIBSMonoReten := Source.vIBSMonoReten;
  FvCBSMonoReten := Source.vCBSMonoReten;
  FvIBSMonoRet := Source.vIBSMonoRet;
  FvCBSMonoRet := Source.vCBSMonoRet;
end;

{ TCredPresIBSZFM }

procedure TCredPresIBSZFM.Assign(Source: TCredPresIBSZFM);
begin
  FcompetApur := Source.competApur;
  FtpCredPresIBSZFM := Source.tpCredPresIBSZFM;
  FvCredPresIBSZFM := Source.vCredPresIBSZFM;
end;

{ TDFeReferenciado }

procedure TDFeReferenciado.Assign(Source: TDFeReferenciado);
begin
  FchaveAcesso := Source.chaveAcesso;
  FnItem := Source.nItem;
end;

{ TgIBSMonoAdRem }

procedure TgIBSMonoAdRem.Assign(Source: TgIBSMonoAdRem);
begin
  gMonoPadrao.Assign(Source.gMonoPadrao);
  gMonoReten.Assign(Source.gMonoReten);
  gMonoRet.Assign(Source.gMonoRet);
  gpBioDiferenca.Assign(Source.gpBioDiferenca);
end;

constructor TgIBSMonoAdRem.Create;
begin
  inherited Create;

  FgMonoPadrao := TgMonoPadraoIBSQtde.Create;
  FgMonoReten := TgMonoRetenIBSQtde.Create;
  FgMonoRet := TgMonoRetIBS.Create;
  FgpBioDiferenca := TgpBioDiferencaIBS.Create;
end;

destructor TgIBSMonoAdRem.Destroy;
begin
  FgMonoPadrao.Free;
  FgMonoReten.Free;
  FgMonoRet.Free;
  FgpBioDiferenca.Free;

  inherited;
end;

{ TgIBSMonoAdValorem }

procedure TgIBSMonoAdValorem.Assign(Source: TgIBSMonoAdValorem);
begin
  gMonoPadrao.Assign(Source.gMonoPadrao);
  gMonoReten.Assign(Source.gMonoReten);
  gMonoRet.Assign(Source.gMonoRet);
  gpBioDiferenca.Assign(Source.gpBioDiferenca);
end;

constructor TgIBSMonoAdValorem.Create;
begin
  inherited Create;

  FgMonoPadrao := TgMonoPadraoIBSAliq.Create;
  FgMonoReten := TgMonoRetenIBSAliq.Create;
  FgMonoRet := TgMonoRetIBS.Create;
  FgpBioDiferenca := TgpBioDiferencaIBS.Create;
end;

destructor TgIBSMonoAdValorem.Destroy;
begin
  FgMonoPadrao.Free;
  FgMonoReten.Free;
  FgMonoRet.Free;
  FgpBioDiferenca.Free;

  inherited;
end;

{ TgCBSMonoAdRem }

procedure TgCBSMonoAdRem.Assign(Source: TgCBSMonoAdRem);
begin
  gMonoPadrao.Assign(Source.gMonoPadrao);
  gMonoReten.Assign(Source.gMonoReten);
  gMonoRet.Assign(Source.gMonoRet);
  gpBioDiferenca.Assign(Source.gpBioDiferenca);
end;

constructor TgCBSMonoAdRem.Create;
begin
  inherited Create;

  FgMonoPadrao := TgMonoPadraoCBSQtde.Create;
  FgMonoReten := TgMonoRetenCBSQtde.Create;
  FgMonoRet := TgMonoRetCBS.Create;
  FgpBioDiferenca := TgpBioDiferencaCBS.Create;
end;

destructor TgCBSMonoAdRem.Destroy;
begin
  FgMonoPadrao.Free;
  FgMonoReten.Free;
  FgMonoRet.Free;
  FgpBioDiferenca.Free;

  inherited;
end;

{ TgCBSMonoAdValorem }

procedure TgCBSMonoAdValorem.Assign(Source: TgCBSMonoAdValorem);
begin
  gMonoPadrao.Assign(Source.gMonoPadrao);
  gMonoReten.Assign(Source.gMonoReten);
  gMonoRet.Assign(Source.gMonoRet);
  gpBioDiferenca.Assign(Source.gpBioDiferenca);
end;

constructor TgCBSMonoAdValorem.Create;
begin
  inherited Create;

  FgMonoPadrao := TgMonoPadraoCBSAliq.Create;
  FgMonoReten := TgMonoRetenCBSAliq.Create;
  FgMonoRet := TgMonoRetCBS.Create;
  FgpBioDiferenca := TgpBioDiferencaCBS.Create;
end;

destructor TgCBSMonoAdValorem.Destroy;
begin
  FgMonoPadrao.Free;
  FgMonoReten.Free;
  FgMonoRet.Free;
  FgpBioDiferenca.Free;

  inherited;
end;

{ TgMonoPadraoCBSQtde }

procedure TgMonoPadraoCBSQtde.Assign(Source: TgMonoPadraoCBSQtde);
begin
  qBCMono := Source.qBCMono;
  adRemCBS := Source.adRemCBS;
  vCBSMono := Source.vCBSMono;
end;

{ TgMonoRetenCBSQtde }

procedure TgMonoRetenCBSQtde.Assign(Source: TgMonoRetenCBSQtde);
begin
  qBCMonoReten := Source.qBCMonoReten;
  adRemCBSReten := Source.adRemCBSReten;
  vCBSMonoReten := Source.vCBSMonoReten;
end;

{ TgMonoRetCBS }

procedure TgMonoRetCBS.Assign(Source: TgMonoRetCBS);
begin
  vCBSMonoRet := Source.vCBSMonoRet;
end;

{ TgpBioDiferencaCBS }

procedure TgpBioDiferencaCBS.Assign(Source: TgpBioDiferencaCBS);
begin
  qBCBioComb := Source.qBCBioComb;
  vCBSDiferenca := Source.vCBSDiferenca;
end;

{ TgMonoPadraoIBSAliq }

procedure TgMonoPadraoIBSAliq.Assign(Source: TgMonoPadraoIBSAliq);
begin
  vBCMono := Source.vBCMono;
  pAliqMonoUF := Source.pAliqMonoUF;
  vIBSMonoUF := Source.vIBSMonoUF;
  pAliqMonoMun := Source.pAliqMonoMun;
  vIBSMonoMun := Source.vIBSMonoMun;
  vIBSMono := Source.vIBSMono;
end;

{ TgMonoRetenIBSAliq }

procedure TgMonoRetenIBSAliq.Assign(Source: TgMonoRetenIBSAliq);
begin
  vBCMonoReten := Source.vBCMonoReten;
  pAliqMonoReten := Source.pAliqMonoReten;
  vIBSMonoReten := Source.vIBSMonoReten;
end;

{ TgMonoPadraoCBSAliq }

procedure TgMonoPadraoCBSAliq.Assign(Source: TgMonoPadraoCBSAliq);
begin
  vBCMono := Source.vBCMono;
  pAliqMonoCBS := Source.pAliqMonoCBS;
  vCBSMono := Source.vCBSMono;
end;

{ TgMonoRetenCBSAliq }

procedure TgMonoRetenCBSAliq.Assign(Source: TgMonoRetenCBSAliq);
begin
  vBCMonoReten := Source.vBCMonoReten;
  pAliqMonoReten := Source.pAliqMonoReten;
  vCBSMonoReten := Source.vCBSMonoReten;
end;

{ TgPagAntecipado }

procedure TgPagAntecipado.Assign(Source: TgPagAntecipado);
begin
  refNFe.Assign(Source.refNFe);
end;

constructor TgPagAntecipado.Create;
begin
  inherited Create;

  FrefNFe := TrefDFePagAntCollection.Create;
end;

destructor TgPagAntecipado.Destroy;
begin
  FrefNFe.Free;

  inherited Destroy;
end;

{ TrefDFePagAntCollection }

function TrefDFePagAntCollection.GetItem(
  Index: Integer): TrefDFePagAntCollectionItem;
begin
  Result := TrefDFePagAntCollectionItem(inherited Items[Index]);
end;

function TrefDFePagAntCollection.New: TrefDFePagAntCollectionItem;
begin
  Result := TrefDFePagAntCollectionItem.Create;
  Self.Add(Result);
end;

procedure TrefDFePagAntCollection.SetItem(Index: Integer;
  Value: TrefDFePagAntCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TrefDFePagAntCollectionItem }

procedure TrefDFePagAntCollectionItem.Assign(
  Source: TrefDFePagAntCollectionItem);
begin
  refDFEChave := Source.refDFEChave;
end;

{ TgPagAntecipadoProd }

procedure TgPagAntecipadoProd.Assign(Source: TgPagAntecipadoProd);
begin
  chDFePagAnt := Source.chDFePagAnt;
  nItemPagAnt := Source.nItemPagAnt;
end;

{ TDFErefAntCollectionItem }

procedure TDFErefCollectionItem.Assign(Source: TDFErefCollectionItem);
begin
  refDFeChave := Source.refDFeChave;
end;

{ TDFErefAntCollection }

function TDFErefCollection.GetItem(Index: Integer): TDFErefCollectionItem;
begin
  Result := TDFErefCollectionItem(inherited Items[Index]);
end;

function TDFErefCollection.New: TDFErefCollectionItem;
begin
  Result := TDFErefCollectionItem.Create;
  Self.Add(Result);
end;

procedure TDFErefCollection.SetItem(Index: Integer;
  Value: TDFErefCollectionItem);
begin
  inherited Items[Index] := Value;
end;

end.
