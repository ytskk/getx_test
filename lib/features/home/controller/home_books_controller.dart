import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:google_books_api/google_books_api.dart';

class HomeBooksController extends GetxController {
  HomeBooksController({
    required GoogleBooksApiInterface apiInterface,
  }) : _apiInterface = apiInterface;

  final GoogleBooksApiInterface _apiInterface;

  @override
  void onInit() {
    super.onInit();
    debounce(
      _searchQuery,
      (_) => searchBooks(),
      time: const Duration(milliseconds: 450),
    );
  }

  // definitions.

  final Rx<LoadableData<List<GoogleBookModel>>> _loadableData =
      const LoadableData<List<GoogleBookModel>>().obs;

  final _searchQuery = ''.obs;

  // getters.

  LoadableData<List<GoogleBookModel>> get state => _loadableData.value;
  List<GoogleBookModel> get books => _loadableData.value.data ?? [];

  String get searchQuery => _searchQuery.value;
  set searchQuery(String value) => _searchQuery.value = value;

  // methods.

  Future<void> searchBooks() async {
    log(
      'Search books for query: ${_searchQuery.value}',
      name: 'HomeBooksController::searchBooks',
    );
    try {
      _loadableData.value = _loadableData.value.loading();
      final books = await _apiInterface.searchBooks(_searchQuery.value);

      _loadableData.value = _loadableData.value.loaded(books);
    } catch (e) {
      log(
        'Error while searching books: $e',
        name: 'HomeBooksController::searchBooks',
      );
      _loadableData.value = _loadableData.value.hasError(e);
    }
  }
}

enum HomeBooksState { initial, loading, loaded, error }
