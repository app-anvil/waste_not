import 'dart:async';

import 'package:logger/logger.dart';

export 'default_printer.dart';
export 'dev_log_printer.dart';
export 'hive_log_printer.dart';

abstract class Printer {
  Printer(this._minLevel);

  LoggerLevel _minLevel;

  // ignore: use_setters_to_change_properties
  void setMinLevel(LoggerLevel level) {
    _minLevel = level;
  }

  LoggerLevel get minLevel => _minLevel;

  void log(
    LoggerLevel level,
    String source,
    Zone zone,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]);
}
