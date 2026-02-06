# 🚀 Demo ACBrLibNFe Node

[![Node.js](https://img.shields.io/badge/Node.js-22+-green.svg)](https://nodejs.org/)
[![NPM](https://img.shields.io/badge/NPM-@projetoacbr/acbrlib--nfe--node-blue.svg)](https://www.npmjs.com/package/@projetoacbr/acbrlib-nfe-node)
[![ACBrLib](https://img.shields.io/badge/ACBrLib-NFe-orange.svg)](https://acbr.sourceforge.io/)
[![License](https://img.shields.io/badge/License-LGPL--2.1-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Windows-blue.svg)](https://nodejs.org/)

> 📄 Este projeto demonstra o uso da biblioteca [`@projetoacbr/acbrlib-nfe-node`](https://www.npmjs.com/package/@projetoacbr/acbrlib-nfe-node) para emissão e gestão de Notas Fiscais Eletrônicas via Node.js.

## 🚀 Como usar

### 1️⃣ Instale as dependências

```bash
npm install
```

### 2️⃣ Prepare a estrutura de pastas projeto Typescript

```
📦 typescript/
├── 📄 package.json
├── 📄 tsconfig.json
├── 📄 .env
├── 📂 src/
│   └── 📄 index.ts
├── 📂 dist/
│   ├── 📄 index.js (compilado a partir de src/index.ts)
│   ├── 📂 lib/
│   │   └── 🔧 libacbrnfe64.so (Linux) ou ACBrNFe64.dll (Windows)
│   └── 📂 data/
│       ├── ⚙️ config/
│       │   └── 📄 acbrlib.ini
│       ├── 📂 cert/
│       │   └── 🔐 cert.pfx
│       ├── 📂 notas/
│       │   └── 📄 nota-nfe.xml
│       ├── 📂 pdf/
│       ├── 📂 log/
│       └── 📂 Schemas/
│           └── 📂 NFe/
└── 📂 node_modules/
```

> 📋 **Importante**: Para execução a partir do código compilado (`dist`), as pastas `lib/` e `data/` devem existir dentro de `dist/` (ou serem copiadas para `dist/`) pois o exemplo resolve caminhos relativos a partir do `__dirname` do arquivo compilado.

> 🔐 **Certificado**: Copie o arquivo `cert.pfx` para a pasta `dist/data/cert/` do projeto antes de executar.

### 3️⃣ Configure as credenciais

Crie um arquivo `.env` na raiz do projeto com as credenciais do certificado digital:

```env
# 🔑 Senha do certificado digital
PFX_PASSWORD=SuaSenhaDoCertificado
```

### 4️⃣ Execute o exemplo

```bash
node main.js
```

> ⚠️ **Windows**: Use biblioteca CDECL MT (64 bits)

---

## 🧭 Observações específicas para este demo em TypeScript (ESM)

Este repositório usa TypeScript compilado para um projeto ESM (module: "nodenext" e `"type": "module"` no `package.json`). Abaixo estão pontos importantes para executar e desenvolver:

- Compilação
  - Use `npm run build` para compilar o TypeScript para a pasta `dist` (o `tsconfig.json` gera `declaration` e sai em `dist`).
  - `package.json` já contém `"build": "npx tsc"` e `"start": "node dist/index.js"`.

- Importação em ESM
  - Em módulos ESM é obrigatório importar caminhos de arquivos com a extensão correta (`.js`) mesmo quando o código-fonte é `.ts`. Por isso o exemplo importa `@projetoacbr/acbrlib-nfe-node/dist/src/index.js`.
  - Como a exportação é `default`, ao instanciar a classe em runtime é necessário usar `ACBrLibNFeMT.default(...)` quando importar o pacote como módulo ESM.

- __dirname e resolução de paths
  - Em ESM `__dirname` não existe. O exemplo utiliza `fileURLToPath(import.meta.url)` para obter o diretório atual e construir caminhos absolutos (`path.resolve(__dirname, ...)`).

- Variáveis de ambiente
  - O demo usa `dotenv` para carregar `.env`. Verifique se `PFX_PASSWORD` está presente antes de executar.

- Execução (compilar + executar)
  - Para rodar produção: `npm run build` && `npm start`.


- Notas para Windows
  - Use a versão 64-bit CDECL MT da DLL e coloque as dependências (libxml2, openssl) na mesma pasta do executável do Node quando necessário.

- Erros comuns
  - "Cannot find module" ao importar: verifique se o `dist` foi gerado e se os imports ESM usam `.js` nas paths.
  - Erros de timeout ao comunicar com webservices: o projeto trata `ACBrLibTimeOutError`; ajuste timeouts e verifique conectividade.

---

<div align="center">
  <p>Feito com ❤️ pela equipe Projeto ACBr</p>
  🌐 <a href="https://projetoacbr.com.br">Projeto ACBr</a>
</div>