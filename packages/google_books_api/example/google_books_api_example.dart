import 'package:dio/dio.dart';
import 'package:google_books_api/src/src.dart';

void main() async {
  final dio = Dio();

  final api = GoogleBooksApi(dio: dio);

  final foundedBooks = await api.searchBooks('flutter apprentice');

  print(foundedBooks.length);
}
