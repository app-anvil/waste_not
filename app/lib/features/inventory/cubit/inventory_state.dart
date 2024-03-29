part of 'inventory_cubit.dart';

final class InventoryState extends SuperBlocState {
  const InventoryState._({
    required this.items,
    required this.groupItems,
    required this.lastItemDeleted,
    required this.lastItemFullConsumed,
    required this.updatesUI,
    required super.status,
    super.errorMessage,
  });

  const InventoryState.initial()
      : items = const [],
        groupItems = const [],
        lastItemDeleted = null,
        lastItemFullConsumed = null,
        updatesUI = true,
        super.initial();

  /// List of items
  final List<ItemEntity> items;

  /// List of items and items's expired date time.
  ///
  /// These is used when is necessary to group items by date.
  final List<Object> groupItems;

  /// The last deleted item.
  ///
  /// It allows to undo the deletion of the last item.
  final ItemEntity? lastItemDeleted;

  /// The last full consumed item.
  ///
  /// It allows to undo the full consumed of the last item.
  final ItemEntity? lastItemFullConsumed;

  /// Indicates if the ui should be rebuilt with current state changes.
  final bool updatesUI;

  @override
  InventoryState copyWith({
    StateStatus? status,
    List<ItemEntity>? items,
    List<Object>? groupItems,
    Optional<ItemEntity?> lastItemDeleted = const Optional.absent(),
    Optional<ItemEntity?> lastItemFullConsumed = const Optional.absent(),
    bool? updatesUI,
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
      updatesUI: updatesUI ?? true,
    );
  }

  @override
  InventoryState copyWithError(String errorMessage) {
    return InventoryState._(
      items: items,
      groupItems: groupItems,
      lastItemDeleted: lastItemDeleted,
      lastItemFullConsumed: lastItemFullConsumed,
      updatesUI: updatesUI,
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
        updatesUI,
        ...super.props,
      ];
}
