import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../l10n/l10n.dart';
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
              return Center(
                child: Text(
                  selectedFilter == null
                      ? l10n.inventoryPageNoItems
                      : l10n.inventoryPageSelectedFilterNoItems,
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
                  return _HeaderTile(obj);
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

class _HeaderTile extends StatelessWidget {
  const _HeaderTile(this.dt);

  final DateTime dt;

  Widget _buildIndicator(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      padding: const EdgeInsets.all(4),
    );
  }

  // n days left
  @override
  Widget build(BuildContext context) {
    final Color color;
    final String text;
    final l10n = context.l10n;
    if (dt.toDate().isBefore(DateTime.now().toDate())) {
      text = l10n.inventoryPageItemHeaderExpired;
      color = const Color(0xffec5c54);
    } else {
      final remainingDays =
          dt.toDate().difference(DateTime.now().toDate()).inDays;
      if (remainingDays == 0) {
        color = const Color(0xfffd8d35);
      } else if (remainingDays < 2) {
        color = const Color(0xfffd8d35);
      } else {
        color = const Color(0xff3f9a8e);
      }
      text = l10n.inventoryPageItemHeaderExpiredInDays(remainingDays);
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: const AppStyle().insets.xs),
      child: Row(
        children: [
          _buildIndicator(color),
          HSpan(const AppStyle().insets.xs),
          Text(text),
        ],
      ),
    );
  }
}
