import 'dart:async';

import 'package:aevum_native/screens/auth_screen.dart';
import 'package:aevum_native/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthClient implements AuthClient {
  int googleCalls = 0;
  int appleCalls = 0;
  int emailCalls = 0;
  int createCalls = 0;
  int resetCalls = 0;
  String? lastEmail;
  String? lastPassword;
  Object? emailError;
  Completer<UserCredential?>? emailCompleter;

  @override
  Future<UserCredential?> signInWithGoogle() async {
    googleCalls += 1;
    return null;
  }

  @override
  Future<UserCredential?> signInWithApple() async {
    appleCalls += 1;
    return null;
  }

  @override
  Future<UserCredential?> signInWithEmail(String email, String password) {
    emailCalls += 1;
    lastEmail = email;
    lastPassword = password;
    if (emailError != null) return Future<UserCredential?>.error(emailError!);
    if (emailCompleter != null) return emailCompleter!.future;
    return Future<UserCredential?>.value();
  }

  @override
  Future<UserCredential?> createAccountWithEmail(String email, String password) async {
    createCalls += 1;
    lastEmail = email;
    lastPassword = password;
    return null;
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    resetCalls += 1;
    lastEmail = email;
  }
}

Future<void> showEmailForm(WidgetTester tester, FakeAuthClient client) async {
  await tester.pumpWidget(
    MaterialApp(home: AuthScreen(authClient: client)),
  );
  await tester.tap(find.text('Continue with Email'));
  await tester.pump();
}

Future<void> enterCredentials(
  WidgetTester tester, {
  String email = 'owner@example.com',
  String password = 'password123',
}) async {
  final fields = find.byType(TextField);
  await tester.enterText(fields.at(0), email);
  await tester.enterText(fields.at(1), password);
}

void main() {
  testWidgets('unconfigured social providers are explicitly disabled', (
    tester,
  ) async {
    final client = FakeAuthClient();
    await tester.pumpWidget(
      MaterialApp(home: AuthScreen(authClient: client)),
    );

    expect(find.text('Google sign-in is not configured'), findsOneWidget);
    expect(find.text('Apple sign-in is not configured'), findsOneWidget);

    final googleButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Google sign-in is not configured'),
    );
    final appleButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Apple sign-in is not configured'),
    );
    expect(googleButton.onPressed, isNull);
    expect(appleButton.onPressed, isNull);
    expect(client.googleCalls, 0);
    expect(client.appleCalls, 0);
  });

  testWidgets('email sign-in trims email and submits to Firebase auth client', (
    tester,
  ) async {
    final client = FakeAuthClient();
    await showEmailForm(tester, client);
    await enterCredentials(tester, email: ' owner@example.com ');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(client.emailCalls, 1);
    expect(client.lastEmail, 'owner@example.com');
    expect(client.lastPassword, 'password123');
  });

  testWidgets('authentication failures are recoverable and user-visible', (
    tester,
  ) async {
    final client = FakeAuthClient()
      ..emailError = FirebaseAuthException(code: 'invalid-credential');
    await showEmailForm(tester, client);
    await enterCredentials(tester);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('The email or password is incorrect.'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);
  });

  testWidgets('loading state prevents duplicate email submissions', (
    tester,
  ) async {
    final client = FakeAuthClient()..emailCompleter = Completer<UserCredential?>();
    await showEmailForm(tester, client);
    await enterCredentials(tester);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pump();

    expect(find.text('Please wait...'), findsOneWidget);
    expect(
      tester
          .widget<ElevatedButton>(
            find.widgetWithText(ElevatedButton, 'Please wait...'),
          )
          .onPressed,
      isNull,
    );
    expect(client.emailCalls, 1);

    client.emailCompleter!.complete();
    await tester.pumpAndSettle();
  });

  testWidgets('password reset response does not enumerate accounts', (
    tester,
  ) async {
    final client = FakeAuthClient();
    await showEmailForm(tester, client);
    await tester.enterText(find.byType(TextField).first, 'owner@example.com');

    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();

    expect(client.resetCalls, 1);
    expect(
      find.text(
        'Password reset instructions were sent if the account exists.',
      ),
      findsOneWidget,
    );
  });
}
