-- UNIQUETUNES 12 — 마지막 앵콜 : 댓글·방명록 테이블
-- Supabase 대시보드 > SQL Editor 에 통째로 붙여넣고 Run

create table if not exists public.comments (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  work_id     text not null check (char_length(work_id) between 1 and 40),
  nick        text not null check (char_length(nick) between 1 and 12),
  color       text not null default '#f1e9df' check (color ~ '^#[0-9a-fA-F]{6}$'),
  body        text not null check (char_length(body) between 1 and 600),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  unique (user_id, work_id)          -- 관객 한 명당 작품마다 댓글 하나 (고쳐 쓰기 가능)
);

alter table public.comments enable row level security;

-- 누구나 읽기
create policy "comments_read" on public.comments
  for select to anon, authenticated using (true);

-- 자기 댓글만 쓰기·고치기·지우기 (익명 로그인 관객 포함)
create policy "comments_insert_own" on public.comments
  for insert to authenticated with check (user_id = auth.uid());
create policy "comments_update_own" on public.comments
  for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "comments_delete_own" on public.comments
  for delete to authenticated using (user_id = auth.uid());

-- 새 댓글이 다른 관객 화면에도 바로 뜨도록
alter publication supabase_realtime add table public.comments;
