import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../aev_sdk.dart';

class DateInput extends StatelessWidget {
  const DateInput({
    required this.initialDate,
    required this.onChanged,
    required this.hintText,
    this.inputDecoration,
    this.validator,
    super.key,
  });

  final DateTime? initialDate;
  final String? Function(DateTime?)? validator;

  final void Function(DateTime) onChanged;
  final InputDecoration? inputDecoration;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: validator,
      initialValue: initialDate,
      builder: (state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (initialDate == null) {
              final now = DateTime.now();
              state.didChange(now);
              onChanged(now);
            }
            DatePicker(
              context,
              onChanged: (value) {
                state.didChange(value);
                onChanged(value);
              },
              initialDateTime: initialDate,
            ).show().then((value) {
              if (value == null) return;
              state.didChange(value);
            });
          },
          child: InputDecorator(
            decoration: const InputDecoration().copyWith(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              errorText: state.errorText,
              labelText: hintText,
            ),
            child: state.value != null
                ? Text(
                    DateFormat('dd MMMM yyyy').format(state.value!),
                    style: context.tt.titleMedium,
                  )
                : const SizedBox(height: 24),
          ),
        );
      },
    );
  }
}
