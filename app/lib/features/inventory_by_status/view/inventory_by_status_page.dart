import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:items_repository/items_repository.dart';

import '../../../l10n/l10n.dart';
import '../../../widgets/widgets.dart';
import '../../features.dart';

class InventoryByStatusPage extends StatelessWidget {
  const InventoryByStatusPage._({required this.filter});

  final ItemStatus filter;

  static const path = '/inventory/by-status';

  static const routeName = 'inventoryByStatus';

  static GoRoute get route => GoRoute(
        path: path,
        name: routeName,
        builder: (context, state) {
          final filter = ItemStatus.fromName(
            state.uri.queryParameters['filter']!,
          );
          final cubit = state.extra! as InventoryCubit;
          return BlocProvider.value(
            value: cubit,
            child: InventoryByStatusPage._(filter: filter),
          );
        },
      );

  static void push(
    BuildContext context, {
    required ItemStatus filter,
    required InventoryCubit cubit,
  }) {
    context.router.pushNamed(
      routeName,
      queryParameters: {'filter': filter.name},
      extra: cubit,
    );
  }

  String _getTitle(BuildContext context) {
    final l10n = context.l10n;
    return switch (filter) {
      ItemStatus.expired => l10n.expiredItems,
      ItemStatus.opened => l10n.openedItems,
      ItemStatus.toBeEaten => l10n.toBeEatenItems,
      ItemStatus.normal => '',
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
            return ItemTile(
              itemId: item.uuid,
              category: '',
            );
          },
        );
      },
    );
  }
}
