part of 'scanner_bloc.dart';

@immutable
sealed class ScannerEvent {
  const ScannerEvent();
}

class ScannerOnBarcodeChanged extends ScannerEvent {
  const ScannerOnBarcodeChanged(this.barcode);
  final String barcode;
}

class ScannerOnBarcodeReset extends ScannerEvent {
  const ScannerOnBarcodeReset();
}

class _ScannerProductFetched extends ScannerEvent {
  const _ScannerProductFetched();
}
