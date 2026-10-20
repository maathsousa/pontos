-- Cole este arquivo no SQL Editor do projeto Supabase e execute.
create table if not exists public.work_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  start_time time not null default '09:00',
  end_time time not null default '18:00',
  lunch_minutes integer not null default 60 check (lunch_minutes >= 0),
  weekly_hours numeric(5,2) not null default 40 check (weekly_hours >= 0),
  updated_at timestamptz not null default now()
);

create table if not exists public.punches (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  work_date date not null,
  kind text not null check (kind in ('entrada','almoco_saida','almoco_volta','saida')),
  punched_at timestamptz not null,
  source text not null default 'automatico' check (source in ('automatico','manual')),
  latitude double precision,
  longitude double precision,
  accuracy_m integer,
  note text,
  created_at timestamptz not null default now(),
  unique (user_id, work_date, kind)
);

alter table public.work_settings enable row level security;
alter table public.punches enable row level security;

drop policy if exists "settings are private to owner" on public.work_settings;
create policy "settings are private to owner" on public.work_settings
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "punches are private to owner" on public.punches;
create policy "punches are private to owner" on public.punches
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
