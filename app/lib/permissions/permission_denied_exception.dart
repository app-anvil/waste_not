class PermissionDeniedException implements Exception {
  const PermissionDeniedException(this.message);

  final String Function() message;
}
