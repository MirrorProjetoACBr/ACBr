{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Jonathas Duarte Pereira                         }
{                              Italo Giurizzato Junior                         }
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

unit ACBrNFGas.Classes;

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
  ACBrDFeComum.Proc,
  ACBrDFe.RTC.Classes,
  ACBrNFGas.Conversao;

type

  { TinfNFGas }

  TinfNFGas = class(TObject)
  private
    FID: string;
    FVersao: Double;
  public
    procedure Assign(Source: TinfNFGas);

    property ID: string read FID write FID;
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
    FfinNFGas: TFinalidadeNFGas;
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

    property cUF: Integer read FcUF write FcUF;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property modelo: Integer read Fmodelo write Fmodelo;
    property serie: Integer read Fserie write Fserie;
    property nNF: Integer read FnNF write FnNF;
    property cNF: Integer read FcNF write FcNF;
    property cDV: Integer read FcDV write FcDV;
    property dhEmi: TDateTime read FdhEmi write FdhEmi;
    property tpEmis: TACBrTipoEmissao read FtpEmis write FtpEmis;
    property nSiteAutoriz: TSiteAutorizador read FnSiteAutoriz write FnSiteAutoriz;
    property cMunFG: Integer read FcMunFG write FcMunFG;
    property finNFGas: TFinalidadeNFGas read FfinNFGas write FfinNFGas default fnNormal;
    property tpFat: TtpFat read FtpFat write FtpFat;
    property verProc: string read FverProc write FverProc;
    property dhCont: TDateTime read FdhCont write FdhCont;
    property xJust: string read FxJust write FxJust;
    property gCompraGov: TgCompraGovReduzido read FgCompraGov write FgCompraGov;
    property tpPagAnt: TtpPagAnt read FtpPagAnt write FtpPagAnt default tpaNenhum;
  end;

  { TEndereco }

  TEndereco = class(TObject)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: Integer;
    FxMun: string;
    FCEP: Integer;
    FUF: string;
    Ffone: string;
    Femail: string;
    FcPais: Integer;
    FxPais: string;
  public
    procedure Assign(Source: TEndereco);

    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: Integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: Integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property fone: string read Ffone write Ffone;
    property email: string read Femail write Femail;
    property cPais: Integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
  end;

  { TEmit }

  TEmit = class(TObject)
  private
    FCNPJ: string;
    FIE: string;
    FxNome: string;
    FxFant: string;
    FEnderEmit: TEndereco;
    FISUFEmit: string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TEmit);

    property CNPJ: string read FCNPJ write FCNPJ;
    property IE: string read FIE write FIE;
    property xNome: string read FxNome write FxNome;
    property xFant: string read FxFant write FxFant;
    property EnderEmit: TEndereco read FEnderEmit write FEnderEmit;
    property ISUFEmit: string read FISUFEmit write FISUFEmit;
  end;

 { TDest }

  TDest = class(TObject)
  private
    FxNome: string;
    FCNPJCPF: string;
    FidEstrangeiro: string;
    FindIEDest: TindIEDest;
    FIE: string;
    FIM: string;
    FcNIS: string;
    FNB: string;
    FxNomeAdicional: string;
    FEnderDest: TEndereco;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TDest);

    property xNome: string read FxNome write FxNome;
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property idEstrangeiro: string read FidEstrangeiro write FidEstrangeiro;
    property idOutros: string read FidEstrangeiro write FidEstrangeiro;
    property indIEDest: TindIEDest read FindIEDest write FindIEDest;
    property IE: string read FIE write FIE;
    property IM: string read FIM write FIM;
    property cNIS: string read FcNIS write FcNIS;
    property NB: string read FNB write FNB;
    property xNomeAdicional: string read FxNomeAdicional write FxNomeAdicional;
    property EnderDest: TEndereco read FEnderDest write FEnderDest;
  end;

  { TInstalacao }

  TInstalacao = class(TObject)
  private
    FidInstalacao: string;
    FidCodCliente: string;
    FtpInstalacao: TtpInstalacao;
    FnContrato: string;
    FtpClasse: TtpClasse;
    FxClasse: string;
    FlatGPS: string;
    FlongGPS: string;
    FcodRoteiroLeitura: string;
  public
    procedure Assign(Source: TInstalacao);

    property idInstalacao: string read FidInstalacao write FidInstalacao;
    property idCodCliente: string read FidCodCliente write FidCodCliente;
    property tpInstalacao: TtpInstalacao read FtpInstalacao write FtpInstalacao;
    property nContrato: string read FnContrato write FnContrato;
    property tpClasse: TtpClasse read FtpClasse write FtpClasse;
    property xClasse: string read FxClasse write FxClasse;
    property latGPS: string read FlatGPS write FlatGPS;
    property longGPS: string read FlongGPS write FlongGPS;
    property codRoteiroLeitura: string read FcodRoteiroLeitura write FcodRoteiroLeitura;
  end;

  { TgNF }

  TgNF = class(TObject)
  private
    FCNPJ: string;
    Fserie: string;
    FnNF: Integer;
    FCompetEmis: TDateTime;
    FCompetApur: TDateTime;
    Fhash115: string;
  public
    procedure Assign(Source: TgNF);

    property CNPJ: string read FCNPJ write FCNPJ;
    property serie: string read Fserie write Fserie;
    property nNF: Integer read FnNF write FnNF;
    property CompetEmis: TDateTime read FCompetEmis write FCompetEmis;
    property CompetApur: TDateTime read FCompetApur write FCompetApur;
    property hash115: string read Fhash115 write Fhash115;
  end;

  { TgSub }

  TgSub = class(TObject)
  private
    FchNFGas: string;
    FgNF: TgNF;
    FmotSub: TmotSub;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgSub);

    property chNFGas: string read FchNFGas write FchNFGas;
    property gNF: TgNF read FgNF write FgNF;
    property motSub: TmotSub read FmotSub write FmotSub;
  end;

  { TgVolContratCollectionItem }

  TgVolContratCollectionItem = class(TObject)
  private
    FnContrat: Integer;
    FtpVolContrat: TVolContrat;
    FqUnidContrat: Double;
  public
    procedure Assign(Source: TgVolContratCollectionItem);

    property nContrat: Integer read FnContrat write FnContrat;
    property tpVolContrat: TVolContrat read FtpVolContrat write FtpVolContrat;
    property qUnidContrat: Double read FqUnidContrat write FqUnidContrat;
  end;

  { TgVolContratCollection }

  TgVolContratCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgVolContratCollectionItem;
    procedure SetItem(Index: Integer; Value: TgVolContratCollectionItem);
  public
    function New: TgVolContratCollectionItem;
    property Items[Index: Integer]: TgVolContratCollectionItem read GetItem write SetItem; default;
  end;

  { TgMedCollectionItem }

  TgMedCollectionItem = class(TObject)
  private
    FnMed: Integer;
    FidEqp: string;
    FdMedAnt: TDateTime;
    FvMedAnt: Double;
    FdMedAtu: TDateTime;
    FvMedAtu: Double;
    FtpEqp: TtpEqp;
    FtpMedidor: TtpMedidor;
  public
    procedure Assign(Source: TgMedCollectionItem);

    property nMed: Integer read FnMed write FnMed;
    property idEqp: string read FidEqp write FidEqp;
    property dMedAnt: TDateTime read FdMedAnt write FdMedAnt;
    property vMedAnt: Double read FvMedAnt write FvMedAnt;
    property dMedAtu: TDateTime read FdMedAtu write FdMedAtu;
    property vMedAtu: Double read FvMedAtu write FvMedAtu;
    property tpEqp: TtpEqp read FtpEqp write FtpEqp;
    property tpMedidor: TtpMedidor read FtpMedidor write FtpMedidor;
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

  { TgTarifCollectionItem }

  TgTarifCollectionItem = class(TObject)
  private
    FdIniTarif: TDateTime;
    FdFimTarif: TDateTime;
    FnAto: string;
    FanoAto: Integer;
    FtpFaixaCons: TtpFaixaCons;
    FvTarifAplic: Double;
  public
    procedure Assign(Source: TgTarifCollectionItem);

    property dIniTarif: TDateTime read FdIniTarif write FdIniTarif;
    property dFimTarif: TDateTime read FdFimTarif write FdFimTarif;
    property nAto: string read FnAto write FnAto;
    property anoAto: Integer read FanoAto write FanoAto;
    property tpFaixaCons: TtpFaixaCons read FtpFaixaCons write FtpFaixaCons;
    property vTarifAplic: Double read FvTarifAplic write FvTarifAplic;
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
    FuMed: TuMed;
    FvMed: Double;
  public
    procedure Assign(Source: TgMedida);

    property uMed: TuMed read FuMed write FuMed;
    property vMed: Double read FvMed write FvMed;
  end;

  { TgMedicao }

  TgMedicao = class(TObject)
  private
    FnMed: Integer;
    FnContrat: Integer;
    FtpMotNaoLeitura: TtpMotNaoLeitura;
    FxMotNaoLeitura: string;
    FgMedida: TgMedida;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgMedicao);

    property nMed: Integer read FnMed write FnMed;
    property nContrat: Integer read FnContrat write FnContrat;
    property gMedida: TgMedida read FgMedida write FgMedida;
    property tpMotNaoLeitura: TtpMotNaoLeitura read FtpMotNaoLeitura write FtpMotNaoLeitura;
    property xMotNaoLeitura: string read FxMotNaoLeitura write FxMotNaoLeitura;
  end;

  { TProd }

  TProd = class(TObject)
  private
    FindOrigemQtd: TindOrigemQtd;
    FgMedicao: TgMedicao;
    FcProd: string;
    FxProd: string;
    FcClass: Integer;
    FCFOP: Integer;
    FuMed: TuMedItem;
    FqFaturada: Integer;
    FvItem: Double;
    FfatorPCS: Double;
    FfatorPTZ: Double;
    FfatorP: Double;
    FfatorT: Double;
    FvProd: Double;
    FindDevolucao: TIndicador;
    FgPagAntecipado: TgPagAntecipadoProd;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TProd);

    property indOrigemQtd: TindOrigemQtd read FindOrigemQtd write FindOrigemQtd;
    property gMedicao: TgMedicao read FgMedicao write FgMedicao;
    property cProd: string read FcProd write FcProd;
    property xProd: string read FxProd write FxProd;
    property cClass: Integer read FcClass write FcClass;
    property CFOP: Integer read FCFOP write FCFOP;
    property uMed: TuMedItem read FuMed write FuMed;
    property qFaturada: Integer read FqFaturada write FqFaturada;
    property vItem: Double read FvItem write FvItem;
    property fatorPCS: Double read FfatorPCS write FfatorPCS;
    property fatorPTZ: Double read FfatorPTZ write FfatorPTZ;
    property fatorP: Double read FfatorP write FfatorP;
    property fatorT: Double read FfatorT write FfatorT;
    property vProd: Double read FvProd write FvProd;
    property indDevolucao: TIndicador read FindDevolucao write FindDevolucao;
    property gPagAntecipado: TgPagAntecipadoProd read FgPagAntecipado write FgPagAntecipado;
  end;

  { TICMS }

  TICMS = class(TObject)
  private
    FCST: TCSTIcms;
    FvBC: Double;
    FpICMS: Double;
    FvICMS: Double;
    FpFCP: Double;
    FvFCP: Double;
    FvBCST: Double;
    FpICMSST: Double;
    FvICMSST: Double;
    FpFCPST: Double;
    FvFCPST: Double;
    FpRedBC: Double;
    FvICMSDeson: Double;
    FcBenef: string;
    FindSemCST: TIndicador;
    FvBCSTRET: Double;
    FpICMSSTRet: Double;
    FvICMSSubstituto: Double;
    FvICMSSTRET: Double;
    FvBCFCPSTRet: Double;
    FpFCPSTRet: Double;
    FvFCPSTRet: Double;
    FpICMSEfet: Double;
    FvICMSEfet: Double;
    FvBCEfet: Double;
    FpRedBCEfet: Double;
    FmodBC: TDeterminacaoBaseIcms;
    FmodBCST: TDeterminacaoBaseIcmsST;
    FmotDesICMS: TMotivoDesoneracaoICMS;
    FvBCFCP: Double;
    FpMVAST: Double;
    FpRedBCST: Double;
    FvBCFCPST: Double;
    FindDeduzDeson: TIndicadorEx;
  public
    procedure Assign(Source: TICMS);

    property CST: TCSTIcms      read FCST        write FCST default cst00;
    property vBC: Double        read FvBC        write FvBC;
    property pICMS: Double      read FpICMS      write FpICMS;
    property vICMS: Double      read FvICMS      write FvICMS;
    property vBCFCP: Double read FvBCFCP write FvBCFCP;
    property pFCP: Double       read FpFCP       write FpFCP;
    property vFCP: Double       read FvFCP       write FvFCP;
    property vBCST: Double      read FvBCST      write FvBCST;
    property pICMSST: Double    read FpICMSST    write FpICMSST;
    property vICMSST: Double    read FvICMSST    write FvICMSST;
    property pFCPST: Double     read FpFCPST     write FpFCPST;
    property vFCPST: Double     read FvFCPST     write FvFCPST;
    property pRedBC: Double     read FpRedBC     write FpRedBC;
    property vICMSDeson: Double read FvICMSDeson write FvICMSDeson;
    property cBenef: string     read FcBenef     write FcBenef;
    property indSemCST: TIndicador read FindSemCST write FindSemCST;
    property vBCSTRET: Double   read FvBCSTRET   write FvBCSTRET;
    property pICMSSTRet: Double read FpICMSSTRet write FpICMSSTRet;
    property vICMSSubstituto: Double read FvICMSSubstituto write FvICMSSubstituto;
    property vICMSSTRET: Double read FvICMSSTRET write FvICMSSTRET;
    property vBCFCPSTRet: Double read FvBCFCPSTRet write FvBCFCPSTRet;
    property pFCPSTRet: Double read FpFCPSTRet write FpFCPSTRet;
    property vFCPSTRet: Double read FvFCPSTRet write FvFCPSTRet;
    property pRedBCEfet: Double read FpRedBCEfet write FpRedBCEfet;
    property vBCEfet: Double read FvBCEfet write FvBCEfet;
    property pICMSEfet: Double read FpICMSEfet write FpICMSEfet;
    property vICMSEfet: Double read FvICMSEfet write FvICMSEfet;
    property modBC: TDeterminacaoBaseIcms read FmodBC write FmodBC default dbiMargemValorAgregado;
    property modBCST: TDeterminacaoBaseIcmsST read FmodBCST write FmodBCST default dbisPrecoTabelado;
    property motDesICMS: TMotivoDesoneracaoICMS read FmotDesICMS write FmotDesICMS;
    property pMVAST: Double read FpMVAST write FpMVAST;
    property pRedBCST: Double read FpRedBCST write FpRedBCST;
    property vBCFCPST: Double read FvBCFCPST write FvBCFCPST;
    property indDeduzDeson: TIndicadorEx read FindDeduzDeson write FindDeduzDeson default tieNenhum;
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

  { TTxReg }

  TTxReg = class(TObject)
  private
    FvBC: Double;
    FpTaxa: Double;
    FvTaxa: Double;
  public
    procedure Assign(Source: TTxReg);

    property vBC: Double read FvBC write FvBC;
    property pTaxa: Double read FpTaxa write FpTaxa;
    property vTaxa: Double read FvTaxa write FvTaxa;
  end;

  { TImposto }

  TImposto = class(TObject)
  private
    FOrig: TOrigemMercadoria;
    FICMS: TICMS;
    FIndSemCST: TIndicador;
    FPIS: TPIS;
    FCOFINS: TCOFINS;
    FretTrib: TretTrib;
    FTxReg: TTxReg;
    FIBSCBS: TIBSCBS;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TImposto);

    property Orig: TOrigemMercadoria read FOrig write FOrig;
    property ICMS: TICMS read FICMS write FICMS;
    property indSemCST: TIndicador read FIndSemCST write FIndSemCST;
    property PIS: TPIS               read FPIS        write FPIS;
    property COFINS: TCOFINS         read FCOFINS     write FCOFINS;
    property retTrib: TretTrib       read FretTrib    write FretTrib;
    property TxReg: TTxReg read FTxReg write FTxReg;
    // Reforma Tributaria
    property IBSCBS: TIBSCBS read FIBSCBS  write FIBSCBS;
  end;

  { TgProcCollectionItem }

  TgProcCollectionItem = class(TObject)
  private
    FtpProc: TtpProc;
    FnProcesso: string;
  public
    procedure Assign(Source: TgProcCollectionItem);

    property tpProc: TtpProc read FtpProc write FtpProc;
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

  { TgProcRef }

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

    property vItem: Double read FvItem write FvItem;
    property qFaturada: Double read FqFaturada write FqFaturada;
    property vProd: Double read FvProd write FvProd;
    property indDevolucao: TIndicador read FindDevolucao write FindDevolucao;
    property gProc: TgProcCollection read FgProc write SetgProc;
  end;

  { TgNormal }

  TgNormal = class(TObject)
  private
    FgTarif: TgTarifCollection;
    FProd: TProd;
    FImposto: TImposto;
    FgProcRef: TgProcRef;
    FinfAdProd: string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgNormal);

    property gTarif: TgTarifCollection read FgTarif write FgTarif;
    property Prod: TProd read FProd write FProd;
    property Imposto: TImposto read FImposto write FImposto;
    property gProcRef: TgProcRef read FgProcRef write FgProcRef;
    property infAdProd: string read FinfAdProd write FinfAdProd;
  end;

  { TgAgregadora }

  TgAgregadora = class(TObject)
  private
    FcClass: string;
    FvTotDFe: Double;
  public
    procedure Assign(Source: TgAgregadora);

    property cClass: string read FcClass write FcClass;
    property vTotDFe: Double read FvTotDFe write FvTotDFe;
  end;

  { TDetCollectionItem }

  TDetCollectionItem = class(TObject)
  private
    FnItem: Integer;
    FchNFGasAnt: string;
    FnItemAnt: Integer;
    FgNormal: TgNormal;
    FgAgregadora: TgAgregadora;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TDetCollectionItem);

    property nItem: Integer read FnItem write FnItem;
    property chNFGasAnt: string read FchNFGasAnt write FchNFGasAnt;
    property nItemAnt: Integer read FnItemAnt write FnItemAnt;
    property gNormal: TgNormal read FgNormal write FgNormal;
    property gAgregadora: TgAgregadora read FgAgregadora write FgAgregadora;
  end;

  { TDetCollection }

  TDetCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TDetCollectionItem;
    procedure SetItem(Index: Integer; Value: TDetCollectionItem);
  public
    function Add: TDetCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use New'{$EndIf};
    function New: TDetCollectionItem;

    property Items[Index: Integer]: TDetCollectionItem read GetItem write SetItem; default;
  end;

  { TTotal }

  TTotal = class(TObject)
  private
    FvProd: Double;
    FvBC: Double;
    FvICMS: Double;
    FvICMSDeson: Double;
    FvFCP: Double;
    FvBCST: Double;
    FvST: Double;
    FvFCPST: Double;
    FvCOFINS: Double;
    FvPIS: Double;
    FvNF: Double;
    FvRetCSLL: Double;
    FvRetPIS: Double;
    FvRetCOFINS: Double;
    FvIRRF: Double;
    FIBSCBSTot: TIBSCBSTot;
    FvTotDFe: Double;
    FvTxReg: Double;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TTotal);

    property vProd: Double       read FvProd       write FvProd;
    property vBC: Double         read FvBC         write FvBC;
    property vICMS: Double       read FvICMS       write FvICMS;
    property vICMSDeson: Double  read FvICMSDeson  write FvICMSDeson;
    property vFCP: Double        read FvFCP        write FvFCP;
    property vBCST: Double       read FvBCST       write FvBCST;
    property vST: Double         read FvST         write FvST;
    property vFCPST: Double      read FvFCPST      write FvFCPST;
    property vCOFINS: Double     read FvCOFINS     write FvCOFINS;
    property vPIS: Double        read FvPIS        write FvPIS;
    property vNF: Double         read FvNF         write FvNF;
    property vRetPIS: Double     read FvRetPIS     write FvRetPIS;
    property vRetCOFINS: Double  read FvRetCOFINS  write FvRetCOFINS;
    property vRetCSLL: Double    read FvRetCSLL    write FvRetCSLL;
    property vIRRF: Double       read FvIRRF       write FvIRRF;
    property vTxReg: Double      read FvTxReg      write FvTxReg;
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
    FcodBarras: string;
    FcodDebAuto: string;
    FcodBanco: string;
    FcodAgencia: string;
    FenderCorresp: TEndereco;
    FgPIX: TgPIX;
    FdApresFat: TDateTime;
    FdProxLeitura: TDateTime;
    FnFat: string;
    FinfAdFat: string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgFat);

    property CompetFat: TDateTime read FCompetFat write FCompetFat;
    property dVencFat: TDateTime read FdVencFat write FdVencFat;
    property codBarras: string read FcodBarras write FcodBarras;
    property codDebAuto: string read FcodDebAuto write FcodDebAuto;
    property codBanco: string read FcodBanco write FcodBanco;
    property codAgencia: string read FcodAgencia write FcodAgencia;
    property enderCorresp: TEndereco read FenderCorresp write FenderCorresp;
    property gPIX: TgPIX read FgPIX write FgPIX;
    property dApresFat: TDateTime read FdApresFat write FdApresFat;
    property dProxLeitura: TDateTime read FdProxLeitura write FdProxLeitura;
    property nFat: string read FnFat write FnFat;
    property infAdFat: string read FinfAdFat write FinfAdFat;
  end;

  { TgConsCollectionItem }

  TgConsCollectionItem = class(TObject)
  private
    FCompetFat: TDateTime;
    FuMed: TuMed;
    FqtdDias: Integer;
    FmedDiaria: Double;
    Fconsumo: Double;
    FvFat: Double;
  public
    procedure Assign(Source: TgConsCollectionItem);

    property CompetFat: TDateTime read FCompetFat write FCompetFat;
    property uMed: TuMed read FuMed write FuMed;
    property qtdDias: Integer read FqtdDias write FqtdDias;
    property medDiaria: Double read FmedDiaria write FmedDiaria;
    property consumo: Double read Fconsumo write Fconsumo;
    property vFat: Double read FvFat write FvFat;
  end;

  { TgConsCollection }

  TgConsCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgConsCollectionItem;
    procedure SetItem(Index: Integer; Value: TgConsCollectionItem);
  public
    function Add: TgConsCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TgConsCollectionItem;
    property Items[Index: Integer]: TgConsCollectionItem read GetItem write SetItem; default;
  end;

  { TgHistConsCollectionItem }

   TgHistConsCollectionItem = class(TObject)
  private
    FxHistorico: string;
    FmedMensal: Double;
    FgCons: TgConsCollection;

    procedure SetgCons(const Value: TgConsCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgHistConsCollectionItem);

    property xHistorico: string read FxHistorico write FxHistorico;
    property medMensal: Double read FmedMensal write FmedMensal;
    property gCons: TgConsCollection read FgCons write SetgCons;
  end;

  { TgHistConsCollection }

  TgHistConsCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgHistConsCollectionItem;
    procedure SetItem(Index: Integer; Value: TgHistConsCollectionItem);
  public
    function Add: TgHistConsCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TgHistConsCollectionItem;
    property Items[Index: Integer]: TgHistConsCollectionItem read GetItem write SetItem; default;
  end;

  { TgAgencia }

 TgAgencia = class(TObject)
  private
    FnomeAgenciaAtend: string;
    FenderAgenciaAtend: string;
    FsitioAgenciaAtend: string;
    FinfAdReg: string;
    FgHistCons: TgHistConsCollection;

    procedure SetgHistCons(const Value: TgHistConsCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TgAgencia);

    property nomeAgenciaAtend: string read FnomeAgenciaAtend write FnomeAgenciaAtend;
    property enderAgenciaAtend: string read FenderAgenciaAtend write FenderAgenciaAtend;
    property sitioAgenciaAtend: string read FsitioAgenciaAtend write FsitioAgenciaAtend;
    property infAdReg: string read FinfAdReg write FinfAdReg;
    property gHistCons: TgHistConsCollection read FgHistCons write SetgHistCons;
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

  { TinfNFGasSupl }

  TinfNFGasSupl = class(TObject)
  private
    FqrCodNFGas: string;
  public
    procedure Assign(Source: TinfNFGasSupl);

    property qrCodNFGas: string read FqrCodNFGas write FqrCodNFgas;
  end;
  { TNFGas }

  TNFGas = class(TObject)
  private
    FinfNFGas: TinfNFGas;
    FIde: TIde;
    FEmit: TEmit;
    FDest: TDest;
    FInstalacao: TInstalacao;
    FgSub: TgSub;
    FgVolContrat: TgVolContratCollection;
    FgMed: TgMedCollection;
    FDet: TDetCollection;
    FTotal: TTotal;
    FpgtoVinc: TpgtoVinc;
    FgFat: TgFat;
    FgAgencia: TgAgencia;
    FautXML: TautXMLCollection;
    FinfAdic: TInfAdic;
    FinfRespTec: TinfRespTec;
    FinfNFGasSupl: TinfNFGasSupl;
    FprocNFGas: TProcDFe;
    FSignature: TSignature;

    procedure SetDet(const Value: TDetCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TNFGas);

    property infNFGas: TinfNFGas read FinfNFGas write FinfNFGas;
    property Ide: TIde read FIde write FIde;
    property Emit: TEmit read FEmit write FEmit;
    property Dest: TDest read FDest write FDest;
    property Instalacao: TInstalacao read FInstalacao write FInstalacao;
    property gSub: TgSub read FgSub write FgSub;
    property gVolContrat: TgVolContratCollection read FgVolContrat write FgVolContrat;
    property gMed: TgMedCollection read FgMed write FgMed;
    property Det: TDetCollection read FDet write SetDet;
    property Total: TTotal read FTotal write FTotal;
    property pgtoVinc: TpgtoVinc read FpgtoVinc write FpgtoVinc;
    property gFat: TgFat read FgFat write FgFat;
    property gAgencia: TgAgencia read FgAgencia write FgAgencia;
    property autXML: TautXMLCollection read FautXML write FautXML;
    property infAdic: TInfAdic read FinfAdic write FinfAdic;
    property infRespTec: TinfRespTec read FinfRespTec write FinfRespTec;
    property infNFGasSupl: TinfNFGasSupl   read FinfNFGasSupl  write FinfNFGasSupl;
    property procNFGas: TProcDFe read FprocNFGas write FprocNFGas;
    property Signature: TSignature read FSignature write FSignature;
  end;

