import 'package:flutter/material.dart';

enum MessageType {
  info,
  error;

  bool get isInfo => this == info;
  bool get isError => this == error;
}

abstract class Message {
  static void showMessage(
    BuildContext context, {
    required String message,
    required MessageType type,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: type.isError ? Colors.red : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
