import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../routes/app_route.dart';
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
          .where((element) => element.status.isToBeEaten)
          .length,
      onTap: () {
        final routeName = AppRoute.inventoryFilteredBy.name;
        final filter = ItemStatus.toBeEaten.name;
        context.router.goNamed(
          routeName,
          queryParameters: {'filter': filter},
          extra: context.read<InventoryCubit>(),
        );
      },
    );
  }
}
