# Lorac Beta

Lorac e uma plataforma educacional web para estudos, produtividade e colaboracao em tempo real. Esta versao beta usa FastAPI para servir a interface HTML/CSS/JS e manter as APIs de salas, turmas, progresso, exercicios, ranking, IA e WebSockets.

## Rodar localmente

### Windows

```powershell
.\start.ps1
```

### macOS/Linux

```bash
./start.sh
```

### Atalho com NPM

```bash
npm run setup
npm run dev
```

Depois acesse:

- App: http://localhost:8000
- API Docs: http://localhost:8000/docs

## Variaveis de ambiente

Copie `.env.example` para `.env` se quiser habilitar integracoes externas.

- `COHERE_API_KEY`: ativa os endpoints de IA em `/api/ai/*`.
- `LIVEKIT_URL`, `LIVEKIT_API_KEY`, `LIVEKIT_API_SECRET`: ativam audio/video nas salas.
- `LORAC_CORS_ORIGINS`: origens liberadas para a API. Em beta local, `*` e suficiente.
- `PORT`: porta usada pelo servidor em deploy.

Sem essas chaves o app continua abrindo no navegador; apenas IA e chamadas ao vivo retornam erro 503 explicativo.

Para instalar tambem os pacotes opcionais de IA e LiveKit:

```bash
python -m pip install -r requirements-integrations.txt
```

## Estrutura atual

- `main.py`: servidor FastAPI, rotas principais, persistencia JSON e WebSockets.
- `backend/ai_routes.py`: endpoints de IA para chat, correcao dissertativa e geracao de questoes.
- `backend/database.py`: banco Excel legado, hoje secundario ao `MemoryDatabase` em `main.py`.
- `static/css/style.css`: design system visual.
- `static/js/app.js`: estado global e views centrais do MVP.
- `static/js/*.js`: modulos educacionais independentes carregados pelo `index.html`.
- `data/*.json`: dados locais da beta.
- `docs/`: contexto tecnico e guias de integracao.

## Modulos identificados

- Produtividade/estudos: foco, calendario, plano de estudos, flashcards e sessoes.
- Dashboard de progresso: estatisticas por usuario, ranking, metas e acompanhamento de turma.
- Kanban/tarefas: estado `tarefas` no frontend; ainda acoplado ao `app.js`.
- Gamificacao: badges, ranking, sequencia de estudos e modo duelo.
- Inteligencia artificial: correcao de dissertativas, geracao de questoes, chat historico/personagens e ferramentas educacionais.

## Deploy beta recomendado

Para gerar um link publico rapidamente, a pasta ja inclui `vercel.json` e pode ser publicada na Vercel. Esse caminho valida a UI e as rotas HTTP, mas WebSockets e persistencia duravel precisam sair para servicos externos antes de uma beta publica completa.

Veja o guia detalhado em `docs/DEPLOY_VERCEL.md`.

Para validar todos os recursos atuais sem refatorar realtime agora, Render, Railway ou Fly.io ainda sao alternativas mais diretas porque mantem um processo Python persistente.

Configuracao sugerida no Render:

- Build command: `pip install -r requirements.txt`
- Start command: `uvicorn main:app --host 0.0.0.0 --port $PORT`
- Environment: Python 3.11+ ou 3.12
- Variables: preencher `.env.example` conforme necessario

Se a beta publica precisar de IA ou chamadas ao vivo desde o primeiro deploy, troque o build command para `pip install -r requirements-integrations.txt`.

## Roadmap curto

- Separar `MemoryDatabase` de `main.py` para `backend/storage/json_store.py`.
- Dividir rotas de `main.py` em `backend/routes/auth.py`, `rooms.py`, `turmas.py`, `progress.py` e `realtime.py`.
- Migrar `static/js/app.js` em etapas, com um modulo por area de produto.
- Trocar persistencia JSON por PostgreSQL ou SQLite gerenciado antes de usuarios externos em volume.
- Adicionar autenticacao com token antes de beta publica ampla.
