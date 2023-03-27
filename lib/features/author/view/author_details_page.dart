import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:getx_test/features/features.dart';
import 'package:getx_test/shared/shared.dart';
import 'package:go_router/go_router.dart';
import 'package:google_books_api/google_books_api.dart';

class AuthorDetailsPage extends StatefulWidget {
  const AuthorDetailsPage({
    super.key,
    required this.authorName,
  });

  final String authorName;

  @override
  State<AuthorDetailsPage> createState() => _AuthorDetailsPageState();
}

class _AuthorDetailsPageState extends State<AuthorDetailsPage> {
  final AuthorDetailsController _controller = Get.put(
    AuthorDetailsController(
      apiInterface: Get.find(),
    ),
  );

  @override
  void initState() {
    super.initState();

    _controller.getAuthorBooks(widget.authorName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            title: Text(widget.authorName),
          ),
        ],
        body: Obx(
          () => _controller.loadable.when(
            initial: () => const Center(
              child: Text('Initial'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (data) => CardsMasonryGridView(
              itemCount: data.length,
              crossAxisSpacing: 6,
              mainAxisSpacing: 16,
              itemBuilder: bookCardsBuilder(
                data,
                onTap: _onBookTap,
              ),
            ),
            error: (Object error) => Center(
              child: Text(error.toString()),
            ),
          ),
        ),
      ),
    );
  }

  void _onBookTap(BuildContext context, GoogleBookModel book) {
    return context.pushNamed(
      AppRouteNames.book.name,
      params: {
        'name': book.linkName,
      },
      extra: book,
    );
  }
}
