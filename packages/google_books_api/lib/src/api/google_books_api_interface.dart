import 'package:google_books_api/google_books_api.dart';

abstract class GoogleBooksApiInterface {
  Future<List<GoogleBookModel>> searchBooks(String query);

  Future<GoogleBookModel> getBookById(String id);

  Future<List<GoogleBookModel>> getAuthorBooks(String author);
}
