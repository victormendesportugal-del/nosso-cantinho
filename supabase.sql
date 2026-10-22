-- Esquema de base. Não é suficiente, sozinho, para tornar a sala privada.
create table if not exists public.room_events (
 id bigint generated always as identity primary key,
 room_code text not null check (char_length(room_code) between 4 and 40),
 kind text not null check (kind in ('message','audio','photo','memory','letter','ttt')),
 author text not null check (char_length(author) between 1 and 32),
 payload jsonb not null default '{}'::jsonb,
 created_at timestamptz not null default now()
);
alter table public.room_events enable row level security;
-- Bloqueio por omissão: só utilizadores autenticados membros da sala devem aceder.
-- Cria room_members e políticas baseadas em auth.uid() antes de habilitar o acesso.
-- NÃO uses políticas anon permissivas: qualquer pessoa poderia ler mensagens e fotos.
