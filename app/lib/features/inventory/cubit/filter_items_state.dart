part of 'filter_items_cubit.dart';

final class FilterItemsState extends Equatable {
  const FilterItemsState._({
    required this.selectedStorage,
  });

  const FilterItemsState.initial() : selectedStorage = null;

  final StorageEntity? selectedStorage;

  FilterItemsState copyWith({
    Optional<StorageEntity?> selectedStorage = const Optional.absent(),
  }) {
    return FilterItemsState._(
      selectedStorage: selectedStorage.present
          ? selectedStorage.value
          : this.selectedStorage,
    );
  }

  @override
  List<Object?> get props => [
        selectedStorage,
      ];
}
