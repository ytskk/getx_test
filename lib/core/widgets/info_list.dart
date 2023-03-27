import 'package:flutter/material.dart';
import '../utils/utils.dart';

import 'constrained_content_box.dart';

class InfoList extends StatelessWidget {
  /// Creates an information list with [title] and [description].
  ///
  /// Both texts are centered.
  ///
  /// Typically used to display information about the current page or state.
  const InfoList({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.titleStyle,
  });

  final Widget? icon;
  final String title;
  final TextStyle? titleStyle;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedContentBox(
      child: Column(
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: theme.colorScheme.primary,
                size: 80,
              ),
              child: icon!,
            ),
            const SizedBox(height: 24),
          ],
          Text(
            title,
            style: theme.textTheme.displaySmall?.bold,
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(
              height: 8,
            ),
            Text(
              description!,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
