import 'package:flutter/material.dart';

import '../../../aev_sdk.dart';

class SelectionPicker<T extends Selectable> {
  SelectionPicker(this.context, {required this.options});
  final BuildContext context;

  final List<T> options;

  Future<T?> push() async {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _SelectionMbs(options: options);
      },
    );
  }
}

class _SelectionMbs<T extends Selectable> extends StatelessWidget {
  const _SelectionMbs({
    required this.options,
    super.key,
  });

  final List<T> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .4,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.col.surfaceVariant,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular($style.corners.card),
          topRight: Radius.circular($style.corners.card),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // options
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: $style.insets.screenH,
              ),
              itemCount: options.length,
              separatorBuilder: (_, __) => const Divider(
                height: 0,
                thickness: .5,
              ),
              itemBuilder: (ctx, index) {
                final option = options[index];
                return _SelectionTile(
                  option: option,
                  onTap: () => context.navRoot.pop(option),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionTile<T extends Selectable> extends StatelessWidget {
  const _SelectionTile({required this.option, required this.onTap, super.key});

  final T option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: $style.insets.sm),
        child: Row(
          children: [
            Flexible(
              child: Text(
                option.value.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
