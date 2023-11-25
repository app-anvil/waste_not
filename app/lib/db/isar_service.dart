import 'dart:io';

import 'package:aev_sdk/aev_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:storages_repository/storages_repository.dart';
import 'package:uuid/uuid.dart';

// TODO: define the interface inside the common package. In this way, the class
// is available also in the repo packages.
class IsarServiceImpl implements IsarService {
  IsarServiceImpl() {
    db = openDB();
  }

  @override
  late Future<Isar> db;

  Future<void> _populateDefault(Isar isar) async {
    await isar.writeTxn(
      () => isar.storageDbModels.putAll(
        [
          StorageDbModel(
            uuid: const Uuid().v4(),
            storageType: StorageType.fridge,
            name: 'Fridge',
            orderingPriority: 0,
          ),
          StorageDbModel(
            uuid: const Uuid().v4(),
            storageType: StorageType.pantry,
            name: 'Pantry',
            orderingPriority: 100,
          ),
          StorageDbModel(
            uuid: const Uuid().v4(),
            storageType: StorageType.freezer,
            name: 'Freezer',
            orderingPriority: 200,
          ),
        ],
      ),
    );
  }

  @override
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      const dbName = 'db';
      const ext = '.isar';

      final isFirstTime =
          !File(path.join(dir.path, '$dbName$ext')).existsSync();

      final isar = await Isar.open(
        [StorageDbModelSchema],
        name: 'db',
        directory: dir.path,
      );

      if (isFirstTime) {
        // populate the db with default storage values.
        await _populateDefault(isar);
      }
      return isar;
    }
    return Future.value(Isar.getInstance());
  }
}
