# Supabase Setup And Migration Guide

The app does not create database tables automatically.

`supabase/schema.sql` is a local schema/migration file. It is committed so every
developer can see the backend structure, but Supabase will not read this file by
itself.

## Why It Is Manual

The Flutter app uses the public anon key from `.env`. That key must never be
allowed to create or alter tables. Table creation requires owner/admin access in
Supabase SQL Editor, Supabase CLI, or a secure backend migration workflow.

## First-Time Setup

1. Open the Supabase project dashboard.
2. Go to SQL Editor.
3. Open `supabase/schema.sql` from this repo.
4. Paste and run it once.
5. Restart the Flutter app.

After the schema is applied, the setup screen should show Supabase ready.

## Optional CLI Flow

Later we can use Supabase CLI migrations instead of manual SQL Editor work:

```powershell
supabase login
supabase link --project-ref projectid
supabase db push
```

This needs Supabase CLI installed and a logged-in Supabase account. It cannot be
done with only `SUPABASE_URL` and `SUPABASE_ANON_KEY`.

## Query/Repository Flow In Flutter

This project uses the official Supabase Flutter client, not a heavy ORM.

Shared helpers:

- `lib/core/database/database_tables.dart`
- `lib/core/database/repositories/supabase_repository.dart`
- `lib/core/database/repositories/site_config_repository.dart`

Feature developers should create repositories per module:

```text
lib/modules/events/data/event_repository.dart
lib/modules/blogs/data/blog_repository.dart
lib/modules/projects/data/project_repository.dart
```

Example:

```dart
class EventRepository extends SupabaseRepository {
  EventRepository({super.client}) : super(tableName: DatabaseTables.events);

  Future<List<Map<String, dynamic>>> fetchPublishedEvents() {
    return table
        .select()
        .eq('status', 'published')
        .eq('is_deleted', false)
        .order('start_at');
  }
}
```

Raw Supabase queries are still allowed when a feature needs joins, filters,
RPCs, or custom SQL-backed functions. Keep them inside repository classes so UI
code does not directly depend on table details.
