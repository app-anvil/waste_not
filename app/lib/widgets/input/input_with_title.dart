import 'package:app/styles/styles.dart';
import 'package:common_components/common_components.dart';
import 'package:flutter/widgets.dart';

class InputWithTitle extends StatelessWidget {
  const InputWithTitle({
    required this.title,
    required this.input,
    required this.isSmall,
    super.key,
  });

  final String title;

  final Widget input;

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: context.tt.labelSmall?.copyWith(
            color: context.col.onBackground,
          ),
        ),
        VSpan($styles.insets.xxs),
        input,
      ],
    );
  }
}
