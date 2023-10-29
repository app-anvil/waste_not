import 'package:app/core/extensions/extensions.dart';
import 'package:app/features/scanner/bloc/scanner_bloc.dart';
import 'package:app/features/scanner/view/scanner_content.dart';
import 'package:app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:products_repository/products_repository.dart';

/// This page is in charge of get a barcode of a product using the camera.
/// When a barcode is returned you perform a fetch with the barcode.
/// When the base product is returned successfully, push the add product page.
///
/// If en error occcurs during the fetch or during the scan, provide a widget
/// to allow user to retry.
class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

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
        if (state.status.isSuccess) {
          context.router.goNamed(
            AppRoute.addProduct.name,
            extra: state.product,
          );
        }
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
