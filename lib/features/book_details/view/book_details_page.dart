import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:getx_test/features/features.dart';
import 'package:go_router/go_router.dart';
import 'package:google_books_api/google_books_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

// TODO: add book controller
class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({
    super.key,
    this.bookId,
    this.book,
  });

  final String? bookId;
  final GoogleBookModel? book;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  GoogleBookModel? bookDetails;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.book != null) {
      bookDetails = widget.book;
    } else {
      _loadBookDetails();
    }
  }

  Future<void> _loadBookDetails() async {
    setState(() {
      isLoading = true;
    });

    final book =
        await Get.find<GoogleBooksApiInterface>().getBookById(widget.bookId!);

    setState(() {
      bookDetails = book;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BookDetailsList(bookDetails: bookDetails!),
    );
  }
}

class BookDetailsList extends StatelessWidget {
  const BookDetailsList({
    super.key,
    required this.bookDetails,
  });

  final GoogleBookModel bookDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // book cover
              Hero(
                tag: 'book_image_${bookDetails.id}',
                createRectTween: (begin, end) {
                  return RectTween(
                    begin: begin,
                    end: end,
                  );
                },
                child: ConstrainedBox(
                  // limit width to half of the screen.
                  constraints: BoxConstraints.loose(
                    Size.fromWidth(
                      MediaQuery.of(context).size.width / 2 - 44,
                    ),
                  ),
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
                      child: NetworkImageBox(
                        imageUrl: bookDetails.imageUrl,
                      ),
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
                      bookDetails.title,
                      style: theme.textTheme.titleLarge,
                    ),
                    if (bookDetails.authors != null)
                      FadingButton(
                        onPressed: () {
                          void _onAuthorTap(String author) {
                            context.pushNamed(
                              AppRouteNames.authorName.name,
                              params: {'name': author},
                            );
                          }

                          final authors = [...bookDetails.authors!];

                          if (authors.length == 1) {
                            return _onAuthorTap(authors.first);
                          }

                          authorSelectionModalBottomSheet(
                            context,
                            authors,
                            _onAuthorTap,
                          );
                        },
                        child: Text(
                          bookDetails.authors!.join(', '),
                          style: theme.textTheme.titleMedium,
                        ),
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
                        launchUrlString(bookDetails.infoUrl);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          indent: 16,
          thickness: 0.5,
          height: 32,
        ),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildQuickInfoItems(bookDetails),
          ),
        ),
        if (bookDetails.description != null) ...[
          const SizedBox(height: 8),
          ColoredBox(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description'.toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.transparent,
                      shadows: [
                        Shadow(
                          color: theme.textTheme.titleMedium!.color!,
                          offset: const Offset(0, -5),
                        ),
                      ],
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ExpandableText(
                    bookDetails.description!,
                    expandText: 'More',
                    linkStyle: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    style: theme.textTheme.bodyLarge,
                    animation: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<dynamic> authorSelectionModalBottomSheet(
    BuildContext context,
    List<String> authors,
    void Function(String author) onAuthorTap,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);

        return Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadingButton(
                  child: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Authors',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    primary: false,
                    itemCount: authors.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          authors[index],
                          style: theme.textTheme.bodyLarge,
                        ),
                        onTap: () {
                          onAuthorTap(authors[index]);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Builds a list of quick info items for the [book].
  ///
  /// Takes all non null info values from the [book] and creates a list of widgets.
  /// Separates all values with a divider, except the last one.
  List<Widget> _buildQuickInfoItems(GoogleBookModel book) {
    const divider = VerticalDivider(
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
    );

    Widget? ratingWidget;
    if (book.averageRating != null) {
      final rating = book.averageRating!;
      ratingWidget = BookQuickInfoItem(
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
      );
    }

    final items = <Widget>[
      if (book.averageRating != null) ratingWidget!,
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
