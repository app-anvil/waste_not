import 'package:app/core/extensions/extensions.dart';
import 'package:app/features/features.dart';
import 'package:app/routes/app_route.dart';
import 'package:app/styles/styles.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storages_repository/storages_repository.dart';

class StorageTile extends StatelessWidget {
  const StorageTile({
    required this.storage,
    required this.index,
    super.key,
  });

  final StorageEntity storage;

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.col.surface,
      title: Row(
        children: [
          Expanded(
            child: Text(
              storage.name,
              style: context.tt.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          WIconButton(
            onPressed: () =>
                context.read<StoragesCubit>().onDelete(storage.uuid),
            icon: Icon(
              Icons.delete_rounded,
              size: 18,
              color: $styles.shareColors.alert,
            ),
          ),
        ],
      ),
      subtitle: storage.description != null ? Text(storage.description!) : null,
      trailing: ReorderableDragStartListener(
        index: index,
        child: const Icon(Icons.drag_handle_rounded),
      ),
      minLeadingWidth: 10,
      leading: WIconButton(
        icon: const Icon(
          Icons.edit_rounded,
          size: 18,
        ),
        onPressed: () => context.router.goNamed(
          AppRoute.editStorage.name,
          extra: storage.uuid,
        ),
      ),
      // leading: IconButton(
      //   padding: EdgeInsets.all(2),
      //   icon: const Icon(
      //     Icons.edit_rounded,
      //     size: 18,
      //   ),
      //   onPressed: () {},
      // ),
    );
  }
}
