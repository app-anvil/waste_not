import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:products_repository/products_repository.dart';

import '../../upsert_item/view/upsert_item_page.dart';
import '../bloc/scanner_bloc.dart';
import 'scanner_content.dart';

/// This page is in charge of get a barcode of a product using the camera.
/// When a barcode is returned you perform a fetch with the barcode.
/// When the base product is returned successfully, push the add product page.
///
/// If en error occurs during the fetch or during the scan, provide a widget
/// to allow user to retry.
class ScannerPage extends StatelessWidget {
  const ScannerPage._();

  static const path = '/scanner';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (context, state) => const ScannerPage._(),
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: ScannerPage._(),
        ),
      );

  static void push(BuildContext context) {
    context.router.push(path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerBloc(
        ProductsRepositoryImpl(GetIt.I.get<ProductsApiClient>()),
      ),
      child: const ScannerView(),
    );
  }
}

class ScannerView extends StatelessWidget {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    // listener, when the product is fetched push to add-product page
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state.status.isSuccess && state.product != null) {
          AddItemPage.push(context, product: state.product!);
        }
        // We reset all the state of the bloc to avoid same possible errors.
        context.read<ScannerBloc>().add(const ScannerOnBarcodeReset());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: const ScannerContent(),
      ),
    );
  }
}
