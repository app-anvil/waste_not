part of 'items_cubit.dart';

final class ItemsState extends SuperBlocState {
  const ItemsState._({
    required this.items,
    required super.status,
    super.errorMessage,
  });

  const ItemsState.initial()
      : items = const [],
        super.initial();

  final List<ItemEntity> items;

  @override
  ItemsState copyWith({
    StateStatus? status,
    List<ItemEntity>? items,
  }) {
    return ItemsState._(
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  ItemsState copyWithError(String errorMessage) {
    return ItemsState._(
      items: items,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, ...super.props];
}