implementation

{ TNFGas }

procedure TNFGas.Assign(Source: TNFGas);
begin
  infNFGas.Assign(Source.infNFGas);
  Ide.Assign(Source.Ide);
  Emit.Assign(Source.Emit);
  Dest.Assign(Source.Dest);
  Instalacao.Assign(Source.Instalacao);
  gSub.Assign(Source.gSub);
  gVolContrat.Assign(Source.gVolContrat);
  gMed.Assign(Source.gMed);
  Det.Assign(Source.Det);
  Total.Assign(Source.Total);
  pgtoVinc.Assign(Source.pgtoVinc);
  gFat.Assign(Source.gFat);
  gAgencia.Assign(Source.gAgencia);
  autXML.Assign(Source.autXML);
  infAdic.Assign(Source.infAdic);
  infRespTec.Assign(Source.infRespTec);
  infNFGasSupl.Assign(Source.infNFGasSupl);
  procNFGas.Assign(Source.procNFGas);
  Signature.Assign(Source.Signature);
end;

constructor TNFGas.Create;
begin
  inherited Create;

  FinfNFGas := TinfNFGas.Create;
  FIde := TIde.Create;
  FEmit := TEmit.Create;
  FDest := TDest.Create;
  FInstalacao := TInstalacao.Create;
  FgSub := TgSub.Create;
  FgVolContrat := TgVolContratCollection.Create;
  FgMed := TgMedCollection.Create;
  FDet := TDetCollection.Create;
  FTotal := TTotal.Create;
  FpgtoVinc := TpgtoVinc.Create;
  FgFat := TgFat.Create;
  FgAgencia := TgAgencia.Create;
  FautXML := TautXMLCollection.Create;
  FinfAdic := TInfAdic.Create;
  FinfRespTec := TinfRespTec.Create;
  FinfNFGasSupl := TinfNFGasSupl.Create;
  FprocNFGas := TProcDFe.Create('', '', '', '');
  FSignature := TSignature.Create;
