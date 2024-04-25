// ignore_for_file: comment_references

import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:get_it/get_it.dart';

import '../../../storages_repository.dart';

abstract class StoragesRepository
    extends CrudRepository<StorageEntity, StoragesRepositoryState> {
  static StoragesRepository get I => GetIt.I.get<StoragesRepository>();

  //List<StorageEntity> get storages;

  Future<void> add({
    required String name,
    required StorageType type,
    String? description,
  });

  Future<StorageEntity> update({
    required String id,
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  });

  Future<void> reorder({required int oldIndex, required int newIndex});

  Future<void> fetch();

  /// Deletes a [StorageEntity] by its [id].
  ///
  /// Returns whether the storage has been successfully deleted.
  Future<bool> delete(String id);
}
