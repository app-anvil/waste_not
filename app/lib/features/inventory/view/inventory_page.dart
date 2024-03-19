import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../l10n/l10n.dart';
import '../../../routes/app_route.dart';
import '../../features.dart';

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
          create: (context) => OpenedItemsCubit(ItemsRepository.I),
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
    final l10n = context.l10n;
    return BlocListener<InventoryCubit, InventoryState>(
      listenWhen: (previous, current) =>
          (previous.lastItemDeleted != current.lastItemDeleted &&
              current.lastItemDeleted != null) ||
          (previous.lastItemFullConsumed != current.lastItemFullConsumed &&
              current.lastItemFullConsumed != null),
      listener: (context, state) {
        if (state.lastItemDeleted != null) {
          final deletedItem = state.lastItemDeleted!;
          GetIt.I.get<MessageHelper>().showMessage(
                context,
                message: l10n.inventoryPageItemDeletedSnackbarText(
                  deletedItem.product.name!,
                ),
                type: MessageType.info,
                action: SnackBarAction(
                  label: l10n.undoAction,
                  onPressed: () {
                    GetIt.I.get<MessageHelper>().hideSnackBar(context);
                    context
                        .read<InventoryCubit>()
                        .onUndoDeletionItemRequested();
                  },
                ),
              );
        }
        if (state.lastItemFullConsumed != null) {
          final consumedItem = state.lastItemFullConsumed!;
          GetIt.I.get<MessageHelper>().showMessage(
                context,
                message: l10n.inventoryPageItemFullConsumedSnackbarText(
                  consumedItem.product.name!,
                ),
                type: MessageType.info,
                action: SnackBarAction(
                  label: l10n.undoAction,
                  onPressed: () {
                    GetIt.I.get<MessageHelper>().hideSnackBar(context);
                    context
                        .read<InventoryCubit>()
                        .onUndoFullConsumptionItemRequested();
                  },
                ),
              );
        }
      },
      child: CustomScrollView(
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
            sliver: const OverviewCards(),
          ),
          VSpan($style.insets.sm).asSliver,
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: $style.insets.screenH,
            ),
            sliver: const StorageSection().asSliver,
          ),
          BlocBuilder<FilterItemsCubit, FilterItemsState>(
            builder: (context, state) {
              if (state.selectedStorage != null) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: $style.insets.screenH,
                  ),
                  sliver: Text(
                    state.selectedStorage!.name,
                    style: context.tt.titleLarge,
                  ).asSliver,
                );
              }
              return const SizedBox.shrink().asSliver;
            },
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              right: $style.insets.screenH,
              left: $style.insets.screenH,
            ),
            sliver: const OpenedItemsSection(),
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
      ),
    );
  }
}
