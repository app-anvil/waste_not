// ignore_for_file: type_annotate_public_apis

import 'dart:async';
import 'dart:developer' as developer;

import '../../logger.dart';

class DevLogPrinter extends Printer {
  DevLogPrinter(this._formatter) : super(LoggerLevel.trace);
  final Formatter _formatter;

  @override
  void log(
    LoggerLevel level,
    String source,
    Zone zone,
    message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (minLevel > level) {
      return;
    }
    final parts = _formatter.format(
      level,
      source,
      zone,
      message,
      error,
      stackTrace,
    );
    developer.log(
      '${parts.timestamp} ${parts.prefix} ${parts.message}',
      time: DateTime.now().toUtc(),
      level: level.value,
      name: parts.source,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
