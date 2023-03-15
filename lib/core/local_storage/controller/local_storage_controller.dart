import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';

class LocalStorageController extends GetxController {
  static LocalStorageController get to => Get.find();

  LocalStorageController({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  late final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();

    _themeMode.value = _loadThemeMode();
    ever(
      _themeMode,
      (themeMode) {
        _saveThemeMode(themeMode);
      },
    );
  }

  // getters.

  /// Get theme mode observable.
  get themeModeObs => _themeMode;

  /// Get theme mode value.
  ThemeMode get themeMode => _themeMode.value;

  // setters.

  /// Set new theme mode value to observable.
  void setThemeMode(ThemeMode themeMode) {
    _themeMode.value = themeMode;
  }

  /// Save the theme mode to local storage.
  void _saveThemeMode(ThemeMode themeMode) {
    _localStorageService.setInt(
        LocalStorageKeys.themeMode.name, themeMode.index);
  }

  /// Load the theme mode from local storage.
  ThemeMode _loadThemeMode() {
    final themeModeIndex =
        _localStorageService.getInt(LocalStorageKeys.themeMode.name);

    return ThemeMode.values[themeModeIndex];
  }
}
