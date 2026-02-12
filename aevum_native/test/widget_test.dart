import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
    await tester.pumpWidget(
      const MaterialApp(home: IntroPageScreen(skipTimer: true)),
    );

    // Verify logo and text exist
    expect(find.byIcon(Icons.history_edu), findsOneWidget);
    expect(find.text("Aevum"), findsOneWidget);
  });
}
