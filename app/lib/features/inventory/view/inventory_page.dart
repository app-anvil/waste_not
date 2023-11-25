import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../routes/app_route.dart';
import '../../../styles/app_colors.dart';
import '../../../theme/theme.dart';
import '../../../widgets/w_card.dart';
import '../../storages/cubit/storages_cubit.dart';

class InventorySliverAppBar extends StatelessWidget {
  const InventorySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      // FIXME: [text]
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
      ],
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContent(
      includeTopPadding: false,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index == 0) return const _StorageSection();
          if (index == 1) {
            return const _ItemTile(
              category: '🥩',
              itemName: 'Filetto',
              storageName: 'Fridge - 1Kg',
              status: ItemStatus.ok,
            );
          }
          if (index == 2) {
            return const _ItemTile(
              category: '🥚',
              itemName: 'Uova',
              storageName: 'Fridge - 4 units',
              status: ItemStatus.warning,
            );
          }
          if (index == 3) {
            return const _ItemTile(
              category: '🥬',
              itemName: 'Insalata',
              storageName: 'Fridge - 200g',
              status: ItemStatus.alert,
            );
          }
          return null;
        },
      ),
    );
    // return const PageScaffold(
    //   title: 'Inventory',
    //   fab: PantryFAB(),
    // );
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
          // TODO: show error
          return const Center(
            // FIXME: [text]
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
                      // FIXME: [text]
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

enum ItemStatus {
  ok,
  warning,
  alert,
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.category,
    required this.storageName,
    required this.itemName,
    required this.status,
  });

  final String category;
  final String itemName;
  final String storageName;

  final ItemStatus status;

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.circular($style.corners.lg),
            color: context.col.surface,
            child: Container(
              padding: EdgeInsets.all($style.insets.xxs),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Text(
                category,
                style: const TextStyle().copyWith(fontSize: 30),
              ),
            ),
          ),
          HSpan($style.insets.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  itemName,
                  style: context.tt.labelLarge,
                ),
                VSpan($style.insets.xxs),
                Text(
                  storageName,
                  style: context.tt.labelSmall,
                ),
              ],
            ),
          ),
          switch (status) {
            ItemStatus.ok => _ExpiryIndicator.ok('4 days'),
            ItemStatus.warning => _ExpiryIndicator.warning('2 days'),
            ItemStatus.alert => _ExpiryIndicator.alert('Expired'),
          },
        ],
      ),
    );
  }
}

class _ExpiryIndicator extends StatelessWidget {
  _ExpiryIndicator.ok(this.label) : backgroundColor = $style.sharedColors.ok;

  _ExpiryIndicator.warning(this.label)
      : backgroundColor = $style.sharedColors.warning;

  _ExpiryIndicator.alert(this.label)
      : backgroundColor = $style.sharedColors.alert;

  final Color backgroundColor;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: $style.insets.xxs,
        horizontal: $style.insets.lg,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular($style.corners.lg),
      ),
      child: Text(
        label,
        style: const TextStyle().copyWith(
          color: AppTheme.light().colors.textLight,
        ),
      ),
    );
  }
}
