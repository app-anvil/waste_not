import 'package:a2f_sdk/a2f_sdk.dart';
import '../../../items_repository.dart';

sealed class ItemsRepositoryState extends Equatable {
  const ItemsRepositoryState();

  @override
  bool? get stringify => false;
}

class ItemsRepositoryInitial extends ItemsRepositoryState {
  @override
  List<Object?> get props => [];
}

class ItemsRepositoryItemAddedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemAddedSuccess(this.item);
  final ItemEntity item;
  @override
  List<Object?> get props => [item];
}

class ItemsRepositoryItemLoadedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemLoadedSuccess(this.item);
  final ItemEntity item;
  @override
  List<Object?> get props => [item];
}

class ItemsRepositoryItemUpdatedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemUpdatedSuccess(this.prevItem, this.item);
  final ItemEntity prevItem;
  final ItemEntity item;
  @override
  List<Object?> get props => [prevItem, item];
}

class ItemsRepositoryItemFullConsumedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemFullConsumedSuccess(this.item);
  final ItemEntity item;
  @override
  List<Object?> get props => [item];
}

class ItemsRepositoryItemDeletedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemDeletedSuccess(this.item);
  final ItemEntity item;
  @override
  List<Object?> get props => [item];
}

class ItemsRepositoryUpdatedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryUpdatedSuccess(this.items);
  final List<ItemEntity> items;
  @override
  List<Object?> get props => [items];
}

class ItemsRepositoryItemOpenedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemOpenedSuccess(this.item);
  final ItemEntity item;
  @override
  List<Object?> get props => [item];
}

class ItemsRepositoryItemUnOpenedSuccess extends ItemsRepositoryState {
  const ItemsRepositoryItemUnOpenedSuccess(this.item);
  final ItemEntity item;
  @override
  List<Object?> get props => [item];
}
