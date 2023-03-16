import 'package:flutter/material.dart';

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
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _ActiveIndicator(
            isSelected: isSelected,
            backgroundColor: color,
          ),
        ),
      ),
    );
  }
}

class _ActiveIndicator extends StatelessWidget {
  const _ActiveIndicator({
    required this.isSelected,
    this.backgroundColor = Colors.white,
  });

  final bool isSelected;
  final Color backgroundColor;

  static const double activeIndicatorSize = 16;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isSelected ? activeIndicatorSize : 0,
      width: isSelected ? activeIndicatorSize : 0,
      decoration: BoxDecoration(
        color: backgroundColor.computeLuminance() > 0.6
            ? Colors.black
            : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
