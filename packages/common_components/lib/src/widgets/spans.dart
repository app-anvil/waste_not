import 'package:flutter/material.dart';

/// {@template h_span}
/// {@endtemplate}
class HSpan extends StatelessWidget {
  /// {@macro h_span}
  const HSpan(this.offset, {super.key})
      : assert(offset >= 0, 'The offset must be positive');

  /// The offset of the span.
  final double offset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: offset);
  }
}

/// {@template v_span}
/// {@endtemplate}
class VSpan extends StatelessWidget {
  /// {@macro v_span}
  const VSpan(this.offset, {super.key})
      : assert(offset >= 0, 'The offset must be positive');

  /// The offset of the span.
  final double offset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: offset);
  }
}
