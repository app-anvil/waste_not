part of 'opened_items_cubit.dart';

final class OpenedItemsState extends Equatable {
  const OpenedItemsState._({
    required this.items,
    required this.groupItems,
  });

  const OpenedItemsState.initial()
      : items = const [],
        groupItems = const [];

  final List<ItemEntity> items;

  final List<Object> groupItems;

  OpenedItemsState copyWith({
    List<ItemEntity>? items,
    List<Object>? groupItems,
  }) {
    return OpenedItemsState._(
      items: items ?? this.items,
      groupItems: groupItems ?? this.groupItems,
    );
  }

  @override
  List<Object?> get props => [
        items,
        groupItems,
      ];
}
