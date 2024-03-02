import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../routes/app_route.dart';
import '../../../../features.dart';

class OpenedItemsCards extends StatelessWidget {
  const OpenedItemsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return OverviewCard(
      indicatorColor: Colors.blue,
      label: context.l10n.opened,
      count: context.watch<OpenedItemsCubit>().state.items.length,
      onTap: () {
        final routeName = AppRoute.inventoryFilteredBy.name;
        final filter = ItemsStatus.opened.name;
        context.router.goNamed(
          routeName,
          queryParameters: {'filter': filter},
          extra: context.read<InventoryCubit>(),
        );
      },
    );
  }
}
