import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../routes/app_route.dart';
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
          .where((element) => element.status.isExpired)
          .length,
      onTap: () {
        final routeName = AppRoute.inventoryFilteredBy.name;
        final filter = ItemStatus.expired.name;
        context.router.goNamed(
          routeName,
          queryParameters: {'filter': filter},
          extra: context.read<InventoryCubit>(),
        );
      },
    );
  }
}
