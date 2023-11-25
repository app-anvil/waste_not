import 'package:flutter/foundation.dart';

/// A wrapper around arbitrary data [T] to indicate presence or absence
/// explicitly.
///
/// [Optional]s are commonly used to distinguish between `null` and
/// absent values.
@immutable
class Optional<T> {
  /// Create a (present) value by wrapping the [value] provided.
  const Optional(T value)
      : _value = value,
        present = true;

  /// Create an absent value that will not be written into the database, the
  /// default value or null will be used instead.
  const Optional.absent()
      : _value = null,
        present = false;

  /// Create a value that is absent if [value] is `null` and [present] if it's
  /// not.
  ///
  /// The functionality is equivalent to the following:
  /// `x != null ? Value(x) : Value.absent()`.
  ///
  /// This constructor should only be used when [T] is not nullable. If [T] were
  /// nullable, there wouldn't be a clear interpretation for a `null` [value].
  /// See the overall documentation on [Optional] for details.
  const Optional.ofNullable(T? value)
      : assert(
          value != null || null is! T,
          "Value.ofNullable(null) can't be used for a nullable T, since the "
          'null value could be both absent and present.',
        ),
        _value = value,
        present = value != null;

  /// Whether this [Optional] wrapper contains a present [value].
  final bool present;

  final T? _value;

  /// If this value is [present], contains the value to update or insert.
  T get value => _value as T;

  @override
  String toString() => present ? 'Value($value)' : 'Value.absent()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Optional && present == other.present && _value == other._value;

  @override
  int get hashCode => present.hashCode ^ _value.hashCode;

  T orElseIfAbsent(T other) => present ? value : other;
}
