import 'package:flext/flext.dart';
import 'package:flutter/material.dart';

enum MessageType {
  info,
  error;

  bool get isInfo => this == info;
  bool get isError => this == error;
}

class MessageHelper {
  MessageHelper() : _messagesQueue = [];

  static const _kMessageDuration = Duration(milliseconds: 4000);

  final List<String> _messagesQueue;

  /// Adds a text at the end of the queue
  void _addText(String text) {
    _messagesQueue.add(text);
    Future.delayed(_kMessageDuration, () => _messagesQueue.removeAt(0))
        .ignore();
  }

  /// Shows a message only if a message is not already in the queue.
  void showMessage(
    BuildContext context, {
    required String message,
    required MessageType type,
    SnackBarAction? action,
  }) {
    if (_messagesQueue.contains(message)) return;
    _addText(message);
    final snackBar = SnackBar(
      content: Text(
        message,
        style: context.tt.bodyMedium?.copyWith(
          color: type.isError ? Colors.white : context.col.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: type.isError ? Colors.red : context.col.primary,
      action: action,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void hideSnackBar(BuildContext context) {
    if (_messagesQueue.isNotEmpty) {
      _messagesQueue.removeLast();
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
