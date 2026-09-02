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

int BPe_Inicializar(const char* eArqConfig, const char* eChaveCrypt);
int BPe_ConfigLer(const char* eArqConfig);
int BPe_ConfigLerValor(const char* eSessao, char* eChave, char* sValor, long* esTamanho);
int BPe_ConfigGravarValor(const char* eSessao, const char* eChave, const char* eValor);
int BPe_UltimoRetorno(char* sMensagem, long* esTamanho);
int BPe_Finalizar();
int BPe_Nome(const char* sNome, long* esTamanho);
int BPe_Versao(const char* sVersao, long* esTamanho);
int BPe_OpenSSLInfo(const char* sOpenSSLInfo, long* esTamanho);
int BPe_ConfigImportar(const char* eArqConfig);
int BPe_ConfigExportar(const char* sMensagem, long* esTamanho);
int BPe_ConfigGravar(const char* eArqConfig);

int BPe_ObterCertificados(const char* sResposta, long* esTamanho);
int BPe_StatusServico(char* sMensagem, long* esTamanho);
int BPe_CarregarXML(const char* eArquivoOuXML);
int BPe_CarregarINI(const char* eArquivoOuINI);
int BPe_ObterXml(int AIndex, const char* sResposta, long* esTamanho);
int BPe_GravarXml(int AIndex, const char* eNomeArquivo, const char* ePathArquivo);
int BPe_ObterIni(int AIndex, const char* sResposta, long* esTamanho);
int BPe_GravarIni(int AIndex, const char* eNomeArquivo, const char* ePathArquivo);
int BPe_CarregarEventoXML(const char* eArquivoOuXML);
int BPe_CarregarEventoINI(const char* eArquivoOuINI);
int BPe_LimparLista();
int BPe_LimparListaEventos();
int BPe_Assinar();
int BPe_Validar();
int BPe_ValidarRegrasdeNegocios(const char* sResposta, long* esTamanho);
int BPe_VerificarAssinatura(const char* sResposta, long* esTamanho);
int BPe_GetPath(int ATipo, const char* sResposta, long* esTamanho);
int BPe_GetPathEvento(const char* ACodEvento, const char* sResposta, long* esTamanho);
int BPe_Enviar(long AImprimir, const char* sResposta, long* esTamanho);
int BPe_Consultar(const char* eChaveOuBPe, long AExtrairEventos, const char* sResposta, long* esTamanho);
int BPe_Cancelar(const char* eChave, const char* eJustificativa, const char* eCNPJCPF, int ALote, const char* sResposta, long* esTamanho);
int BPe_EnviarEvento(int idLote, const char* sResposta, long* esTamanho);
int BPe_EnviarEmail(const char* ePara, const char* eXmlBPe, long AEnviaPDF, const char* eAssunto, const char* eCC, const char* eAnexos, const char* eMensagem);
int BPe_EnviarEmailEvento(const char* ePara, const char* eXmlEvento, const char* eXmlBPe, long AEnviaPDF, const char* eAssunto, const char* eCC, const char* eAnexos, const char* eMensagem);
int BPe_Imprimir(const char* cImpressora, int nNumCopias, long bMostrarPreview);
int BPe_ImprimirPDF();
int BPe_SalvarPDF(const char* sResposta, long* esTamanho);
int BPe_ImprimirEvento(const char* eArquivoXmlBPe, const char* eArquivoXmlEvento);
int BPe_ImprimirEventoPDF(const char* eArquivoXmlBPe, const char* eArquivoXmlEvento);
int BPe_SalvarEventoPDF(const char* eArquivoXmlBPe, const char* eArquivoXmlEvento, const char* sResposta, long* esTamanho);