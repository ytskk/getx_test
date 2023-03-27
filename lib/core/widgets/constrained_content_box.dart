import 'package:flutter/material.dart';

/// {@template constrained_content_box}
/// A widget that constrains its child to a maximum width.
///
/// Default constraint coefficient is [defaultConstraintCoefficient] (1.22).
/// {@endtemplate}
class ConstrainedContentBox extends StatelessWidget {
  /// {@macro constrained_content_box}
  const ConstrainedContentBox({
    super.key,
    required this.child,
    this.constraintCoefficient = defaultConstraintCoefficient,
  });

  final Widget child;
  final double constraintCoefficient;

  static const double defaultConstraintCoefficient = 1.22;

  @override
  Widget build(BuildContext context) {
    final maxContentWidth =
        MediaQuery.of(context).size.width / constraintCoefficient;

    return Center(
      child: SizedBox(
        width: maxContentWidth,
        child: child,
      ),
    );
  }
}
