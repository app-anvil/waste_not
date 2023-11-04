import 'package:flutter_test/flutter_test.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:products_repository/products_repository.dart';

void main() {
  final offProduct = Product(
    barcode: '000',
    brands: 'Mulino Bianco',
    genericName: 'Biscotti',
  );
  final baseModel = ProductModel.fromOFF(offProduct);

  setUp(() {});

  test(
    'ProductModel is subclass of BaseProductEntity',
    () async {
      // assert
      expect(baseModel, isA<ProductEntity>());
    },
  );
}
