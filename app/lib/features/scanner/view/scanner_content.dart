import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../l10n/l10n.dart';
import '../bloc/scanner_bloc.dart';

class ScannerContent extends StatefulWidget {
  const ScannerContent({super.key});

  @override
  State<ScannerContent> createState() => _ScannerContentState();
}

class _ScannerContentState extends State<ScannerContent> with LoggerMixin {
  BarcodeCapture? capture;

  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bloc builder scanner cubit, with listener, when code is not null
    // performs a fetch.
    return BlocConsumer<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          AppHaptics.vibrate();
          GetIt.I.get<MessageHelper>().showMessage(
                context,
                message: state.errorMessage!,
                type: state.showMessageAsError
                    ? MessageType.error
                    : MessageType.info,
              );
        }
      },
      // Before an indicator appeared if state status was n progress, but
      // if mobile scanner is not in the tree, the controller cannot be able to
      // detect a new barcode, so we use a stack.
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MobileScanner(
              controller: _controller,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              placeholderBuilder: (ctx, child) {
                return const Center(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(strokeWidth: 5),
                  ),
                );
              },
              onDetect: (capture) {
                logger.d('${capture.barcodes.last.rawValue}');
                _controller.barcodes.last
                    .then((value) => logger.d('${value.raw}'));
                if (capture.barcodes.last.rawValue != null ||
                    context.watch<ScannerBloc>().state.barcode == null) {
                  context.read<ScannerBloc>().add(
                        ScannerOnBarcodeChanged(
                          capture.barcodes.last.rawValue!,
                        ),
                      );
                }
              },
              overlay: QRScannerOverlay(
                overlayColour: Colors.black.withOpacity(0.5),
              ),
            ),
            // manual input
            // TODO: Uncomment: use only for dev purposes
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          controller: TextEditingController(
                            text: '8076809580748',
                          ),
                          decoration: InputDecoration(
                            hintText: context.l10n.insertBarcodeHintText,
                            prefixIcon: const Icon(Icons.search_rounded),
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              context
                                  .read<ScannerBloc>()
                                  .add(ScannerOnBarcodeChanged(value));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.status.isProgress) ...[
              const Center(child: CupertinoActivityIndicator()),
            ],
          ],
        );
      },
    );
  }
}

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({required this.overlayColour, super.key});

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    // // Changing the size of scanner cutout dependent on the device size.
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            overlayColour,
            BlendMode.srcOut,
          ), // This one will create the magic
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Align(
                child: Container(
                  height: scanArea,
                  width: scanArea,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          child: CustomPaint(
            foregroundPainter: BorderPainter(),
            child: SizedBox(
              width: scanArea + 25,
              height: scanArea + 25,
            ),
          ),
        ),
      ],
    );
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas
      ..clipPath(path)
      ..drawRRect(
        rrect,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = width,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(size.width - 44, size.height - 44),
              radius: 40,
            ),
          )
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({required this.error, super.key});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';

      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';

      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';

      // ignore: no_default_cases
      default:
        errorMessage = 'Ops. Something went wrong.\nRetry to open the scanner.';
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