end;

destructor TNFGas.Destroy;
begin
  FinfNFGas.Free;
  FIde.Free;
  FEmit.Free;
  FDest.Free;
  FInstalacao.Free;
  FgSub.Free;
  FgVolContrat.Free;
  FgMed.Free;
  FDet.Free;
  FTotal.Free;
  FpgtoVinc.Free;
  FgFat.Free;
  FgAgencia.Free;
  FautXML.Free;
  FinfAdic.Free;
  FinfRespTec.Free;
  FinfNFGasSupl.Free;
  FprocNFGas.Free;
  FSignature.Free;

  inherited Destroy;
end;

procedure TNFGas.SetDet(const Value: TDetCollection);
begin
  FDet := Value;
end;

{ TinfNFGas }

procedure TinfNFGas.Assign(Source: TinfNFGas);
begin
  ID := Source.ID;
  Versao := Source.Versao;
end;

{ TIde }

procedure TIde.Assign(Source: TIde);
begin
  cUF := Source.cUF;
  tpAmb := Source.tpAmb;
  modelo := Source.modelo;
  serie := Source.serie;
  nNF := Source.nNF;
  cNF := Source.cNF;
  cDV := Source.cDV;
  dhEmi := Source.dhEmi;
  tpEmis := Source.tpEmis;
  nSiteAutoriz := Source.nSiteAutoriz;
  cMunFG := Source.cMunFG;
  verProc := Source.verProc;
  finNFGas := Source.finNFGas;
  tpFat := Source.tpFat;
  dhCont := Source.dhCont;
  xJust := Source.xJust;
  gCompraGov.Assign(Source.gCompraGov);
  tpPagAnt := Source.tpPagAnt;
