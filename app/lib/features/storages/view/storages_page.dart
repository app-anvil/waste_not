import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storages_repository/storages_repository.dart';

import '../storages.dart';

class StoragesPage extends StatelessWidget {
  const StoragesPage._();

  static const path = '/inventory/storages';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (context, state) => const StoragesPage._(),
      );

  static void push(BuildContext context) => context.router.push(path);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoragesCubit(StoragesRepository.I),
      child: const StoragesView(),
    );
  }
}

class StoragesView extends StatelessWidget {
  const StoragesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.add_rounded),
        onPressed: () => AddStoragePage.push(context),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            // FIXME: l10n
            title: Text(
              'Storages',
              style: const TextStyle().copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // TODO(marco): try this package: https://pub.dev/packages/reorderables
          const SliverFillRemaining(
            child: _StoragesContent(),
          ),
          //const _StoragesContent().toSliver(),
        ],
      ),
    );
  }
}

class _StoragesContent extends StatefulWidget {
  const _StoragesContent();

  @override
  State<_StoragesContent> createState() => _StoragesContentState();
}

class _StoragesContentState extends State<_StoragesContent> {
  List<StorageEntity> _items = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final storages = context.read<StoragesCubit>().state.storages;
    _items = storages;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoragesCubit, StoragesState>(
      listener: (context, state) {
        setState(() {
          _items = state.storages;
        });
      },
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          final storage = _items[index];
          return StorageTile(
            key: Key(storage.uuid),
            storage: storage,
            index: index,
          );
        },
        itemCount: _items.length,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex--;
          }
          if (oldIndex == newIndex || _items.length <= 1) return;

          // Reorder the storages locally while the cubit is doing its thing
          // because otherwise you see the tile going back to its position and
          // then coming back to the new position.
          setState(() {
            final movedItem = _items.removeAt(oldIndex);
            _items.insert(newIndex, movedItem);
          });
          context.read<StoragesCubit>().onReorder(oldIndex, newIndex);
        },
      ),
    );
  }
}
