import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/models/app_table_schema.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/models/database_health_status.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/services/supabase_database_service.dart';

class SupabaseHealthScreen extends StatefulWidget {
  const SupabaseHealthScreen({super.key});

  @override
  State<SupabaseHealthScreen> createState() => _SupabaseHealthScreenState();
}

class _SupabaseHealthScreenState extends State<SupabaseHealthScreen> {
  late final Future<DatabaseHealthStatus> _statusFuture;

  @override
  void initState() {
    super.initState();
    _statusFuture = SupabaseDatabaseService().checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Kanpur Setup')),
      body: FutureBuilder<DatabaseHealthStatus>(
        future: _statusFuture,
        builder: (context, snapshot) {
          final status = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatusPanel(
                loading: snapshot.connectionState != ConnectionState.done,
                status: status,
              ),
              const SizedBox(height: 16),
              Text(
                'Supabase Tables',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              for (final table in appTableSchemas)
                Card(
                  child: ListTile(
                    title: Text(table.name),
                    subtitle: Text('${table.module}\n${table.purpose}'),
                    trailing: Text('${table.fields.length} fields'),
                    isThreeLine: true,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({required this.loading, required this.status});

  final bool loading;
  final DatabaseHealthStatus? status;

  @override
  Widget build(BuildContext context) {
    final ready = status?.isReady ?? false;

    return Card(
      color: loading
          ? null
          : ready
          ? Colors.green.shade50
          : Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loading
                  ? 'Checking Supabase connection...'
                  : ready
                  ? 'Supabase ready'
                  : 'Supabase needs attention',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(status?.message ?? 'Please wait.'),
          ],
        ),
      ),
    );
  }
}
