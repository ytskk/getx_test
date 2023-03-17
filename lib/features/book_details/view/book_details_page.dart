import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_test/core/widgets/fading_button.dart';
import 'package:google_books_api/google_books_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                      FadingButton(
                        child: Text(
                          'Open in Google Books',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          launchUrlString(book?.infoUrl ?? '');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildQuickInfoItems(book!),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a list of quick info items for the [book].
  ///
  /// Takes all non null info values from the [book] and creates a list of widgets.
  /// Separates all values with a divider, except the last one.
  List<Widget> _buildQuickInfoItems(GoogleBookModel book) {
    const divider = VerticalDivider();

    final rating = book.averageRating!;
    final items = <Widget>[
      if (book.averageRating != null)
        BookQuickInfoItem(
          title: 'Rating',
          content: Text(rating.toString()),
          bottom: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < rating.toInt(); i++)
                const Icon(
                  Icons.star_rounded,
                  size: 16,
                ),
              if (rating % 1 != 0)
                const Icon(
                  Icons.star_half_rounded,
                  size: 16,
                ),
              for (int i = 0;
                  i < 5 - rating.toInt() - ((rating % 1) != 0 ? 1 : 0);
                  i++)
                const Icon(
                  Icons.star_border_rounded,
                  size: 16,
                  // color: Colors.yellow,
                ),
            ],
          ),
        ),
      if (book.pageCount != null)
        BookQuickInfoItem(
          title: 'Length',
          content: Text('${book.pageCount}'),
          bottom: const Text('Pages'),
        ),
      if (book.publishedDate != null)
        // NOTE: dumb date handling, but works ;)
        BookQuickInfoItem(
          title: 'Released',
          content: Text(book.publishedDate!.substring(0, 4)),
          bottom: book.publishedDate!.length > 4
              ? Text(book.publishedDate!.substring(5))
              : null,
        ),
      if (book.publisher != null)
        BookQuickInfoItem(
          title: 'Publisher info',
          bottom: Text(book.publisher ?? ''),
        ),
    ];

    final wrappedItems = <Widget>[];

    for (Widget element in items.take(items.length - 1)) {
      wrappedItems.addAll([
        element,
        divider,
      ]);
    }

    wrappedItems.add(items.last);

    return wrappedItems;
  }
}

class BookQuickInfoItem extends StatelessWidget {
  const BookQuickInfoItem({
    super.key,
    this.content,
    required this.title,
    this.bottom,
  });

  final String title;
  final Widget? content;
  final Widget? bottom;

  static const double _maxWidth = 160;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        const Size.fromWidth(_maxWidth),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.textTheme.labelLarge?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            if (content != null)
              DefaultTextStyle(
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 0.9,
                ),
                child: content!,
              ),
            if (bottom != null)
              if (bottom.runtimeType == Text)
                DefaultTextStyle(
                  style: theme.textTheme.labelLarge!,
                  textAlign: TextAlign.center,
                  child: AutoSizeText(
                    (bottom as Text).data!,
                    maxLines: 2,
                  ),
                )
              else
                DefaultTextStyle(
                  style: theme.textTheme.labelLarge!,
                  textAlign: TextAlign.center,
                  child: bottom!,
                ),
          ],
        ),
      ),
    );
  }
}
