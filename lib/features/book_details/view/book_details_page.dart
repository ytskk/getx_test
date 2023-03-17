import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_books_api/google_books_api.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({
    super.key,
    required this.bookId,
    this.book,
  });

  final String bookId;
  final GoogleBookModel? book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'book_image_${book?.id}',
                  createRectTween: (begin, end) {
                    return RectTween(
                      begin: begin,
                      end: end,
                    );
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        book?.imageUrl ?? '',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book?.title ?? '',
                        style: theme.textTheme.titleLarge,
                      ),
                      if (book?.authors != null)
                        Text(
                          book?.authors!.join(', ') ?? '',
                          style: theme.textTheme.titleMedium,
                        ),
                      const SizedBox(height: 16),
                      CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(1000),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        minSize: null,
                        child: Text(
                          'Get',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
