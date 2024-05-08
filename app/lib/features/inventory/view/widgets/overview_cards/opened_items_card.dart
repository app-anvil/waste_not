import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../features.dart';

class OpenedItemsCards extends StatelessWidget {
  const OpenedItemsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return OverviewCard(
      indicatorColor: Colors.blue,
      label: context.l10n.opened,
      count: context.watch<OpenedItemsCubit>().state.items.length,
      onTap: () => InventoryByStatusPage.push(
        context,
        filter: ItemStatus.opened,
        cubit: context.read<InventoryCubit>(),
      ),
    );
  }
}
