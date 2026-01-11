import 'package:flutter_mvvm_101/core/constants/app_constants.dart';
import 'package:flutter_mvvm_101/core/utils/connectivity_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_101/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setUpAll(() {
    // Load mock environment variables for testing
    AppConstants.setMockEnv({
      'BASE_URL': 'https://example.com',
      'CONNECT_TIMEOUT': '5000',
      'RECEIVE_TIMEOUT': '5000',
    });
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    // We override connectivityStatusProvider to provide a dummy stream.
    // This prevents the real ConnectivityService from being created,
    // which avoids starting the Timer.periodic that causes "Pending timers" error.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectivityStatusProvider.overrideWith(
            (ref) => Stream.value(ConnectivityStatus.isConnected),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // Initial pump
    await tester.pump();

    // We don't expect much UI yet in a smoke test, but at least MyApp should be there.
    expect(find.byType(MyApp), findsOneWidget);

    // Ensure all animations/timers settle
    await tester.pumpAndSettle();
  });
}
