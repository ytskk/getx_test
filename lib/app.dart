import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = LocalStorageController.to.themeModeObs;
    final primaryColor = LocalStorageController.to.accentColorObs;

    return Obx(
      () => MaterialApp.router(
        themeAnimationDuration: const Duration(milliseconds: 500),
        themeAnimationCurve: Curves.easeOut,
        theme: _buildThemeData(primaryColor.value),
        darkTheme: _buildThemeData(
          primaryColor.value,
          brightness: Brightness.dark,
        ),
        themeMode: themeMode.value,
        routerConfig: router,
      ),
    );
  }
}

ThemeData _buildThemeData(
  Color primaryColor, {
  Brightness brightness = Brightness.light,
}) {
  final colorScheme = _getColorSchemeFromSeed(
    primaryColor,
    brightness: brightness,
  );

  if (brightness == Brightness.dark) {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      colorScheme: colorScheme,
    );
  }

  return ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    colorScheme: colorScheme,
  );
}

ColorScheme _getColorSchemeFromSeed(
  Color seedColor, {
  Brightness brightness = Brightness.light,
}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );
  return colorScheme;
}