end;

constructor TIde.Create;
begin
  inherited Create;

  FgCompraGov := TgCompraGovReduzido.Create;
  FtpPagAnt:= tpaNenhum;
end;

destructor TIde.Destroy;
begin
  FgCompraGov.Free;

  inherited Destroy;
end;

{ TEmit }

procedure TEmit.Assign(Source: TEmit);
begin
  CNPJ := Source.CNPJ;
  IE := Source.IE;
  xNome := Source.xNome;
  xFant := Source.xFant;
  ISUFEmit := Source.ISUFEmit;
  EnderEmit.Assign(Source.EnderEmit);
end;

constructor TEmit.Create;
begin
  inherited Create;

  FEnderEmit := TEndereco.Create;
end;

destructor TEmit.Destroy;
begin
  FEnderEmit.Free;

  inherited Destroy;
end;

{ TEndereco }

procedure TEndereco.Assign(Source: TEndereco);
begin
  xLgr := Source.xLgr;
  nro := Source.nro;
  xCpl := Source.xCpl;
  xBairro := Source.xBairro;
  cMun := Source.cMun;
  xMun := Source.xMun;
  CEP := Source.CEP;
  UF := Source.UF;
  fone := Source.fone;
  email := Source.email;
  cPais := Source.cPais;
  xPais := Source.xPais;
