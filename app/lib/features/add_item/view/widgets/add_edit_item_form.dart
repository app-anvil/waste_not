import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../features.dart';

class AddEditItemForm extends StatelessWidget {
  const AddEditItemForm.add({super.key}) : isEditing = false;

  const AddEditItemForm.edit({super.key}) : isEditing = true;

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditItemCubit>();
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FIXME: use cached network and add loading builder
              if (cubit.state.product.imageFrontSmallUrl != null)
                Image.network(
                  cubit.state.product.imageFrontSmallUrl!,
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
              HSpan(const AppStyle().insets.sm),
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
            initialDate: cubit.state.expirationDate,
            onChanged: cubit.onExpirationDateChanged,
            // FIXME: l10n
            hintText: 'Expiration date',
            // FIXME: l10n
            validator: (value) => value == null ? 'Required field' : null,
          ),
          VSpan($style.insets.sm),
          SelectionInput<StorageEntity>(
            initialValue: cubit.state.storage,
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
          isEditing ? const _AddBtn.edit() : const _AddBtn.add(),  
        ],
      ),
    );
  }
}

class _QuantityAndUnitMeasureSection extends StatelessWidget {
  const _QuantityAndUnitMeasureSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditItemCubit>();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: cubit.state.quantity?.toString(),
            keyboardType: TextInputType.numberWithOptions(
              decimal: context.watch<AddEditItemCubit>().state.unitOfMeasure !=
                  UnitOfMeasure.unit,
            ),
            inputFormatters: [
              ReplaceCommaFormatter(),
            ],
            decoration: const InputDecoration().copyWith(
              // FIXME: l10n
              labelText: 'Quantity',
              // FIXME: l10n
              hintText: 'Enter a quantity',
            ),
            onChanged: (value) => cubit.onQuantityChanged(
              value.isEmpty ? 1 : double.parse(value),
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
  const _AddBtn.add() : isEditing = false;

  const _AddBtn.edit() : isEditing = true;

  final bool isEditing;

  void _onSave(BuildContext context) {
    final isValid = Form.of(context).validate();
    if (isValid) {
      final cubit = context.read<AddEditItemCubit>();
      context.navRoot
          .pushBlocListenerBarrier<AddEditItemCubit, AddEditItemState>(
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
            GetIt.I.get<MessageHelper>().showMessage(
              context,
              message: curr.errorMessage!,
              type: MessageType.error,
            );
          }
        },
        trigger: cubit.onSave,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _onSave(context),
            // FIXME: l10n
            child: Text(isEditing ? 'Edit' : 'Add'),
          ),
        ),
      ],
    );
  }
}
