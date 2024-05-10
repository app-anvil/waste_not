import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../features.dart';

class ExpiredItemsCard extends StatelessWidget {
  const ExpiredItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OverviewCard(
      indicatorColor: const Color(0xffec5c54),
      label: context.l10n.expired,
      count: context
          .watch<InventoryCubit>()
          .state
          .items
          .where((element) => ItemStatus.fromItem(element).isExpired)
          .length,
      onTap: () => InventoryByStatusPage.push(
        context,
        filter: ItemStatus.expired,
        cubit: context.read<InventoryCubit>(),
      ),
    );
  }
}
