part of 'scanner_bloc.dart';

@immutable
class ScannerState extends SuperBlocState {
  const ScannerState._({
    required super.status,
    this.product,
    this.barcode,
    super.errorMessage,
  });

  const ScannerState.initial()
      : barcode = null,
        product = null,
        super.initial();

  final String? barcode;

  final BaseProductEntity? product;

  @override
  ScannerState copyWith({
    StateStatus? status,
    Optional<String?> barcode = const Optional.absent(),
    Optional<BaseProductEntity?> product = const Optional.absent(),
  }) {
    return ScannerState._(
      status: status ?? this.status,
      barcode: barcode.present ? barcode.value : this.barcode,
      product: product.present ? product.value : this.product,
    );
  }

  @override
  ScannerState copyWithError(String errorMessage) {
    return ScannerState._(
      status: StateStatus.failure,
      errorMessage: errorMessage,
      product: product,
      barcode: barcode,
    );
  }

  @override
  List<Object?> get props => [barcode, product, ...super.props];
}
