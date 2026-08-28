const Set<String> publicRoutes = <String>{'/', '/auth'};

bool isAdminRoute(String path) =>
    path == '/dev-menu' || path.startsWith('/admin-');

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

  return null;
}
