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

int BPe_Inicializar(const uintptr_t* libHandle, const char* eArqConfig, const char* eChaveCrypt);
int BPe_ConfigLer(const uintptr_t libHandle, const char* eArqConfig);
int BPe_ConfigLerValor(const uintptr_t libHandle, const char* eSessao, char* eChave, char* sValor, long* esTamanho);
int BPe_ConfigGravarValor(const uintptr_t libHandle, const char* eSessao, const char* eChave, const char* eValor);
int BPe_UltimoRetorno(const uintptr_t libHandle, char* sMensagem, long* esTamanho);
int BPe_Finalizar(const uintptr_t libHandle);
int BPe_Nome(const uintptr_t libHandle, const char* sNome, long* esTamanho);
int BPe_Versao(const uintptr_t libHandle, const char* sVersao, long* esTamanho);
int BPe_OpenSSLInfo(const uintptr_t libHandle, const char* sOpenSSLInfo, long* esTamanho);
int BPe_ConfigImportar(const uintptr_t libHandle, const char* eArqConfig);
int BPe_ConfigExportar(const uintptr_t libHandle, const char* sMensagem, long* esTamanho);
int BPe_ConfigGravar(const uintptr_t libHandle, const char* eArqConfig);

int BPe_ObterCertificados(const uintptr_t libHandle, const char* sResposta, long* esTamanho);
int BPe_StatusServico(const uintptr_t libHandle, char* sMensagem, long* esTamanho);
int BPe_CarregarXML(const uintptr_t libHandle, const char* eArquivoOuXML);
int BPe_CarregarINI(const uintptr_t libHandle, const char* eArquivoOuINI);
int BPe_ObterXml(const uintptr_t libHandle, int AIndex, const char* sResposta, long* esTamanho);
int BPe_GravarXml(const uintptr_t libHandle, int AIndex, const char* eNomeArquivo, const char* ePathArquivo);
int BPe_ObterIni(const uintptr_t libHandle, int AIndex, const char* sResposta, long* esTamanho);
int BPe_GravarIni(const uintptr_t libHandle, int AIndex, const char* eNomeArquivo, const char* ePathArquivo);
int BPe_CarregarEventoXML(const uintptr_t libHandle, const char* eArquivoOuXML);
int BPe_CarregarEventoINI(const uintptr_t libHandle, const char* eArquivoOuINI);
int BPe_LimparLista(const uintptr_t libHandle);
int BPe_LimparListaEventos(const uintptr_t libHandle);
int BPe_Assinar(const uintptr_t libHandle);
int BPe_Validar(const uintptr_t libHandle);
int BPe_ValidarRegrasdeNegocios(const uintptr_t libHandle, const char* sResposta, long* esTamanho);
int BPe_VerificarAssinatura(const uintptr_t libHandle, const char* sResposta, long* esTamanho);
int BPe_GetPath(const uintptr_t libHandle, int ATipo, const char* sResposta, long* esTamanho);
int BPe_GetPathEvento(const uintptr_t libHandle, const char* ACodEvento, const char* sResposta, long* esTamanho);
int BPe_Enviar(const uintptr_t libHandle, long AImprimir, const char* sResposta, long* esTamanho);
int BPe_Consultar(const uintptr_t libHandle, const char* eChaveOuBPe, long AExtrairEventos, const char* sResposta, long* esTamanho);
int BPe_Cancelar(const uintptr_t libHandle, const char* eChave, const char* eJustificativa, const char* eCNPJCPF, int ALote, const char* sResposta, long* esTamanho);
int BPe_EnviarEvento(const uintptr_t libHandle, int idLote, const char* sResposta, long* esTamanho);
int BPe_EnviarEmail(const uintptr_t libHandle, const char* ePara, const char* eXmlBPe, long AEnviaPDF, const char* eAssunto, const char* eCC, const char* eAnexos, const char* eMensagem);
int BPe_EnviarEmailEvento(const uintptr_t libHandle, const char* ePara, const char* eXmlEvento, const char* eXmlBPe, long AEnviaPDF, const char* eAssunto, const char* eCC, const char* eAnexos, const char* eMensagem);
int BPe_Imprimir(const uintptr_t libHandle, const char* cImpressora, int nNumCopias, long bMostrarPreview);
int BPe_ImprimirPDF(const uintptr_t libHandle);
int BPe_SalvarPDF(const uintptr_t libHandle, const char* sResposta, long* esTamanho);
int BPe_ImprimirEvento(const uintptr_t libHandle, const char* eArquivoXmlBPe, const char* eArquivoXmlEvento);
int BPe_ImprimirEventoPDF(const uintptr_t libHandle, const char* eArquivoXmlBPe, const char* eArquivoXmlEvento);
int BPe_SalvarEventoPDF(const uintptr_t libHandle, const char* eArquivoXmlBPe, const char* eArquivoXmlEvento, const char* sResposta, long* esTamanho);