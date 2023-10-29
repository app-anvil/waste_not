part of 'scanner_bloc.dart';

@immutable
class ScannerState extends SuperBlocState {
  const ScannerState._({
    //this.product,
    required super.status,
    this.barcode,
    super.errorMessage,
  });

  const ScannerState.initial()
      : barcode = null,
        super.initial();

  final String? barcode;

  //final BaseProductEntity? product;

  @override
  ScannerState copyWith({
    StateStatus? status,
    Optional<String?> barcode = const Optional.absent(),
  }) {
    return ScannerState._(
      status: status ?? this.status,
      barcode: barcode.present ? barcode.value : this.barcode,
    );
  }

  @override
  ScannerState copyWithError(String errorMessage) {
    return ScannerState._(
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [barcode, ...super.props];
}
