# Arquitetura beta Lorac

## Fluxo principal

1. O navegador abre `GET /`, servido por `main.py` com `index.html`.
2. `index.html` carrega `static/css/style.css`, `static/js/app.js` e os modulos educacionais em `static/js/`.
3. O frontend usa `fetch()` para rotas REST em `/api/*` e WebSocket para `/ws/{room_id}/{user_id}`.
4. `MemoryDatabase` mantem usuarios, salas, mensagens, turmas, exercicios e progresso em memoria.
5. A cada mutacao relevante, o estado e serializado para `data/studysync_data.json`, `data/turmas.json` ou `data/global_exercises.json`.

## Contratos de dominio encontrados

- Usuarios possuem `role` (`aluno` ou `professor`), metas, flashcards e perfil.
- Salas concentram chat, foco colaborativo, lousa, pins, documentos e chamadas.
- Turmas agrupam estudantes, materias, videos, avisos e exercicios.
- Exercicios podem ser compartilhados em um banco global e importados por professores.
- Respostas de exercicio preservam tentativas, prazo e correcao manual/IA.
- Ranking e gamificacao derivam de `StudySession` e estatisticas calculadas por usuario.

## Mapa modular recomendado

Esta e a organizacao-alvo para a proxima etapa, quando a mudanca fisica for autorizada:

```text
lorac/
  main.py
  backend/
    routes/
      auth.py
      rooms.py
      progress.py
      turmas.py
      exercises.py
      realtime.py
      ai.py
    storage/
      json_store.py
    domain/
      models.py
      services.py
  static/
    css/
    js/
      core/
      modules/
      integrations/
  data/
  docs/
```

## Observacoes para novos devs

- `main.py` ainda e o arquivo de orquestracao. Evite reescrever regras de negocio durante a modularizacao; primeiro mova blocos mantendo contratos e testes manuais.
- `static/js/app.js` e o estado central do MVP. Os nomes dos eventos WebSocket sao contrato com o backend.
- `backend/database.py` e legado Excel. O fluxo vivo usa `MemoryDatabase` em `main.py`.
- Chaves de IA e LiveKit devem ficar em `.env`, nunca no codigo.

## Riscos para beta publica

- Autenticacao ainda nao usa token assinado.
- Persistencia JSON local nao e adequada para multiplos workers.
- WebSockets exigem hospedagem com processo persistente.
- Alguns scripts referenciados em `index.html` ainda nao existem nesta pasta e devem ser revisados antes de uma rodada grande de testes.
