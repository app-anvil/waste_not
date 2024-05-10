import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';

import '../../../l10n/l10n.dart';
import '../../../router/router.dart';
import '../../features.dart';
import '../upsert_item.dart';

class AddItemPage extends _UpsertItemPage {
  const AddItemPage({required ProductEntity product}) : super._add(product);

  static String get path => '/inventory/items/add';

  /// Navigates to the page for adding a new item from a [product].
  static void push(
    BuildContext context, {
    required ProductEntity product,
  }) =>
      context.router.push(path, extra: product);

  static GoRoute get route => GoRoute(
        path: path,
        builder: (BuildContext context, GoRouterState state) {
          final product = state.extra! as ProductEntity;
          return _UpsertItemPage._add(product);
        },
      );
}

class EditItemPage extends _UpsertItemPage {
  const EditItemPage({required super.itemId}) : super._edit();

  static String get path =>
      '/inventory/items/${RouteTokens.itemId.asPathToken}/edit';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (BuildContext context, GoRouterState state) {
          final id = state.pathParameters[RouteTokens.itemId.value]!;
          return _UpsertItemPage._edit(itemId: id);
        },
      );

  /// Navigates to the page for editing an item.
  static void push(BuildContext context, {required String itemId}) {
    context.router.push(
      path.replaceFirst(RouteTokens.itemId.asPathToken, itemId),
    );
  }
}

class _UpsertItemPage extends StatelessWidget {
  const _UpsertItemPage._add(this.product) : itemId = null;

  const _UpsertItemPage._edit({required String this.itemId}) : product = null;

  /// [itemId] should be defined only if it is in creating mode.
  final String? itemId;

  /// [product] matters only when creating a new item.
  ///
  /// If null when creating a new item, an error will occur.
  final ProductEntity? product;

  @override
  Widget build(BuildContext context) {
    final cubit = UpsertItemCubit(
      itemsRepo: ItemsRepository.I,
      product: product,
      itemId: itemId,
    );
    return BlocProvider(
      create: (context) => cubit,
      child: _AddEditItemView(isEditing: itemId != null),
    );
  }
}

class _AddEditItemView extends StatelessWidget {
  const _AddEditItemView({required this.isEditing});

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editItem : l10n.addItem),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: isEditing
            ? const UpsertItemForm.edit()
            : const UpsertItemForm.add(),
      ),
    );
  }
}
