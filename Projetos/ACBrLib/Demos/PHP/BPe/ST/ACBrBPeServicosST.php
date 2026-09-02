<?php
/* {******************************************************************************}
// { Projeto: Componentes ACBr                                                    }
// {  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
// { mentos de Automação Comercial utilizados no Brasil                           }
// {                                                                              }
// { Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
// {                                                                              }
// { Colaboradores nesse arquivo: Renato Rubinho                                  }
// {                                                                              }
// {  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
// { Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
// {                                                                              }
// {  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
// { sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
// { Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
// { qualquer versão posterior.                                                   }
// {                                                                              }
// {  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
// { NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
// { ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
// { do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
// {                                                                              }
// {  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
// { com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
// { no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
// { Você também pode obter uma copia da licença em:                              }
// { http://www.opensource.org/licenses/lgpl-license.php                          }
// {                                                                              }
// { Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
// {       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
// {******************************************************************************}
*/
header('Content-Type: application/json; charset=UTF-8');

include 'ACBrBPeST.php';
include '../../ACBrComum/ACBrComum.php';

$nomeLib = "ACBrBPe";
$metodo = $_POST['metodo'];

if (ValidaFFI() != 0)
    exit;

$dllPath = CarregaDll(__DIR__, $nomeLib);

if ($dllPath == -10)
    exit;

$importsPath = CarregaImports(__DIR__, $nomeLib, 'ST');

if ($importsPath == -10)
    exit;

$iniPath = CarregaIniPath(__DIR__, $nomeLib);

$processo = "file_get_contents";
$ffi = CarregaContents($importsPath, $dllPath);

