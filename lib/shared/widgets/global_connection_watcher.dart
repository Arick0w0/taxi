import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/connectivity_service.dart';
import '../../core/router/app_router.dart';

class GlobalConnectionWatcher extends ConsumerStatefulWidget {
  final Widget child;

  const GlobalConnectionWatcher({super.key, required this.child});

  @override
  ConsumerState<GlobalConnectionWatcher> createState() =>
      _GlobalConnectionWatcherState();
}

class _GlobalConnectionWatcherState
    extends ConsumerState<GlobalConnectionWatcher> {
  bool _isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ConnectivityStatus>>(connectivityStatusProvider, (
      previous,
      next,
    ) {
      debugPrint('👀 Watcher received: ${next.value}');
      if (next.value == ConnectivityStatus.isDisconnected) {
        if (!_isDialogOpen) {
          debugPrint('🚨 Opening No Internet Dialog');
          _isDialogOpen = true;

          final context = rootNavigatorKey.currentContext;
          if (context == null) return;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              onWillPop: () async => false, // Prevent back button closing
              child: AlertDialog(
                title: const Text('No Internet Connection'),
                content: const Text(
                  'Please check your network settings and try again.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      debugPrint('🔄 Retry button pressed');
                      ref.read(connectivityServiceProvider).refreshConnection();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ).then((_) {
            // Handle if dialog is closed by other means (shouldn't happen with barrier false)
            _isDialogOpen = false;
          });
        }
      } else if (next.value == ConnectivityStatus.isConnected &&
          _isDialogOpen) {
        debugPrint('✅ Connected - Closing Dialog');
        // Close the dialog programmatically
        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        _isDialogOpen = false;
      }
    });

    return widget.child;
  }
}
