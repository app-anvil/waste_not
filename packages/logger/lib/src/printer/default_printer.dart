// ignore_for_file: type_annotate_public_apis

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logger/src/formatter.dart';
import 'package:logger/src/logger_level.dart';
import 'package:logger/src/printer/printer.dart';

class DefaultPrinter extends Printer {
  DefaultPrinter(this._formatter) : super(LoggerLevel.trace);

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
    // If the error is not null with add a new line before it to print it
    // below the log message.
    var err = parts.error ?? '';
    if (error != null) {
      err = '\n$err';
    }
    // Prefer print in web, debugPrint otherwise.
    (kIsWeb ? print : debugPrint).call(
      '[${parts.source}] ${parts.timestamp} ${parts.prefix} '
      '${parts.message}$err',
    );
  }
}
