import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class ItemDaysLeftHeaderTile extends StatelessWidget {
  const ItemDaysLeftHeaderTile({
    required this.expiredAt,
    super.key,
  });

  final DateTime expiredAt;

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
    final Color color;
    final String text;
    final l10n = context.l10n;
    if (expiredAt.toDate().isBefore(DateTime.now().toDate())) {
      text = l10n.inventoryPageItemHeaderExpired;
      color = const Color(0xffec5c54);
    } else {
      final remainingDays =
          expiredAt.toDate().difference(DateTime.now().toDate()).inDays;
      if (remainingDays == 0) {
        color = const Color(0xfffd8d35);
      } else if (remainingDays < 2) {
        color = const Color(0xfffd8d35);
      } else {
        color = const Color(0xff3f9a8e);
      }
      text = l10n.inventoryPageItemHeaderExpiredInDays(remainingDays);
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
