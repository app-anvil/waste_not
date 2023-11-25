import 'package:flutter/material.dart';

/// Use this class when there is a text input, but the user cannot write
/// input, but it can select.
/// In this way, the controller is injected into the text field used inside
/// the builder. The builder can use bloc listener to change the value of the
/// controller.
class InputController extends StatefulWidget {
  const InputController({
    required this.builder,
    super.key,
    this.initialValue,
  });
  final String? initialValue;
  final Widget Function(TextEditingController) builder;

  @override
  State<InputController> createState() => _InputControllerState();
}

class _InputControllerState extends State<InputController> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller);
  }
}
