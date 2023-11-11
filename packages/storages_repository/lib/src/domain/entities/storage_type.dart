import 'package:flutter/material.dart';

/// The type of the storage.
///
/// [fridge], [freezer] and [pantry].
enum StorageType {
  fridge,
  freezer,
  pantry;

  String get value => switch (this) {
        StorageType.fridge => 'Fridge',
        StorageType.pantry => 'Pantry',
        StorageType.freezer => 'Freezer',
      };
}

extension StorageTypeExt on StorageType {
  IconData get icon => switch (this) {
        StorageType.fridge => Icons.kitchen_rounded,
        StorageType.pantry => Icons.inventory_2_rounded,
        StorageType.freezer => Icons.ac_unit_rounded,
      };
}
