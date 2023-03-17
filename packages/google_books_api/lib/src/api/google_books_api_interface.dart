import 'package:google_books_api/google_books_api.dart';

abstract class GoogleBooksApiInterface {
  Future<List<GoogleBookModel>> searchBooks(
    String query, {
    String? author,
    String? isbn,
  });
}
