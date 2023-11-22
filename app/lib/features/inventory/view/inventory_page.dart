import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../routes/app_route.dart';
import '../../../widgets/w_card.dart';
import '../../features.dart';

class InventorySliverAppBar extends StatelessWidget {
  const InventorySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      // FIXME: l10n
      title: Text(
        'Inventory',
        style: const TextStyle().copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class InventoryFAB extends StatelessWidget {
  const InventoryFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.router.goNamed(AppRoute.scanner.name),
      child: const Icon(Icons.add_rounded),
    );
  }
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoragesCubit(StoragesRepository.I)..onFetch(),
        ),
        BlocProvider(
          create: (context) => ItemsCubit(ItemsRepository.I)..onFetch(),
        ),
      ],
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          // FIXME: l10n
          title: Text(
            'Inventory',
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: $style.insets.screenH,
          ),
          sliver: const _StorageSection().asSliver,
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            right: $style.insets.screenH,
            left: $style.insets.screenH,
            bottom: 70,
          ),
          sliver: const ItemsSection(),
        ),
      ],
    );
  }
}

class _StorageSection extends StatelessWidget {
  const _StorageSection();

  Widget _buildShimmer() {
    return Padding(
      padding: EdgeInsets.only(bottom: $style.insets.sm),
      child: Stack(
        children: [
          const IgnorePointer(
            child: Opacity(
              opacity: 0,
              child: WCard(
                child: _StorageItem(
                  iconData: Icons.timelapse_rounded,
                  label: 'Opened',
                ),
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
                      // FIXME: l10n
                      const Text('Edit'),
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
                    prototype: const _StorageItem(
                      iconData: Icons.timelapse_rounded,
                      label: 'Opened',
                    ),
                    listView: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final storage = state.storages[index];
                        return _StorageItem(
                          iconData: storage.storageType.icon,
                          label: storage.name,
                        );
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
        return _buildShimmer();
      },
    );
  }
}

class _StorageItem extends StatelessWidget {
  const _StorageItem({
    required this.iconData,
    required this.label,
  });

  final IconData iconData;

  final String label;

  @override
  Widget build(BuildContext context) {
    final iconColor = context.col.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: iconColor,
        ),
        VSpan($style.insets.xs),
        Text(
          label,
          style: context.tt.labelLarge,
        ),
      ],
    );
  }
}
