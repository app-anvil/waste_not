import 'dart:io';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:items_repository/items_repository.dart';
import 'package:notifications_repository/notifications_repository.dart';
import 'package:path/path.dart' as path;
import 'package:storages_repository/storages_repository.dart';
import 'package:uuid/uuid.dart';

/// Implementation of [IsarService].
///
/// The interface is defined in the `a2f_sdk` package.
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
            // FIXME: l10n
            name: 'Fridge',
            orderingPriority: 0,
          ),
          StorageDbModel(
            uuid: const Uuid().v4(),
            storageType: StorageType.pantry,
            // FIXME: l10n
            name: 'Pantry',
            orderingPriority: 100,
          ),
          StorageDbModel(
            uuid: const Uuid().v4(),
            storageType: StorageType.freezer,
            // FIXME: l10n
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
        [
          StorageDbModelSchema,
          ItemIsarModelSchema,
          NotificationIsarModelSchema,
        ],
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
