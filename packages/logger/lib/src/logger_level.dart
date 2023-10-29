import 'package:flutter/foundation.dart';

@immutable
class LoggerLevel implements Comparable<LoggerLevel> {
  const LoggerLevel(this.name, this.value);

  factory LoggerLevel.fromName(String name) =>
      levels.firstWhere((element) => element.name == name.toUpperCase());
  final String name;

  /// Unique value for this level. Used to order levels, so filtering can
  /// exclude messages whose level is under certain value.
  final int value;

  /// Special key to turn on logging for all levels ([value] = 0).
  static const LoggerLevel all = LoggerLevel('ALL', 0);

  /// Special key to turn off all logging ([value] = 2000).
  static const LoggerLevel off = LoggerLevel('OFF', 2000);

  /// Key for highly detailed tracing ([value] = 300).
  static const LoggerLevel trace = LoggerLevel('TRACE', 300);

  /// Key for fairly detailed tracing ([value] = 400).
  static const LoggerLevel debug = LoggerLevel('DEBUG', 400);

  /// Key for tracing information ([value] = 500).
  static const LoggerLevel info = LoggerLevel('INFO', 500);

  /// Key for static configuration messages ([value] = 700).
  static const LoggerLevel warning = LoggerLevel('WARNING', 700);

  /// Key for informational messages ([value] = 800).
  static const LoggerLevel error = LoggerLevel('ERROR', 800);

  /// Key for serious failures ([value] = 1000).
  static const LoggerLevel severe = LoggerLevel('SEVERE', 1000);

  static const List<LoggerLevel> levels = [
    all,
    trace,
    debug,
    error,
    warning,
    error,
    severe,
    off,
  ];

  @override
  bool operator ==(Object other) =>
      other is LoggerLevel && value == other.value;

  bool operator <(LoggerLevel other) => value < other.value;

  bool operator <=(LoggerLevel other) => value <= other.value;

  bool operator >(LoggerLevel other) => value > other.value;

  bool operator >=(LoggerLevel other) => value >= other.value;

  @override
  int compareTo(LoggerLevel other) => value - other.value;

  @override
  int get hashCode => value;

  @override
  String toString() => name;
}
