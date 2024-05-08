import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../../../../l10n/l10n.dart';
import '../../../../widgets/widgets.dart';
import '../../../features.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    required this.category,
    required this.itemId,
    super.key,
  });

  final String itemId;

  final String category;

  @override
  State<ItemTile> createState() => ItemTileState();
}

class ItemTileState extends State<ItemTile> {
  late bool _fullConsumeItemAction;

  late bool _isActionEnabled;

  @override
  void initState() {
    super.initState();
    _fullConsumeItemAction = false;
    _isActionEnabled = false;
  }

  void _toggleFullConsumeAction() {
    AppHaptics.lightImpact();
    setState(() {
      _fullConsumeItemAction = !_fullConsumeItemAction;
    });
  }

  void _toggleEnableAction() {
    setState(() {
      _isActionEnabled = !_isActionEnabled;
    });
  }

  Widget slideLeftBackground(BuildContext context, ItemEntity item) {
    return ColoredBox(
      color: _isActionEnabled
          ? Colors.blue
          : context.col.onSurface.withOpacity(0.38),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(width: 20),
            const Icon(
              Icons.timelapse_rounded,
              color: Colors.white,
            ),
            Text(
              !ItemStatus.fromItem(item).isOpened
                  ? context.l10n.openAction
                  : context.l10n.undoOpenAction,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground(BuildContext context) {
    return ColoredBox(
      color: _isActionEnabled
          ? _fullConsumeItemAction
              ? Colors.orange
              : Colors.amber
          : context.col.onSurface.withOpacity(0.38),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Icon(
              Icons.local_dining_rounded,
              color: Colors.white,
            ),
            Text(
              _fullConsumeItemAction
                  ? context.l10n.fullConsumeAction
                  : context.l10n.consumeAction,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  void _onFullConsume(BuildContext context) {
    context.read<InventoryCubit>().onFullConsume(widget.itemId);
  }

  void _delete(BuildContext context) {
    context.read<InventoryCubit>().onDelete(widget.itemId);
  }

  void _open(BuildContext context) {
    context.read<ItemCubit>().onOpened();
  }

  void _unOpen(BuildContext context) {
    context.read<ItemCubit>().onUnOpened();
  }

  void _consume(BuildContext context, ItemEntity item) {
    unawaited(
      const ConsumeItemModal().show(
        context,
        item: item,
      ),
    );
  }

  void _edit(BuildContext context) {
    EditItemPage.push(context, itemId: widget.itemId);
  }

  Future<void> _onLongPress(BuildContext context, ItemEntity item) async {
    return ModalBottomSheet.of(context).showActions(
      actions: [
        ModalBottomSheetActions.edit(context).copyWith(onTap: _edit),
        if (!ItemStatus.fromItem(item).isExpired)
          ModalBottomSheetActions.open(context).copyWith(
            onTap: !ItemStatus.fromItem(item).isOpened ? _open : _unOpen,
            title: !ItemStatus.fromItem(item).isOpened
                ? context.l10n.openAction
                : context.l10n.undoOpenAction,
          ),
        ModalBottomSheetActions.consume(context).copyWith(
          onTap: (context) => _consume(context, item),
        ),
        ModalBottomSheetActions.consume(context).copyWith(
          title: context.l10n.fullConsumeAction,
          onTap: _onFullConsume,
        ),
        ModalBottomSheetActions.divider,
        ModalBottomSheetActions.delete(context).copyWith(onTap: _delete),
      ],
    );
  }

  void _onTap(BuildContext context) => ItemPage.push(
        context,
        itemId: widget.itemId,
        cubit: context.read<ItemCubit>(),
      );

  @override
  Widget build(BuildContext context) {
    // TODO: to be obtained by the item product
    // final remaininigMeasureText =
    //     ' ${item.remainingMeasure.unitOfMeasure?.name}';
    // final measure = item.remainingMeasure;
    return BlocProvider(
      create: (context) => ItemCubit(
        item: ItemsRepository.I.getItemOrThrow(widget.itemId),
        repo: ItemsRepository.I,
      ),
      child: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          final item = state.item;
          return A2Dismissible(
            key: widget.key ?? Key(widget.itemId),
            dismissThresholds: const {
              DismissDirection.startToEnd: 0.2,
              DismissDirection.endToStart: 0.2,
            },
            resizeDuration: null,
            movementDuration: Duration.zero,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                !ItemStatus.fromItem(item).isOpened
                    ? _open(context)
                    : _unOpen(context);
              } else {
                if (_fullConsumeItemAction) {
                  _onFullConsume(context);
                } else {
                  // TODO: add consume item logic
                  // modal bottom sheet or alert:
                  // how many units did you consume? or how many unit remaining?
                  // suggest unit of measure -1 and only a btn to decrease the
                  // value.
                  _consume(context, item);
                }
              }
              return false;
            },
            onUpdate: (WDismissUpdateDetails details) {
              if (details.dragProgress >= .2 && !_isActionEnabled) {
                _toggleEnableAction();
              }
              if (details.dragProgress < .2 && _isActionEnabled) {
                _toggleEnableAction();
              }
              if (details.direction == DismissDirection.endToStart &&
                  details.dragProgress > .5 &&
                  !_fullConsumeItemAction) {
                _toggleFullConsumeAction();
              } else if (details.direction == DismissDirection.endToStart &&
                  details.dragProgress < .5 &&
                  _fullConsumeItemAction) {
                _toggleFullConsumeAction();
              }
            },
            onDismissed: (direction) {},
            // disable left action (open/close item)
            direction: !ItemStatus.fromItem(item).isExpired
                ? DismissDirection.horizontal
                : DismissDirection.endToStart,
            background: slideLeftBackground(context, item),
            secondaryBackground: slideRightBackground(context),
            child: A2Card(
              onTap: () => _onTap(context),
              onLongPress: () => _onLongPress(context, item),
              child: Row(
                children: [
                  if (widget.category.isNotEmpty) ...[
                    Material(
                      borderRadius:
                          BorderRadius.circular(const AppStyle().corners.lg),
                      color: context.col.surface,
                      child: Container(
                        padding: EdgeInsets.all($style.insets.xxs),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          widget.category,
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
                        // The name cannot be changed, so no builder is
                        // required.
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
                                  // FIXME: l10n
                                  TextSpan(text: '${item.amount} units'),
                                  // TODO: to be obtained by the item product
                                  // TextSpan(
                                  //   text: measure.quantity.toString(),
                                  // ),
                                  // TextSpan(text: remaininigMeasureText),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //_buildIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
