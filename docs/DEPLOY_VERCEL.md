# Deploy Vercel - beta inicial

Este projeto agora possui uma configuracao minima para gerar um link publico na Vercel. O arquivo `app.py` e um entrypoint fino que expoe o mesmo FastAPI `app` definido em `main.py`.

Observacao: nao declare `runtime: "python3.12"` em `vercel.json`. A Vercel detecta o runtime Python pelo entrypoint e pelo `requirements.txt`; a versao desejada fica indicada em `.python-version`.

## O que deve funcionar no link

- Interface principal servida por `GET /`.
- Arquivos estaticos em `/static/*`.
- Rotas HTTP em `/api/*`.
- Documentacao OpenAPI em `/docs`.
- Healthcheck em `/api/health`.

## Limitacoes importantes

- WebSockets (`/ws/*`) nao sao adequados para Vercel Functions. Para chat, foco colaborativo, lousa e presenca online em producao, use Supabase Realtime, Ably, Pusher, Liveblocks ou um backend persistente fora da Vercel.
- Dados em `data/*.json` ficam locais no desenvolvimento. Em Vercel, `backend/settings.py` usa `/tmp/lorac-data`, que e efemero. Para beta real com usuarios, conecte um banco externo.
- IA e LiveKit sao opcionais. Configure variaveis de ambiente antes de prometer esses recursos aos testadores.

## Passo a passo

1. Suba esta pasta para um repositorio Git.
2. Na Vercel, crie um projeto apontando para a pasta que contem `app.py`, `main.py`, `requirements.txt` e `vercel.json`.
3. Build command: deixe vazio ou use o padrao da Vercel para Python.
4. Output directory: deixe vazio.
5. Variaveis recomendadas:
   - `LORAC_ENV=vercel`
   - `LORAC_CORS_ORIGINS=*`
   - `COHERE_API_KEY=` se IA for habilitada
   - `LIVEKIT_URL=`, `LIVEKIT_API_KEY=`, `LIVEKIT_API_SECRET=` se chamadas forem habilitadas
6. Depois do deploy, teste:
   - `/`
   - `/api/health`
   - `/docs`

## Proxima decisao arquitetural

Se Vercel for a plataforma final, a proxima etapa tecnica deve ser:

1. Trocar persistencia JSON por Supabase/Postgres.
2. Trocar WebSocket interno por realtime externo.
3. Manter Vercel como camada de UI + APIs HTTP.

Se o objetivo for validar todos os recursos atuais sem refatorar realtime agora, Render/Railway/Fly.io continuam sendo o caminho mais direto.
