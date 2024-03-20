import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../l10n/l10n.dart';
import '../../../item/cubit/item_cubit.dart';
import '../../inventory.dart';

class OpenedItemsSection extends StatelessWidget {
  const OpenedItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterItemsCubit, FilterItemsState>(
      listener: (context, state) {
        context.read<OpenedItemsCubit>().applyFilter(state.selectedStorage);
      },
      child: BlocBuilder<OpenedItemsCubit, OpenedItemsState>(
        buildWhen: (prev, current) => prev != current,
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const SizedBox.shrink().asSliver;
          }
          return SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => VSpan(
                const AppStyle().insets.xs,
              ),
              itemCount: state.items.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const _HeaderTile();
                }
                final item = state.items[index - 1];
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
            ),
          );
        },
      ),
    );
  }
}

class _HeaderTile extends StatelessWidget {
  const _HeaderTile();

  //final DateTime dt;

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
    const color = Colors.blue;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: const AppStyle().insets.xs),
      child: Row(
        children: [
          _buildIndicator(color),
          HSpan(const AppStyle().insets.xs),
          Text(context.l10n.openedItemsHeader),
        ],
      ),
    );
  }
}
