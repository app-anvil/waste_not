import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../features.dart';

class ToBeEatenItemsCard extends StatelessWidget {
  const ToBeEatenItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OverviewCard(
      indicatorColor: const Color(0xfffd8d35),
      label: context.l10n.toBeEaten,
      count: context
          .watch<InventoryCubit>()
          .state
          .items
          .where((element) => ItemStatus.fromItem(element).isToBeEaten)
          .length,
      onTap: () => InventoryByStatusPage.push(
        context,
        filter: ItemStatus.toBeEaten,
        cubit: context.read<InventoryCubit>(),
      ),
    );
  }
}
