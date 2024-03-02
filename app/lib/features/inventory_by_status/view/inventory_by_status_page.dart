import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../l10n/l10n.dart';
import '../../../widgets/widgets.dart';
import '../../features.dart';

class InventoryByStatusPage extends StatelessWidget {
  const InventoryByStatusPage({required this.filter, super.key});

  final ItemsStatus filter;

  String _getTitle(BuildContext context) {
    final l10n = context.l10n;
    return switch (filter) {
      ItemsStatus.expired => l10n.expiredItems,
      ItemsStatus.opened => l10n.openedItems,
      ItemsStatus.toBeEaten => l10n.toBeEatenItems,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryByStatusCubit(
        ItemsRepository.I,
        filter: filter,
      ),
      child: InventoryByStatusView(
        title: _getTitle(context),
      ),
    );
  }
}

class InventoryByStatusView extends StatelessWidget {
  const InventoryByStatusView({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              title,
              style: const TextStyle().copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              right: $style.insets.screenH,
              left: $style.insets.screenH,
              bottom: 70,
            ),
            sliver: const _ItemsSection(),
          ),
        ],
      ),
    );
  }
}

class _ItemsSection extends StatelessWidget {
  const _ItemsSection();

  String _getEmptyMessage(BuildContext context) {
    final filter = context.read<InventoryByStatusCubit>().state.filter;
    final l10n = context.l10n;
    if (filter.isExpired) {
      return l10n.inventoryByStatusPageNoExpiredItems;
    } else if (filter.isOpened) {
      return l10n.inventoryByStatusPageNoOpenedItems;
    }
    return l10n.inventoryByStatusPageNoToBeEatenItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryByStatusCubit, InventoryByStatusState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        if (state.groupItems.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text(_getEmptyMessage(context)),
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
              return ItemStatusDaysHeaderTile(
                date: obj,
                status: state.filter,
              );
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
      },
    );
  }
}
