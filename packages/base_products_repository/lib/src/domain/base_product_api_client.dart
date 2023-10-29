import 'package:base_products_repository/base_products_repository.dart';

abstract interface class BaseProductApiClient {
  Future<BaseProductEntity> fetchProduct(String barcode);
}
