import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storages_repository/storages_repository.dart';

part 'filter_items_state.dart';

class FilterItemsCubit extends Cubit<FilterItemsState> {
  FilterItemsCubit() : super(const FilterItemsState.initial());

  void onToggled(StorageEntity storage) {
    if (state.selectedStorage == storage) {
      emit(
        state.copyWith(
          selectedStorage: const Optional(null),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedStorage: Optional(storage),
        ),
      );
    }
  }
}
