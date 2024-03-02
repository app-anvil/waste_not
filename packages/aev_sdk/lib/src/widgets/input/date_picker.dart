import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../aev_sdk.dart';

class DatePicker {
  const DatePicker(
    this.context, {
    required this.onChanged,
    this.initialDateTime,
  });

  final BuildContext context;

  final DateTime? initialDateTime;

  final void Function(DateTime) onChanged;

  Future<DateTime?> show() => showModalBottomSheet(
        context: context,
        isDismissible: true,
        useRootNavigator: true,
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor: context.col.surfaceVariant,
        builder: (ctx) {
          return SizedBox(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   color: context.col.surface,
                //   padding: EdgeInsets.all($styles.insets.sm),
                //   child: ActionButton(
                //     label: 'Salva',
                //     onTap: onConfirm,
                //   ),
                // ),
                Expanded(
                  child: CupertinoDatePicker(
                    onDateTimeChanged: onChanged,
                    mode: CupertinoDatePickerMode.date,
                    minimumDate: initialDateTime != null
                        ? null
                        : DateTime.now()
                            .subtract(const Duration(days: 1))
                            .toDate(),
                    initialDateTime: initialDateTime ?? DateTime.now(),
                    // backgroundColor: context.col.surfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      );
}
