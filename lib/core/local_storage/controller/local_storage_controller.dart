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
  late final Rx<Color> _accentColor = Colors.blue.shade500.obs;

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

    _accentColor.value = _loadAccentColor();
    ever(
      _accentColor,
      (accentColor) {
        _saveAccentColor(accentColor);
      },
    );
  }

  // getters.

  /// Get theme mode observable.
  get themeModeObs => _themeMode;

  /// Get theme mode value.
  ThemeMode get themeMode => _themeMode.value;

  /// Get accent color observable.
  get accentColorObs => _accentColor;

  /// Get accent color value.
  Color get accentColor => _accentColor.value;

  /// Load the theme mode from local storage.
  ThemeMode _loadThemeMode() {
    final themeModeIndex =
        _localStorageService.getInt(LocalStorageKeys.themeMode.name);

    return ThemeMode.values[themeModeIndex];
  }

  /// Load the accent color from local storage.
  Color _loadAccentColor() {
    final accentColorHex = _localStorageService.getString(
      LocalStorageKeys.accentColor.name,
      defaultValue: 'ff0000ff',
    );

    return Color(int.parse(accentColorHex, radix: 16));
  }

  // setters.

  /// Set new theme mode value to observable.
  void setThemeMode(ThemeMode themeMode) {
    _themeMode.value = themeMode;
  }

  /// Set new accent color value to observable.
  void setAccentColor(Color accentColor) {
    _accentColor.value = accentColor;
  }

  /// Save the theme mode to local storage.
  void _saveThemeMode(ThemeMode themeMode) {
    _localStorageService.setInt(
        LocalStorageKeys.themeMode.name, themeMode.index);
  }

  /// Save the accent color to local storage.
  void _saveAccentColor(Color accentColor) {
    _localStorageService.setString(
        LocalStorageKeys.accentColor.name, accentColor.value.toRadixString(16));
  }
}
