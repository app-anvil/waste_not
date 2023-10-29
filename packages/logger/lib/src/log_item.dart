class LogItem {
  LogItem({
    required this.source,
    required this.message,
    required this.timestamp,
    required this.prefix,
    required this.dateTime,
    this.error,
  });

  String source;
  String message;
  String timestamp;
  String prefix;
  String? error;
  DateTime dateTime;
}
