import 'package:app/core/core.dart';
import 'package:app/routes/app_route.dart';
import 'package:app/styles/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InventorySliverAppBar extends StatelessWidget {
  const InventorySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
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
    return const InventoryView();
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

  @override
  Widget build(BuildContext context) {
    final list = ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        const _StorageItem(
          iconData: Icons.timelapse_rounded,
          label: 'Opened',
        ),
        HSpan($styles.insets.md),
        const _StorageItem(
          iconData: Icons.inventory_2_rounded,
          label: 'Pantry',
        ),
        HSpan($styles.insets.md),
        const _StorageItem(
          iconData: Icons.kitchen_rounded,
          label: 'Fridge',
        ),
        HSpan($styles.insets.md),
        const _StorageItem(
          iconData: Icons.kitchen_rounded,
          label: 'Fridge 2',
        ),
        HSpan($styles.insets.md),
        const _StorageItem(
          iconData: Icons.ac_unit_rounded,
          label: 'Freezer',
        ),
        HSpan($styles.insets.md),
        const _StorageItem(
          iconData: Icons.ac_unit_rounded,
          label: 'Freezer 2',
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.only(bottom: $styles.insets.sm),
      child: WCard(
        child: PrototypeHeight(
          prototype: const _StorageItem(
            iconData: Icons.timelapse_rounded,
            label: 'Opened',
          ),
          listView: list,
        ),
      ),
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
        VSpan($styles.insets.xs),
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
            borderRadius: BorderRadius.circular($styles.corners.lg),
            color: context.col.surface,
            child: Container(
              padding: EdgeInsets.all($styles.insets.xxs),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Text(
                category,
                style: const TextStyle().copyWith(fontSize: 30),
              ),
            ),
          ),
          HSpan($styles.insets.sm),
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
                VSpan($styles.insets.xxs),
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
  _ExpiryIndicator.ok(this.label) : backgroundColor = $styles.shareColors.ok;

  _ExpiryIndicator.warning(this.label)
      : backgroundColor = $styles.shareColors.warning;

  _ExpiryIndicator.alert(this.label)
      : backgroundColor = $styles.shareColors.alert;

  final Color backgroundColor;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: $styles.insets.xxs,
        horizontal: $styles.insets.lg,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular($styles.corners.lg),
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
