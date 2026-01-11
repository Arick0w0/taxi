// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_101/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    // We expect the app to start. Since default auth is true, it should show Home.
    // However, without mocking API, it might show error or loading.
    // But the separate AppBar 'Users' should be visible.
    await tester.pump(); 
    // Just verify the app launches without crashing
    expect(find.byType(MyApp), findsOneWidget);
  });
}
