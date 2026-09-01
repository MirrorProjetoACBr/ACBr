{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
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

unit ACBrNFAg.Classes;

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
  ACBrNFAg.Conversao,
  ACBrNFAg.Consts,
  ACBrDFe.RTC.Classes,
  ACBrDFeComum.Proc;

type
  { TinfNFAg }

  TinfNFAg = class(TObject)
  private
    FID: string;
    FVersao: Double;
  public
    procedure Assign(Source: TinfNFAg);

    property ID: string     read FID     write FID;
    property Versao: Double read FVersao write FVersao;
  end;

  { TIde }

  TIde = class(TObject)
  private
    FcUF: Integer;
    FtpAmb: TACBrTipoAmbiente;
    Fmodelo: Integer;
    Fserie: Integer;
    FnNF: Integer;
    FcNF: Integer;
    FcDV: Integer;
    FdhEmi: TDateTime;
    FtpEmis: TACBrTipoEmissao;
    FnSiteAutoriz: TSiteAutorizador;
    FcMunFG: Integer;
    FfinNFAg: TFinalidadeNFAg;
    FtpFat: TtpFat;
    FverProc: string;
    FdhCont: TDateTime;
    FxJust: string;
    FgCompraGov: TgCompraGovReduzido;
    FtpPagAnt: TtpPagAnt;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TIde);

    property cUF: Integer                read FcUF     write FcUF;
    property tpAmb: TACBrTipoAmbiente    read FtpAmb   write FtpAmb default taHomologacao;
    property modelo: Integer             read Fmodelo  write Fmodelo;
    property serie: Integer              read Fserie   write Fserie;
    property nNF: Integer                read FnNF     write FnNF;
    property cNF: Integer                read FcNF     write FcNF;
    property cDV: Integer                read FcDV     write FcDV;
    property dhEmi: TDateTime            read FdhEmi   write FdhEmi;
    property tpEmis: TACBrTipoEmissao    read FtpEmis  write FtpEmis default teNormal;
    property nSiteAutoriz: TSiteAutorizador read FnSiteAutoriz write FnSiteAutoriz default sa0;
    property cMunFG: Integer             read FcMunFG  write FcMunFG;
    property finNFAg: TFinalidadeNFAg    read FfinNFAg write FfinNFAg default fnNormal;
    property tpFat: TtpFat               read FtpFat write FtpFat;
    property verProc: string             read FverProc write FverProc;
    property dhCont: TDateTime           read FdhCont  write FdhCont;
    property xJust: string               read FxJust   write FxJust;
    property gCompraGov: TgCompraGovReduzido read FgCompraGov write FgCompraGov;
    property tpPagAnt: TtpPagAnt         read FtpPagAnt write FtpPagAnt;
  end;

  { TEndereco }

  TEndereco = class(TObject)
  private
    FxLgr: string;
    Fnro: string;
    fxCpl: string;
    FxBairro: string;
    FcMun: Integer;
    FxMun: string;
    FCEP: Integer;
    FUF: string;
    Ffone: string;
    Femail: string;
  public
    procedure Assign(Source: TEndereco);

    property xLgr: string    read FxLgr    write FxLgr;
    property nro: string     read Fnro     write Fnro;
    property xCpl: string    read FxCpl    write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: Integer   read FcMun    write FcMun;
    property xMun: string    read FxMun    write FxMun;
    property CEP: Integer    read FCEP     write FCEP;
    property UF: string      read FUF      write FUF;
    property fone: string    read Ffone    write Ffone;
    property email: string   read Femail   write Femail;
  end;

  { TEmit }

  TEmit = class(TObject)
  private
    FCNPJ: string;
    FIE: string;
    FxNome: string;
    FxFant: string;
    FenderEmit: TEndereco;
    FISUFEmit: string;
  public
    constructor Create();
    destructor Destroy; override;

    procedure Assign(Source: TEmit);

    property CNPJ: string         read FCNPJ write FCNPJ;
    property IE: string           read FIE write FIE;
    property xNome: string        read FxNome write FxNome;
    property xFant: string        read FxFant write FxFant;
    property EnderEmit: TEndereco read FEnderEmit write FEnderEmit;
    property ISUFEmit: string     read FISUFEmit write FISUFEmit;
  end;

  { TDest }

  TDest = class(TObject)
  private
    FxNome: string;
    FCNPJCPF: string;
    FidOutros: string;
    FIE: string;
    FIM: string;
    FcNIS: string;
    FNB: string;
    FxNomeAdicional: string;
    FEnderDest: TEndereco;
  public
    constructor Create();
    destructor Destroy; override;

    procedure Assign(Source: TDest);

    property xNome: string          read FxNome          write FxNome;
    property CNPJCPF: string        read FCNPJCPF        write FCNPJCPF;
    property idOutros: string       read FidOutros       write FidOutros;
    property IE: string             read FIE             write FIE;
    property IM: string             read FIM             write FIM;
    property cNIS: string           read FcNIS           write FcNIS;
    property NB: string             read FNB             write FNB;
    property xNomeAdicional: string read FxNomeAdicional write FxNomeAdicional;
    property EnderDest: TEndereco   read FEnderDest      write FEnderDest;
  end;

  { Tligacao }

  Tligacao = class(TObject)
  private
    FidLigacao: string;
    FidCodCliente: string;
    FtpLigacao: TtpLigacao;
    FlatGPS: string;
    FlongGPS: string;
    FcodRoteiroLeitura: string;
  public
    procedure Assign(Source: Tligacao);

    property idLigacao: string         read FidLigacao         write FidLigacao;
    property idCodCliente: string      read FidCodCliente      write FidCodCliente;
    property tpLigacao: TtpLigacao     read FtpLigacao         write FtpLigacao;
    property latGPS: string            read FlatGPS            write FlatGPS;
    property longGPS: string           read FlongGPS           write FlongGPS;
    property codRoteiroLeitura: string read FcodRoteiroLeitura write FcodRoteiroLeitura;
  end;

  { TgSub }

  TgSub = class(TObject)
  private
    FchNFAg: string;
    FmotSub: TmotSub;
  public
    procedure Assign(Source: TgSub);

    property chNFAg: string        read FchNFAg     write FchNFAg;
    property motSub: TmotSub       read FmotSub     write FmotSub;
  end;

  { TgMedCollectionItem }

  TgMedCollectionItem = class(TObject)
  private
    FidMedidor: string;
    FdMedAnt: TDateTime;
    FdMedAtu: TDateTime;
    FnMed: Integer;
  public
    procedure Assign(Source: TgMedCollectionItem);

    property idMedidor: string  read FidMedidor write FidMedidor;
    property dMedAnt: TDateTime read FdMedAnt   write FdMedAnt;
    property dMedAtu: TDateTime read FdMedAtu   write FdMedAtu;
    property nMed: Integer      read FnMed      write FnMed;
  end;

  { TgMedCollection }

  TgMedCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgMedCollectionItem;
    procedure SetItem(Index: Integer; Value: TgMedCollectionItem);
  public
    function New: TgMedCollectionItem;
    property Items[Index: Integer]: TgMedCollectionItem read GetItem write SetItem; default;
  end;

  { TgFatConjunto }

  TgFatConjunto = class(TObject)
  private
    FchNFAgFat: string;
  public
    procedure Assign(Source: TgFatConjunto);

    property chNFAgFat: string read FchNFAgFat write FchNFAgFat;
  end;

  { TgTarifCollectionItem }

  TgTarifCollectionItem = class(TObject)
  private
    FdIniTarif: TDateTime;
    FdFimTarif: TDateTime;
    FnAto: string;
    FanoAto: Integer;
    FtpFaixaCons: TtpFaixaCons;
  public
    procedure Assign(Source: TgTarifCollectionItem);

    property dIniTarif: TDateTime      read FdIniTarif     write FdIniTarif;
    property dFimTarif: TDateTime      read FdFimTarif     write FdFimTarif;
    property nAto: string              read FnAto          write FnAto;
    property anoAto: Integer           read FanoAto        write FanoAto;
    property tpFaixaCons: TtpFaixaCons read FtpFaixaCons   write FtpFaixaCons;
  end;

  { TgTarifCollection }

  TgTarifCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgTarifCollectionItem;
    procedure SetItem(Index: Integer; Value: TgTarifCollectionItem);
  public
    function New: TgTarifCollectionItem;
    property Items[Index: Integer]: TgTarifCollectionItem read GetItem write SetItem; default;
  end;

  { TgMedida }

  TgMedida = class(TObject)
  private
    FtpGrMed: TtpGrMed;
    FnUnidConsumo: string;
    FvUnidConsumo: Double;
    FuMed: TuMedFat;
    FvMedAnt: Double;
    FvMedAtu: Double;
    FvConst: Double;
    FvMed: Double;
  public
    procedure Assign(Source: TgMedida);

    property tpGrMed: TtpGrMed    read FtpGrMed      write FtpGrMed;
    property nUnidConsumo: string read FnUnidConsumo write FnUnidConsumo;
    property vUnidConsumo: Double read FvUnidConsumo write FvUnidConsumo;
    property uMed: TuMedFat       read FuMed         write FuMed;
    property vMedAnt: Double      read FvMedAnt      write FvMedAnt;
    property vMedAtu: Double      read FvMedAtu      write FvMedAtu;
    property vConst: Double       read FvConst       write FvConst;
    property vMed: Double         read FvMed         write FvMed;
  end;

  { TgMedicao }

  TgMedicao = class(TObject)
  private
    FnMed: Integer;
    FgMedida: TgMedida;
    FtpMotNaoLeitura: TtpMotNaoLeitura;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgMedicao);

    property nMed: Integer                     read FnMed            write FnMed;
    property gMedida: TgMedida                 read FgMedida         write FgMedida;
    property tpMotNaoLeitura: TtpMotNaoLeitura read FtpMotNaoLeitura write FtpMotNaoLeitura;
  end;

  { TProd }

  TProd = class(TObject)
  private
    FindOrigemQtd: TindOrigemQtd;
    FgMedicao: TgMedicao;
    FcProd: string;
    FxProd: string;
    FcClass: Integer;
    FtpCategoria: TtpCategoria;
    FxCategoria: string;
    FqEconomias: string;
    FuMed: TuMedFat;
    FqFaturada: Integer;
    FvItem: Double;
    FfatorPoluicao: Double;
    FvProd: Double;
    FindDevolucao: TIndicador;
    FgPagAntecipado: TgPagAntecipadoProd;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TProd);

    property indOrigemQtd: TindOrigemQtd read FindOrigemQtd write FindOrigemQtd;
    property gMedicao: TgMedicao         read FgMedicao     write FgMedicao;
    property cProd: string               read FcProd        write FcProd;
    property xProd: string               read FxProd        write FxProd;
    property cClass: Integer             read FcClass       write FcClass;
    property tpCategoria: TtpCategoria   read FtpCategoria  write FtpCategoria;
    property xCategoria: string          read FxCategoria   write FxCategoria;
    property qEconomias: string          read FqEconomias   write FqEconomias;
    property uMed: TuMedFat              read FuMed         write FuMed;
    property qFaturada: Integer          read FqFaturada    write FqFaturada;
    property vItem: Double               read FvItem        write FvItem;
    property fatorPoluicao: Double       read FfatorPoluicao write FfatorPoluicao;
    property vProd: Double               read FvProd        write FvProd;
    property indDevolucao: TIndicador    read FindDevolucao write FindDevolucao;
    property gPagAntecipado: TgPagAntecipadoProd read FgPagAntecipado write FgPagAntecipado;
  end;

  { TPIS }

  TPIS = class(TObject)
  private
    FCST: TCSTPis;
    FvBC: Double;
    FpPIS: Double;
    FvPIS: Double;
  public
    procedure Assign(Source: TPIS);

    property CST: TCSTPis read FCST  write FCST default pis01;
    property vBC: Double  read FvBC  write FvBC;
    property pPIS: Double read FpPIS write FpPIS;
    property vPIS: Double read FvPIS write FvPIS;
  end;

  { TCOFINS }

  TCOFINS = class(TObject)
  private
    FCST: TCSTCofins;
    FvBC: Double;
    FpCOFINS: Double;
    FvCOFINS: Double;
  public
    procedure Assign(Source: TCOFINS);

    property CST: TCSTCofins    read FCST     write FCST default cof01;
    property vBC: Double        read FvBC     write FvBC;
    property pCOFINS: Double    read FpCOFINS write FpCOFINS;
    property vCOFINS: Double    read FvCOFINS write FvCOFINS;
  end;

  { TretTrib }

  TretTrib = class(TObject)
  private
    FvRetPIS: Double;
    FvRetCOFINS: Double;
    FvRetCSLL: Double;
    FvBCIRRF: Double;
    FvIRRF: Double;
  public
    procedure Assign(Source: TretTrib);

    property vRetPIS: Double    read FvRetPIS    write FvRetPIS;
    property vRetCOFINS: Double read FvRetCOFINS write FvRetCOFINS;
    property vRetCSLL: Double   read FvRetCSLL   write FvRetCSLL;
    property vBCIRRF: Double    read FvBCIRRF    write FvBCIRRF;
    property vIRRF: Double      read FvIRRF      write FvIRRF;
  end;

  { TTFS }

  TTFS = class(TObject)
  private
    FvBCTFS: Double;
    FpTFS: Double;
    FvTFS: Double;
  public
    procedure Assign(Source: TTFS);

    property vBCTFS: Double read FvBCTFS write FvBCTFS;
    property pTFS: Double   read FpTFS   write FpTFS;
    property vTFS: Double   read FvTFS   write FvTFS;
  end;

  { TTFU }

  TTFU = class(TObject)
  private
    FvBCTFU: Double;
    FpTFU: Double;
    FvTFU: Double;
  public
    procedure Assign(Source: TTFU);

    property vBCTFU: Double read FvBCTFU write FvBCTFU;
    property pTFU: Double   read FpTFU   write FpTFU;
    property vTFU: Double   read FvTFU   write FvTFU;
  end;

  { TImposto }

  TImposto = class(TObject)
  private
    FIBSCBS: TIBSCBS;
    FPIS: TPIS;
    FCOFINS: TCOFINS;
    FretTrib: TretTrib;
    FTFS: TTFS;
    FTFU: TTFU;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TImposto);
    // Reforma Tributaria
    property IBSCBS: TIBSCBS   read FIBSCBS  write FIBSCBS;
    property PIS: TPIS         read FPIS     write FPIS;
    property COFINS: TCOFINS   read FCOFINS  write FCOFINS;
    property retTrib: TretTrib read FretTrib write FretTrib;
    property TFS: TTFS         read FTFS     write FTFS;
    property TFU: TTFU         read FTFU     write FTFU;
  end;

  { TgProcCollectionItem }

  TgProcCollectionItem = class(TObject)
  private
    FtpProc: TtpProc;
    FnProcesso: string;
  public
    procedure Assign(Source: TgProcCollectionItem);

    property tpProc: TtpProc   read FtpProc    write FtpProc;
    property nProcesso: string read FnProcesso write FnProcesso;
  end;

  { TgProcCollection }

  TgProcCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgProcCollectionItem;
    procedure SetItem(Index: Integer; Value: TgProcCollectionItem);
  public
    function New: TgProcCollectionItem;
    property Items[Index: Integer]: TgProcCollectionItem read GetItem write SetItem; default;
  end;

  { TgProRef }

  TgProcRef = class(TObject)
  private
    FvItem: Double;
    FqFaturada: Double;
    FvProd: Double;
    FindDevolucao: TIndicador;
    FgProc: TgProcCollection;

    procedure SetgProc(const Value: TgProcCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgProcRef);

    property vItem: Double            read FvItem        write FvItem;
    property qFaturada: Double        read FqFaturada    write FqFaturada;
    property vProd: Double            read FvProd        write FvProd;
    property indDevolucao: TIndicador read FindDevolucao write FindDevolucao;
    property gProc: TgProcCollection  read FgProc        write SetgProc;
  end;

  { TDetCollectionItem }

  TDetCollectionItem = class(TObject)
  private
    FnItem: Integer;
    FchNFAgAnt: string;
    FnItemAnt: Integer;

    FgTarif: TgTarifCollection;
    FProd: TProd;
    FImposto: TImposto;
    FgProcRef: TgProcRef;
    FinfAdProd: string;

    procedure SetgTarif(const Value: TgTarifCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TDetCollectionItem);
    // Atributos
    property nItem: Integer read FnItem write FnItem;
    property chNFAgAnt: string   read FchNFAgAnt   write FchNFAgAnt;
    property nItemAnt: Integer read FnItemAnt write FnItemAnt;

    property gTarif: TgTarifCollection read FgTarif    write SetgTarif;
    property Prod: TProd               read FProd      write FProd;
    property Imposto: TImposto         read FImposto   write FImposto;
    property gProcRef: TgProcRef       read FgProcRef  write FgProcRef;
    property infAdProd: string         read FinfAdProd write FinfAdProd;
  end;

  { TDetCollection }

  TDetCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TDetCollectionItem;
    procedure SetItem(Index: Integer; Value: TDetCollectionItem);
  public
    function New: TDetCollectionItem;
    property Items[Index: Integer]: TDetCollectionItem read GetItem write SetItem; default;
  end;

  { TTotal }

  TTotal = class(TObject)
  private
    FvProd: Double;
    FvRetCSLL: Double;
    FvRetPIS: Double;
    FvRetCOFINS: Double;
    FvIRRF: Double;
    FvCOFINS: Double;
    FvPIS: Double;
    FvTFS: Double;
    FvTFU: Double;
    FvNF: Double;
    FIBSCBSTot: TIBSCBSTot;
    FvTotDFe: Double;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TTotal);

    property vProd: Double       read FvProd       write FvProd;
    property vRetPIS: Double     read FvRetPIS     write FvRetPIS;
    property vRetCOFINS: Double  read FvRetCOFINS  write FvRetCOFINS;
    property vRetCSLL: Double    read FvRetCSLL    write FvRetCSLL;
    property vIRRF: Double       read FvIRRF       write FvIRRF;
    property vCOFINS: Double     read FvCOFINS     write FvCOFINS;
    property vPIS: Double        read FvPIS        write FvPIS;
    property vTFS: Double        read FvTFS        write FvTFS;
    property vTFU: Double        read FvTFU        write FvTFU;
    property vNF: Double         read FvNF         write FvNF;
    // Reforma Tributaria
    property IBSCBSTot: TIBSCBSTot read FIBSCBSTot write FIBSCBSTot;
    property vTotDFe: Double read FvTotDFe write FvTotDFe;
  end;

  { TgPIX }

  TgPIX = class(TObject)
  private
    FurlQRCodePIX: string;
  public
    procedure Assign(Source: TgPIX);

    property urlQRCodePIX: string read FurlQRCodePIX write FurlQRCodePIX;
  end;

  { TgFat }

  TgFat = class(TObject)
  private
    FCompetFat: TDateTime;
    FdVencFat: TDateTime;
    FdApresFat: TDateTime;
    FdProxLeitura: TDateTime;
    FnFat: string;
    FcodBarras: string;
    FcodDebAuto: string;
    FcodBanco: string;
    FcodAgencia: string;
    FenderCorresp: TEndereco;
    FgPIX: TgPIX;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgFat);

    property CompetFat: TDateTime    read FCompetFat    write FCompetFat;
    property dVencFat: TDateTime     read FdVencFat     write FdVencFat;
    property dApresFat: TDateTime    read FdApresFat    write FdApresFat;
    property dProxLeitura: TDateTime read FdProxLeitura write FdProxLeitura;
    property nFat: string            read FnFat         write FnFat;
    property codBarras: string       read FcodBarras    write FcodBarras;
    property codDebAuto: string      read FcodDebAuto   write FcodDebAuto;
    property codBanco: string        read FcodBanco     write FcodBanco;
    property codAgencia: string      read FcodAgencia   write FcodAgencia;
    property enderCorresp: TEndereco read FenderCorresp write FenderCorresp;
    property gPIX: TgPIX             read FgPIX         write FgPIX;
  end;

  { TgConsCollectionItem }

  TgConsCollectionItem = class(TObject)
  private
    FCompetFat: TDateTime;
    FuMed: TuMedFat;
    FqtdDias: string;
    FmedDiaria: Double;
    Fconsumo: Double;
    FvolFat: Double;
  public
    procedure Assign(Source: TgConsCollectionItem);

    property CompetFat: TDateTime read FCompetFat write FCompetFat;
    property uMed: TuMedFat       read FuMed      write FuMed;
    property qtdDias: string      read FqtdDias   write FqtdDias;
    property medDiaria: Double    read FmedDiaria write FmedDiaria;
    property consumo: Double      read Fconsumo   write Fconsumo;
    property volFat: Double       read FvolFat    write FvolFat;
  end;

  { TgConsCollection }

  TgConsCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgConsCollectionItem;
    procedure SetItem(Index: Integer; Value: TgConsCollectionItem);
  public
    function New: TgConsCollectionItem;
    property Items[Index: Integer]: TgConsCollectionItem read GetItem write SetItem; default;
  end;

  { TgHistConsCollectionItem }

  TgHistConsCollectionItem = class(TObject)
  private
    FxHistorico: string;
    FgCons: TgConsCollection;
    FmedMensal: Double;

    procedure SetgCons(const Value: TgConsCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgHistConsCollectionItem);

    property xHistorico: string read FxHistorico write FxHistorico;
    property gCons: TgConsCollection read FgCons write SetgCons;
    property medMensal: Double read FmedMensal write FmedMensal;
  end;

  { TgHistConsCollection }

  TgHistConsCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgHistConsCollectionItem;
    procedure SetItem(Index: Integer; Value: TgHistConsCollectionItem);
  public
    function New: TgHistConsCollectionItem;
    property Items[Index: Integer]: TgHistConsCollectionItem read GetItem write SetItem; default;
  end;

  { TgAgencia }

  TgAgencia = class(TObject)
  private
    Fecon: string;
    FeconAcumulada: string;
    FsPrestador: string;
    FdEmissSelo: TDateTime;
    FsRegulador: string;
    FnAgenciaAtend: string;
    FenderAgenciaAtend: string;
    FgHistCons: TgHistConsCollection;

    procedure SetgHistCons(const Value: TgHistConsCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgAgencia);

    property econ: string              read Fecon              write Fecon;
    property econAcumulada: string     read FeconAcumulada     write FeconAcumulada;
    property sPrestador: string        read FsPrestador        write FsPrestador;
    property dEmissSelo: TDateTime     read FdEmissSelo        write FdEmissSelo;
    property sRegulador: string        read FsRegulador        write FsRegulador;
    property nAgenciaAtend: string     read FnAgenciaAtend     write FnAgenciaAtend;
    property enderAgenciaAtend: string read FenderAgenciaAtend write FenderAgenciaAtend;
    property gHistCons: TgHistConsCollection read FgHistCons write SetgHistCons;
  end;

  { TgAnaliseCollectionItem }

  TgAnaliseCollectionItem = class(TObject)
  private
    FxItemAnalisado: string;
    FnAmostraMinima: string;
    FnAmostraAnalisada: string;
    FnAmostraFPadrao: string;
    FnAmostraDPadrao: string;
    FnMediaMensal: string;
    FxValorReferencia: string;
  public
    procedure Assign(Source: TgAnaliseCollectionItem);

    property xItemAnalisado: string read FxItemAnalisado write FxItemAnalisado;
    property nAmostraMinima: string read FnAmostraMinima write FnAmostraMinima;
    property nAmostraAnalisada: string read FnAmostraAnalisada write FnAmostraAnalisada;
    property nAmostraFPadrao: string read FnAmostraFPadrao write FnAmostraFPadrao;
    property nAmostraDPadrao: string read FnAmostraDPadrao write FnAmostraDPadrao;
    property nMediaMensal: string read FnMediaMensal write FnMediaMensal;
    property xValorReferencia: string read FxValorReferencia write FxValorReferencia;
  end;

  { TgAnaliseCollection }

  TgAnaliseCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgAnaliseCollectionItem;
    procedure SetItem(Index: Integer; Value: TgAnaliseCollectionItem);
  public
    function New: TgAnaliseCollectionItem;
    property Items[Index: Integer]: TgAnaliseCollectionItem read GetItem write SetItem; default;
  end;

  { TgQualiAgua }

  TgQualiAgua = class(TObject)
  private
    FCompetAnalise: TDateTime;
    FgAnalise: TgAnaliseCollection;
    FConclusao: string;
    FcProcesso: string;
    FSistemaAbast: string;

    procedure SetgAnalise(const Value: TgAnaliseCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgQualiAgua);

    property CompetAnalise: TDateTime read FCompetAnalise write FCompetAnalise;
    property gAnalise: TgAnaliseCollection read FgAnalise write SetgAnalise;
    property Conclusao: string read FConclusao write FConclusao;
    property cProcesso: string read FcProcesso write FcProcesso;
    property SistemaAbast: string read FSistemaAbast write FSistemaAbast;
  end;

  { TautXMLCollectionItem }

  TautXMLCollectionItem = class(TObject)
  private
    FCNPJCPF: string;
  public
    procedure Assign(Source: TautXMLCollectionItem);

    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
  end;

  { TautXMLCollection }

  TautXMLCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TautXMLCollectionItem;
    procedure SetItem(Index: Integer; Value: TautXMLCollectionItem);
  public
    function New: TautXMLCollectionItem;
    property Items[Index: Integer]: TautXMLCollectionItem read GetItem write SetItem; default;
  end;

  { TInfAdic }

  TInfAdic = class(TObject)
  private
    FinfAdFisco: string;
    FinfCpl: string;
  public
    procedure Assign(Source: TInfAdic);

    property infAdFisco: string read FinfAdFisco write FinfAdFisco;
    // o campo abaixo precisa ser alterado pois ele pode aparecer até 5 vezes
    // no XML portanto é uma lista
    property infCpl: string read FinfCpl write FinfCpl;
  end;

  { TInfPAA }

  TInfPAA = class(TObject)
  private
    FCNPJPAA: string;
  public
    procedure Assign(Source: TInfPAA);

    property CNPJPAA: string read FCNPJPAA write FCNPJPAA;
  end;

  { TinfRespTec }

  TinfRespTec = class(TObject)
  private
    FCNPJ: string;
    FxContato: string;
    Femail: string;
    Ffone: string;
    FidCSRT: Integer;
    FhashCSRT: string;
  public
    procedure Assign(Source: TinfRespTec);

    property CNPJ: string     read FCNPJ     write FCNPJ;
    property xContato: string read FxContato write FxContato;
    property email: string    read Femail    write Femail;
    property fone: string     read Ffone     write Ffone;
    property idCSRT: Integer  read FidCSRT   write FidCSRT;
    property hashCSRT: string read FhashCSRT write FhashCSRT;
  end;

  { TinfNFAgSupl }

  TinfNFAgSupl = class(TObject)
  private
    FqrCodNFAg: string;
  public
    procedure Assign(Source: TinfNFAgSupl);

    property qrCodNFAg: string read FqrCodNFAg write FqrCodNFAg;
  end;

  { TNFAg }

  TNFAg = class(TObject)
  private
    FinfNFAg: TinfNFAg;   // Ok
    FIde: TIde;           // Ok
    FEmit: TEmit;         // Ok
    FDest: TDest;         // Ok
    Fligacao: Tligacao;   // Ok
    FgSub: TgSub;         // Ok
    FgMed: TgMedCollection;  // Ok
    FgFatConjunto: TgFatConjunto; // Ok
    FDet: TDetCollection;  // Ok
    FTotal: TTotal;  // Ok
    FgFat: TgFat; // Ok
    FgAgencia: TgAgencia; // Ok
    FgQualiAgua: TgQualiAgua; // Ok
    FautXML: TautXMLCollection;  // Ok
    FinfAdic: TInfAdic; // Ok
    FinfPAA: TInfPAA;  // Ok
    FinfRespTec: TinfRespTec;    // Ok
    FinfNFAgSupl: TinfNFAgSupl;  // Ok
    FSignature: TSignature;      // Ok
    FprocNFAg: TProcDFe;
    FpgtoVinc: TpgtoVinc;

    procedure SetgMed(const Value: TgMedCollection);
    procedure SetDet(const Value: TDetCollection);
    procedure SetautXML(const Value: TautXMLCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TNFAg);

    property infNFAg: TinfNFAg           read FinfNFAg      write FinfNFAg;
    property Ide: TIde                   read FIde          write FIde;
    property Emit: TEmit                 read FEmit         write FEmit;
    property Dest: TDest                 read FDest         write FDest;
    property ligacao: Tligacao           read Fligacao      write Fligacao;
    property gSub: TgSub                 read FgSub         write FgSub;
    property gMed: TgMedCollection       read FgMed         write SetgMed;
    property gFatConjunto: TgFatConjunto read FgFatConjunto write FgFatConjunto;
    property Det: TDetCollection         read FDet          write SetDet;
    property Total: TTotal               read FTotal        write FTotal;
    property gFat: TgFat                 read FgFat         write FgFat;
    property gAgencia: TgAgencia         read FgAgencia     write FgAgencia;
    property gQualiAgua: TgQualiAgua     read FgQualiAgua   write FgQualiAgua;
    property autXML: TautXMLCollection   read FautXML       write SetautXML;
    property infAdic: TInfAdic           read FinfAdic      write FinfAdic;
    property infPAA: TInfPAA             read FinfPAA       write FinfPAA;
    property infRespTec: TinfRespTec     read FinfRespTec   write FinfRespTec;
    property infNFAgSupl: TinfNFAgSupl   read FinfNFAgSupl  write FinfNFAgSupl;
    property Signature: TSignature       read FSignature    write FSignature;
    property procNFAg: TProcDFe          read FprocNFAg     write FprocNFAg;
    property pgtoVinc: TpgtoVinc read FpgtoVinc write FpgtoVinc;
  end;

