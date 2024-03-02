import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../l10n/l10n.dart';

/// Action to be placed into a [ModalBottomSheet].
class ModalBottomSheetAction {
  ModalBottomSheetAction({
    required this.title,
    this.subtitle,
    this.iconData,
    this.leading,
    this.onTap,
    this.popOnTap = true,
    this.titleStyle,
    this.subtitleStyle,
    this.isDangerous = false,
  }) : assert(leading == null || iconData == null, '');

  /// The title of the action.
  final String title;

  /// The optional subtitle for the action.
  final String? subtitle;

  /// The leading widget for the action.
  ///
  /// If [leading] is used, then [iconData] must be null.
  final Widget? leading;

  /// The leading icon for the action.
  ///
  /// If [iconData] is used, then [leading] must be null.
  final IconData? iconData;

  /// The callback to be called when the user taps on the action text.
  final void Function(BuildContext context)? onTap;

  /// Whether to pop the modal from the root navigator during the
  /// [onTap] callback. If false the responsibility to pop the modal from
  /// the root navigator is delegated to the caller.
  final bool popOnTap;

  /// The style of the text.
  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  /// Indicates if the actions is dangerous (e.g. delete item).
  ///
  /// Dangerous action have red text color.
  final bool isDangerous;

  ModalBottomSheetAction copyWith({
    String? title,
    String? subtitle,
    IconData? iconData,
    Widget? leading,
    void Function(BuildContext context)? onTap,
    bool? popOnTap,
    bool? isDangerous,
  }) {
    return ModalBottomSheetAction(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconData: iconData ?? this.iconData,
      leading: leading ?? this.leading,
      onTap: onTap ?? this.onTap,
      popOnTap: popOnTap ?? this.popOnTap,
      isDangerous: isDangerous ?? this.isDangerous,
    );
  }
}

abstract class ModalBottomSheetActions {
  /// Action used to specify to insert a divider between actions.
  static final divider = ModalBottomSheetAction(
    title: '',
  );

  static ModalBottomSheetAction delete(BuildContext context) {
    return ModalBottomSheetAction(
      title: context.l10n.deleteAction,
      iconData: Icons.delete_forever_rounded,
      isDangerous: true,
      onTap: (context) => GetIt.I.get<MessageHelper>().showMessage(
        context,
        message: context.l10n.snackBarNotImplemented,
        type: MessageType.info,
      ),
    );
  }

  static ModalBottomSheetAction consume(BuildContext context) {
    return ModalBottomSheetAction(
      title: context.l10n.consumeAction,
      iconData: Icons.local_dining_rounded,
      titleStyle: context.tt.bodyMedium,
      onTap: (context) => GetIt.I.get<MessageHelper>().showMessage(
        context,
        message: context.l10n.snackBarNotImplemented,
        type: MessageType.info,
      ),
    );
  }

  static ModalBottomSheetAction edit(BuildContext context) {
    return ModalBottomSheetAction(
      title: context.l10n.editAction,
      iconData: Icons.edit_rounded,
      titleStyle: context.tt.bodyMedium,
      onTap: (context) => GetIt.I.get<MessageHelper>().showMessage(
        context,
        message: context.l10n.snackBarNotImplemented,
        type: MessageType.info,
      ),
    );
  }

  static ModalBottomSheetAction open(BuildContext context) {
    return ModalBottomSheetAction(
      title: context.l10n.openAction,
      iconData: Icons.timelapse_rounded,
      titleStyle: context.tt.bodyMedium,
      onTap: (context) => GetIt.I.get<MessageHelper>().showMessage(
        context,
        message: context.l10n.snackBarNotImplemented,
        type: MessageType.info,
      ),
    );
  }
}
