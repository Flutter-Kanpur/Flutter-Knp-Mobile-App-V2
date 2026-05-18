import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_knp_mobile_app_v2/app/environments/env.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/models/database_health_status.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/repositories/site_config_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  const SupabaseDatabaseService({SupabaseClient? client}) : _client = client;

  final SupabaseClient? _client;

  Future<DatabaseHealthStatus> checkConnection() async {
    final envLoaded =
        Env.supabaseUrl.isNotEmpty && Env.supabaseAnonKey.isNotEmpty;

    if (!dotenv.isInitialized || !envLoaded) {
      return const DatabaseHealthStatus(
        supabaseInitialized: false,
        envLoaded: false,
        tableReachable: false,
        message: 'Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env.',
      );
    }

    try {
      await SiteConfigRepository(client: _client).fetchSchemaVersion();

      return const DatabaseHealthStatus(
        supabaseInitialized: true,
        envLoaded: true,
        tableReachable: true,
        message: 'Supabase connection and schema access are working.',
      );
    } on PostgrestException catch (error) {
      return DatabaseHealthStatus(
        supabaseInitialized: true,
        envLoaded: true,
        tableReachable: false,
        message:
            'Supabase reached, but site_config check failed: ${error.message}',
      );
    } catch (error) {
      return DatabaseHealthStatus(
        supabaseInitialized: true,
        envLoaded: true,
        tableReachable: false,
        message: 'Supabase check failed: $error',
      );
    }
  }
}
