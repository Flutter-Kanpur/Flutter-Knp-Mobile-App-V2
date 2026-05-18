class DatabaseHealthStatus {
  const DatabaseHealthStatus({
    required this.supabaseInitialized,
    required this.envLoaded,
    required this.tableReachable,
    required this.message,
  });

  final bool supabaseInitialized;
  final bool envLoaded;
  final bool tableReachable;
  final String message;

  bool get isReady => supabaseInitialized && envLoaded && tableReachable;
}
