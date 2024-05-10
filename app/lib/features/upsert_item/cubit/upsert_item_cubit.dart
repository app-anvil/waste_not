import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

part 'upsert_item_state.dart';

class UpsertItemCubit extends Cubit<UpsertItemState> with LoggerMixin {
  /// Create a new add or edit cubit.
  ///
  /// If itemId is not null, it creates a [UpsertItemCubit.edit] cubit,
  /// otherwise [product] must be not null.
  factory UpsertItemCubit({
    required ItemsRepository itemsRepo,
    String? itemId,
    ProductEntity? product,
  }) {
    if (itemId != null) {
      final item = itemsRepo.getItemOrThrow(itemId);
      return UpsertItemCubit.edit(itemsRepo: itemsRepo, item: item);
    }
    return UpsertItemCubit.add(product: product!, itemsRepo: itemsRepo);
  }

  UpsertItemCubit.add({
    required ProductEntity product,
    required ItemsRepository itemsRepo,
  })  : _itemsRepo = itemsRepo,
        _item = null,
        super(
          UpsertItemState.initial(product),
        );

  UpsertItemCubit.edit({
    required ItemsRepository itemsRepo,
    required ItemEntity item,
  })  : _itemsRepo = itemsRepo,
        _item = item,
        super(UpsertItemState.initial(item.product, item: item));

  final ItemsRepository _itemsRepo;

  final ItemEntity? _item;

  void onExpirationDateChanged(DateTime value) {
    emit(state.copyWith(expirationDate: value));
  }

  void onStorageChanged(StorageEntity value) {
    emit(state.copyWith(storage: value));
  }

  void onQuantityChanged(double value) {
    emit(state.copyWith(quantity: value));
  }

  void onAmountChanged(int value) {
    emit(state.copyWith(amount: PositiveField.dirty(value)));
  }

  void onUnitOfMeasureChanged(UnitOfMeasure value) {
    emit(state.copyWith(unitOfMeasure: value));
  }

  Future<void> onSave() async {
    if (!state.isValid) {
      // FIXME:l10n
      emit(state.copyWithError('Insert all required fields'));
      return;
    }
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _itemsRepo.upsert(
        product: state.product,
        initialExpiryDate: state.expirationDate!,
        amount: state.amount.value.toInt(),
        storage: state.storage!,
        openedAt: null,
        id: _item?.uuid,
      );
      emit(state.copyWith(status: StateStatus.success));
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      // FIXME: add exception message
      emit(state.copyWithError(e.toString()));
    }
  }
}
