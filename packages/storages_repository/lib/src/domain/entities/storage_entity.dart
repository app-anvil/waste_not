import 'package:aev_sdk/aev_sdk.dart';
import '../../../storages_repository.dart';

// class DefaultStorages {
//   static final fridge = Storage(
//     id: '0',
//     name: 'Fridge',
//     storageType: StorageType.fridge,
//   );

//   static final freezer = Storage(
//     id: '1',
//     name: 'Freezer',
//     storageType: StorageType.freezer,
//   );

//   static final pantry = Storage(
//     id: '2',
//     name: 'Pantry',
//     storageType: StorageType.pantry,
//   );

//   static final values = [freezer, fridge, pantry];
// }

abstract interface class StorageEntity extends Equatable implements Selectable {
  abstract final String uuid;
  abstract final String name;
  abstract final String? description;
  abstract final StorageType storageType;

  /// Indicates the ordering property of the items.
  ///
  /// When an storage is added, it's obtained the max ordering
  /// priority from the list of storages and this value is increment by the
  /// orderingPriorityFactor.
  ///
  /// When a storage is ordered by the the user, the storages change their
  /// priority.
  ///
  /// Minor value is most important.
  abstract final double orderingPriority;
}
