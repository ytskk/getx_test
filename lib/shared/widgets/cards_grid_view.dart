import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getx_test/shared/shared.dart';
import 'package:google_books_api/google_books_api.dart';

class CardsMasonryGridView extends StatelessWidget {
  const CardsMasonryGridView({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
  });

  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 24,
      ),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

IndexedWidgetBuilder bookCardsBuilder(
  List<GoogleBookModel> books, {
  required void Function(BuildContext context, GoogleBookModel book) onTap,
}) {
  return (context, index) {
    final book = books[index];
    return BookCard(
      bookId: book.id,
      title: book.title,
      authors: book.authors?.join(', '),
      imageUrl: book.imageUrl,
      onTap: () => onTap(context, book),
    );
  };
}
