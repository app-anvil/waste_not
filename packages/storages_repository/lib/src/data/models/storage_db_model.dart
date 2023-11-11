// ignore_for_file: must_be_immutable, overridden_fields

import 'package:common_components/common_components.dart';
import 'package:storages_repository/storages_repository.dart';

part 'storage_db_model.g.dart';

@Collection(inheritance: false)
class StorageDbModel extends StorageModel {
  StorageDbModel({
    required this.uuid,
    required this.storageType,
    required this.name,
    required this.orderingPriority,
    this.description,
    this.id = Isar.autoIncrement,
  }) : super(
          uuid: uuid,
          name: name,
          storageType: storageType,
          orderingPriority: orderingPriority,
        );

  final Id id;

  @override
  final String name;

  @override
  @Index()
  final String uuid;

  @override
  final String? description;

  @override
  @Enumerated(EnumType.name)
  final StorageType storageType;

  /// Indicates the ordering property of the items.
  ///
  /// When an storage is added, it's obtained the max ordering
  /// priority from the list of storages and this value is increment by 1.
  ///
  /// When a storage is ordered by the the user, the storages change their
  /// priority.
  ///
  /// Minor value is most important.
  @override
  final double orderingPriority;

  @override
  StorageDbModel copyWith({
    String? name,
    String? description,
    StorageType? storageType,
    double? orderingPriority,
  }) {
    return StorageDbModel(
      name: name ?? this.name,
      description: description ?? this.description,
      storageType: storageType ?? this.storageType,
      orderingPriority: orderingPriority ?? this.orderingPriority,
      uuid: uuid,
      id: id,
    );
  }

  @override
  @ignore
  List<Object?> get props => super.props;

  @override
  @ignore
  bool? get stringify => super.stringify;
}
