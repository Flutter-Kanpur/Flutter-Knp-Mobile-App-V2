import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseRepository {
  SupabaseRepository({required this.tableName, SupabaseClient? client})
    : client = client ?? Supabase.instance.client;

  final String tableName;
  final SupabaseClient client;

  SupabaseQueryBuilder get table => client.from(tableName);

  Future<List<Map<String, dynamic>>> fetchAll({
    String columns = '*',
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await table
        .select(columns)
        .range(offset, offset + limit - 1);
    return response.map(Map<String, dynamic>.from).toList();
  }

  Future<Map<String, dynamic>?> fetchById(
    Object id, {
    String idColumn = 'id',
    String columns = '*',
  }) async {
    return table.select(columns).eq(idColumn, id).maybeSingle();
  }

  Future<Map<String, dynamic>> insert(Map<String, dynamic> values) async {
    return table.insert(values).select().single();
  }

  Future<Map<String, dynamic>> updateById(
    Object id,
    Map<String, dynamic> values, {
    String idColumn = 'id',
  }) async {
    return table.update(values).eq(idColumn, id).select().single();
  }

  Future<void> softDeleteById(Object id) async {
    await table.update({'is_deleted': true}).eq('id', id);
  }
}
