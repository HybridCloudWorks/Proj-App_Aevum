const Set<String> publicRoutes = <String>{'/', '/auth'};

const bool prototypeFeaturesEnabled = bool.fromEnvironment(
  'AEVUM_ENABLE_PROTOTYPE_FEATURES',
  defaultValue: false,
);

const Set<String> prototypeRoutes = <String>{
  '/restoration',
  '/ai-identity',
  '/ai-chronicles',
  '/tree',
  '/identify-tree',
  '/legacy-handover',
  '/onboarding-journey',
  '/family-branches',
  '/discovery',
  '/vault-health',
  '/cloud-redundancy',
};

bool isAdminRoute(String path) =>
    path == '/dev-menu' || path.startsWith('/admin-');

bool isPrototypeRoute(String path) => prototypeRoutes.contains(path);

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

  if (isAuthenticated &&
      isPrototypeRoute(path) &&
      !prototypeFeaturesEnabled) {
    return '/dashboard';
  }

  return null;
}
