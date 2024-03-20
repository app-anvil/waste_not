part of 'scanner_bloc.dart';

@immutable
class ScannerState extends SuperBlocState {
  const ScannerState._({
    required super.status,
    required this.showMessageAsError,
    this.product,
    this.barcode,
    super.errorMessage,
  });

  const ScannerState.initial()
      : barcode = null,
        product = null,
        showMessageAsError = false,
        super.initial();

  final String? barcode;

  final ProductEntity? product;

  /// Indicates if the [errorMessage] should be displayed as an error or not.
  ///
  /// e.g. product not found is not an error.
  ///
  /// It is useful only is [errorMessage] is not null.
  final bool showMessageAsError;

  @override
  ScannerState copyWith({
    StateStatus? status,
    Optional<String?> barcode = const Optional.absent(),
    Optional<ProductEntity?> product = const Optional.absent(),
    bool? showMessageAsError,
  }) {
    return ScannerState._(
      status: status ?? this.status,
      barcode: barcode.present ? barcode.value : this.barcode,
      product: product.present ? product.value : this.product,
      showMessageAsError: showMessageAsError ?? false,
    );
  }

  @override
  ScannerState copyWithError(
    String errorMessage, {
    bool showMessageAsError = true,
  }) {
    return ScannerState._(
      status: StateStatus.failure,
      errorMessage: errorMessage,
      product: product,
      barcode: barcode,
      showMessageAsError: showMessageAsError,
    );
  }

  @override
  List<Object?> get props => [
        barcode,
        product,
        showMessageAsError,
        ...super.props,
      ];
}
