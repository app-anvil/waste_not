part of 'inventory_cubit.dart';

final class InventoryState extends SuperBlocState {
  const InventoryState._({
    required this.items,
    required this.groupItems,
    required super.status,
    super.errorMessage,
  });

  const InventoryState.initial()
      : items = const [],
        groupItems = const [],
        super.initial();

  final List<ItemEntity> items;

  final List<Object> groupItems;

  @override
  InventoryState copyWith({
    StateStatus? status,
    List<ItemEntity>? items,
    List<Object>? groupItems,
    Optional<StorageEntity?> selectedStorage = const Optional.absent(),
  }) {
    return InventoryState._(
      items: items ?? this.items,
      groupItems: groupItems ?? this.groupItems,
      status: status ?? this.status,
    );
  }

  @override
  InventoryState copyWithError(String errorMessage) {
    return InventoryState._(
      items: items,
      groupItems: groupItems,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        items,
        groupItems,
        ...super.props,
      ];
}