implementation

uses
  ACBrUtil.Base;

{ TinfNFAgSupl }

procedure TinfNFAgSupl.Assign(Source: TinfNFAgSupl);
begin
  qrCodNFAg := Source.qrCodNFAg;
end;

{ TinfPAA }

procedure TinfPAA.Assign(Source: TinfPAA);
begin
  CNPJPAA := Source.CNPJPAA;
end;

{ TinfRespTec }

procedure TinfRespTec.Assign(Source: TinfRespTec);
begin
  CNPJ     := Source.CNPJ;
  xContato := Source.xContato;
  email    := Source.email;
  fone     := Source.fone;
  idCSRT   := Source.idCSRT;
  hashCSRT := Source.hashCSRT;
end;

{ TInfAdic }

procedure TInfAdic.Assign(Source: TInfAdic);
begin
  infAdFisco := Source.infAdFisco;
  infCpl     := Source.infCpl;
end;

{ TautXMLCollectionItem }

procedure TautXMLCollectionItem.Assign(Source: TautXMLCollectionItem);
begin
  CNPJCPF := Source.CNPJCPF;
end;

{ TautXMLCollection }

function TautXMLCollection.GetItem(Index: Integer): TautXMLCollectionItem;
begin
  Result := TautXMLCollectionItem(inherited Items[Index]);
