import 'package:getx_test/core/navigation/navigation.dart';
import 'package:getx_test/features/features.dart';
import 'package:go_router/go_router.dart';
import 'package:google_books_api/google_books_api.dart';

final routes = [
  GoRoute(
    name: AppRouteNames.home.name,
    path: AppRouteNames.home.path,
    builder: (_, __) => HomePage(),
  ),
  GoRoute(
    name: AppRouteNames.book.name,
    path: AppRouteNames.book.path,
    builder: (_, state) {
      final extra = state.extra;
      print('extra.runtimeType: ${extra.runtimeType}');

      if (extra.runtimeType == String) {
        return BookDetailsPage(
          bookId: extra as String,
        );
      }

      final GoogleBookModel? book = state.extra as GoogleBookModel?;

      return BookDetailsPage(
        book: book,
      );
    },
  ),
  GoRoute(
    name: AppRouteNames.authorName.name,
    path: AppRouteNames.authorName.path,
    builder: (_, state) {
      final authorName = state.params['name'] as String;

      return AuthorDetailsPage(authorName: authorName);
    },
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
