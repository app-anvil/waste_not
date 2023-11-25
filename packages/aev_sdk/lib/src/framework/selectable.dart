import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

/// This class has a getter to obtains the value of the object.
///
/// The object extends this class when the object is used inside a
/// SelectionInput.
abstract class Selectable extends Equatable {
  /// The String representation of the [Selectable] object.
  String get value;

  /// The optional icon as prefix
  Widget? get icon;

  @override
  List<Object?> get props => [
        value,
        icon,
      ];

  @override
  bool? get stringify => true;
}
