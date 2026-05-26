import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkConnectivityService {
  static final NetworkConnectivityService _instance =
      NetworkConnectivityService._internal();
  factory NetworkConnectivityService() => _instance;
  NetworkConnectivityService._internal();

  // Add static instance getter
  static NetworkConnectivityService get instance => _instance;

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  bool _isConnected = true;
  Timer? _connectivityTimer;

  // MARK: - Public Properties

  /// Stream of connection status changes
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  /// Current connection status
  bool get isConnected => _isConnected;

  // MARK: - Public Methods

  /// Initialize the connectivity service
  Future<void> initialize() async {
    try {
      // Check initial connectivity
      await _checkConnectivity();

      // Listen to connectivity changes
      _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);

      // Start periodic connectivity checks
      _startPeriodicChecks();

      debugPrint('Network connectivity service initialized');
    } catch (e) {
      debugPrint('Failed to initialize network connectivity service: $e');
    }
  }

  /// Check if device is currently connected to the internet
  Future<bool> checkInternetConnection() async {
    try {
      // First check basic connectivity
      final connectivityResult = await _connectivity.checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.isEmpty) {
        _updateConnectionStatus(false);
        return false;
      }

      // Then check actual internet connectivity
      final result = await InternetAddress.lookup('google.com');
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      _updateConnectionStatus(isConnected);
      return isConnected;
    } catch (e) {
      _updateConnectionStatus(false);
      return false;
    }
  }

  /// Stop the service and clean up resources
  void dispose() {
    _connectivityTimer?.cancel();
    _connectionStatusController.close();
  }

  // MARK: - Private Methods

  Future<void> _checkConnectivity() async {
    final isConnected = await checkInternetConnection();
    _updateConnectionStatus(isConnected);
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      _updateConnectionStatus(false);
    } else {
      _checkConnectivity();
    }
  }

  void _startPeriodicChecks() {
    // Check connectivity every 30 seconds
    _connectivityTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkConnectivity();
    });
  }

  void _updateConnectionStatus(bool isConnected) {
    if (_isConnected != isConnected) {
      _isConnected = isConnected;
      _connectionStatusController.add(isConnected);

      debugPrint(
        'Network status changed: ${isConnected ? 'Online' : 'Offline'}',
      );
    }
  }
}

// MARK: - Extension for easy access
extension NetworkConnectivityServiceExtension on NetworkConnectivityService {
  /// Get a singleton instance
  static NetworkConnectivityService get instance =>
      NetworkConnectivityService();
}
