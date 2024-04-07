import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

part 'consume_item_state.dart';

class ConsumeItemCubit extends Cubit<ConsumeItemState> with LoggerMixin {
  ConsumeItemCubit(this.item, this._repo)
      : super(const ConsumeItemState.initial());

  final ItemEntity item;

  final ItemsRepository _repo;

  void onDecrease() {
    if (state.consumedAmount > 1) {
      final newValue = state.consumedAmount - 1;
      emit(
        state.copyWith(
          consumedAmount: newValue,
          isDecreaseEnabled: newValue > 1,
          isIncreaseEnabled: true,
        ),
      );
    }
  }

  void onIncrease() {
    if (state.consumedAmount < item.amount) {
      final newValue = state.consumedAmount + 1;
      emit(
        state.copyWith(
          consumedAmount: newValue,
          isIncreaseEnabled: newValue < item.amount,
          isDecreaseEnabled: true,
        ),
      );
    }
  }

  Future<void> onConsume() async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _repo.consume(
        amount: state.consumedAmount,
        id: item.uuid,
      );
      emit(
        state.copyWith(
          status: StateStatus.success,
        ),
      );
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      // FIXME: add exception message
      emit(state.copyWithError(e.toString()));
    }
  }
}
