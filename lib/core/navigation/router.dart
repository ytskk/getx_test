import 'package:getx_test/core/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRouteNames.home.path,
  routes: routes,
  debugLogDiagnostics: true,
);
