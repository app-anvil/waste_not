import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Mixin to provide a [Logger] instance to a class.
///
/// Prefer using this mixin instead of defining a static const [Logger] instance
/// directly in the class! In this way parent classes and implementations
/// can share the same logger.
///
/// ### Do
///
/// ```dart
/// abstract class Parent with LoggerMixin {
///   @nonVirtual
///   void parentMethod() {
///     logger.i('Parent method called');
///   }
/// }
///
/// class Child extends Parent {
///   @override
///   Logger get logger => const Logger('Child');
/// }
/// ```
///
/// ### Avoid
///
/// ```dart
/// abstract class Parent with LoggerMixin {
///   static const _logger = Logger('Parent');
///   @nonVirtual
///   void parentMethod() {
///     _logger.i('Parent method called');
///   }
/// }
///
/// class Child extends Parent {
///   static const _logger = Logger('Child');
/// }
/// ```
mixin LoggerMixin {
  Logger? _logger;

  @protected
  Logger get logger => _logger ??= Logger(runtimeType.toString());
}