end;

{ TDest }

procedure TDest.Assign(Source: TDest);
begin
  xNome := Source.xNome;
  CNPJCPF := Source.CNPJCPF;
  idEstrangeiro := Source.idEstrangeiro;
  indIEDest := Source.indIEDest;
  IE := Source.IE;
  IM := Source.IM;
  cNIS := Source.cNIS;
  NB := Source.NB;
  xNomeAdicional := Source.xNomeAdicional;
  EnderDest.Assign(Source.EnderDest);
end;

constructor TDest.Create;
begin
  inherited Create;

  FEnderDest := TEndereco.Create;
end;

destructor TDest.Destroy;
begin
  FEnderDest.Free;

  inherited Destroy;
end;

{ TInstalacao }

procedure TInstalacao.Assign(Source: TInstalacao);
begin
  idInstalacao := Source.idInstalacao;
  idCodCliente := Source.idCodCliente;
  tpInstalacao := Source.tpInstalacao;
  nContrato := Source.nContrato;
  tpClasse := Source.tpClasse;
  xClasse := Source.xClasse;
  latGPS := Source.latGPS;
  longGPS := Source.longGPS;
  codRoteiroLeitura := Source.codRoteiroLeitura;
end;

{ TgSub }

procedure TgSub.Assign(Source: TgSub);
begin
  chNFGas := Source.chNFGas;
  gNF.Assign(Source.gNF);
  motSub := Source.motSub;
