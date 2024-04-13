import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';

import '../../../../l10n/l10n.dart';
import '../../../../routes/app_route.dart';
import '../../../../widgets/widgets.dart';
import '../../../features.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    required this.category,
    required this.item,
    super.key,
  });

  final ItemEntity item;

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

  Widget slideLeftBackground(BuildContext context) {
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
              widget.item.openedAt == null
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
    context.read<InventoryCubit>().onFullConsume(widget.item.uuid);
  }

  void _delete(BuildContext context) {
    context.read<InventoryCubit>().onDelete(widget.item.uuid);
  }

  void _open(BuildContext context) {
    context.read<ItemCubit>().onOpened();
  }

  void _consume(BuildContext context) {
    unawaited(
      const ConsumeItemModal().show(
        context,
        item: widget.item,
      ),
    );
  }

  void _edit(BuildContext context) {
    context.router.goNamed(
      AppRoute.editItem.name,
      pathParameters: {
        'id': widget.item.uuid,
      },
    );
  }

  Future<void> _onLongPress(BuildContext context) async {
    return ModalBottomSheet.of(context).showActions(
      actions: [
        ModalBottomSheetActions.edit(context).copyWith(onTap: _edit),
        if (!ItemStatus.fromItem(widget.item).isExpired)
          ModalBottomSheetActions.open(context).copyWith(
            onTap: _open,
            title: widget.item.openedAt == null
                ? context.l10n.openAction
                : context.l10n.undoOpenAction,
          ),
        ModalBottomSheetActions.consume(context).copyWith(
          onTap: _consume,
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

  @override
  Widget build(BuildContext context) {
    // TODO: to be obtained by the item product
    // final remaininigMeasureText =
    //     ' ${widget.item.remainingMeasure.unitOfMeasure?.name}';
    // final measure = widget.item.remainingMeasure;
    return A2Dismissible(
      key: widget.key ?? Key(widget.item.uuid),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.2,
        DismissDirection.endToStart: 0.2,
      },
      resizeDuration: null,
      movementDuration: Duration.zero,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _open(context);
        } else {
          if (_fullConsumeItemAction) {
            _onFullConsume(context);
          } else {
            // TODO: add consume item logic
            // modal bottom sheet or alert: how many units did you consume?
            // or how many unit remaining? suggest unit of measure -1 and only a
            // btn to decrese the value.
            _consume(context);
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
      direction: !ItemStatus.fromItem(widget.item).isExpired
          ? DismissDirection.horizontal
          : DismissDirection.endToStart,
      background: slideLeftBackground(context),
      secondaryBackground: slideRightBackground(context),
      child: A2Card(
        onLongPress: () => _onLongPress(context),
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
                  // The name cannot be changed, so no builder is required.
                  Text(
                    widget.item.product.name ?? '',
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
                              text: widget.item.storage.name,
                            ),
                            const TextSpan(
                              text: ' - ',
                            ),
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
  }
}
