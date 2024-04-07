part of 'consume_item_cubit.dart';

final class ConsumeItemState extends SuperBlocState {
  const ConsumeItemState._({
    required this.consumedAmount,
    required this.isDecreaseEnabled,
    required this.isIncreaseEnabled,
    required super.status,
    super.errorMessage,
  });

  const ConsumeItemState.initial()
      : consumedAmount = 1,
        isDecreaseEnabled = false,
        isIncreaseEnabled = true,
        super.initial();

  final int consumedAmount;

  final bool isDecreaseEnabled;
  final bool isIncreaseEnabled;

  @override
  ConsumeItemState copyWith({
    StateStatus? status,
    int? consumedAmount,
    bool? isDecreaseEnabled,
    bool? isIncreaseEnabled,
  }) {
    return ConsumeItemState._(
      consumedAmount: consumedAmount ?? this.consumedAmount,
      isIncreaseEnabled: isIncreaseEnabled ?? this.isIncreaseEnabled,
      isDecreaseEnabled: isDecreaseEnabled ?? this.isDecreaseEnabled,
      status: status ?? this.status,
    );
  }

  @override
  ConsumeItemState copyWithError(String errorMessage) {
    return ConsumeItemState._(
      consumedAmount: consumedAmount,
      isDecreaseEnabled: isDecreaseEnabled,
      isIncreaseEnabled: isIncreaseEnabled,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        consumedAmount,
        isIncreaseEnabled,
        isDecreaseEnabled,
        ...super.props,
      ];
}