end;

procedure TautXMLCollection.SetItem(Index: Integer;
  Value: TautXMLCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TautXMLCollection.New: TautXMLCollectionItem;
begin
  Result := TautXMLCollectionItem.Create;
  Self.Add(Result);
end;

{ TgFat }

procedure TgFat.Assign(Source: TgFat);
begin
  CompetFat    := Source.CompetFat;
  dVencFat     := Source.dVencFat;
  dApresFat    := Source.dApresFat;
  dProxLeitura := Source.dProxLeitura;
  nFat         := Source.nFat;
  codBarras    := Source.codBarras;
  codDebAuto   := Source.codDebAuto;
  codBanco     := Source.codBanco;
  codAgencia   := Source.codAgencia;

  enderCorresp.Assign(Source.enderCorresp);
  gPIX.Assign(Source.gPIX);
end;

constructor TgFat.Create;
begin
  inherited Create;

  FenderCorresp := TEndereco.Create;
  FgPIX         := TgPIX.Create;
end;

destructor TgFat.Destroy;
begin
  FenderCorresp.Free;
  FgPIX.Free;

  inherited Destroy;
end;

{ TTotal }

procedure TTotal.Assign(Source: TTotal);
begin
  vProd := Source.vProd;
  vRetCSLL := Source.vRetCSLL;
  vRetPIS := Source.vRetPIS;
  vRetCOFINS := Source.vRetCOFINS;
  vIRRF := Source.vIRRF;
  vCOFINS := Source.vCOFINS;
  vPIS := Source.vPIS;
  vTFS := Source.vTFS;
  vTFU := Source.vTFU;
  vNF := Source.vNF;
  IBSCBSTot := Source.IBSCBSTot;
  vTotDFe := Source.vTotDFe;
end;

constructor TTotal.Create;
begin
  inherited Create;

  FIBSCBSTot := TIBSCBSTot.Create;
end;

destructor TTotal.Destroy;
begin
  FIBSCBSTot.Free;

  inherited Destroy;
end;

{ TDetCollection }

function TDetCollection.GetItem(Index: Integer): TDetCollectionItem;
begin
  Result := TDetCollectionItem(inherited Items[Index]);
end;

function TDetCollection.New: TDetCollectionItem;
begin
  Result := TDetCollectionItem.Create;
  Self.Add(Result);
end;

procedure TDetCollection.SetItem(Index: Integer; Value: TDetCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TDetCollectionItem }

procedure TDetCollectionItem.Assign(Source: TDetCollectionItem);
begin
  gTarif.Assign(Source.gTarif);
  Prod.Assign(Source.Prod);
  Imposto.Assign(Source.Imposto);
  gProcRef.Assign(Source.gProcRef);
  infAdProd := Source.infAdProd;
  nItem := Source.nItem;
  chNFAgAnt := Source.chNFAgAnt;
  nItemAnt := Source.nItemAnt;
end;

constructor TDetCollectionItem.Create;
begin
  inherited Create;

  FgTarif := TgTarifCollection.Create;
  FProd := TProd.Create;
  FImposto := TImposto.Create;
  FgProcRef := TgProcRef.Create;
end;

destructor TDetCollectionItem.Destroy;
begin
  FgTarif.Free;
  FProd.Free;
  FImposto.Free;
  FgProcRef.Free;

  inherited Destroy;
end;
procedure TDetCollectionItem.SetgTarif(const Value: TgTarifCollection);
begin
  FgTarif := Value;
end;

{ TgMedCollectionItem }

procedure TgMedCollectionItem.Assign(Source: TgMedCollectionItem);
begin
  nMed      := Source.nMed;
  idMedidor := Source.idMedidor;
  dMedAnt   := Source.dMedAnt;
  dMedAtu   := Source.dMedAtu;
end;

{ TgMedCollection }

function TgMedCollection.GetItem(Index: Integer): TgMedCollectionItem;
begin
  Result := TgMedCollectionItem(inherited Items[Index]);
end;

function TgMedCollection.New: TgMedCollectionItem;
begin
  Result := TgMedCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgMedCollection.SetItem(Index: Integer; Value: TgMedCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgQualiAgua }

procedure TgQualiAgua.Assign(Source: TgQualiAgua);
begin
  CompetAnalise := Source.CompetAnalise;
  Conclusao := Source.Conclusao;
  cProcesso := Source.cProcesso;
  SistemaAbast := Source.SistemaAbast;

  gAnalise.Assign(Source.gAnalise);
end;

constructor TgQualiAgua.Create;
begin
  inherited Create;

  FgAnalise := TgAnaliseCollection.Create;
end;

destructor TgQualiAgua.Destroy;
begin
  FgAnalise.Free;

  inherited;
end;

procedure TgQualiAgua.SetgAnalise(const Value: TgAnaliseCollection);
begin
  FgAnalise := Value;
end;

{ TgSub }

procedure TgSub.Assign(Source: TgSub);
begin
  chNFAg := Source.chNFAg;
  motSub := Source.motSub;
end;

{ Tligacao }

procedure Tligacao.Assign(Source: Tligacao);
begin
  idLigacao     := Source.idLigacao;
  idCodCliente := Source.idCodCliente;
  tpLigacao     := Source.tpLigacao;
  latGPS       := Source.latGPS;
  longGPS      := Source.longGPS;
  codRoteiroLeitura := Source.codRoteiroLeitura;
end;

{ TEndereco }

procedure TEndereco.Assign(Source: TEndereco);
begin
  xLgr    := Source.xLgr;
  nro     := Source.nro;
  xCpl    := Source.xCpl;
  xBairro := Source.xBairro;
  cMun    := Source.cMun;
  xMun    := Source.xMun;
  UF      := Source.UF;
  CEP     := Source.CEP;
  fone    := Source.fone;
  email   := Source.email;
end;

{ TDest }

procedure TDest.Assign(Source: TDest);
begin
  CNPJCPF        := Source.CNPJCPF;
  idOutros       := Source.idOutros;
  xNome          := Source.xNome;
  IE             := Source.IE;
  IM             := Source.IM;
  cNIS           := Source.cNIS;
  NB             := Source.NB;
  xNomeAdicional := Source.xNomeAdicional;

  EnderDest.Assign(Source.EnderDest);
end;

constructor TDest.Create();
begin
  inherited Create;

  FEnderDest := TEndereco.Create;
end;

destructor TDest.Destroy;
begin
  FEnderDest.Free;

  inherited;
end;

{ TEmit }

procedure TEmit.Assign(Source: TEmit);
begin
  CNPJ  := Source.CNPJ;
  IE    := Source.IE;
  xNome := Source.xNome;
  xFant := Source.xFant;
  ISUFEmit := Source.ISUFEmit;

  EnderEmit.Assign(Source.EnderEmit);
end;

constructor TEmit.Create();
begin
  inherited Create;

  FEnderEmit := TEndereco.Create;
end;

destructor TEmit.Destroy;
begin
  FEnderEmit.Free;

  inherited;
end;

{ TIde }

procedure TIde.Assign(Source: TIde);
begin
  cUF     := Source.cUF;
  cNF     := Source.cNF;
  modelo  := Source.modelo;
  serie   := Source.serie;
  nNF     := Source.nNF;
  dhEmi   := Source.dhEmi;
  cMunFG  := Source.cMunFG;
  tpEmis  := Source.tpEmis;
  cDV     := Source.cDV;
  tpAmb   := Source.tpAmb;
  finNFAg := Source.finNFAg;
  verProc := Source.verProc;
  dhCont  := Source.dhCont;
  xJust   := Source.xJust;
  nSiteAutoriz := Source.nSiteAutoriz;
  tpFat := Source.tpFat;
  tpPagAnt := Source.tpPagAnt;
end;

constructor TIde.Create;
begin
  inherited Create;

  FgCompraGov := TgCompraGovReduzido.Create;
end;

destructor TIde.Destroy;
begin
  FgCompraGov.Free;

  inherited;
end;

{ TinfNFAg }

procedure TinfNFAg.Assign(Source: TinfNFAg);
begin
  ID     := Source.ID;
  Versao := Source.Versao;
end;

{ TNFAg }

procedure TNFAg.Assign(Source: TNFAg);
begin
  infNFAg.Assign(Source.infNFAg);
  Ide.Assign(Source.Ide);
  Emit.Assign(Source.Emit);
  Dest.Assign(Source.Dest);
  ligacao.Assign(Source.ligacao);
  gSub.Assign(Source.gSub);
  gMed.Assign(Source.gMed);
  Det.Assign(Source.Det);
  Total.Assign(Source.Total);
  gFat.Assign(Source.gFat);
  gAgencia.Assign(Source.gAgencia);
  gQualiAgua.Assign(Source.gQualiAgua);
  autXML.Assign(Source.autXML);
  infAdic.Assign(Source.infAdic);
  infPAA.Assign(Source.infPAA);
  infRespTec.Assign(Source.infRespTec);

  infNFAgSupl.Assign(Source.infNFAgSupl);
  Signature.Assign(Source.Signature);
  procNFAg.Assign(Source.procNFAg);
end;

constructor TNFAg.Create;
begin
  inherited Create;

  FinfNFAg     := TinfNFAg.Create;
  FIde         := TIde.Create;
  FEmit        := TEmit.Create;
  FDest        := TDest.Create;
  Fligacao     := Tligacao.Create;
  FgSub        := TgSub.Create;
  FgMed        := TgMedCollection.Create;
  FgFatConjunto := TgFatConjunto.Create;
  FDet         := TDetCollection.Create;
  FTotal       := TTotal.Create;
  FgFat        := TgFat.Create;
  FgAgencia    := TgAgencia.Create;
  FgQualiAgua  := TgQualiAgua.Create;
  FautXML      := TautXMLCollection.Create;
  FinfAdic     := TinfAdic.Create;
  FinfPAA      := TinfPAA.Create;
  FinfRespTec  := TinfRespTec.Create;
  FinfNFAgSupl := TinfNFAgSupl.Create;
  FSignature   := TSignature.Create;
  FpgtoVinc := TpgtoVinc.Create;

  FprocNFAg    := TProcDFe.Create('1.00', NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');

  FIde.nSiteAutoriz := sa0;
end;

destructor TNFAg.Destroy;
begin
  FinfNFAg.Free;
  FIde.Free;
  FEmit.Free;
  FDest.Free;
  Fligacao.Free;
  FgSub.Free;
  FgMed.Free;
  FgFatConjunto.Free;
  FDet.Free;
  FTotal.Free;
  FgFat.Free;
  FgAgencia.Free;
  FgQualiAgua.Free;
  FautXML.Free;
  FinfAdic.Free;
  FinfPAA.Free;
  FinfRespTec.Free;
  FinfNFAgSupl.Free;
  FSignature.Free;
  FprocNFAg.Free;
  FpgtoVinc.Free;

  inherited Destroy;
end;

procedure TNFAg.SetgMed(const Value: TgMedCollection);
begin
  FgMed := Value;
end;

procedure TNFAg.SetDet(const Value: TDetCollection);
begin
  FDet := Value;
end;

procedure TNFAg.SetautXML(const Value: TautXMLCollection);
begin
  FautXML := Value;
end;

{ TgFatConjunto }

procedure TgFatConjunto.Assign(Source: TgFatConjunto);
begin
  chNFAgFat := Source.chNFAgFat;
end;

{ TgTarifCollectionItem }

procedure TgTarifCollectionItem.Assign(Source: TgTarifCollectionItem);
begin
  dIniTarif   := Source.dIniTarif;
  dFimTarif   := Source.dFimTarif;
  nAto        := Source.nAto;
  anoAto      := Source.anoAto;
  tpFaixaCons := Source.tpFaixaCons;
end;

{ TgTarifCollection }

function TgTarifCollection.GetItem(Index: Integer): TgTarifCollectionItem;
begin
  Result := TgTarifCollectionItem(inherited Items[Index]);
end;

function TgTarifCollection.New: TgTarifCollectionItem;
begin
  Result := TgTarifCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgTarifCollection.SetItem(Index: Integer;
  Value: TgTarifCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TProd }

procedure TProd.Assign(Source: TProd);
begin
  indOrigemQtd := Source.indOrigemQtd;
  cProd        := Source.cProd;
  xProd        := Source.xProd;
  cClass       := Source.cClass;
  tpCategoria  := Source.tpCategoria;
  xCategoria   := Source.xCategoria;
  qEconomias   := Source.qEconomias;
  uMed         := Source.uMed;
  qFaturada    := Source.qFaturada;
  vItem        := Source.vItem;
  fatorPoluicao := Source.fatorPoluicao;
  vProd        := Source.vProd;
  indDevolucao := Source.indDevolucao;

  gMedicao.Assign(Source.gMedicao);
  gPagAntecipado.Assign(Source.gPagAntecipado);
end;

constructor TProd.Create;
begin
  inherited Create;

  FgMedicao := TgMedicao.Create;
  FgPagAntecipado := TgPagAntecipadoProd.Create;
end;

destructor TProd.Destroy;
begin
  FgMedicao.Free;
  FgPagAntecipado.Free;

  inherited Destroy;
end;

{ TImposto }

procedure TImposto.Assign(Source: TImposto);
begin
  IBSCBS := Source.IBSCBS;
  PIS.Assign(Source.PIS);
  COFINS.Assign(Source.COFINS);
  retTrib.Assign(Source.retTrib);
  TFS.Assign(Source.TFS);
  TFU.Assign(Source.TFU);
end;

constructor TImposto.Create;
begin
  inherited Create;

  FIBSCBS := TIBSCBS.Create;
  FPIS := TPIS.Create;
  FCOFINS := TCOFINS.Create;
  FretTrib := TretTrib.Create;
  FTFS := TTFS.Create;
  FTFU := TTFU.Create;
end;

destructor TImposto.Destroy;
begin
  FIBSCBS.Free;
  FPIS.Free;
  FCOFINS.Free;
  FretTrib.Free;
  FTFS.Free;
  FTFU.Free;

  inherited Destroy;
end;

{ TgProRef }

procedure TgProcRef.Assign(Source: TgProcRef);
begin
  vItem        := Source.vItem;
  qFaturada    := Source.qFaturada;
  vProd        := Source.vProd;
  indDevolucao := Source.indDevolucao;
  gProc.Assign(Source.gProc);
end;

constructor TgProcRef.Create;
begin
  inherited Create;

  FgProc := TgProcCollection.Create;
end;

destructor TgProcRef.Destroy;
begin
  FgProc.Free;

  inherited Destroy;
end;

procedure TgProcRef.SetgProc(const Value: TgProcCollection);
begin
  FgProc := Value;
end;

{ TgMedicao }

procedure TgMedicao.Assign(Source: TgMedicao);
begin
  nMed := Source.nMed;
  gMedida.Assign(Source.gMedida);
  tpMotNaoLeitura := Source.tpMotNaoLeitura;
end;

constructor TgMedicao.Create;
begin
  inherited Create;

  FgMedida := TgMedida.Create;
end;

destructor TgMedicao.Destroy;
begin
  FgMedida.Free;

  inherited Destroy;
end;

{ TgMedida }

procedure TgMedida.Assign(Source: TgMedida);
begin
  tpGrMed := Source.tpGrMed;
  nUnidConsumo := Source.nUnidConsumo;
  vUnidConsumo := Source.vUnidConsumo;
  uMed := Source.uMed;
  vMedAnt := Source.vMedAnt;
  vMedAtu := Source.vMedAtu;
  vConst := Source.vConst;
  vMed := Source.vMed;
end;

{ TPIS }

procedure TPIS.Assign(Source: TPIS);
begin
  CST  := Source.CST;
  vBC  := Source.vBC;
  pPIS := Source.pPIS;
  vPIS := Source.vPIS;
end;

{ TCOFINS }

procedure TCOFINS.Assign(Source: TCOFINS);
begin
  CST     := Source.CST;
  vBC     := Source.vBC;
  pCOFINS := Source.pCOFINS;
  vCOFINS := Source.vCOFINS;
end;

{ TretTrib }

procedure TretTrib.Assign(Source: TretTrib);
begin
  vRetPIS    := Source.vRetPIS;
  vRetCOFINS := Source.vRetCOFINS;
  vRetCSLL   := Source.vRetCSLL;
  vBCIRRF    := Source.vBCIRRF;
  vIRRF      := Source.vIRRF;
end;

{ TTFS }

procedure TTFS.Assign(Source: TTFS);
begin
  vBCTFS := Source.vBCTFS;
  pTFS := Source.pTFS;
  vTFS := Source.vTFS;
end;

{ TTFU }

procedure TTFU.Assign(Source: TTFU);
begin
  vBCTFU := Source.vBCTFU;
  pTFU := Source.pTFU;
  vTFU := Source.vTFU;
end;

{ TgProcCollectionItem }

procedure TgProcCollectionItem.Assign(Source: TgProcCollectionItem);
begin
  tpProc    := Source.tpProc;
  nProcesso := Source.nProcesso;
end;

{ TgProcCollection }

function TgProcCollection.GetItem(Index: Integer): TgProcCollectionItem;
begin
  Result := TgProcCollectionItem(inherited Items[Index]);
end;

function TgProcCollection.New: TgProcCollectionItem;
begin
  Result := TgProcCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgProcCollection.SetItem(Index: Integer; Value: TgProcCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgPIX }

procedure TgPIX.Assign(Source: TgPIX);
begin
  urlQRCodePIX := Source.urlQRCodePIX;
end;

{ TgAgencia }

procedure TgAgencia.Assign(Source: TgAgencia);
begin
  econ := Source.econ;
  econAcumulada := Source.econAcumulada;
  sPrestador := Source.sPrestador;
  dEmissSelo := Source.dEmissSelo;
  sRegulador := Source.sRegulador;
  nAgenciaAtend := Source.nAgenciaAtend;
  enderAgenciaAtend := Source.enderAgenciaAtend;

  gHistCons.Assign(Source.gHistCons);
end;

constructor TgAgencia.Create;
begin
  inherited Create;

  FgHistCons := TgHistConsCollection.Create;
end;

destructor TgAgencia.Destroy;
begin
  FgHistCons.Free;

  inherited Destroy;
end;

procedure TgAgencia.SetgHistCons(const Value: TgHistConsCollection);
begin
  FgHistCons := Value;
end;

{ TgHistConsCollectionItem }

procedure TgHistConsCollectionItem.Assign(Source: TgHistConsCollectionItem);
begin
  xHistorico := Source.xHistorico;
  medMensal := Source.medMensal;

  gCons.Assign(Source.gCons);
end;

constructor TgHistConsCollectionItem.Create;
begin
  inherited Create;

  FgCons := TgConsCollection.Create;
end;

destructor TgHistConsCollectionItem.Destroy;
begin
  FgCons.Free;

  inherited Destroy;
end;

procedure TgHistConsCollectionItem.SetgCons(const Value: TgConsCollection);
begin
  FgCons := Value;
end;

{ TgHistConsCollection }

function TgHistConsCollection.GetItem(Index: Integer): TgHistConsCollectionItem;
begin
  Result := TgHistConsCollectionItem(inherited Items[Index]);
end;

function TgHistConsCollection.New: TgHistConsCollectionItem;
begin
  Result := TgHistConsCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgHistConsCollection.SetItem(Index: Integer;
  Value: TgHistConsCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgConsCollectionItem }

procedure TgConsCollectionItem.Assign(Source: TgConsCollectionItem);
begin
  CompetFat := Source.CompetFat;
  uMed := Source.uMed;
  qtdDias := Source.qtdDias;
  medDiaria := Source.medDiaria;
  consumo := Source.consumo;
  volFat := Source.volFat;
end;

{ TgConsCollection }

function TgConsCollection.GetItem(Index: Integer): TgConsCollectionItem;
begin
  Result := TgConsCollectionItem(inherited Items[Index]);
end;

function TgConsCollection.New: TgConsCollectionItem;
begin
  Result := TgConsCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgConsCollection.SetItem(Index: Integer; Value: TgConsCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgAnaliseCollectionItem }

procedure TgAnaliseCollectionItem.Assign(Source: TgAnaliseCollectionItem);
begin
  xItemAnalisado := Source.xItemAnalisado;
  nAmostraMinima := Source.nAmostraMinima;
  nAmostraAnalisada := Source.nAmostraAnalisada;
  nAmostraFPadrao := Source.nAmostraFPadrao;
  nAmostraDPadrao := Source.nAmostraDPadrao;
  nMediaMensal := Source.nMediaMensal;
  xValorReferencia := Source.xValorReferencia;
end;

{ TgAnaliseCollection }

function TgAnaliseCollection.GetItem(Index: Integer): TgAnaliseCollectionItem;
begin
  Result := TgAnaliseCollectionItem(inherited Items[Index]);
end;

function TgAnaliseCollection.New: TgAnaliseCollectionItem;
begin
  Result := TgAnaliseCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgAnaliseCollection.SetItem(Index: Integer;
  Value: TgAnaliseCollectionItem);
begin
  inherited Items[Index] := Value;
end;

end.
