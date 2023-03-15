import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/features/features.dart';

class AppearanceSelection extends StatelessWidget {
  AppearanceSelection({super.key});

  final appearanceController = Get.put(AppearanceController());

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

class AppearanceVariantItem extends StatelessWidget {
  const AppearanceVariantItem({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.icon,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(
                      color: theme.colorScheme.primary,
                      width: 4,
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ColoredBox(
                  color: theme.colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Icon(
                        icon,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected
                  ? null
                  : theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
