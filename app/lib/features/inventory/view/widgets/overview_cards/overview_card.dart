import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/a2_card.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    required this.label,
    required this.count,
    required this.indicatorColor,
    required this.onTap,
    super.key,
  });

  final String label;
  final int count;
  final Color indicatorColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return A2Card(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '$count',
                style: context.tt.headlineLarge,
              ),
            ],
          ),
          VSpan($style.insets.sm),
          Text(
            label,
            style: context.tt.titleMedium,
          ),
        ],
      ),
    );
  }
}
