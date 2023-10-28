// ignore_for_file: comment_references

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

export 'formatter.dart';
export 'log_item.dart';
export 'log_utils.dart';
export 'logger_level.dart';
export 'logger_mixin.dart';

/// {@template logger}
/// The logger package
/// {@endtemplate}
class Logger {

  /// {@macro logger}
  const Logger(this._source, [this._zone = Zone.root]);
  final String _source;
  final Zone _zone;

  static final Printer defaultPrinter = DefaultPrinter(
    const Formatter(useColors: false, colorOnlyLevel: false),
  );

  static final Printer devLogPrinter = DevLogPrinter(
    const Formatter(useColors: true, colorOnlyLevel: false),
  );

  static final HiveLogPrinter hiveLogPrinter = HiveLogPrinter(
    const Formatter(useColors: false, colorOnlyLevel: false),
  );

  static Set<Printer> _printers = {
    // Enable a console log.
    if (kDebugMode) Logger.devLogPrinter else Logger.defaultPrinter,
  };

  static void enablePrinter(Printer printer) {
    _printers.add(printer);
  }

  static void disablePrinter(Printer printer) {
    _printers.remove(printer);
  }

  static void disableAllPrinters() {
    _printers = {};
  }

  /// Log a message at level [LoggerLevel.verbose].
  // ignore: avoid_void_async
  void v(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) async {
    for (final p in _printers) {
      p.log(
        LoggerLevel.trace,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.debug].
  // ignore: avoid_void_async
  void d(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) async {
    for (final p in _printers) {
      p.log(
        LoggerLevel.debug,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.info].
  // ignore: avoid_void_async
  void i(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) async {
    for (final p in _printers) {
      p.log(
        LoggerLevel.info,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.warning].
  // ignore: avoid_void_async
  void w(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) async {
    for (final p in _printers) {
      p.log(
        LoggerLevel.warning,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.error].
  // ignore: avoid_void_async
  void e(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) async {
    for (final p in _printers) {
      p.log(
        LoggerLevel.error,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.severe].
  // ignore: avoid_void_async
  void wtf(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) async {
    for (final p in _printers) {
      p.log(
        LoggerLevel.severe,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }
}
