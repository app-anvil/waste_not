import 'package:base_products_repository/base_products_repository.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage(this.product, {super.key});

  final BaseProductEntity product;

  @override
  Widget build(BuildContext context) {
    return AddProductView(product);
  }
}

class AddProductView extends StatelessWidget {
  const AddProductView(this.product, {super.key});

  final BaseProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // FIXME: [text]
        title: const Text('Add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: add shimmer
                Image.network(
                  product.imageFrontSmallUrl!,
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name ?? '---'),
                      Text(product.brand ?? '---'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
