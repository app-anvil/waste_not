import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../l10n/l10n.dart';
import '../../../../widgets/widgets.dart';
import '../../../features.dart';

/// The list of items.
///
/// It is rebuilt only if the order of the list changes:
///
/// - item expiration date is changed
///
/// - item is opened / closed.
///
/// If item's remainingMeasure is changed the list is not updated, only the
/// item tile is updated, but the state of InventoryCubit is always updated.
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
        buildWhen: (prev, current) => prev != current && current.updatesUI,
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
                      // The item from the list is always updated, but the list
                      // is rebuilt only if state.updatesUI is true.
                      // Only a single tile is updated if an item is edited.
                      return ItemTile(
                        key: ValueKey(item.uuid),
                        item: item,
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
