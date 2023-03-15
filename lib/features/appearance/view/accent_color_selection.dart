import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_test/core/core.dart';
import 'package:getx_test/features/features.dart';

class AccentColorSelection extends StatelessWidget {
  AccentColorSelection({super.key});

  final appearanceController = AppearanceController.to;

  @override
  Widget build(BuildContext context) {
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
