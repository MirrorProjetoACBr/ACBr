inherited frlXDANFSeRLPadraoNacional: TfrlXDANFSeRLPadraoNacional
  Left = 273
  Top = 132
  Caption = 'frlXDANFSeRLPadraoNacional'
  ClientHeight = 815
  TextHeight = 13
  inherited RLNFSe: TRLReport
    Top = 0
    Margins.LeftMargin = 6.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.099999999999999000
    Margins.BottomMargin = 5.000000000000000000
    BeforePrint = RLNFSeBeforePrint
    object rlbBanda02_Ide_NFSe: TRLBand
      Left = 28
      Top = 93
      Width = 940
      Height = 120
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda02_Ide_NFSeBeforePrint
      object rllNumNF0: TRLLabel
        Left = 4
        Top = 45
        Width = 140
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 4
        Top = 35
        Width = 89
        Height = 11
        Caption = 'N'#218'MERO DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 328
        Top = 35
        Width = 168
        Height = 11
        Caption = 'DATA E HORA DA EMISS'#195'O DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmissaoNFSe: TRLLabel
        Left = 328
        Top = 45
        Width = 140
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 195
        Top = 35
        Width = 115
        Height = 11
        Caption = 'COMPET'#202'NCIA DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCompetencia: TRLLabel
        Left = 195
        Top = 45
        Width = 72
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel18: TRLLabel
        Left = 4
        Top = 62
        Width = 80
        Height = 11
        Caption = 'N'#218'MERO DA DPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllNumeroDPS: TRLLabel
        Left = 5
        Top = 74
        Width = 118
        Height = 15
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllCodigoChave: TRLLabel
        Left = 4
        Top = 4
        Width = 136
        Height = 11
        Caption = 'CHAVE DE ACESSO DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllChaveAcesso: TRLLabel
        Left = 4
        Top = 17
        Width = 506
        Height = 17
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 195
        Top = 62
        Width = 68
        Height = 11
        Caption = 'S'#201'RIE DA DPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllSerieDPS: TRLLabel
        Left = 196
        Top = 74
        Width = 118
        Height = 15
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel22: TRLLabel
        Left = 328
        Top = 62
        Width = 159
        Height = 11
        Caption = 'DATA E HORA DA EMISS'#195'O DA DPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmissaoDPS: TRLLabel
        Left = 329
        Top = 74
        Width = 140
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLMemo1: TRLMemo
        Left = 540
        Top = 88
        Width = 209
        Height = 28
        Alignment = taCenter
        AutoSize = False
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'A autenticidade desta NFS-e pode ser verificada'
          'pela leitura deste c'#243'digo QR ou pela consulta da'
          'chave de acesso no portal nacional da NFS-e')
        ParentFont = False
      end
      object RLLabel23: TRLLabel
        Left = 4
        Top = 92
        Width = 94
        Height = 11
        Caption = 'EMITENTE DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitente: TRLLabel
        Left = 5
        Top = 104
        Width = 51
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel15: TRLLabel
        Left = 195
        Top = 92
        Width = 94
        Height = 11
        Caption = 'SITUA'#199#195'O DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel19: TRLLabel
        Left = 329
        Top = 92
        Width = 58
        Height = 11
        Caption = 'FINALIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllSituacao: TRLLabel
        Left = 196
        Top = 104
        Width = 52
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllFinalidade: TRLLabel
        Left = 329
        Top = 104
        Width = 58
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object imgQRCode: TRLImage
        Left = 607
        Top = 5
        Width = 80
        Height = 80
        Center = True
        Scaled = True
      end
    end
    object rlbBanda03_Emitente: TRLBand
      Left = 28
      Top = 213
      Width = 940
      Height = 110
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda03_EmitenteBeforePrint
      object RLLabel30: TRLLabel
        Left = 408
        Top = 0
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel32: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteInscMunicipal: TRLLabel
        Left = 408
        Top = 15
        Width = 104
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteCNPJ: TRLLabel
        Left = 264
        Top = 15
        Width = 127
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel1: TRLLabel
        Left = 4
        Top = 31
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteNome: TRLLabel
        Left = 4
        Top = 43
        Width = 71
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 607
        Top = 2
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteTelefone: TRLLabel
        Left = 607
        Top = 15
        Width = 81
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel24: TRLLabel
        Left = 4
        Top = 58
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteEndereco: TRLLabel
        Left = 4
        Top = 70
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel29: TRLLabel
        Left = 408
        Top = 58
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteEmail: TRLLabel
        Left = 408
        Top = 70
        Width = 69
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel31: TRLLabel
        Left = 408
        Top = 31
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteMunicipio: TRLLabel
        Left = 408
        Top = 43
        Width = 86
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel55: TRLLabel
        Left = 607
        Top = 31
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteCEP: TRLLabel
        Left = 607
        Top = 43
        Width = 65
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel60: TRLLabel
        Left = 4
        Top = 83
        Width = 195
        Height = 11
        Caption = 'Simples Nacional na Data de Compet'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteSimplesNacional: TRLLabel
        Left = 3
        Top = 95
        Width = 115
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel69: TRLLabel
        Left = 408
        Top = 83
        Width = 182
        Height = 11
        Caption = 'Regime de Apura'#231#227'o Tribut'#225'ria pelo SN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteRegimeApuracao: TRLLabel
        Left = 408
        Top = 95
        Width = 118
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel21: TRLLabel
        Left = 4
        Top = 2
        Width = 146
        Height = 14
        Caption = 'PRESTADOR / FORNECEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda04_Tomador: TRLBand
      Left = 28
      Top = 323
      Width = 940
      Height = 84
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda04_TomadorBeforePrint
      object rllTomaCNPJ: TRLLabel
        Left = 264
        Top = 16
        Width = 57
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaInscMunicipal: TRLLabel
        Left = 408
        Top = 16
        Width = 90
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaNome: TRLLabel
        Left = 4
        Top = 42
        Width = 57
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaEndereco: TRLLabel
        Left = 5
        Top = 68
        Width = 71
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaMunicipio: TRLLabel
        Left = 408
        Top = 42
        Width = 72
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllTomaEmail: TRLLabel
        Left = 408
        Top = 68
        Width = 55
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaTelefone: TRLLabel
        Left = 607
        Top = 16
        Width = 67
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 4
        Top = 2
        Width = 133
        Height = 14
        Caption = 'TOMADOR / ADQUIRENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel70: TRLLabel
        Left = 4
        Top = 30
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel71: TRLLabel
        Left = 4
        Top = 56
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel72: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel73: TRLLabel
        Left = 408
        Top = 2
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel75: TRLLabel
        Left = 408
        Top = 56
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel76: TRLLabel
        Left = 408
        Top = 30
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel77: TRLLabel
        Left = 607
        Top = 2
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel78: TRLLabel
        Left = 607
        Top = 30
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllTomaCEP: TRLLabel
        Left = 608
        Top = 42
        Width = 51
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbBanda07_ServicoPrestado: TRLBand
      Left = 28
      Top = 577
      Width = 940
      Height = 84
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda07_ServicoPrestadoBeforePrint
      object RLLabel14: TRLLabel
        Left = 4
        Top = 2
        Width = 120
        Height = 15
        Caption = 'SERVI'#199'O PRESTADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel61: TRLLabel
        Left = 170
        Top = 2
        Width = 197
        Height = 11
        Caption = 'C'#243'digo de Tributa'#231#227'o Nacional / Munic'#237'pal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel92: TRLLabel
        Left = 408
        Top = 3
        Width = 59
        Height = 11
        Caption = 'C'#243'digo NBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllLocalPrestacao: TRLLabel
        Left = 540
        Top = 15
        Width = 74
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel94: TRLLabel
        Left = 539
        Top = 2
        Width = 165
        Height = 11
        Caption = 'Local da Presta'#231#227'o / Sigla UF / Pa'#237's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCodigoNBS: TRLLabel
        Left = 409
        Top = 15
        Width = 58
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel96: TRLLabel
        Left = 4
        Top = 56
        Width = 100
        Height = 11
        Caption = 'Descri'#231#227'o do Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rlmDescServico: TRLMemo
        Left = 4
        Top = 69
        Width = 733
        Height = 12
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'rlmDescServico')
        ParentFont = False
        Transparent = False
      end
      object rlmCodTribNac: TRLMemo
        Left = 4
        Top = 29
        Width = 733
        Height = 26
        AutoSize = False
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'rlmCodTribNac')
        ParentFont = False
        Transparent = False
      end
      object rllCodigoTrib: TRLLabel
        Left = 170
        Top = 15
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda14_InformacoesComplementares: TRLBand
      Left = 28
      Top = 1050
      Width = 940
      Height = 59
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda14_InformacoesComplementaresBeforePrint
      object rlmDadosAdicionais: TRLMemo
        Left = 5
        Top = 21
        Width = 662
        Height = 12
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'Dados Adicionais....')
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 4
        Top = 2
        Width = 230
        Height = 16
        Caption = 'INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllMsgTeste: TRLLabel
        Left = 24
        Top = 24
        Width = 724
        Height = 31
        Alignment = taCenter
        Caption = 'AMBIENTE DE HOMOLOGA'#199#195'O - SEM VALOR FISCAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlbBanda08_ItensDetalhado: TRLBand
      Left = 28
      Top = 661
      Width = 940
      Height = 20
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object RLLabel65: TRLLabel
        Left = 460
        Top = 1
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtde'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel66: TRLLabel
        Left = 4
        Top = 1
        Width = 48
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel67: TRLLabel
        Left = 670
        Top = 1
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor ISS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel68: TRLLabel
        Left = 384
        Top = 1
        Width = 70
        Height = 14
        Caption = 'Valor Unit'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 504
        Top = 1
        Width = 85
        Height = 14
        Caption = 'Valor do Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 590
        Top = 1
        Width = 76
        Height = 14
        Caption = 'Base C'#225'lc. (%)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda09_SubItens: TRLSubDetail
      Left = 28
      Top = 681
      Width = 940
      Height = 19
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      OnDataRecord = rlbBanda09_SubItensDataRecord
      object rlbBanda08_ItensServico: TRLBand
        Left = 1
        Top = 0
        Width = 938
        Height = 16
        BeforePrint = rlbBanda08_ItensServicoBeforePrint
        object txtServicoQtde: TRLLabel
          Left = 460
          Top = 1
          Width = 36
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object rlmServicoDescricao: TRLMemo
          Left = 4
          Top = 1
          Width = 373
          Height = 14
          Behavior = [beSiteExpander]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtServicoUnitario: TRLLabel
          Left = 384
          Top = 1
          Width = 70
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtServicoTotal: TRLLabel
          Left = 504
          Top = 1
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtBaseCalculo: TRLLabel
          Left = 590
          Top = 1
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtISS: TRLLabel
          Left = 670
          Top = 1
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
      end
    end
    object rlbBanda16_Sistema: TRLBand
      Left = 28
      Top = 1109
      Width = 940
      Height = 18
      BandType = btSummary
      BeforePrint = rlbBanda16_SistemaBeforePrint
      object rllDataHoraImpressao: TRLLabel
        Left = 2
        Top = 3
        Width = 76
        Height = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllSistema: TRLLabel
        Left = 356
        Top = 2
        Width = 392
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda10_TributacaoMunicipal: TRLBand
      Left = 28
      Top = 700
      Width = 940
      Height = 115
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda10_TributacaoMunicipalBeforePrint
      object RLLabel10: TRLLabel
        Left = 4
        Top = 2
        Width = 190
        Height = 15
        Caption = 'TRIBUTA'#199#195'O MUNICIPAL (ISSQN)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 204
        Top = 2
        Width = 135
        Height = 11
        Caption = 'Tipo de Tributa'#231#227'o do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllTribISSQN: TRLLabel
        Left = 205
        Top = 14
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel17: TRLLabel
        Left = 204
        Top = 29
        Width = 135
        Height = 11
        Caption = 'Tipo de Imunidade do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllTipoImunidade: TRLLabel
        Left = 204
        Top = 42
        Width = 70
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel25: TRLLabel
        Left = 4
        Top = 85
        Width = 49
        Height = 11
        Caption = 'BC ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorBCISSQN: TRLLabel
        Left = 4
        Top = 98
        Width = 73
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel90: TRLLabel
        Left = 365
        Top = 29
        Width = 177
        Height = 11
        Caption = 'Suspens'#227'o da Exigibilidade do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllSuspensao: TRLLabel
        Left = 365
        Top = 42
        Width = 56
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel93: TRLLabel
        Left = 573
        Top = 57
        Width = 127
        Height = 11
        Caption = 'Desconto Incondicionando'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorDescIncond: TRLLabel
        Left = 573
        Top = 70
        Width = 81
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel97: TRLLabel
        Left = 204
        Top = 85
        Width = 81
        Height = 11
        Caption = 'Al'#237'quota Aplicada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliquotaAplicada: TRLLabel
        Left = 203
        Top = 98
        Width = 78
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel99: TRLLabel
        Left = 365
        Top = 2
        Width = 235
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF / Pais de Incid'#234'ncia do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllMunicipioIncidencia: TRLLabel
        Left = 365
        Top = 14
        Width = 90
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel101: TRLLabel
        Left = 573
        Top = 29
        Width = 139
        Height = 11
        Caption = 'N'#250'm. do Processo Suspens'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllNumeroProcesso: TRLLabel
        Left = 573
        Top = 42
        Width = 82
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel103: TRLLabel
        Left = 365
        Top = 57
        Width = 119
        Height = 11
        Caption = 'Total Dedu'#231#245'es/Redu'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalDedRed: TRLLabel
        Left = 365
        Top = 70
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel105: TRLLabel
        Left = 365
        Top = 85
        Width = 92
        Height = 11
        Caption = 'Reten'#231#227'o do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllRetencaoISSQN: TRLLabel
        Left = 365
        Top = 98
        Width = 79
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel111: TRLLabel
        Left = 204
        Top = 57
        Width = 70
        Height = 11
        Caption = 'C'#225'lculo do BM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCalculoBM: TRLLabel
        Left = 204
        Top = 70
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel113: TRLLabel
        Left = 573
        Top = 85
        Width = 73
        Height = 11
        Caption = 'ISSQN Apurado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorISSQNApurado: TRLLabel
        Left = 573
        Top = 98
        Width = 94
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel109: TRLLabel
        Left = 4
        Top = 57
        Width = 93
        Height = 11
        Caption = 'Beneficio Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllBeneficioMunic: TRLLabel
        Left = 4
        Top = 70
        Width = 73
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel107: TRLLabel
        Left = 4
        Top = 29
        Width = 143
        Height = 11
        Caption = 'Regime Especial de Tributa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllRegimeEspecial: TRLLabel
        Left = 4
        Top = 42
        Width = 77
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda01_Logos: TRLBand
      Left = 28
      Top = 24
      Width = 940
      Height = 69
      AutoSize = True
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda01_LogosBeforePrint
      object RLLabel74: TRLLabel
        Left = 327
        Top = 3
        Width = 74
        Height = 15
        Alignment = taCenter
        Caption = 'DANFSe v2.0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 285
        Top = 18
        Width = 168
        Height = 15
        Alignment = taCenter
        Caption = 'Documento Auxiliar da NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rliLogoNFSe: TRLImage
        Left = 2
        Top = 2
        Width = 251
        Height = 63
        Center = True
        Scaled = True
      end
      object rlmPrefeitura: TRLMemo
        Left = 540
        Top = 4
        Width = 204
        Height = 14
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rlbHomologacao: TRLLabel
        Left = 279
        Top = 34
        Width = 184
        Height = 15
        Alignment = taCenter
        Caption = 'NFS-e emitida em Homologa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel33: TRLLabel
        Left = 540
        Top = 54
        Width = 42
        Height = 14
        Caption = 'P'#225'gina:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 585
        Top = 54
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Info = itPageNumber
        ParentFont = False
        Text = ''
      end
      object RLLabel62: TRLLabel
        Left = 659
        Top = 53
        Width = 7
        Height = 15
        Caption = '/'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 669
        Top = 54
        Width = 50
        Height = 14
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Info = itLastPageNumber
        ParentFont = False
        Text = ''
      end
    end
    object rlbBanda06_Intermediario: TRLBand
      Left = 28
      Top = 490
      Width = 940
      Height = 87
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda06_IntermediarioBeforePrint
      object rllInterCNPJ: TRLLabel
        Left = 264
        Top = 17
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterInscMunicipal: TRLLabel
        Left = 408
        Top = 18
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterNome: TRLLabel
        Left = 4
        Top = 44
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterEndereco: TRLLabel
        Left = 4
        Top = 71
        Width = 68
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterMunicipio: TRLLabel
        Left = 408
        Top = 44
        Width = 67
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllInterEmail: TRLLabel
        Left = 409
        Top = 71
        Width = 52
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterTelefone: TRLLabel
        Left = 607
        Top = 18
        Width = 65
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel81: TRLLabel
        Left = 4
        Top = 2
        Width = 166
        Height = 14
        Caption = 'INTERMEDI'#193'RIO DA OPERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel82: TRLLabel
        Left = 4
        Top = 31
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel83: TRLLabel
        Left = 4
        Top = 58
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel84: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel85: TRLLabel
        Left = 408
        Top = 6
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel86: TRLLabel
        Left = 408
        Top = 58
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel87: TRLLabel
        Left = 408
        Top = 31
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel88: TRLLabel
        Left = 607
        Top = 6
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel89: TRLLabel
        Left = 607
        Top = 32
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllInterCEP: TRLLabel
        Left = 607
        Top = 44
        Width = 48
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllIntermediarioNaoIdentificado: TRLLabel
        Left = 279
        Top = 0
        Width = 382
        Height = 16
        Align = faCenterTop
        Alignment = taCenter
        Caption = 'INTERMEDI'#193'RIO DO SERVI'#199'O N'#195'O IDENTIFICADO NA NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda11_TributacaoFederal: TRLBand
      Left = 28
      Top = 815
      Width = 940
      Height = 60
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda11_TributacaoFederalBeforePrint
      object RLLabel115: TRLLabel
        Left = 4
        Top = 2
        Width = 215
        Height = 15
        Caption = 'TRIBUTA'#199#195'O FEDERAL (EXCETO CBS)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel116: TRLLabel
        Left = 238
        Top = 5
        Width = 26
        Height = 11
        Caption = 'IRRF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorIRRF: TRLLabel
        Left = 239
        Top = 18
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel118: TRLLabel
        Left = 4
        Top = 31
        Width = 138
        Height = 11
        Caption = 'PIS - D'#233'bito Apura'#231#227'o Pr'#243'pria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorPIS: TRLLabel
        Left = 3
        Top = 42
        Width = 46
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel124: TRLLabel
        Left = 377
        Top = 5
        Width = 163
        Height = 11
        Caption = 'Contribui'#231#227'o Previdenci'#225'ria-Retida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorCP: TRLLabel
        Left = 376
        Top = 18
        Width = 44
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel126: TRLLabel
        Left = 238
        Top = 31
        Width = 153
        Height = 11
        Caption = 'COFINS-D'#233'bito Apura'#231#227'o Pr'#243'pria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorCOFINS: TRLLabel
        Left = 237
        Top = 44
        Width = 67
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel132: TRLLabel
        Left = 574
        Top = 3
        Width = 140
        Height = 11
        Caption = 'Contribui'#231#245'es Sociais-Retidas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorCSLL: TRLLabel
        Left = 574
        Top = 16
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel134: TRLLabel
        Left = 426
        Top = 31
        Width = 162
        Height = 11
        Caption = 'Descri'#231#227'o Contrib. Sociais-Retidas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllDescCSLL: TRLLabel
        Left = 426
        Top = 44
        Width = 55
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda13_ValorTotaNFSe: TRLBand
      Left = 28
      Top = 987
      Width = 940
      Height = 63
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda13_ValorTotaNFSeBeforePrint
      object RLLabel3: TRLLabel
        Left = 4
        Top = 2
        Width = 139
        Height = 15
        Caption = 'VALOR TOTAL DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel26: TRLLabel
        Left = 227
        Top = 2
        Width = 130
        Height = 11
        Caption = 'Valor da Opera'#231#227'o / Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalServico: TRLLabel
        Left = 227
        Top = 16
        Width = 83
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel35: TRLLabel
        Left = 557
        Top = 3
        Width = 114
        Height = 11
        Caption = 'Desconto Condicionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalDescCond: TRLLabel
        Left = 557
        Top = 16
        Width = 95
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel37: TRLLabel
        Left = 392
        Top = 31
        Width = 82
        Height = 11
        Caption = 'Total do IBS/CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalIBSCBS: TRLLabel
        Left = 392
        Top = 46
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel39: TRLLabel
        Left = 392
        Top = 3
        Width = 121
        Height = 11
        Caption = 'Desconto Incondicionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalDescIncond: TRLLabel
        Left = 392
        Top = 16
        Width = 101
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel41: TRLLabel
        Left = 4
        Top = 31
        Width = 179
        Height = 11
        Caption = 'Total das Reten'#231#245'es (ISSQN / Federais)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalISSQNRetido: TRLLabel
        Left = 4
        Top = 46
        Width = 107
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel43: TRLLabel
        Left = 227
        Top = 31
        Width = 110
        Height = 11
        Caption = 'Valor L'#237'quido da NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalLiq: TRLLabel
        Left = 227
        Top = 46
        Width = 63
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel20: TRLLabel
        Left = 557
        Top = 31
        Width = 160
        Height = 11
        Caption = 'Valor L'#237'quido da NFS-e + IBS/CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorLiqIBSCBS: TRLLabel
        Left = 557
        Top = 46
        Width = 77
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda05_Destinatario: TRLBand
      Left = 28
      Top = 407
      Width = 940
      Height = 83
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda05_DestinatarioBeforePrint
      object rllDestCNPJ: TRLLabel
        Left = 264
        Top = 16
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestInscMunicipal: TRLLabel
        Left = 408
        Top = 16
        Width = 87
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestNome: TRLLabel
        Left = 4
        Top = 42
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestEndereco: TRLLabel
        Left = 4
        Top = 68
        Width = 68
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestMunicipio: TRLLabel
        Left = 409
        Top = 42
        Width = 69
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllDestEmail: TRLLabel
        Left = 409
        Top = 68
        Width = 52
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestTelefone: TRLLabel
        Left = 607
        Top = 16
        Width = 64
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel42: TRLLabel
        Left = 4
        Top = 2
        Width = 162
        Height = 14
        Caption = 'DESTINAT'#193'RIO DA OPERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel44: TRLLabel
        Left = 4
        Top = 29
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel47: TRLLabel
        Left = 4
        Top = 56
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel48: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel49: TRLLabel
        Left = 408
        Top = 2
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel51: TRLLabel
        Left = 409
        Top = 56
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel52: TRLLabel
        Left = 408
        Top = 29
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel53: TRLLabel
        Left = 607
        Top = 2
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel56: TRLLabel
        Left = 607
        Top = 29
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllDestCEP: TRLLabel
        Left = 608
        Top = 42
        Width = 48
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllDestinatarioNaoIdentificado: TRLLabel
        Left = 282
        Top = 0
        Width = 376
        Height = 16
        Align = faCenterTop
        Alignment = taCenter
        Caption = 'DESTINAT'#193'RIO DO SERVI'#199'O N'#195'O IDENTIFICADO NA NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda12_TributacaoFederalIBSCBS: TRLBand
      Left = 28
      Top = 875
      Width = 940
      Height = 112
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda12_TributacaoFederalIBSCBSBeforePrint
      object RLLabel27: TRLLabel
        Left = 4
        Top = 2
        Width = 132
        Height = 15
        Caption = 'TRIBUTA'#199#195'O IBS / CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel28: TRLLabel
        Left = 186
        Top = 3
        Width = 78
        Height = 11
        Caption = 'CST / cClassTrib'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCST: TRLLabel
        Left = 185
        Top = 15
        Width = 28
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel34: TRLLabel
        Left = 4
        Top = 29
        Width = 134
        Height = 11
        Caption = 'Exclus'#245'es e Redu'#231#245'es da BC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllExcRedBC: TRLLabel
        Left = 4
        Top = 41
        Width = 56
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel38: TRLLabel
        Left = 292
        Top = 2
        Width = 377
        Height = 11
        Caption = 
          'Indicador de Opera'#231#227'o / C'#243'digo IBGE Incid'#234'ncia / Munic'#237'pio Incid' +
          #234'ncia / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllcIndOp: TRLLabel
        Left = 292
        Top = 15
        Width = 40
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel57: TRLLabel
        Left = 186
        Top = 29
        Width = 144
        Height = 11
        Caption = 'BC ap'#243's Exclus'#245'es e Redu'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorBC: TRLLabel
        Left = 186
        Top = 41
        Width = 44
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel59: TRLLabel
        Left = 374
        Top = 56
        Width = 123
        Height = 11
        Caption = 'Al'#237'q. Efetiva Estadual - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliqEfetIBSUF: TRLLabel
        Left = 374
        Top = 69
        Width = 71
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel63: TRLLabel
        Left = 374
        Top = 29
        Width = 176
        Height = 11
        Caption = 'Red. Al'#237'quota IBS / Red. Al'#237'quota CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllRedAliquota: TRLLabel
        Left = 374
        Top = 41
        Width = 60
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel79: TRLLabel
        Left = 4
        Top = 56
        Width = 128
        Height = 11
        Caption = 'Al'#237'q. Efetiva Munic'#237'pal - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliqEfetIBSMun: TRLLabel
        Left = 4
        Top = 69
        Width = 75
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel91: TRLLabel
        Left = 4
        Top = 83
        Width = 118
        Height = 11
        Caption = 'Valor Total Apurado - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurIBS: TRLLabel
        Left = 4
        Top = 95
        Width = 65
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel98: TRLLabel
        Left = 186
        Top = 56
        Width = 140
        Height = 11
        Caption = 'Valor Apurado Municipal - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurIBSMun: TRLLabel
        Left = 186
        Top = 69
        Width = 82
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel102: TRLLabel
        Left = 186
        Top = 83
        Width = 69
        Height = 11
        Caption = 'Al'#237'quota - CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliquotaCBS: TRLLabel
        Left = 186
        Top = 95
        Width = 62
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel106: TRLLabel
        Left = 374
        Top = 83
        Width = 85
        Height = 11
        Caption = 'Al'#237'q. Efetiva - CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliqEfetCBS: TRLLabel
        Left = 374
        Top = 95
        Width = 62
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel110: TRLLabel
        Left = 580
        Top = 29
        Width = 111
        Height = 11
        Caption = 'Al'#237'q. - IBS UF / IBS Mun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliquotaIBS: TRLLabel
        Left = 580
        Top = 41
        Width = 58
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel114: TRLLabel
        Left = 580
        Top = 56
        Width = 135
        Height = 11
        Caption = 'Valor Apurado Estadual - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurIBSUF: TRLLabel
        Left = 580
        Top = 69
        Width = 78
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel119: TRLLabel
        Left = 580
        Top = 83
        Width = 122
        Height = 11
        Caption = 'Valor Total Apurado - CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurCBS: TRLLabel
        Left = 580
        Top = 95
        Width = 69
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbCanhoto: TRLBand
      Left = 28
      Top = 1127
      Width = 940
      Height = 55
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbCanhotoBeforePrint
      object rllNumChave: TRLLabel
        Left = 402
        Top = 33
        Width = 345
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel50: TRLLabel
        Left = 403
        Top = 13
        Width = 135
        Height = 15
        Caption = 'N. NFS-e / Chave NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel54: TRLLabel
        Left = 151
        Top = 14
        Width = 225
        Height = 15
        Caption = 'Identifica'#231#227'o e Assinatura do Recebedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLDraw5: TRLDraw
        Left = 150
        Top = 48
        Width = 248
        Height = 1
        Brush.Style = bsClear
        DrawKind = dkLine
      end
      object RLLabel121: TRLLabel
        Left = 5
        Top = 14
        Width = 33
        Height = 15
        Caption = 'DATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel122: TRLLabel
        Left = 4
        Top = 38
        Width = 136
        Height = 12
        Caption = '_______ / _______ / __________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllNumNFSe: TRLLabel
        Left = 558
        Top = 14
        Width = 58
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
  end
  inherited RLPDFFilter1: TRLPDFFilter
    Left = 160
    Top = 16
  end
end
