// ignore_for_file: comment_references, type_annotate_public_apis

import 'dart:async';

import 'package:hive/hive.dart';
import '../../logger.dart';

class HiveLogPrinter extends Printer {
  HiveLogPrinter(
    this._formatter, {
    this.retentionDays = 7,
  }) : super(LoggerLevel.info);
  final Formatter _formatter;
  final int retentionDays;
  static const _sessionHeader = '## Log Box opened';

  bool _initialized = false;
  Box<String>? _box;

  /// Initializes the printer.
  ///
  /// This method cannot call [AppCtx]!
  Future<void> init() async {
    if (_initialized) {
      throw Exception(
        'FilePrinter has already been initialized.',
      );
    }
    _box = await Hive.openBox<String>('logs');
    await _box!.put(
      DateTime.now().toUtc().toIso8601String(),
      _sessionHeader,
    );
    _initialized = true;
  }

  /// Purges log entries created earlier than [retentionDays] days ago.
  Future<int> purgeOldLogs() async {
    if (!_initialized) {
      throw Exception(
        'FilePrinter has not been initialized.',
      );
    }
    final allLogKeys = [..._box?.keys ?? []];
    var count = 0;
    for (final key in allLogKeys) {
      final dt = DateTime.tryParse(key.toString());
      if (dt == null ||
          dt.isBefore(DateTime.now().subtract(Duration(days: retentionDays)))) {
        _box?.delete(key).ignore();
        count++;
      }
    }
    return count;
  }

  /// Gets the logs more recent than [fromDateTime].
  ///
  /// The returned structure is a list where each item is a map (between a
  /// date-time and a log message for that date-time) that is a session of
  /// logs. The sessions are sorted from the most recent (ASC) while logs are
  /// sorted from the oldest (DESC)
  List<Map<DateTime, String>> getLogsBySession({
    required DateTime fromDateTime,
  }) {
    final allLogKeys = [..._box?.keys ?? []];
    final allSessions = <Map<DateTime, String>>[];
    var session = <DateTime, String>{};
    for (final key in allLogKeys) {
      final dt = DateTime.tryParse(key.toString());
      if (dt != null && dt.isAfter(fromDateTime)) {
        final message = _box?.get(key);
        if (message == null) continue;
        if (message.startsWith(_sessionHeader)) {
          // It means it is a new session!
          if (session.isNotEmpty) {
            allSessions.add(session);
            session = {};
          }
        } else {
          session[dt] = message;
        }
      }
    }
    // Reverse the list to have the most recent session first.
    return allSessions.reversed.toList();
  }

  @override
  void log(
    LoggerLevel level,
    String source,
    Zone zone,
    message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (!_initialized || minLevel > level) {
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
    if (err.isNotEmpty) {
      err = '\n$err';
    }
    _box
        ?.put(
          parts.dateTime.toIso8601String(),
          '[${parts.source}] ${parts.timestamp} ${parts.prefix} '
          '${parts.message}$err',
        )
        .ignore();
  }
}
