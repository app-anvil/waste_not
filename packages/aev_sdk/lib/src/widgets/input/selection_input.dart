import 'package:flutter/material.dart';

import '../../../aev_sdk.dart';

class SelectionInput<T extends Selectable> extends StatelessWidget {
  const SelectionInput({
    required this.hintText,
    required this.options,
    this.initialValue,
    this.onPicked,
    this.validator,
    super.key,
  });

  final String hintText;
  final T? initialValue;
  final String? Function(T?)? validator;
  final void Function(T?)? onPicked;

  final List<T> options;

  // decorations

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      initialValue: initialValue,
      builder: (state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            SelectionPicker(context, options: options).push().then(
              (value) {
                if (value == null) return;
                state.didChange(value);
                if (value != initialValue) {
                  onPicked?.call(value);
                }
              },
            );
          },
          child: InputDecorator(
            decoration: const InputDecoration().copyWith(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              errorText: state.errorText,
              labelText: hintText,
            ),
            child: state.value != null
                ? Text(
                    state.value!.value,
                    style: context.tt.titleMedium,
                  )
                : const SizedBox(height: 24),
          ),
        );
      },
    );
  }
}
