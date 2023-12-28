import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../l10n/l10n.dart';
import '../../../routes/app_route.dart';
import '../../features.dart';

// class InventorySliverAppBar extends StatelessWidget {
//   const InventorySliverAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar.large(
//       title: Text(
//         context.l10n.inventoryAppBarTitle,
//         style: const TextStyle().copyWith(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

class InventoryFAB extends StatelessWidget {
  const InventoryFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.router.goNamed(AppRoute.scanner.name),
      child: const Icon(Icons.add_rounded),
    );
  }
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoragesCubit(StoragesRepository.I)..onFetch(),
        ),
        BlocProvider(
          create: (context) => InventoryCubit(ItemsRepository.I)..onFetch(),
        ),
        BlocProvider(create: (context) => FilterItemsCubit()),
      ],
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(
            context.l10n.inventoryAppBarTitle,
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: $style.insets.screenH,
          ),
          sliver: const StorageSection().asSliver,
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            right: $style.insets.screenH,
            left: $style.insets.screenH,
            bottom: 70,
          ),
          sliver: const ItemsSection(),
        ),
      ],
    );
  }
}
