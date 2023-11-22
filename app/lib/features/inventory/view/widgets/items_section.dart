import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/w_card.dart';
import '../../../items/cubit/items_cubit.dart';

class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        if (state.status.isFailure) {
          // TODO(marco): show error
          return const Center(
            // FIXME: l10n
            child: Text('Error'),
          ).asSliver;
        }
        if (state.status.isSuccess) {
          return SliverList.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return _ItemTile(
                item: item,
                category: '',
              );
            },
          );
        }
        return const Center(child: CupertinoActivityIndicator()).toSliver();
      },
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.category,
    required this.item,
  });

  final ItemEntity item;

  final String category;

  Widget _buildIndicator() {
    if (item.expirationDate.toDate().isBefore(DateTime.now().toDate())) {
      return const _ExpiryIndicator.alert('Expired');
    }
    final remainingDays =
        item.expirationDate.toDate().difference(DateTime.now().toDate()).inDays;
    if (remainingDays > 2) {
      return _ExpiryIndicator.ok('$remainingDays days');
    }
    return _ExpiryIndicator.warning('$remainingDays days');
  }

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Row(
        children: [
          if (category.isNotEmpty) ...[
            Material(
              borderRadius: BorderRadius.circular(const AppStyle().corners.lg),
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
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.product.name ?? '',
                  style: context.tt.labelLarge,
                ),
                VSpan($style.insets.xxs),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: context.tt.labelSmall,
                        children: [
                          TextSpan(
                            text: item.storage.name,
                          ),
                          const TextSpan(
                            text: ' - ',
                          ),
                          TextSpan(
                            text: item.remainingMeasure.quantity.toString(),
                          ),
                          TextSpan(
                            text:
                                ' ${item.remainingMeasure.unitOfMeasure.name}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildIndicator(),
        ],
      ),
    );
  }
}

class _ExpiryIndicator extends StatelessWidget {
  const _ExpiryIndicator.ok(this.label)
      : backgroundColor = const Color(0xff3f9a8e);

  const _ExpiryIndicator.warning(this.label)
      : backgroundColor = const Color(0xfffd8d35);

  const _ExpiryIndicator.alert(this.label)
      : backgroundColor = const Color(0xffec5c54);

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
