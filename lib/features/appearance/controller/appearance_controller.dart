import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';

class AppearanceController extends GetxController {
  static AppearanceController to = Get.find();

  late final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  get themeModeObs => _themeMode;
  ThemeMode get themeMode => _themeMode.value;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode.value = themeMode;
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
  }
}
