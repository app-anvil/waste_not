part of 'consume_item_cubit.dart';

final class ConsumeItemState extends SuperBlocState {
  const ConsumeItemState._({
    required this.consumedUnits,
    required this.isDecreaseEnabled,
    required this.isIncreaseEnabled,
    required super.status,
    super.errorMessage,
  });

  const ConsumeItemState.initial()
      : consumedUnits = 1,
        isDecreaseEnabled = false,
        isIncreaseEnabled = true,
        super.initial();

  final int consumedUnits;

  final bool isDecreaseEnabled;
  final bool isIncreaseEnabled;

  @override
  ConsumeItemState copyWith({
    StateStatus? status,
    int? consumedUnits,
    bool? isDecreaseEnabled,
    bool? isIncreaseEnabled,
  }) {
    return ConsumeItemState._(
      consumedUnits: consumedUnits ?? this.consumedUnits,
      isIncreaseEnabled: isIncreaseEnabled ?? this.isIncreaseEnabled,
      isDecreaseEnabled: isDecreaseEnabled ?? this.isDecreaseEnabled,
      status: status ?? this.status,
    );
  }

  @override
  ConsumeItemState copyWithError(String errorMessage) {
    return ConsumeItemState._(
      consumedUnits: consumedUnits,
      isDecreaseEnabled: isDecreaseEnabled,
      isIncreaseEnabled: isIncreaseEnabled,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        consumedUnits,
        isIncreaseEnabled,
        isDecreaseEnabled,
        ...super.props,
      ];
}
