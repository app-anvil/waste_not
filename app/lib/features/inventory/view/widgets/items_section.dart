import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../l10n/l10n.dart';
import '../../../../widgets/widgets.dart';
import '../../../features.dart';

class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<FilterItemsCubit, FilterItemsState>(
      listener: (context, state) {
        context.read<InventoryCubit>().applyFilter(state.selectedStorage);
      },
      child: BlocBuilder<InventoryCubit, InventoryState>(
        buildWhen: (prev, current) => prev != current,
        builder: (context, state) {
          if (state.status.isFailure) {
            // TODO(marco): show error
            return const Center(
              // FIXME: l10n
              child: Text('Error'),
            ).asSliver;
          }
          if (state.status.isSuccess) {
            if (state.items.isEmpty) {
              final selectedFilter =
                  context.watch<FilterItemsCubit>().state.selectedStorage;
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: Text(
                    selectedFilter == null
                        ? l10n.inventoryPageNoItems
                        : l10n.inventoryPageSelectedFilterNoItems,
                  ),
                ),
              ).asSliver;
            }
            return SliverList.separated(
              separatorBuilder: (context, index) => VSpan(
                const AppStyle().insets.xs,
              ),
              itemCount: state.groupItems.length,
              itemBuilder: (context, index) {
                final obj = state.groupItems[index];
                if (obj is DateTime) {
                  return ItemDaysLeftHeaderTile(expiredAt: obj);
                }
                assert(obj is ItemEntity, 'Unexpected object type');
                final item = obj as ItemEntity;
                return BlocProvider(
                  create: (context) => ItemCubit(
                    repo: ItemsRepository.I,
                    item: item,
                  ),
                  child: Builder(
                    builder: (context) {
                      // the item from the list is not updated.
                      // So we get the value of item from its cubit with watch.
                      return ItemTile(
                        item: context.watch<ItemCubit>().state.item,
                        category: '',
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CupertinoActivityIndicator()).asSliver;
        },
      ),
    );
  }
}
