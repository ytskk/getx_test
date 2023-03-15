import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:getx_test/features/features.dart';

class AccentColorSelection extends StatelessWidget {
  AccentColorSelection({super.key});

  final appearanceController = AppearanceController.to;

  @override
  Widget build(BuildContext context) {
    final selectedAccentColor = appearanceController.accentColorObs;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ...accentColorVariants.map(
                        (color) {
                          return AccentColorItem(
                            color: color,
                            isSelected:
                                color == AppearanceController.to.accentColor,
                            onTap: () {
                              appearanceController.setAccentColor(color);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CupertinoButton(
              child: const Text('Random'),
              onPressed: () {
                appearanceController.setAccentColor(
                  accentColorVariants[
                      Random().nextInt(accentColorVariants.length)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AccentColorItem extends StatelessWidget {
  const AccentColorItem({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  static const double buttonSize = 44;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isSelected ? const _ActiveIndicator() : const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class _ActiveIndicator extends StatelessWidget {
  const _ActiveIndicator();

  static const double activeIndicatorSize = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: activeIndicatorSize,
      width: activeIndicatorSize,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
