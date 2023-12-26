import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../../l10n/l10n.dart';
import '../../../../routes/app_route.dart';
import '../../../../widgets/widgets.dart';
import '../../../storages/storages.dart';
import '../../cubit/cubit.dart';

class StorageSection extends StatelessWidget {
  const StorageSection({super.key});

  Widget _buildShimmer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: $style.insets.sm),
      child: Stack(
        children: [
          const IgnorePointer(
            child: Opacity(
              opacity: 0,
              child: WCard(
                child: _PrototypeStorageItem(),
              ),
            ),
          ),
          Positioned.fill(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              period: const Duration(milliseconds: 1000),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    $style.corners.card,
                  ),
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoragesCubit, StoragesState>(
      builder: (context, state) {
        if (state.status.isFailure) {
          // TODO(marco): show error
          return const Center(
            // FIXME: l10n
            child: Text('Error'),
          );
        }
        if (state.status.isSuccess) {
          return Padding(
            padding: EdgeInsets.only(bottom: $style.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => context.router.goNamed(
                    AppRoute.storages.name,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(context.l10n.editAction),
                      HSpan($style.insets.xs),
                      const Icon(
                        Icons.edit_rounded,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                WCard(
                  child: PrototypeHeight(
                    prototype: _StorageItem(
                      storage: state.storages.first,
                    ),
                    listView: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final storage = state.storages[index];
                        return _StorageItem(storage: storage);
                      },
                      separatorBuilder: (context, index) =>
                          HSpan($style.insets.md),
                      itemCount: state.storages.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return _buildShimmer(context);
      },
    );
  }
}

class _StorageItem extends StatelessWidget {
  const _StorageItem({required this.storage});

  final StorageEntity storage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<FilterItemsCubit>().onToggled(storage),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<FilterItemsCubit, FilterItemsState>(
            builder: (context, state) {
              final icon = Icon(
                storage.storageType.icon,
                // the size of the icon must be the equal to 28 - padding.
                size: storage == state.selectedStorage ? 16 : 28,
                color: storage == state.selectedStorage
                    ? context.col.background
                    : context.col.primary,
              );
              if (state.selectedStorage == null ||
                  storage.uuid != state.selectedStorage!.uuid) {
                return icon;
              }
              return Container(
                decoration: BoxDecoration(
                  color: context.col.primary,
                  shape: BoxShape.circle,
                ),
                // icon size + padding must be equal to 28 (16 + 12)
                padding: const EdgeInsets.all(6),
                child: icon,
              );
            },
          ),
          VSpan($style.insets.xs),
          Text(
            storage.name,
            style: context.tt.labelLarge,
          ),
        ],
      ),
    );
  }
}

class _PrototypeStorageItem extends StatelessWidget {
  const _PrototypeStorageItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.timelapse_rounded,
          color: context.col.primary,
        ),
        VSpan($style.insets.xs),
        Text(
          '',
          style: context.tt.labelLarge,
        ),
      ],
    );
  }
}