import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:google_books_api/google_books_api.dart';

class AuthorDetailsController extends GetxController {
  AuthorDetailsController({
    required GoogleBooksApiInterface apiInterface,
  }) : _apiInterface = apiInterface;

  final GoogleBooksApiInterface _apiInterface;

  // definitions.

  final Rx<LoadableData<List<GoogleBookModel>>> _books =
      const LoadableData<List<GoogleBookModel>>().obs;

  // getters.

  LoadableData get loadable => _books.value;
  List<GoogleBookModel> get books => _books.value.data ?? [];
  LoadingStatus get status => _books.value.status;

  // methods.

  Future<void> getAuthorBooks(String authorName) async {
    _books.value = _books.value.loading();

    final List<GoogleBookModel> books =
        await _apiInterface.getAuthorBooks(authorName);

    _books.value = _books.value.loaded(books);
  }
}
