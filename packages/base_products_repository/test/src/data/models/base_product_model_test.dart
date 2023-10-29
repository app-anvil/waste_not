import 'package:base_products_repository/base_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() {
  final offProduct = Product(
    barcode: '000',
    brands: 'Mulino Bianco',
    genericName: 'Biscotti',
  );
  final baseModel = BaseProductModel.fromOFF(offProduct);

  setUp(() {});

  test(
    'BaseProductModel is subclass of BaseProductEntity',
    () async {
      // assert
      expect(baseModel, isA<BaseProductEntity>());
    },
  );
}
