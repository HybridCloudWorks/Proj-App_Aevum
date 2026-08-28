import 'package:aevum_native/services/route_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveAuthRedirect', () {
    test('allows public routes when signed out', () {
      expect(resolveAuthRedirect(path: '/', isAuthenticated: false, isAdmin: false), isNull);
      expect(resolveAuthRedirect(path: '/auth', isAuthenticated: false, isAdmin: false), isNull);
    });

    test('redirects signed-out users away from protected routes', () {
      expect(resolveAuthRedirect(path: '/dashboard', isAuthenticated: false, isAdmin: false), '/auth');
    });

    test('redirects authenticated users away from the auth screen', () {
      expect(resolveAuthRedirect(path: '/auth', isAuthenticated: true, isAdmin: false), '/dashboard');
    });

    test('blocks non-admin users from admin and dev routes', () {
      expect(resolveAuthRedirect(path: '/admin-infra', isAuthenticated: true, isAdmin: false), '/dashboard');
      expect(resolveAuthRedirect(path: '/dev-menu', isAuthenticated: true, isAdmin: false), '/dashboard');
    });

    test('allows trusted admins to admin routes', () {
      expect(resolveAuthRedirect(path: '/admin-infra', isAuthenticated: true, isAdmin: true), isNull);
    });

    test('blocks prototype routes in the default Private Beta build', () {
      expect(prototypeFeaturesEnabled, isFalse);
      expect(isPrototypeRoute('/restoration'), isTrue);
      expect(isPrototypeRoute('/discovery'), isTrue);
      expect(isPrototypeRoute('/tree'), isTrue);
      expect(resolveAuthRedirect(path: '/restoration', isAuthenticated: true, isAdmin: false), '/dashboard');
      expect(resolveAuthRedirect(path: '/tree', isAuthenticated: true, isAdmin: false), '/dashboard');
    });

    test('keeps validated core authenticated routes available', () {
      expect(isPrototypeRoute('/dashboard'), isFalse);
      expect(resolveAuthRedirect(path: '/dashboard', isAuthenticated: true, isAdmin: false), isNull);
    });
  });
}
