import 'package:app/core/core.dart';
import 'package:app/features/storages/add_edit_storage/add_edit_storage.dart';
import 'package:app/styles/styles.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storages_repository/storages_repository.dart';

class AddEditStoragePage extends StatelessWidget {
  const AddEditStoragePage({this.storageId, super.key});

  final String? storageId;

  @override
  Widget build(BuildContext context) {
    // get storage from repository.
    final repo = StoragesRepository.I;
    final storage =
        storageId == null ? null : repo.getStorageOrThrow(storageId!);
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
    // TODO: remove it
    return BlocListener<AddEditStorageCubit, AddEditStorageState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          // Pop the add/edit screen.
          context.router.pop();
        }
        if (state.status.isFailure) {
          // show error message
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: $styles.insets.screenHMargin),
              child: UnconstrainedBox(
                child: BlocBuilder<AddEditStorageCubit, AddEditStorageState>(
                  builder: (_, state) {
                    return ElevatedButton(
                      onPressed: state.isValid
                          ? () {
                              final cubit = context.read<AddEditStorageCubit>();
                              // ignore: cascade_invocations
                              cubit.onSave();
                              // context.navRoot.
                              // pushLoading<AddEditStorageCubit,
                              //     AddEditStorageState>(
                              //   bloc: cubit,
                              //   listener: (ctx, curr) {
                              //     if (curr.status.isSuccess) {
                              //       // Pop the loading screen
                              //       ctx.navRoot.pop();
                              //       // Pop the add/edit screen.
                              //       context.router.pop();
                              //     }
                              //     if (curr.status.isFailure) {
                              //       // Pop the loading screen
                              //       ctx.navRoot.pop();
                              //       // show error message
                              //     }
                              //   },
                              //   trigger: cubit.onSave,
                              // );
                            }
                          : null,
                      // FIXME: [text]
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
              const _NameSection().toSliver(),
              VSpan($styles.insets.sm).toSliver(),
              const _StorageTypeSection().toSliver(),
              VSpan($styles.insets.sm).toSliver(),
              const _DescriptionSection().toSliver(),
            ],
          ),
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
            // FIXME: [text]
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
