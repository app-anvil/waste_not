import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/widgets.dart';

enum UnitOfMeasure implements Selectable {
  kilogram,
  liter;

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => false;

  @override
  String get value => name;

  @override
  Widget? get icon => null;
}
