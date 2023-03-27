import 'package:flutter/material.dart';
import 'package:getx_test/shared/shared.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.bookId,
    required this.title,
    this.authors,
    this.imageUrl,
    required this.onTap,
  });

  final String bookId;
  final String title;
  final String? authors;
  final String? imageUrl;
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
              child: NetworkImageBox(
                imageUrl: imageUrl,
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
