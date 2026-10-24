# ONG — Atividade 1

Estrutura inicial de um site de ONG para o Projeto Integrador Extensionista II.
Criado com `vp create vite`, modelo **Vanilla, JavaScript**, usando Vite+ e Express.

## Requisitos

- Node.js 26 e npm 12 (versões utilizadas neste projeto).
- Git para clonar o repositório.

Não é necessário instalar o Vite+ globalmente: os comandos npm usam a versão local.

## Como executar

Clone o repositório e entre na pasta:

```sh
git clone https://github.com/LuizFelipeOliver/mvp-ong.git
cd mvp-ong
npm install
cp .env.example .env
```

No Windows, copie `.env.example` para `.env` pelo explorador de arquivos ou use
`Copy-Item .env.example .env` no PowerShell.

No primeiro terminal, inicie a API:

```sh
npm run api
```

No segundo terminal, na mesma pasta, inicie a página:

```sh
npm run dev
```

Abra **http://localhost:5173**. A página deve mostrar **Status da API: ok** e a data
e hora retornadas pela API, apresentadas no horário local do navegador.
Mantenha os dois terminais abertos; use `Ctrl+C` para encerrar cada processo.

## Configuração e API

O `.env` define `PORT=3001`, a porta da API. Se alterar esse valor, reinicie os
dois servidores. O Vite encaminha `/api` para essa porta por meio do proxy em
`vite.config.ts`. A página usa a porta 5173 e avisa se ela já estiver ocupada.

O `.env` é ignorado pelo Git; apenas o modelo `.env.example` é publicado.
Nunca coloque senhas ou tokens em variáveis com prefixo `VITE_`: elas são públicas.

`GET http://127.0.0.1:3001/api/health` retorna, por exemplo:

```json
{
  "status": "ok",
  "timestamp": "2026-10-24T12:00:00.000Z"
}
```

A data e hora são geradas a cada consulta. Se a API estiver desligada ou retornar
uma resposta inválida, a página mostra uma mensagem de indisponibilidade.

## Verificações

```sh
npm test
npx vp check
npm run build
```

O teste verifica o status HTTP, o campo `status` e a data/hora de `/api/health`.
O build gera os arquivos estáticos em `dist/`; o proxy descrito acima é para o
servidor de desenvolvimento, não uma configuração de hospedagem em produção.

## Entrega na plataforma

1. Envie o link público: https://github.com/LuizFelipeOliver/mvp-ong.
2. Com os dois servidores rodando, abra http://localhost:5173 e tire uma captura
   **PNG ou JPG**, incluindo a **barra de endereço**, **Status da API: ok** e a
   **data e hora**. Envie a imagem junto com o link.
3. Abra o link do repositório em uma janela anônima para conferir o acesso sem login.

Não é necessário hospedar o site para esta atividade: a captura é do projeto local.
