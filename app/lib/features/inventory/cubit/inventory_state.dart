part of 'inventory_cubit.dart';

final class InventoryState extends SuperBlocState {
  const InventoryState._({
    required this.items,
    required this.groupItems,
    required this.lastItemDeleted,
    required this.lastItemFullConsumed,
    required super.status,
    super.errorMessage,
  });

  const InventoryState.initial()
      : items = const [],
        groupItems = const [],
        lastItemDeleted = null,
        lastItemFullConsumed = null,
        super.initial();

  final List<ItemEntity> items;

  final List<Object> groupItems;

  final ItemEntity? lastItemDeleted;

  final ItemEntity? lastItemFullConsumed;

  @override
  InventoryState copyWith({
    StateStatus? status,
    List<ItemEntity>? items,
    List<Object>? groupItems,
    Optional<ItemEntity?> lastItemDeleted = const Optional.absent(),
    Optional<ItemEntity?> lastItemFullConsumed = const Optional.absent(),
  }) {
    return InventoryState._(
      items: items ?? this.items,
      groupItems: groupItems ?? this.groupItems,
      lastItemDeleted: lastItemDeleted.present
          ? lastItemDeleted.value
          : this.lastItemDeleted,
      lastItemFullConsumed: lastItemFullConsumed.present
          ? lastItemFullConsumed.value
          : this.lastItemFullConsumed,
      status: status ?? this.status,
    );
  }

  @override
  InventoryState copyWithError(String errorMessage) {
    return InventoryState._(
      items: items,
      groupItems: groupItems,
      lastItemDeleted: lastItemDeleted,
      lastItemFullConsumed: lastItemFullConsumed,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        items,
        groupItems,
        lastItemDeleted,
        lastItemFullConsumed,
        ...super.props,
      ];
}
