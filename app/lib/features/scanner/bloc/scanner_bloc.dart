import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:products_repository/products_repository.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> with LoggerMixin {
  ScannerBloc(this._repo) : super(const ScannerState.initial()) {
    on<ScannerOnBarcodeChanged>(_handleOnBarcodeChanged);
    on<ScannerOnBarcodeReset>(_handleReset);
    on<_ScannerProductFetched>(_handleOnProductFetched);
  }

  final ProductsRepository _repo;

  void _handleOnBarcodeChanged(
    ScannerOnBarcodeChanged event,
    Emitter<ScannerState> emit,
  ) {
    if (state.barcode != event.barcode) {
      emit(state.copyWith(barcode: Optional(event.barcode)));
      add(const _ScannerProductFetched());
    }
  }

  Future<void> _handleOnProductFetched(
    _ScannerProductFetched event,
    Emitter<ScannerState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      final product = await _repo.fetchProduct(state.barcode!);
      emit(
        state.copyWith(
          status: StateStatus.success,
          barcode: const Optional(null),
          product: Optional(product),
        ),
      );
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      emit(state.copyWithError('Impossible to retrieve the product.'));
      return;
    }
  }

  void _handleReset(
    ScannerOnBarcodeReset event,
    Emitter<ScannerState> emit,
  ) {
    emit(const ScannerState.initial());
  }
}
