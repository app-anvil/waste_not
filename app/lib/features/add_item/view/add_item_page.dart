import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';

import '../../../l10n/l10n.dart';
import '../../features.dart';

class AddEditItemPage extends StatelessWidget {
  const AddEditItemPage.add(this.product, {super.key}) : itemId = null;

  const AddEditItemPage.edit({required String this.itemId, super.key})
      : product = null;

  /// [product] is defined only if it is in creating mode.
  final ProductEntity? product;

  /// [itemId] is defined only if it is in creating mode.
  final String? itemId;

  @override
  Widget build(BuildContext context) {
    final itemsRepo = ItemsRepository.I;
    final cubit = AddEditItemCubit(
      itemsRepo: itemsRepo,
      product: product,
      itemId: itemId,
    );
    return BlocProvider(
      create: (context) => cubit,
      child: AddEditItemView(
        isEditing: itemId != null,
      ),
    );
  }
}

class AddEditItemView extends StatelessWidget {
  const AddEditItemView({required this.isEditing, super.key});

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
            ? const AddEditItemForm.edit()
            : const AddEditItemForm.add(),
      ),
    );
  }
}
