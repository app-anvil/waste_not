import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../cubit/add_item_cubit.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage(this.product, {super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemCubit(
        product: product,
        itemsRepo: GetIt.I.get<ItemsRepository>(),
      ),
      child: const AddProductView(),
    );
  }
}

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // FIXME: [text]
        title: const Text('Add item'),
      ),
      body: const Padding(
        padding: EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FIXME: use cached network and add loading  builder
            Image.network(
              cubit.state.product.imageFrontSmallUrl!,
              width: 100,
              height: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cubit.state.product.name ?? '---'),
                ],
              ),
            ),
          ],
        ),
        VSpan($style.insets.sm),
        DateInput(
          initialDate: null,
          onChanged: cubit.onExpirationDateChanged,
          // FIXME: l10n
          hintText: 'Expiration date',
          // FIXME: l10n
          validator: (value) => value == null ? 'Required field' : null,
        ),
        VSpan($style.insets.sm),
        SelectionInput<StorageEntity>(
          // FIXME: l10n
          hintText: 'Select a storage',
          options: GetIt.I.get<StoragesRepository>().items,
          // FIXME: l10n
          validator: (value) => value == null ? 'Required field' : null,
          onPicked: (storage) {
            if (storage != null) {
              cubit.onStorageChanged(storage);
            }
          },
        ),
        VSpan($style.insets.sm),
        const _QuantityAndUnitMeasureSection(),
        VSpan($style.insets.md),
        const _AddBtn(),
      ],
    );
  }
}

class _QuantityAndUnitMeasureSection extends StatelessWidget {
  const _QuantityAndUnitMeasureSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemCubit>();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration().copyWith(
              // FIXME: l10n
              labelText: 'Quantity',
              // FIXME: l10n
              hintText: 'Digit a quantity',
            ),
            onChanged: (value) => cubit.onQuantityChanged(
              double.parse(value),
            ),
            // FIXME: l10n
            validator: (value) =>
                value == null || value.isEmpty ? 'Required field' : null,
          ),
        ),
        Expanded(
          child: SelectionInput<UnitOfMeasure>(
            // FIXME: l10n
            hintText: 'Select unit of measure',
            initialValue: cubit.state.unitOfMeasure,
            options: UnitOfMeasure.values,
            onPicked: (value) {
              if (value != null) {
                cubit.onUnitOfMeasureChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _AddBtn extends StatelessWidget {
  const _AddBtn();

  void _onAdd(BuildContext context) {
    final isValid = Form.of(context).validate();
    if (isValid) {
      final cubit = context.read<AddItemCubit>();
      context.navRoot.pushBlocListenerBarrier<AddItemCubit, AddItemState>(
        bloc: cubit,
        listener: (ctx, curr) {
          if (curr.status.isSuccess) {
            // Pop the loading screen
            ctx.navRoot.pop();
            // Pop the add/edit screen.
            context.router.pop();
          }
          if (curr.status.isFailure) {
            // Pop the loading screen
            ctx.navRoot.pop();
            Message.showMessage(
              context,
              message: curr.errorMessage!,
              type: MessageType.error,
            );
          }
        },
        trigger: cubit.onAdd,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _onAdd(context),
            // FIXME: l10n
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }
}
