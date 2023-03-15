import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = LocalStorageController.to.themeModeObs;

    return Obx(
      () => MaterialApp.router(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: themeMode.value,
        routerConfig: router,
      ),
    );
  }
}
