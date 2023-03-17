import 'dart:developer';

import 'package:get/get.dart';
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

  final _state = HomeBooksState.initial.obs;
  final _books = <GoogleBookModel>[].obs;
  final _searchQuery = ''.obs;

  // getters.

  List<GoogleBookModel> get books => _books;

  HomeBooksState get state => _state.value;

  String get searchQuery => _searchQuery.value;
  set searchQuery(String value) => _searchQuery.value = value;

  // methods.

  Future<void> searchBooks() async {
    log(
      'Search books for query: ${_searchQuery.value}',
      name: 'HomeBooksController::searchBooks',
    );
    try {
      _state.value = HomeBooksState.loading;
      final books = await _apiInterface.searchBooks(_searchQuery.value);

      _books.assignAll(books);
      _state.value = HomeBooksState.loaded;
    } catch (e) {
      _state.value = HomeBooksState.error;
    }
  }
}

enum HomeBooksState { initial, loading, loaded, error }
