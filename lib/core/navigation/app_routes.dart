import 'package:getx_test/core/navigation/navigation.dart';
import 'package:getx_test/features/features.dart';
import 'package:go_router/go_router.dart';

final routes = [
  GoRoute(
    name: AppRouteNames.home.name,
    path: AppRouteNames.home.path,
    builder: (_, __) => const HomePage(),
  ),
  GoRoute(
      name: AppRouteNames.settings.name,
      path: AppRouteNames.settings.path,
      builder: (_, __) => const SettingsPage(),
      routes: [
        GoRoute(
          name: AppRouteNames.appearance.name,
          path: AppRouteNames.appearance.npath,
          builder: (_, __) => AppearancePage(),
        ),
      ]),
];
