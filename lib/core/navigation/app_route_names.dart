enum AppRouteNames {
  home(
    AppRoute(name: 'Home', path: '/'),
  ),
  settings(
    AppRoute(name: 'Settings', path: '/settings'),
  ),
  appearance(
    AppRoute(name: 'Appearance', path: '/appearance'),
  ),
  ;

  const AppRouteNames(AppRoute route) : _route = route;

  final AppRoute _route;

  String get name => _route.name;

  /// The path of the route with a leading slash.
  String get path => _route.path;

  /// The path of the route without a leading slash. Useful for
  /// nesting routes.
  String get npath => _route.path.replaceAll('/', '');
}

/// {@ template app_route}
/// Describes a route in the app.
///
/// Requires a [name] and a [path].
/// {@ endtemplate}
class AppRoute {
  /// {@macro app_route}
  const AppRoute({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;
}
