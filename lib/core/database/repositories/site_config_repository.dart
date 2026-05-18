import 'package:flutter_knp_mobile_app_v2/core/database/database_tables.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/repositories/supabase_repository.dart';

class SiteConfigRepository extends SupabaseRepository {
  SiteConfigRepository({super.client})
    : super(tableName: DatabaseTables.siteConfig);

  Future<Map<String, dynamic>?> fetchSchemaVersion() {
    return table
        .select('config_key, config_type, json_payload, updated_at')
        .eq('config_key', 'app_schema_version')
        .maybeSingle();
  }
}
