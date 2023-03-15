import 'package:flutter/material.dart';
import 'package:getx_test/features/features.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: ListView(
        children: [
          AppearanceSelection(),
        ],
      ),
    );
  }
}