end;

constructor TgSub.Create;
begin
  inherited Create;

  FgNF := TgNF.Create;
end;

destructor TgSub.Destroy;
begin
  FgNF.Free;

  inherited Destroy;
end;

{ TgNF }

procedure TgNF.Assign(Source: TgNF);
begin
  CNPJ := Source.CNPJ;
  serie := Source.serie;
  nNF := Source.nNF;
  CompetEmis := Source.CompetEmis;
  CompetApur := Source.CompetApur;
  hash115 := Source.hash115;
end;

{ TgVolContratCollection }

function TgVolContratCollection.GetItem(
  Index: Integer): TgVolContratCollectionItem;
begin
  Result := TgVolContratCollectionItem(inherited Items[Index]);
end;

function TgVolContratCollection.New: TgVolContratCollectionItem;
begin
  Result := TgVolContratCollectionItem.Create;
  inherited Add(Result);
end;

procedure TgVolContratCollection.SetItem(Index: Integer;
  Value: TgVolContratCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgVolContratCollectionItem }

procedure TgVolContratCollectionItem.Assign(Source: TgVolContratCollectionItem);
begin
  nContrat := Source.nContrat;
  tpVolContrat := Source.tpVolContrat;
  qUnidContrat := Source.qUnidContrat;
end;

{ TgMedCollection }

function TgMedCollection.GetItem(Index: Integer): TgMedCollectionItem;
begin
  Result := TgMedCollectionItem(inherited Items[Index]);
end;

function TgMedCollection.New: TgMedCollectionItem;
begin
  Result := TgMedCollectionItem.Create;
  inherited Add(Result);
end;

procedure TgMedCollection.SetItem(Index: Integer; Value: TgMedCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgMedCollectionItem }

procedure TgMedCollectionItem.Assign(Source: TgMedCollectionItem);
begin
  nMed := Source.nMed;
  idEqp := Source.idEqp;
  dMedAnt := Source.dMedAnt;
  vMedAnt := Source.vMedAnt;
  dMedAtu := Source.dMedAtu;
  vMedAtu := Source.vMedAtu;
  tpEqp := Source.tpEqp;
  tpMedidor := Source.tpMedidor;
end;

{ TDetCollection }

function TDetCollection.Add: TDetCollectionItem;
begin
  Result := New;
end;

function TDetCollection.GetItem(Index: Integer): TDetCollectionItem;
begin
  Result := TDetCollectionItem(inherited Items[Index]);
end;

function TDetCollection.New: TDetCollectionItem;
begin
  Result := TDetCollectionItem.Create;
  inherited Add(Result);
end;

