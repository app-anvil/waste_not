import 'package:app/core/core.dart';
import 'package:app/features/storages/storages.dart';
import 'package:app/routes/app_route.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storages_repository/storages_repository.dart';

class StoragesPage extends StatelessWidget {
  const StoragesPage({super.key});

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
    return PageScaffold(
      sliverAppBar: SliverAppBar.large(
        // FIXME: [text]
        title: Text(
          'Storages',
          style: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      fab: FloatingActionButton.small(
        child: const Icon(Icons.add_rounded),
        onPressed: () => context.router.goNamed(AppRoute.addStorage.name),
      ),
      child: const _StoragesContent(),
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
