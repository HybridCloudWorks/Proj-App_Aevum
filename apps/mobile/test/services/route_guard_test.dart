import 'package:aevum_native/services/route_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveAuthRedirect', () {
    test('allows public routes when signed out', () {
      expect(
        resolveAuthRedirect(
          path: '/',
          isAuthenticated: false,
          isAdmin: false,
        ),
        isNull,
      );
      expect(
        resolveAuthRedirect(
          path: '/auth',
          isAuthenticated: false,
          isAdmin: false,
        ),
        isNull,
      );
    });

    test('redirects signed-out users away from protected routes', () {
      expect(
        resolveAuthRedirect(
          path: '/dashboard',
          isAuthenticated: false,
          isAdmin: false,
        ),
        '/auth',
      );
    });

    test('redirects authenticated users away from the auth screen', () {
      expect(
        resolveAuthRedirect(
          path: '/auth',
          isAuthenticated: true,
          isAdmin: false,
        ),
        '/dashboard',
      );
    });

    test('blocks non-admin users from admin and dev routes', () {
      expect(
        resolveAuthRedirect(
          path: '/admin-infra',
          isAuthenticated: true,
          isAdmin: false,
        ),
        '/dashboard',
      );
      expect(
        resolveAuthRedirect(
          path: '/dev-menu',
          isAuthenticated: true,
          isAdmin: false,
        ),
        '/dashboard',
      );
    });

    test('keeps planned admin demo routes unavailable to trusted admins', () {
      expect(routeStatus('/admin-infra'), FeatureStatus.planned);
      expect(
        resolveAuthRedirect(
          path: '/admin-infra',
          isAuthenticated: true,
          isAdmin: true,
        ),
        '/dashboard',
      );
    });

    test('blocks mock and prototype routes in Private Beta builds', () {
      expect(prototypeFeaturesEnabled, isFalse);
      expect(routeStatus('/tree'), FeatureStatus.prototype);
      expect(routeStatus('/media-detail'), FeatureStatus.prototype);
      expect(isRouteReleased('/tree'), isFalse);
      expect(
        resolveAuthRedirect(
          path: '/tree',
          isAuthenticated: true,
          isAdmin: false,
        ),
        '/dashboard',
      );
    });

    test('keeps validated core authenticated routes available', () {
      expect(routeStatus('/dashboard'), FeatureStatus.beta);
      expect(
        resolveAuthRedirect(
          path: '/dashboard',
          isAuthenticated: true,
          isAdmin: false,
        ),
        isNull,
      );
    });

    test('defaults unclassified routes to prototype', () {
      expect(routeStatus('/new-unclassified-route'), FeatureStatus.prototype);
      expect(isRouteReleased('/new-unclassified-route'), isFalse);
    });
  });
}
