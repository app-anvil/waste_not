import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../../l10n/l10n.dart';
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
          SimpleSelectionInput<StorageEntity>(
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
          // TODO: to be added. Now it is not used.
          // const _QuantityAndMeasureSection(),
          // VSpan($style.insets.md),
          const _UnitsSection(),
          VSpan($style.insets.md),
          if (isEditing) const _AddBtn.edit() else const _AddBtn.add(),
        ],
      ),
    );
  }
}

class _QuantityAndMeasureSection extends StatelessWidget {
  const _QuantityAndMeasureSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditItemCubit>();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: cubit.state.quantity?.toString(),
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [ReplaceCommaFormatter('.')],
            decoration: const InputDecoration().copyWith(
              // FIXME: l10n
              labelText: 'Quantity',
              // FIXME: l10n
              hintText: 'Enter a quantity',
            ),
            onChanged: (value) => cubit.onQuantityChanged(
              value.isEmpty ? 1 : double.parse(value),
            ),
          ),
        ),
        Expanded(
          child: SimpleSelectionInput<UnitOfMeasure>(
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

class _UnitsSection extends StatelessWidget {
  const _UnitsSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditItemCubit>();
    return BlocSelector<AddEditItemCubit, AddEditItemState, PositiveField>(
      selector: (state) {
        return state.amount;
      },
      builder: (context, amount) {
        return TextFormField(
          initialValue: '${amount.value}',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration().copyWith(
            // FIXME: l10n
            labelText: 'Amount',
            // FIXME: l10n
            hintText: 'Enter how many items you want to add',
          ),
          onChanged: (value) => cubit.onAmountChanged(
            value.isEmpty ? 1 : int.parse(value),
          ),
          // FIXME: l10n
          validator: (_) => amount.error?.message,
        );
      },
    );
  }
}

class _AddBtn extends StatelessWidget {
  const _AddBtn.add() : isEditing = false;

  const _AddBtn.edit() : isEditing = true;

  final bool isEditing;

  void _onSave(BuildContext context) {
    // call all form validator method, also the amount (positive input)
    // validator.
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
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _onSave(context),
            child: Text(isEditing ? l10n.editAction : l10n.addAction),
          ),
        ),
      ],
    );
  }
}
