import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:items_repository/items_repository.dart';

import '../../../router/router.dart';
import '../../features.dart';

class ItemPage extends StatelessWidget {
  final String id;

  const ItemPage._({required this.id});

  static String get path =>
      '/inventory/items/${RouteTokens.itemId.asPathToken}';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (BuildContext context, GoRouterState state) {
          final cubit = state.extra as ItemCubit?;
          final id = state.pathParameters[RouteTokens.itemId.value]!;
          return BlocProvider.value(
            value: cubit ??
                ItemCubit(
                  item: ItemsRepository.I.getItemOrThrow(id),
                  repo: ItemsRepository.I,
                ),
            child: ItemPage._(id: id),
          );
        },
      );

  /// Pushes the item details page onto the navigator stack.
  ///
  /// If [cubit] is not provided, a new [ItemCubit] will be created.
  static void push(
    BuildContext context, {
    required String itemId,
    ItemCubit? cubit,
  }) {
    context.router.push(
      path.replaceFirst(RouteTokens.itemId.asPathToken, itemId),
      extra: cubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = context.read<ItemCubit>().state.item;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              item.product.name ?? 'Item',
              style: const TextStyle().copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton.filledTonal(
                onPressed: () => EditItemPage.push(context, itemId: item.uuid),
                icon: const Icon(Icons.edit_rounded),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: $style.insets.screenH,
            ),
            sliver: const _ImageAndNameSection(),
          ),
          VSpan($style.insets.sm).asSliver,
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: $style.insets.screenH,
            ),
            sliver: SliverMainAxisGroup(
              slivers: [
                _InfoTile(
                  // FIXME: l10n
                  label: 'Expiration date',
                  value:
                      DateFormat('dd MMMM yyyy', context.locale.toLanguageTag())
                          .format(item.actualExpiryDate),
                ),
                VSpan($style.insets.sm).asSliver,
                _InfoTile(
                  // FIXME: l10n
                  label: 'Storage',
                  value: item.storage.name,
                ),
                VSpan($style.insets.sm).asSliver,
                _InfoTile(
                  // FIXME: l10n
                  label: 'Amount',
                  value: item.amount,
                ),
                VSpan($style.insets.sm).asSliver,
                // open
                // consume
                // partially consume
                // delete
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageAndNameSection extends StatelessWidget {
  const _ImageAndNameSection();

  @override
  Widget build(BuildContext context) {
    // we use read because image and name are not editable.
    final cubit = context.read<ItemCubit>();
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FIXME: use cached network and add loading builder
          if (cubit.state.item.product.imageFrontSmallUrl != null)
            Image.network(
              cubit.state.item.product.imageFrontSmallUrl!,
              width: 100,
              height: 100,
            )
          else
            const SizedBox.square(
              dimension: 100,
              child: ColoredBox(
                color: Colors.grey,
              ),
            ),
          $style.insets.sm.asHSpan,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cubit.state.item.product.name ?? '---'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile<T> extends StatelessWidget {
  final String label;
  final T value;

  const _InfoTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SliverCrossAxisGroup(
      slivers: [
        Text(
          label,
          style: context.tt.labelLarge,
        ).asSliver,
        SliverCrossAxisExpanded(
          flex: 1,
          sliver: Text(
            value.toString(),
            style: context.tt.bodyMedium,
            textAlign: TextAlign.end,
          ).asSliver,
        ),
      ],
    );
  }
}
