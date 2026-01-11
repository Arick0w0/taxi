import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { isConnected, isDisconnected, isUnknown }

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityStatus> _controller =
      StreamController<ConnectivityStatus>.broadcast();

  ConnectivityService() {
    _init();
  }

  void _init() {
    // 1. Initial Check
    _checkAndBroadcastScheduler();

    // 2. Listen to hardware changes (WiFi / Mobile toggle)
    _connectivity.onConnectivityChanged.listen((results) {
      debugPrint('🔌 Hardware Connectivity Changed: $results');
      // Pass results directly to avoid stale state from checkConnectivity()
      _checkAndBroadcastScheduler(results);
    });

    // 3. Periodic Heartbeat (Real-time Internet Check)
    Timer.periodic(const Duration(seconds: 5), (_) {
      _checkAndBroadcastScheduler();
    });
  }

  Future<void> _checkAndBroadcastScheduler([
    List<ConnectivityResult>? results,
  ]) async {
    try {
      // Use passed results if available, otherwise fetch fresh
      final effectiveResults =
          results ?? await _connectivity.checkConnectivity();

      final status = await _checkStatus(effectiveResults);
      if (!_controller.isClosed) {
        _controller.add(status);
        debugPrint('📡 Emitting Status: $status');
      }
    } catch (e) {
      debugPrint('❌ Error in Scheduler: $e');
    }
  }

  Stream<ConnectivityStatus> get connectivityStream =>
      _controller.stream.distinct();

  Future<ConnectivityStatus> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    return _checkStatus(results);
  }

  /// Manually force a connection check and update the stream
  Future<void> refreshConnection() async {
    await _checkAndBroadcastScheduler();
  }

  Future<ConnectivityStatus> _checkStatus(
    List<ConnectivityResult> results,
  ) async {
    if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet)) {
      try {
        // Ping Google DNS to verify actual internet access
        debugPrint('🌐 Pinging google.com...');
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint('✅ Ping Success');
          return ConnectivityStatus.isConnected;
        }
      } on SocketException catch (_) {
        debugPrint('⛔ Ping Failed (SocketException)');
        return ConnectivityStatus.isDisconnected;
      }
    } else {
      debugPrint('🔌 No active hardware connection');
    }
    return ConnectivityStatus.isDisconnected;
  }

  void dispose() {
    _controller.close();
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.connectivityStream;
});
