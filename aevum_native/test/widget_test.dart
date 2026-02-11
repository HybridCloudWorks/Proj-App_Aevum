import 'package:flutter_test/flutter_test.dart';
import 'package:aevum_native/main.dart';

void main() {
  testWidgets('App loads screen gallery', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AevumApp());

    // Verify that the gallery title is present
    expect(find.text('Aevum Screen Gallery'), findsOneWidget);

    // Verify that sections are present
    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.text('Authentication'), findsOneWidget);
  });
}
