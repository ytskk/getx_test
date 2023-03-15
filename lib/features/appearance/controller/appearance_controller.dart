import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';

class AppearanceController extends GetxController {
  static AppearanceController to = Get.find();

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  final Rx<Color> _accentColor = Colors.blue.shade500.obs;

  get themeModeObs => _themeMode;
  ThemeMode get themeMode => _themeMode.value;

  get accentColorObs => _accentColor;
  Color get accentColor => _accentColor.value;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode.value = themeMode;
  }

  void setAccentColor(Color accentColor) {
    _accentColor.value = accentColor;
  }

  @override
  void onInit() {
    super.onInit();
    _themeMode.value = LocalStorageController.to.themeMode;
    ever(
      _themeMode,
      (themeMode) {
        LocalStorageController.to.setThemeMode(themeMode);
      },
    );

    _accentColor.value = LocalStorageController.to.accentColor;
    ever(
      _accentColor,
      (accentColor) {
        LocalStorageController.to.setAccentColor(accentColor);
      },
    );
  }
}
