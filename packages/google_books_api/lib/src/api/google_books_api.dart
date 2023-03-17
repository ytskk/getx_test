import 'package:dio/dio.dart';
import 'package:google_books_api/src/src.dart';

class GoogleBooksApi implements GoogleBooksApiInterface {
  const GoogleBooksApi({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<GoogleBookModel>> searchBooks(
    String query, {
    String? author,
    String? isbn,
  }) async {
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
}
