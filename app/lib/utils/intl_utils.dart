import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/l10n.dart';

/// Use only if no context is provided.
final $l10n = IntlUtils._localizations!;

abstract class IntlUtils {
  static AppLocalizations? _localizations;

  IntlUtils._();

  static void init(BuildContext context) {
    _localizations ??= AppLocalizations.of(context);
  }

  static String message(String m, {List<Object>? args}) =>
      Intl.message(m, args: args);
}
