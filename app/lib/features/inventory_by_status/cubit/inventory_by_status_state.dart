part of 'inventory_by_status_cubit.dart';

final class InventoryByStatusState extends Equatable {
  const InventoryByStatusState._({
    required this.items,
    required this.groupItems,
    required this.filter,
  });

  const InventoryByStatusState.initial(this.filter)
      : items = const [],
        groupItems = const [];

  InventoryByStatusState copyWith({
    ItemsStatus? filter,
    List<ItemEntity>? items,
    List<Object>? groupItems,
  }) {
    return InventoryByStatusState._(
      filter: filter ?? this.filter,
      items: items ?? this.items,
      groupItems: groupItems ?? this.groupItems,
    );
  }

  final ItemsStatus filter;

  /// List of items
  final List<ItemEntity> items;

  /// List of items and items expired date time.
  ///
  /// These is used when is necessary to group items by date.
  final List<Object> groupItems;

  @override
  List<Object?> get props => [filter, items, groupItems];
}
