enum FeatureStatus { production, beta, prototype, planned }

const Set<String> publicRoutes = <String>{'/', '/auth'};

const bool prototypeFeaturesEnabled = bool.fromEnvironment(
  'AEVUM_ENABLE_PROTOTYPE_FEATURES',
  defaultValue: false,
);

const Map<String, FeatureStatus> routeFeatureStatus =
    <String, FeatureStatus>{
  '/': FeatureStatus.production,
  '/auth': FeatureStatus.production,
  '/dashboard': FeatureStatus.beta,
  '/profile-main': FeatureStatus.beta,
  '/memories': FeatureStatus.beta,
  '/upload': FeatureStatus.beta,
  '/invite': FeatureStatus.beta,
  '/restoration': FeatureStatus.prototype,
  '/ai-identity': FeatureStatus.prototype,
  '/ai-chronicles': FeatureStatus.prototype,
  '/tree': FeatureStatus.prototype,
  '/identify-tree': FeatureStatus.prototype,
  '/legacy-handover': FeatureStatus.prototype,
  '/onboarding-journey': FeatureStatus.prototype,
  '/family-branches': FeatureStatus.prototype,
  '/discovery': FeatureStatus.prototype,
  '/vault-health': FeatureStatus.prototype,
  '/cloud-redundancy': FeatureStatus.prototype,
  '/map': FeatureStatus.prototype,
  '/messenger': FeatureStatus.prototype,
  '/search': FeatureStatus.prototype,
  '/restricted-profile': FeatureStatus.prototype,
  '/media-detail': FeatureStatus.prototype,
  '/plant-branch': FeatureStatus.prototype,
  '/dev-menu': FeatureStatus.planned,
};

bool isAdminRoute(String path) =>
    path == '/dev-menu' || path.startsWith('/admin-');

FeatureStatus routeStatus(String path) {
  if (path.startsWith('/admin-')) return FeatureStatus.planned;
  return routeFeatureStatus[path] ?? FeatureStatus.prototype;
}

bool isPrototypeRoute(String path) =>
    routeStatus(path) == FeatureStatus.prototype;

bool isRouteReleased(String path) {
  final status = routeStatus(path);
  if (status == FeatureStatus.planned) return false;
  if (status == FeatureStatus.prototype) {
    return prototypeFeaturesEnabled;
  }
  return true;
}

String? resolveAuthRedirect({
  required String path,
  required bool isAuthenticated,
  required bool isAdmin,
}) {
  if (!isAuthenticated && !publicRoutes.contains(path)) {
    return '/auth';
  }

  if (isAuthenticated && path == '/auth') {
    return '/dashboard';
  }

  if (isAuthenticated && isAdminRoute(path) && !isAdmin) {
    return '/dashboard';
  }

  if (isAuthenticated && !isRouteReleased(path)) {
    return '/dashboard';
  }

  return null;
}
