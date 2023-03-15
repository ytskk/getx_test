import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/features/features.dart';

class AppearancePage extends StatelessWidget {
  AppearancePage({super.key});

  final appearanceController = Get.put(AppearanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: ListView(
        children: [
          AppearanceSelection(),
          AccentColorSelection(),
        ],
      ),
    );
  }
}
