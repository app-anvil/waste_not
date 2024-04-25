part of 'item_cubit.dart';

final class ItemState extends SuperBlocState {
  const ItemState._({
    required this.item,
    required super.status,
    // ignore: unused_element
    super.errorMessage,
  });

  const ItemState.initial(this.item) : super.initial();

  final ItemEntity item;

  @override
  ItemState copyWithError(String errorMessage) {
    return ItemState._(
      item: item,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  ItemState copyWith({required StateStatus status, ItemEntity? item}) {
    return ItemState._(
      item: item ?? this.item,
      status: status,
    );
  }

  @override
  List<Object?> get props => [item, ...super.props];

  @override
  bool? get stringify => true;
}
