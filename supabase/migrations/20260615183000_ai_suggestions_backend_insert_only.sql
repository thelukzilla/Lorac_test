-- Lorac beta: ajuste de RLS para sugestoes de correcao por IA.
-- A sugestao deve ser criada pelo backend/Edge Function com a chave service_role.
-- Como service_role ignora RLS, nao criamos INSERT para authenticated/frontend.

alter table public.ai_correction_suggestions enable row level security;

-- Remove a policy antiga caso ela tenha sido aplicada durante a modelagem.
-- Sem policy de INSERT, professores autenticados nao conseguem gravar sugestoes
-- direto pelo navegador; eles apenas pedem a sugestao para o backend.
drop policy if exists "ai_suggestions_insert_teacher_only"
on public.ai_correction_suggestions;

-- Intencionalmente nao ha policy de INSERT para usuarios autenticados.
-- As policies de SELECT/UPDATE devem continuar na migration base:
-- professor ve/aprova; aluno ve apenas sugestao aprovada.
