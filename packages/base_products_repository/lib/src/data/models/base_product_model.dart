import 'package:base_products_repository/base_products_repository.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class BaseProductModel extends BaseProductEntity {
  const BaseProductModel({
    super.barcode,
    super.brand,
    super.name,
    super.imageFrontUrl,
    super.imageFrontSmallUrl,
  });

  BaseProductModel.fromOFF(Product product)
      : super(
          barcode: product.barcode,
          brand: product.brands,
          name: product.productName,
          imageFrontUrl: product.imageFrontUrl,
          imageFrontSmallUrl: product.imageFrontSmallUrl,
        );
}