procedure TDetCollection.SetItem(Index: Integer; Value: TDetCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TDetCollectionItem }

procedure TDetCollectionItem.Assign(Source: TDetCollectionItem);
begin
  nItem := Source.nItem;
  chNFGasAnt := Source.chNFGasAnt;
  nItemAnt := Source.nItemAnt;
  gNormal.Assign(Source.gNormal);
  gAgregadora.Assign(Source.gAgregadora);
end;

constructor TDetCollectionItem.Create;
begin
  inherited Create;

  FgNormal := TgNormal.Create;
  FgAgregadora := TgAgregadora.Create;
end;

destructor TDetCollectionItem.Destroy;
begin
  FgNormal.Free;
  FgAgregadora.Free;

  inherited Destroy;
end;

{ TgNormal }

procedure TgNormal.Assign(Source: TgNormal);
begin

  gTarif.Assign(Source.gTarif);
  Prod.Assign(Source.Prod);
  Imposto.Assign(Source.Imposto);
  gProcRef.Assign(Source.gProcRef);
  infAdProd := Source.infAdProd;
end;

constructor TgNormal.Create;
begin
  inherited Create;

  FgTarif := TgTarifCollection.Create;
  FProd := TProd.Create;
  FImposto := TImposto.Create;
  FgProcRef := TgProcRef.Create;
end;

destructor TgNormal.Destroy;
begin
  FgTarif.Free;
  FProd.Free;
  FImposto.Free;
  FgProcRef.Free;

  inherited Destroy;
end;

{ TgTarifCollection }

function TgTarifCollection.GetItem(Index: Integer): TgTarifCollectionItem;
begin
  Result := TgTarifCollectionItem(inherited Items[Index]);
end;

function TgTarifCollection.New: TgTarifCollectionItem;
begin
  Result := TgTarifCollectionItem.Create;
  inherited Add(Result);
end;

procedure TgTarifCollection.SetItem(Index: Integer;
  Value: TgTarifCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TgTarifCollectionItem }

procedure TgTarifCollectionItem.Assign(Source: TgTarifCollectionItem);
begin
  dIniTarif := Source.dIniTarif;
  dFimTarif := Source.dFimTarif;
  nAto := Source.nAto;
  anoAto := Source.anoAto;
  tpFaixaCons := Source.tpFaixaCons;
  vTarifAplic := Source.vTarifAplic;
end;

{ TgAgregadora }

procedure TgAgregadora.Assign(Source: TgAgregadora);
begin
  cClass := Source.cClass;
  vTotDFe := Source.vTotDFe;
end;

{ TProd }

procedure TProd.Assign(Source: TProd);
begin
  indOrigemQtd := Source.indOrigemQtd;
  cProd := Source.cProd;
  xProd := Source.xProd;
  cClass := Source.cClass;
  CFOP := Source.CFOP;
  uMed := Source.uMed;
  qFaturada := Source.qFaturada;
  vItem := Source.vItem;
  fatorPCS := Source.fatorPCS;
  fatorPTZ := Source.fatorPTZ;
  fatorP := Source.fatorP;
  fatorT := Source.fatorT;
  vProd := Source.vProd;
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

{ TgMedicao }

procedure TgMedicao.Assign(Source: TgMedicao);
begin
  nMed := Source.nMed;
  nContrat := Source.nContrat;
  tpMotNaoLeitura := Source.tpMotNaoLeitura;
  xMotNaoLeitura := Source.xMotNaoLeitura;
  gMedida.Assign(Source.gMedida);
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

{ TImposto }

procedure TImposto.Assign(Source: TImposto);
begin
  inherited Create;

  Orig := Source.Orig;
  indSemCST := Source.indSemCST;

  ICMS.Assign(Source.ICMS);
  PIS.Assign(Source.PIS);
  COFINS.Assign(Source.COFINS);
  retTrib.Assign(Source.retTrib);
  TxReg.Assign(Source.TxReg);
  IBSCBS := Source.IBSCBS;
end;

constructor TImposto.Create;
begin
  inherited Create;

  FICMS := TICMS.Create;
  FPIS := TPIS.Create;
  FCOFINS := TCOFINS.Create;
  FretTrib := TretTrib.Create;
  FTxReg := TTxReg.Create;
  FIBSCBS := TIBSCBS.Create;
end;

destructor TImposto.Destroy;
begin
  FICMS.Free;
  FPIS.Free;
  FCOFINS.Free;
  FretTrib.Free;
  FTxReg.Free;
  FIBSCBS.Free;

  inherited Destroy;
end;

{ TICMS }

procedure TICMS.Assign(Source: TICMS);
begin
  CST := Source.CST;
  vBC := Source.vBC;
  pICMS := Source.pICMS;
  vICMS := Source.vICMS;
  vBCFCP := Source.vBCFCP;
  pFCP := Source.pFCP;
  vFCP := Source.vFCP;
  vBCST := Source.vBCST;
  pICMSST := Source.pICMSST;
  vICMSST := Source.vICMSST;
  pFCPST := Source.pFCPST;
  vFCPST := Source.vFCPST;
  pRedBC := Source.pRedBC;
  vICMSDeson := Source.vICMSDeson;
  cBenef := Source.cBenef;
  vBCSTRET := Source.vBCSTRET;
  vICMSSTRET := Source.vICMSSTRET;
  vBCFCPSTRet := Source.vBCFCPSTRet;
  pFCPSTRet := Source.pFCPSTRet;
  vFCPSTRet := Source.vFCPSTRet;
  pRedBCEfet := Source.pRedBCEfet;
  vBCEfet := Source.vBCEfet;
  pICMSEfet := Source.pICMSEfet;
  vICMSEfet := Source.vICMSEfet;
  pICMSSTRet := Source.pICMSSTRet;
  vICMSSubstituto := Source.vICMSSubstituto;
  modBC := Source.modBC;
  modBCST := Source.modBCST;
  motDesICMS := Source.motDesICMS;
  pMVAST := Source.pMVAST;
  pRedBCST := Source.pRedBCST;
  vBCFCPST := Source.vBCFCPST;
  indDeduzDeson := Source.indDeduzDeson;


