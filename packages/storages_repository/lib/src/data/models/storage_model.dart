import 'package:common_components/common_components.dart';
import 'package:flutter/foundation.dart';
import 'package:storages_repository/storages_repository.dart';

class StorageModel with ModelToStringMixin implements StorageEntity {
  StorageModel({
    required this.uuid,
    required this.name,
    required this.storageType,
    required this.orderingPriority,
    this.description,
  });

  @override
  final String? description;

  @override
  final String uuid;

  @override
  final String name;

  @override
  final StorageType storageType;

  @override
  final double orderingPriority;

  StorageModel copyWith({
    String? name,
    String? description,
    StorageType? storageType,
    double? orderingPriority,
  }) {
    return StorageModel(
      name: name ?? this.name,
      description: description ?? this.description,
      storageType: storageType ?? this.storageType,
      orderingPriority: orderingPriority ?? this.orderingPriority,
      uuid: uuid,
    );
  }

  @nonVirtual
  @override
  // ignore: no_runtimetype_tostring
  String get $modelName => '$runtimeType';

  @override
  Map<String, Object?> $toMap() => {
        'uuid': uuid,
        'name': name,
        'orderingPriority': orderingPriority,
        'description': description,
        'storageType': storageType,
      };

  @override
  List<Object?> get props => [
        uuid,
        name,
        description,
        storageType,
        orderingPriority,
      ];

  @override
  bool? get stringify => true;
}
