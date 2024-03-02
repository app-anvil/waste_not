import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';

import '../../../../features.dart';

export 'expired_items_card.dart';
export 'opened_items_card.dart';
export 'overview_card.dart';
export 'to_be_eaten_items_card.dart';

class OverviewCards extends StatelessWidget {
  const OverviewCards({super.key});

  @override
  Widget build(BuildContext context) {
    // Grid version layout
    // return SliverGrid.count(
    //   crossAxisCount: 2,
    //   mainAxisSpacing: $style.insets.sm,
    //   crossAxisSpacing: $style.insets.sm,
    //   childAspectRatio: 1.6,
    //   children: const [
    //     OpenedItemsCards(),
    //     ToBeEatenItemsCard(),
    //     ExpiredItemsCard(),
    //   ],
    // );
    return SliverMainAxisGroup(
      slivers: [
        SliverCrossAxisGroup(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(right: $style.insets.xs),
              sliver: const OpenedItemsCards().asSliver,
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: $style.insets.xs),
              sliver: const ToBeEatenItemsCard().asSliver,
            ),
          ],
        ),
        VSpan($style.insets.sm).asSliver,
        const ExpiredItemsCard().asSliver,
      ],
    );
  }
}
