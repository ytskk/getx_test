import 'package:dio/dio.dart';
import 'package:google_books_api/src/src.dart';

class GoogleBooksApi implements GoogleBooksApiInterface {
  const GoogleBooksApi({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<GoogleBookModel>> searchBooks(String query) async {
    final response = await _dio.get(
      'https://www.googleapis.com/books/v1/volumes',
      queryParameters: {
        'q': query,
        'langRestrict': 'en',
        'maxResults': 40,
      },
    );

    final items = response.data['items'] as List<dynamic>?;

    if (items == null) {
      return [];
    }

    return items
        .map((e) => GoogleBookModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<GoogleBookModel>> getAuthorBooks(String author) async {
    final query = 'inauthor:$author';

    final items = await searchBooks(query);

    return items;
  }

  @override
  Future<GoogleBookModel> getBookById(String id) async {
    final response = await _dio.get(
      'https://www.googleapis.com/books/v1/volumes/$id',
    );

    final item = response.data as Map<String, dynamic>;

    return GoogleBookModel.fromJson(item);
  }
}