end;

{ TPIS }

procedure TPIS.Assign(Source: TPIS);
begin
  CST := Source.CST;
  vBC := Source.vBC;
  pPIS := Source.pPIS;
  vPIS := Source.vPIS;
end;

{ TCOFINS }

procedure TCOFINS.Assign(Source: TCOFINS);
begin
  CST := Source.CST;
  vBC := Source.vBC;
  pCOFINS := Source.pCOFINS;
  vCOFINS := Source.vCOFINS;
end;

{ TretTrib }

procedure TretTrib.Assign(Source: TretTrib);
begin
  vRetPIS := Source.vRetPIS;
  vRetCOFINS := Source.vRetCOFINS;
  vRetCSLL := Source.vRetCSLL;
  vBCIRRF := Source.vBCIRRF;
  vIRRF := Source.vIRRF;
end;

{ TTxReg }

procedure TTxReg.Assign(Source: TTxReg);
begin
  vBC := Source.vBC;
  pTaxa := Source.pTaxa;
  vTaxa := Source.vTaxa;
end;

{ TgProcRef }

procedure TgProcRef.Assign(Source: TgProcRef);
begin
  vItem := Source.vItem;
  qFaturada := Source.qFaturada;
  vProd := Source.vProd;
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
  FreeAndNil(FgProc);

  inherited Destroy;
end;

procedure TgProcRef.SetgProc(const Value: TgProcCollection);
begin
  FgProc := Value;
end;

{ TgProcCollection }

function TgProcCollection.GetItem(Index: Integer): TgProcCollectionItem;
begin
  Result := TgProcCollectionItem(inherited Items[Index]);
end;

function TgProcCollection.New: TgProcCollectionItem;
begin
  Result := TgProcCollectionItem.Create;
  inherited Add(Result);
end;

procedure TgProcCollection.SetItem(Index: Integer; Value: TgProcCollectionItem);
begin
  Items[Index].Assign(Value);
end;

{ TgProcCollectionItem }

procedure TgProcCollectionItem.Assign(Source: TgProcCollectionItem);
begin
  tpProc := Source.tpProc;
  nProcesso := Source.nProcesso;
end;

{ TTotal }

procedure TTotal.Assign(Source: TTotal);
begin
  vProd := Source.vProd;
  vBC := Source.vBC;
  vICMS := Source.vICMS;
  vICMSDeson := Source.vICMSDeson;
  vFCP := Source.vFCP;
  vBCST := Source.vBCST;
  vST := Source.vST;
  vFCPST := Source.vFCPST;
  vCOFINS := Source.vCOFINS;
  vPIS := Source.vPIS;
  vNF := Source.vNF;
  vRetCSLL := Source.vRetCSLL;
  vRetPIS := Source.vRetPIS;
  vRetCOFINS := Source.vRetCOFINS;
  vTxReg := Source.vTxReg;
  vIRRF := Source.vIRRF;
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

{ TgFat }

procedure TgFat.Assign(Source: TgFat);
begin
  CompetFat := Source.CompetFat;
  dVencFat := Source.dVencFat;
  dApresFat := Source.dApresFat;
  dProxLeitura := Source.dProxLeitura;
  nFat := Source.nFat;
  codBarras := Source.codBarras;
  codDebAuto := Source.codDebAuto;
  codBanco := Source.codBanco;
  codAgencia := Source.codAgencia;
  enderCorresp.Assign(Source.enderCorresp);
  gPIX.Assign(Source.gPIX);
  infAdFat := Source.infAdFat;
end;

constructor TgFat.Create;
begin
  inherited Create;

  FenderCorresp := TEndereco.Create;
  FgPIX := TgPIX.Create;
end;

destructor TgFat.Destroy;
begin
  FenderCorresp.Free;
  FgPIX.Free;

  inherited;
end;

{ TgPIX }

procedure TgPIX.Assign(Source: TgPIX);
begin
  urlQRCodePIX := Source.urlQRCodePIX;
end;

{ TgAgencia }

procedure TgAgencia.Assign(Source: TgAgencia);
begin
  nomeAgenciaAtend := Source.nomeAgenciaAtend;
  enderAgenciaAtend := Source.enderAgenciaAtend;
  sitioAgenciaAtend := Source.sitioAgenciaAtend;
  infAdReg := Source.infAdReg;
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

{ TgHistConsCollection }

function TgHistConsCollection.Add: TgHistConsCollectionItem;
begin
  Result := Self.New;
end;

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

{ TgConsCollection }

function TgConsCollection.Add: TgConsCollectionItem;
begin
  Result := Self.New;
end;

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

{ TgConsCollectionItem }

procedure TgConsCollectionItem.Assign(Source: TgConsCollectionItem);
begin
  CompetFat := Source.CompetFat;
  uMed := Source.uMed;
  qtdDias := Source.qtdDias;
  medDiaria := Source.medDiaria;
  consumo := Source.consumo;
  vFat := Source.vFat;
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

{ TautXMLCollectionItem }

procedure TautXMLCollectionItem.Assign(Source: TautXMLCollectionItem);
begin
  CNPJCPF := Source.CNPJCPF;
end;

{ TInfAdic }

procedure TInfAdic.Assign(Source: TInfAdic);
begin
  infAdFisco := Source.infAdFisco;
  infCpl := Source.infCpl;
end;

{ TinfRespTec }

procedure TinfRespTec.Assign(Source: TinfRespTec);
begin
  CNPJ := Source.CNPJ;
  xContato := Source.xContato;
  email := Source.email;
  fone := Source.fone;
  idCSRT := Source.idCSRT;
  hashCSRT := Source.hashCSRT;
end;

{ TinfNFGasSupl }

procedure TinfNFGasSupl.Assign(Source: TinfNFGasSupl);
begin
  qrCodNFGas := Source.qrCodNFgas;
end;

{ TgMedida }

procedure TgMedida.Assign(Source: TgMedida);
begin
  uMed := Source.uMed;
  vMed := Source.vMed;
end;

end.
