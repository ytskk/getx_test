import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:getx_test/features/features.dart';
import 'package:getx_test/shared/shared.dart';
import 'package:go_router/go_router.dart';
import 'package:google_books_api/google_books_api.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeBooksController _homeBooksController = Get.put(
    HomeBooksController(
      apiInterface: Get.find(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed(AppRouteNames.settings.name),
          ),
        ],
        title: const Text('Home'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                _homeBooksController.searchQuery = value.trim();
              }
            },
          ),
        ),
      ),
      body: Obx(
        () {
          return _homeBooksController.state.when(
            initial: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Search for books'),
                  FadingButton(
                    child: const Text('Random book'),
                    onPressed: () => context.pushNamed(
                      AppRouteNames.book.name,
                      params: {
                        'name': 'steve_jobs-walter_isaacson',
                      },
                      extra: '26ev_abfrU8C',
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            loaded: (data) => data.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
                    child: InfoList(
                      icon: Icon(Icons.error_rounded),
                      title: 'No books found',
                      description: 'Try another search query',
                    ),
                  )
                : CardsMasonryGridView(
                    itemCount: data.length,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 16,
                    itemBuilder: bookCardsBuilder(
                      data,
                      onTap: _onBookTap,
                    ),
                  ),
            error: (error) => Center(
              child: Text('Error: $error'),
            ),
          );
        },
      ),
    );
  }

  void _onBookTap(BuildContext context, GoogleBookModel book) {
    context.pushNamed(
      AppRouteNames.book.name,
      params: {
        'name': book.linkName,
      },
      extra: book,
    );
  }
}
