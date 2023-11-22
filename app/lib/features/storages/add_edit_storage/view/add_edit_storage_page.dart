import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storages_repository/storages_repository.dart';

import '../add_edit_storage.dart';

class AddEditStoragePage extends StatelessWidget {
  const AddEditStoragePage({this.storageId, super.key});

  final String? storageId;

  @override
  Widget build(BuildContext context) {
    // get storage from repository.
    final repo = StoragesRepository.I;
    final storage = storageId == null ? null : repo.getItemOrThrow(storageId!);
    return BlocProvider(
      create: (context) => AddEditStorageCubit(
        repo: repo,
        initialStorage: storage,
      ),
      child: storage == null
          ? const AddEditStorageView()
          : const AddEditStorageView.edit(),
    );
  }
}

class AddEditStorageView extends StatelessWidget {
  const AddEditStorageView({super.key}) : _title = 'Add storage';

  const AddEditStorageView.edit({super.key}) : _title = 'Edit storage';

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          Padding(
            padding: $style.insets.screenH.asPaddingRight,
            child: UnconstrainedBox(
              child: BlocBuilder<AddEditStorageCubit, AddEditStorageState>(
                builder: (_, state) {
                  return ElevatedButton(
                    onPressed: state.isValid
                        ? () {
                            final cubit = context.read<AddEditStorageCubit>();
                            context.navRoot.pushBlocListenerBarrier<
                                AddEditStorageCubit, AddEditStorageState>(
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
                              trigger: cubit.onSave,
                            );
                          }
                        : null,
                    // FIXME: l10n
                    child: const Text('Done'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: PageContent(
        child: CustomScrollView(
          slivers: [
            const _NameSection().asSliver,
            VSpan($style.insets.sm).asSliver,
            const _StorageTypeSection().asSliver,
            VSpan($style.insets.sm).asSliver,
            const _DescriptionSection().asSliver,
          ],
        ),
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
  const _NameSection();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: context.read<AddEditStorageCubit>().state.name.value,
      onChanged: (value) =>
          context.read<AddEditStorageCubit>().onNameChanged(value),
      decoration: const InputDecoration().copyWith(
        // FIXME: l10n
        labelText: 'Name of the storage',
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: context.read<AddEditStorageCubit>().state.description,
      onChanged: (value) =>
          context.read<AddEditStorageCubit>().onDescriptionChanged(value),
      decoration: const InputDecoration().copyWith(
        // FIXME: l10n
        labelText: 'Description of the storage (optional)',
      ),
      maxLines: 3,
      maxLength: 60,
    );
  }
}

class _StorageTypeSection extends StatelessWidget {
  const _StorageTypeSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddEditStorageCubit, AddEditStorageState, StorageType>(
      selector: (state) {
        return state.storageType;
      },
      builder: (context, type) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // FIXME: l10n
            Text(
              'Type of the storage',
              style: context.tt.titleSmall?.copyWith(
                color: context.col.primary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...StorageType.values.map(
                  (e) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<StorageType>(
                        value: e,
                        groupValue: type,
                        onChanged: (obj) => context
                            .read<AddEditStorageCubit>()
                            .onStorageTypeChanged(obj!),
                      ),
                      Text(
                        e.value,
                        style: context.tt.labelLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
