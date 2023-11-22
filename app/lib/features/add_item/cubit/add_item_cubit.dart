import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:logger/logger.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> with LoggerMixin {
  AddItemCubit({
    required ProductEntity product,
    required ItemsRepository itemsRepo,
  })  : _itemsRepo = itemsRepo,
        super(
          AddItemState.initial(product),
        );

  final ItemsRepository _itemsRepo;

  void onExpirationDateChanged(DateTime value) {
    emit(state.copyWith(expirationDate: value));
  }

  void onStorageChanged(StorageEntity value) {
    emit(state.copyWith(storage: value));
  }

  void onQuantityChanged(double value) {
    emit(state.copyWith(quantity: value));
  }

  void onUnitOfMeasureChanged(UnitOfMeasure value) {
    emit(state.copyWith(unitOfMeasure: value));
  }

  Future<void> onAdd() async {
    if (!state.isValid) {
      // FIXME:l10n
      state.copyWithError('Insert all required fields');
      return;
    }
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _itemsRepo.upsert(
        product: state.product,
        expirationDate: state.expirationDate!,
        remainingMeasure: Measure(
          quantity: state.quantity!,
          unitOfMeasure: state.unitOfMeasure,
        ),
        storage: state.storage!,
      );
      emit(state.copyWith(status: StateStatus.success));
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      // FIXME: add exception message
      emit(state.copyWithError(e.toString()));
    }
  }
}
