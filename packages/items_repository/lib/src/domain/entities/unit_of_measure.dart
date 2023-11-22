import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/widgets.dart';

enum UnitOfMeasure implements Selectable {
  kilogram,
  liter,
  unit;

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => false;

  @override
  String get value => name;

  @override
  Widget? get icon => null;
}
