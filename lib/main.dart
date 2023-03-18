import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/app.dart';
import 'package:google_books_api/google_books_api.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerServices();

  runApp(const App());
}

Future<void> registerServices() async {
  final localStorageService = Get.put(LocalStorageService());
  await localStorageService.init();

  Get.put(
    LocalStorageController(localStorageService: localStorageService),
  );

  Get.put<GoogleBooksApiInterface>(
    GoogleBooksApi(
      dio: Dio(),
    ),
  );
}
