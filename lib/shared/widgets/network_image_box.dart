import 'package:flutter/material.dart';

class NetworkImageBox extends StatelessWidget {
  const NetworkImageBox({
    super.key,
    this.imageUrl,
    this.width = defaultWidth,
    this.height = defaultHeight,
  });

  final String? imageUrl;
  final double? width;
  final double? height;

  static const double defaultWidth = 128;
  static const double defaultHeight = 200;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: defaultWidth,
        height: defaultHeight,
        fit: BoxFit.cover,
      );
    }

    final theme = Theme.of(context);

    return Container(
      width: defaultWidth,
      height: defaultHeight,
      color: theme.colorScheme.primary.withOpacity(0.1),
    );
  }
}
