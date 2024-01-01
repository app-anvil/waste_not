import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';

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
    late final AddEditItemCubit cubit;
    if (itemId != null) {
      final item = itemsRepo.getItemOrThrow(itemId!);
      cubit = AddEditItemCubit.edit(
        itemsRepo: itemsRepo,
        item: item,
      );
    } else {
      cubit = AddEditItemCubit.add(
        product: product!,
        itemsRepo: itemsRepo,
      );
    }
    return BlocProvider(
      create: (context) => cubit,
      child: AddEditProductView(
        isEditing: itemId != null,
      ),
    );
  }
}

class AddEditProductView extends StatelessWidget {
  const AddEditProductView({required this.isEditing, super.key});

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // FIXME: l10n
        title: Text(isEditing ? 'Edit item' : 'Add item'),
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
