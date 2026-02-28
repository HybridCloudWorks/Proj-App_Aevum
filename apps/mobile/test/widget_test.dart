import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:aevum_native/screens/intro_page_screen.dart';
import 'dart:io';

// Simple MockHttpOverrides that does nothing but allow tests to run
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  testWidgets('IntroPageScreen smoke test', (WidgetTester tester) async {
    // Test IntroPageScreen directly to avoid main app complexity
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const IntroPageScreen(),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => const Scaffold(body: Text('Auth')),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    // Verify logo and text exist initially
    expect(find.byIcon(Icons.hourglass_empty), findsOneWidget);
    expect(find.text("AEVUM"), findsOneWidget);

    // Allow the auto-redirect timer to finish so test can cleanly exit
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify it navigated
    expect(find.text('Auth'), findsOneWidget);
  });
}
