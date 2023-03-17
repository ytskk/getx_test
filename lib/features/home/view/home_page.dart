import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:getx_test/features/features.dart';
import 'package:go_router/go_router.dart';
import 'package:google_books_api/google_books_api.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // TODO: DI
  final HomeBooksController _homeBooksController = Get.put(
    HomeBooksController(
      apiInterface: GoogleBooksApi(
        dio: Dio(),
      ),
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
          switch (_homeBooksController.state) {
            case HomeBooksState.initial:
              return const Center(
                child: Text('Search for books'),
              );
            case HomeBooksState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeBooksState.loaded:
              return MasonryGridView.count(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 24,
                ),
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 16,
                itemCount: _homeBooksController.books.length,
                itemBuilder: (context, index) {
                  final book = _homeBooksController.books[index];
                  return BookCard(
                    bookId: book.id,
                    title: book.title,
                    authors: book.authors?.join(', '),
                    imageUrl: book.imageUrl,
                    onTap: () => _onBookTap(context, book),
                  );
                },
              );
            case HomeBooksState.error:
              return const Center(
                child: Text('Error'),
              );
          }
        },
      ),
    );
  }

  void _onBookTap(BuildContext context, GoogleBookModel book) {
    context.pushNamed(
      AppRouteNames.bookId.name,
      params: {
        'id': book.id,
      },
      extra: book,
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.bookId,
    required this.title,
    this.authors,
    required this.imageUrl,
    required this.onTap,
  });

  final String bookId;
  final String title;
  final String? authors;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'book_image_$bookId',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (authors != null)
                  Text(
                    authors!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                      color:
                          theme.textTheme.labelSmall?.color?.withOpacity(0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
