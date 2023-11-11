import 'package:flutter/material.dart';

class WIconButton extends StatelessWidget {
  const WIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final Widget icon;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: icon,
          ),
        ),
      ),
    );
  }
}
