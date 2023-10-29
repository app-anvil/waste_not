import 'package:app/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerState.initial()) {
    on<ScannerOnBarcodeChanged>(_handleOnBarcodeChanged);
    on<ScannerOnBarcodeReset>(_handleReset);
    on<_ScannerProductFetched>(_handleOnProductFetched);
  }

  void _handleOnBarcodeChanged(
    ScannerOnBarcodeChanged event,
    Emitter<ScannerState> emit,
  ) {
    if (state.barcode != event.barcode) {
      emit(state.copyWith(barcode: Optional(event.barcode)));
    }
  }

  Future<void> _handleOnProductFetched(
    _ScannerProductFetched event,
    Emitter<ScannerState> emit,
  ) async {}

  void _handleReset(
    ScannerOnBarcodeReset event,
    Emitter<ScannerState> emit,
  ) {
    emit(
      state.copyWith(barcode: const Optional(null)),
    );
  }
}
