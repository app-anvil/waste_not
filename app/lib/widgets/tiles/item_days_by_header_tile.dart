import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';

import '../../l10n/l10n.dart';

class ItemStatusDaysHeaderTile extends StatelessWidget {
  const ItemStatusDaysHeaderTile({
    required this.date,
    required this.status,
    super.key,
  });

  final DateTime date;
  final ItemStatus status;

  Widget _buildIndicator(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      padding: const EdgeInsets.all(4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String text;
    final Color color;
    final l10n = context.l10n;
    final daysFromNow =
        DateTime.now().toDate().difference(date.toDate()).inDays;
    if (status.isOpened) {
      color = Colors.blue;
    } else if (status.isExpired) {
      color = const Color(0xffec5c54);
    } else {
      color = const Color(0xfffd8d35);
    }
    if (daysFromNow == 0) {
      if (status.isOpened) {
        text = l10n.openTodayItemHeader;
      } else if (status.isExpired) {
        // Should not be happen
        text = l10n.expiresTodayItemHeader;
      } else {
        text = l10n.toBeEatenTodayItemHeader;
      }
    } else {
      if (status.isOpened) {
        text = l10n.openedItemForDaysHeader(daysFromNow);
      } else if (status.isExpired) {
        text = l10n.expiredItemForDaysHeader(daysFromNow);
      } else {
        text = l10n.toBeEatenItemForDaysHeader(daysFromNow);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: const AppStyle().insets.xs),
      child: Row(
        children: [
          _buildIndicator(color),
          HSpan(const AppStyle().insets.xs),
          Text(text),
        ],
      ),
    );
  }
}
