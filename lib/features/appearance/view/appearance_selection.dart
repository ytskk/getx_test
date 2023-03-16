import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/features/features.dart';

class AppearanceSelection extends StatelessWidget {
  AppearanceSelection({super.key});

  final appearanceController = AppearanceController.to;

  @override
  Widget build(BuildContext context) {
    final selectedThemeMode = appearanceController.themeModeObs;

    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: AppearanceVariantItem(
                isSelected: selectedThemeMode == ThemeMode.light,
                label: 'Light',
                icon: Icons.light_mode_rounded,
                onTap: () {
                  appearanceController.setThemeMode(ThemeMode.light);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppearanceVariantItem(
                isSelected: selectedThemeMode == ThemeMode.dark,
                label: 'Dark',
                icon: Icons.dark_mode_rounded,
                onTap: () {
                  appearanceController.setThemeMode(ThemeMode.dark);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppearanceVariantItem(
                isSelected: selectedThemeMode == ThemeMode.system,
                label: 'Auto',
                icon: Icons.app_shortcut_outlined,
                onTap: () {
                  appearanceController.setThemeMode(ThemeMode.system);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
