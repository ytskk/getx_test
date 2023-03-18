import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BookQuickInfoItem extends StatelessWidget {
  const BookQuickInfoItem({
    super.key,
    this.content,
    required this.title,
    this.bottom,
  });

  final String title;
  final Widget? content;
  final Widget? bottom;

  static const double _maxWidth = 160;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        const Size.fromWidth(_maxWidth),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.textTheme.labelLarge?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            if (content != null)
              DefaultTextStyle(
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 0.9,
                ),
                child: content!,
              ),
            if (bottom != null)
              if (bottom.runtimeType == Text)
                DefaultTextStyle(
                  style: theme.textTheme.labelLarge!,
                  textAlign: TextAlign.center,
                  child: AutoSizeText(
                    (bottom as Text).data!,
                    maxLines: 2,
                  ),
                )
              else
                DefaultTextStyle(
                  style: theme.textTheme.labelLarge!,
                  textAlign: TextAlign.center,
                  child: bottom!,
                ),
          ],
        ),
      ),
    );
  }
}
