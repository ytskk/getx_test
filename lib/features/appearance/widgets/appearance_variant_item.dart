import 'package:flutter/material.dart';

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
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: isSelected
                  ? Border.all(
                      color: theme.colorScheme.secondary,
                      width: 4,
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Icon(
                  icon,
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: theme.textTheme.bodyMedium!.copyWith(
              color: isSelected
                  ? null
                  : theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(
              label,
            ),
          ),
        ],
      ),
    );
  }
}
