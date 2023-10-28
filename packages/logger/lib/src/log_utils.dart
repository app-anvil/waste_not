// ignore_for_file: comment_references

import 'dart:math';

abstract class LogUtils {
  /// Conceals a [sensitiveString] by substituting a part of with stars (`*`),
  /// in order to hide potential sensitive data from the logs.
  ///
  /// [start] must be >= 0 and <= [sensitiveString.length]
  ///
  /// [end] can be either
  /// * __>=0__ ——> in this case it should lays between [start] and
  ///   [sensitiveString.length - 1]. The [sensitiveString]
  ///   will be concealed between start and end included.
  /// * __negative__ ——> in this case it should be
  ///   [end >= start - sensitiveString.length]. Meaning the [sensitiveString]
  ///   will be concealed from [start] until [sensitiveString.length + end].
  ///
  /// In case any of the constraints above are not respected, a [RangeError] is
  /// thrown.
  ///
  /// [maxLength] gives the maximum length allowed for the output [String].
  static String conceal(
    String sensitiveString, {
    int? maxLength,
    int start = 0,
    int? end,
  }) {
    // Check start.
    RangeError.checkValueInInterval(start, 0, sensitiveString.length);

    // Check end.
    if (end != null) {
      final case1 = end < 0 && sensitiveString.length + end >= start;
      final case2 = end <= sensitiveString.length && end >= start;
      if (!(case1 ^ case2)) {
        if (end <= 0) {
          throw RangeError('end=$end is not a valid value. It should be in '
              'range [${start - sensitiveString.length},0]');
        } else {
          RangeError.checkValueInInterval(end, start, sensitiveString.length);
        }
      }
    }

    // Check max length
    maxLength ??= sensitiveString.length;
    // ignore: parameter_assignments
    maxLength = min(sensitiveString.length, maxLength);
    RangeError.checkNotNegative(maxLength);

    // ignore: parameter_assignments
    sensitiveString = sensitiveString.substring(0, maxLength);

    if (sensitiveString.isEmpty) {
      return sensitiveString;
    }

    if (end == null) {
      end = sensitiveString.length;
    } else if (end < 0) {
      // ignore: parameter_assignments
      end = sensitiveString.length + end;
    }

    return sensitiveString.replaceRange(
      start,
      end,
      ''.padLeft(end - start, '*'),
    );
  }
}
