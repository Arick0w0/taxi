import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus {
  isConnected,
  isDisconnected,
  isUnknown,
}

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityStatus> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.mobile) || 
          results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.ethernet)) {
        return ConnectivityStatus.isConnected;
      } else {
        return ConnectivityStatus.isDisconnected;
      }
    });
  }
  
  Future<ConnectivityStatus> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.mobile) || 
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet)) {
      return ConnectivityStatus.isConnected;
    } else {
      return ConnectivityStatus.isDisconnected;
    }
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.connectivityStream;
});