try {
    $resultado = "";
    $processo = "Inicializar";

    $processo = "BPe_Inicializar";
    if (Inicializar($ffi, $iniPath) != 0)
        exit;

    if ($metodo == "salvarConfiguracoes") {
        $processo = $metodo . "/" . "BPe_ConfigGravarValor";

        if (ConfigGravarValor($ffi, "Principal", "LogPath", $_POST['LogPath']) != 0) exit;
        if (ConfigGravarValor($ffi, "Principal", "LogNivel", $_POST['LogNivel']) != 0) exit;

        if (ConfigGravarValor($ffi, "BPe", "ExibirErroSchema", $_POST['exibirErroSchema']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "FormatoAlerta", $_POST['formatoAlerta']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "FormaEmissao", $_POST['formaEmissao']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "VersaoDF", $_POST['versaoDF']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "RetirarAcentos", $_POST['retirarAcentos']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SalvarGer", $_POST['SalvarGer']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "PathSalvar", $_POST['pathSalvar']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "PathSchemas", $_POST['pathSchemas']) != 0) exit;

        if (ConfigGravarValor($ffi, "BPe", "SSLType", $_POST['SSLType']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "Timeout", $_POST['timeout']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "Ambiente", $_POST['ambiente']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "Visualizar", $_POST['visualizar']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SalvarWS", $_POST['SalvarWS']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "AjustaAguardaConsultaRet", $_POST['ajustaAguardaConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "AguardarConsultaRet", $_POST['aguardarConsultaRet']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "Tentativas", $_POST['tentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "IntervaloTentativas", $_POST['intervaloTentativas']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SalvarArq", $_POST['SalvarArq']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SepararPorMes", $_POST['SepararPorMes']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "AdicionarLiteral", $_POST['AdicionarLiteral']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "EmissaoPathBPe", $_POST['EmissaoPathBPe']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SalvarEvento", $_POST['SalvarEvento']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SepararPorCNPJ", $_POST['SepararPorCNPJ']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "SepararPorModelo", $_POST['SepararPorModelo']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "PathBPe", $_POST['PathBPe']) != 0) exit;
        if (ConfigGravarValor($ffi, "BPe", "PathEvento", $_POST['PathEvento']) != 0) exit;

        if (ConfigGravarValor($ffi, "Proxy", "Servidor", $_POST['proxyServidor']) != 0) exit;
        if (ConfigGravarValor($ffi, "Proxy", "Porta", $_POST['proxyPorta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Proxy", "Usuario", $_POST['proxyUsuario']) != 0) exit;
        if (ConfigGravarValor($ffi, "Proxy", "Senha", $_POST['proxySenha']) != 0) exit;

        if (ConfigGravarValor($ffi, "DFe", "UF", $_POST['UF']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "SSLCryptLib", $_POST['SSLCryptLib']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "SSLHttpLib", $_POST['SSLHttpLib']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "SSLXmlSignLib", $_POST['SSLXmlSignLib']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "ArquivoPFX", $_POST['ArquivoPFX']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "DadosPFX", $_POST['DadosPFX']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "Senha", $_POST['senhaCertificado']) != 0) exit;
        if (ConfigGravarValor($ffi, "DFe", "NumeroSerie", $_POST['NumeroSerie']) != 0) exit;

        if (ConfigGravarValor($ffi, "DABPe", "PathLogo", $_POST['PathLogo']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "Modelo", $_POST['PosPrinterModelo']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "PaginaDeCodigo", $_POST['PaginaDeCodigo']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "Porta", $_POST['PosPrinterPorta']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "ColunasFonteNormal", $_POST['ColunasFonteNormal']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "EspacoEntreLinhas", $_POST['EspacoEntreLinhas']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "LinhasBuffer", $_POST['LinhasBuffer']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "LinhasEntreCupons", $_POST['LinhasEntreCupons']) != 0) exit;
        if (ConfigGravarValor($ffi, "PosPrinter", "CortaPapel", $_POST['CortaPapel']) != 0) exit;

        if (ConfigGravarValor($ffi, "Email", "Nome", $_POST['emailNome']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Conta", $_POST['emailConta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Servidor", $_POST['emailServidor']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Porta", $_POST['emailPorta']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "SSL", $_POST['emailSSL']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "TLS", $_POST['emailTLS']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Usuario", $_POST['emailUsuario']) != 0) exit;
        if (ConfigGravarValor($ffi, "Email", "Senha", $_POST['emailSenha']) != 0) exit;

        $resultado = "Configurações salvas com sucesso.";
    }

    if ($metodo == "carregarConfiguracoes") {
        $processo = $metodo . "/" . "BPe_ConfigLer";

        if (ConfigLerValor($ffi, "Principal", "LogPath", $LogPath) != 0) exit;
        if (ConfigLerValor($ffi, "Principal", "LogNivel", $LogNivel) != 0) exit;

        if (ConfigLerValor($ffi, "BPe", "ExibirErroSchema", $exibirErroSchema) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "FormatoAlerta", $formatoAlerta) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "FormaEmissao", $formaEmissao) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "VersaoDF", $versaoDF) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "RetirarAcentos", $retirarAcentos) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SalvarGer", $SalvarGer) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "PathSalvar", $pathSalvar) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "PathSchemas", $pathSchemas) != 0) exit;

        if (ConfigLerValor($ffi, "BPe", "SSLType", $SSLType) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "Timeout", $timeout) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "Ambiente", $ambiente) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "Visualizar", $visualizar) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SalvarWS", $SalvarWS) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "AjustaAguardaConsultaRet", $ajustaAguardaConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "AguardarConsultaRet", $aguardarConsultaRet) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "Tentativas", $tentativas) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "IntervaloTentativas", $intervaloTentativas) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SalvarArq", $SalvarArq) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SepararPorMes", $SepararPorMes) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "AdicionarLiteral", $AdicionarLiteral) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "EmissaoPathBPe", $EmissaoPathBPe) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SalvarEvento", $SalvarEvento) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SepararPorCNPJ", $SepararPorCNPJ) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "SepararPorModelo", $SepararPorModelo) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "PathBPe", $PathBPe) != 0) exit;
        if (ConfigLerValor($ffi, "BPe", "PathEvento", $PathEvento) != 0) exit;

        if (ConfigLerValor($ffi, "Proxy", "Servidor", $proxyServidor) != 0) exit;
        if (ConfigLerValor($ffi, "Proxy", "Porta", $proxyPorta) != 0) exit;
        if (ConfigLerValor($ffi, "Proxy", "Usuario", $proxyUsuario) != 0) exit;
        if (ConfigLerValor($ffi, "Proxy", "Senha", $proxySenha) != 0) exit;

        if (ConfigLerValor($ffi, "DFe", "UF", $UF) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "SSLCryptLib", $SSLCryptLib) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "SSLHttpLib", $SSLHttpLib) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "SSLXmlSignLib", $SSLXmlSignLib) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "ArquivoPFX", $ArquivoPFX) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "DadosPFX", $DadosPFX) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "Senha", $senhaCertificado) != 0) exit;
        if (ConfigLerValor($ffi, "DFe", "NumeroSerie", $NumeroSerie) != 0) exit;

        if (ConfigLerValor($ffi, "DABPe", "PathLogo", $PathLogo) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "Modelo", $PosPrinterModelo) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "PaginaDeCodigo", $PaginaDeCodigo) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "Porta", $PosPrinterPorta) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "ColunasFonteNormal", $ColunasFonteNormal) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "EspacoEntreLinhas", $EspacoEntreLinhas) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "LinhasBuffer", $LinhasBuffer) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "LinhasEntreCupons", $LinhasEntreCupons) != 0) exit;
        if (ConfigLerValor($ffi, "PosPrinter", "CortaPapel", $CortaPapel) != 0) exit;

        if (ConfigLerValor($ffi, "Email", "Nome", $emailNome) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Conta", $emailConta) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Servidor", $emailServidor) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Porta", $emailPorta) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "SSL", $emailSSL) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "TLS", $emailTLS) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Usuario", $emailUsuario) != 0) exit;
        if (ConfigLerValor($ffi, "Email", "Senha", $emailSenha) != 0) exit;

        $processo = $metodo . "/" . "responseData";
        $responseData = [
            'dados' => [
                'LogPath' => $LogPath ?? '',
                'LogNivel' => $LogNivel ?? '',

                'exibirErroSchema' => $exibirErroSchema ?? '',
                'formatoAlerta' => $formatoAlerta ?? '',
                'formaEmissao' => $formaEmissao ?? '',
                'versaoDF' => $versaoDF ?? '',
                'retirarAcentos' => $retirarAcentos ?? '',
                'SalvarGer' => $SalvarGer ?? '',
                'pathSalvar' => $pathSalvar ?? '',
                'pathSchemas' => $pathSchemas ?? '',
                'SSLType' => $SSLType ?? '',
                'timeout' => $timeout ?? '',
                'ambiente' => $ambiente ?? '',
                'visualizar' => $visualizar ?? '',
                'SalvarWS' => $SalvarWS ?? '',
                'ajustaAguardaConsultaRet' => $ajustaAguardaConsultaRet ?? '',
                'aguardarConsultaRet' => $aguardarConsultaRet ?? '',
                'tentativas' => $tentativas ?? '',
                'intervaloTentativas' => $intervaloTentativas ?? '',
                'SalvarArq' => $SalvarArq ?? '',
                'SepararPorMes' => $SepararPorMes ?? '',
                'AdicionarLiteral' => $AdicionarLiteral ?? '',
                'EmissaoPathBPe' => $EmissaoPathBPe ?? '',
                'SalvarEvento' => $SalvarEvento ?? '',
                'SepararPorCNPJ' => $SepararPorCNPJ ?? '',
                'SepararPorModelo' => $SepararPorModelo ?? '',
                'PathBPe' => $PathBPe ?? '',
                'PathEvento' => $PathEvento ?? '',

                'proxyServidor' => $proxyServidor ?? '',
                'proxyPorta' => $proxyPorta ?? '',
                'proxyUsuario' => $proxyUsuario ?? '',
                'proxySenha' => $proxySenha ?? '',

                'UF' => $UF ?? '',
                'SSLCryptLib' => $SSLCryptLib ?? '',
                'SSLHttpLib' => $SSLHttpLib ?? '',
                'SSLXmlSignLib' => $SSLXmlSignLib ?? '',
                'ArquivoPFX' => $ArquivoPFX ?? '',
                'DadosPFX' => $DadosPFX ?? '',
                'senhaCertificado' => $senhaCertificado ?? '',
                'NumeroSerie' => $NumeroSerie ?? '',

                'PathLogo' => $PathLogo ?? '',
                'PosPrinterModelo' => $PosPrinterModelo ?? '',
                'PaginaDeCodigo' => $PaginaDeCodigo ?? '',
                'PosPrinterPorta' => $PosPrinterPorta ?? '',
                'ColunasFonteNormal' => $ColunasFonteNormal ?? '',
                'EspacoEntreLinhas' => $EspacoEntreLinhas ?? '',
                'LinhasBuffer' => $LinhasBuffer ?? '',
                'LinhasEntreCupons' => $LinhasEntreCupons ?? '',
                'CortaPapel' => $CortaPapel ?? '',

                'emailNome' => $emailNome ?? '',
                'emailConta' => $emailConta ?? '',
                'emailServidor' => $emailServidor ?? '',
                'emailPorta' => $emailPorta ?? '',
                'emailSSL' => $emailSSL ?? '',
                'emailTLS' => $emailTLS ?? '',
                'emailUsuario' => $emailUsuario ?? '',
                'emailSenha' => $emailSenha ?? ''
            ]
        ];
    }

    if ($metodo == "statusServico") {
        $processo = "BPe_StatusServico";

        if (StatusServico($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "OpenSSLInfo") {
        $processo = "BPe_OpenSSLInfo";

        if (OpenSSLInfo($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterCertificados") {
        $processo = "BPe_ObterCertificados";

        if (ObterCertificados($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CarregarXmlBPe") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['conteudoArquivo01'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CarregarIniBPe") {
        $processo = "BPe_CarregarINI";

        if (CarregarINI($ffi, $_POST['conteudoArquivo01'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "Enviar") {
        if ($_POST['tipoArquivo'] == "xml") {
            $processo = "BPe_CarregarXml";

            if (CarregarXmlBPe($ffi, $_POST['AeArquivoBPe'], $resultado) != 0) {
                exit;
            }
        } else {
            $processo = "BPe_CarregarINI";

            if (CarregarINI($ffi, $_POST['AeArquivoBPe'], $resultado) != 0) {
                exit;
            }
        }

        $processo = "BPe_AssinarBPe";

        if (AssinarBPe($ffi, $resultado) != 0) {
            exit;
        }

        $processo = "BPe_Enviar";

        if (Enviar(
            $ffi,
            $_POST['AImprimir'],
            $resultado
        ) != 0) {
            exit;
        }
    }

    if ($metodo == "AssinarBPe") {
        $processo = "BPe_AssinarBPe";

        if (AssinarBPe($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ValidarBPe") {
        $processo = "BPe_ValidarBPe";

        if (ValidarBPe($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ValidarRegrasdeNegocios") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_ValidarRegrasdeNegocios";

        if (ValidarRegrasdeNegocios($ffi, $resultado) != 0) {
            exit;
        }

        $resultado = "ok";
    }

    if ($metodo == "EnviarEmail") {
        $processo = "BPe_EnviarEmail";

        if (EnviarEmail($ffi, $_POST['AePara'], $_POST['AeArquivoXmlBPe'], $_POST['AEnviaPDF'], $_POST['AeAssunto'], $_POST['AeCC'], $_POST['AeAnexos'], $_POST['AeMensagem'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "Consultar") {
        $processo = "BPe_Consultar";

        if (Consultar($ffi, $_POST['eChaveOuBPe'], $_POST['AExtrairEventos'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "Cancelar") {
        $processo = "BPe_Cancelar";

        if (Cancelar($ffi, $_POST['AeChave'], $_POST['AeJustificativa'], $_POST['AeCNPJCPF'], $_POST['ALote'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CarregarEventoXML") {
        $processo = "BPe_CarregarEventoXML";

        if (CarregarEventoXML($ffi, $_POST['conteudoArquivo01'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "CarregarEventoINI") {
        $processo = "BPe_CarregarEventoINI";

        if (CarregarEventoINI($ffi, $_POST['conteudoArquivo01'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "EnviarEvento") {
        if ($_POST['tipoArquivo'] == "xml") {
            $processo = "BPe_CarregarEventoXML";

            if (CarregarEventoXML($ffi, $_POST['AeArquivoBPe'], $resultado) != 0) {
                exit;
            }
        } else {
            $processo = "BPe_CarregarEventoINI";

            if (CarregarEventoINI($ffi, $_POST['AeArquivoBPe'], $resultado) != 0) {
                exit;
            }
        }

        $processo = "BPe_EnviarEvento";

        if (EnviarEvento($ffi, $_POST['ALote'], $resultado) != 0) {
            exit;
        }
    }


    if ($metodo == "LimparListaBPe") {
        $processo = "BPe_LimparListaBPe";

        if (LimparListaBPe($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "LimparListaEventos") {
        $processo = "BPe_LimparListaEventos";

        if (LimparListaEventos($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "EnviarEmailEvento") {
        $processo = "BPe_EnviarEmailEvento";

        if (EnviarEmailEvento($ffi, $_POST['AePara'], $_POST['AeArquivoXmlEvento'], $_POST['AeArquivoXmlBPe'], $_POST['AEnviaPDF'], $_POST['AeAssunto'], $_POST['AeCC'], $_POST['AeAnexos'], $_POST['AeMensagem'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ObterXml") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_ObterXml";

        if (ObterXml($ffi, $_POST['AeIndex'], $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "GravarXml") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_GravarXml";

        if (GravarXml($ffi, $_POST['AeIndex'], $_POST['AeNomeArquivo'], $_POST['AePath'], $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "ObterIni") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_ObterIni";

        if (ObterIni($ffi, $_POST['AeIndex'], $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "GravarIni") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_GravarIni";

        if (GravarIni($ffi, $_POST['AeIndex'], $_POST['AeNomeArquivo'], $_POST['AePath'], $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "VerificarAssinatura") {
        $processo = "BPe_VerificarAssinatura";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_VerificarAssinatura";

        if (VerificarAssinatura($ffi, $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "GetPath") {
        $processo = "BPe_GetPath";

        if (GetPath($ffi, $_POST['AeTipo'], $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "GetPathEvento") {
        $processo = "BPe_GetPathEvento";

        if (GetPathEvento($ffi, $_POST['AeCodEvento'], $resultado) != 0) {
            exit;
        }

    }

    if ($metodo == "ImprimirPDF") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_ImprimirPDF";

        if (ImprimirPDF($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "SalvarPDF") {
        $processo = "BPe_CarregarXml";

        if (CarregarXmlBPe($ffi, $_POST['AeArquivoXmlBPe'], $resultado) != 0) {
            exit;
        }

        $processo = "BPe_SalvarPDF";

        if (SalvarPDF($ffi, $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "ImprimirEventoPDF") {
        $processo = "BPe_ImprimirEventoPDF";

        if (ImprimirEventoPDF($ffi, $_POST['AeArquivoXmlBPe'], $_POST['AeArquivoXmlEvento'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo == "SalvarEventoPDF") {
        $processo = "BPe_SalvarEventoPDF";

        if (SalvarEventoPDF($ffi, $_POST['AeArquivoXmlBPe'], $_POST['AeArquivoXmlEvento'], $resultado) != 0) {
            exit;
        }
    }

    if ($metodo != "carregarConfiguracoes") {
        $processo = "responseData";
        $responseData = [
            'mensagem' => $resultado
        ];
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    echo json_encode(["mensagem" => "Exceção[$processo]: $erro"]);
    exit;
}

try {
    if ($processo != "BPe_Inicializar") {
        $processo = "BPe_Finalizar";
        if (Finalizar($ffi) != 0)
            exit;
    }
} catch (Exception $e) {
    $erro = $e->getMessage();
    echo json_encode(["mensagem" => "Exceção[$processo]: $erro"]);
    exit;
}

echo json_encode($responseData);
