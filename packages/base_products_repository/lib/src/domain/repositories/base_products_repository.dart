import 'package:base_products_repository/base_products_repository.dart';

/// {@template base_products_repository}
/// The [BaseProductsRepository] allows to fetch a [BaseProductEntity] by a
/// barcode.
/// {@endtemplate}
abstract interface class BaseProductsRepository {
  /// Fetchs a product by its barcode.
  ///
  /// Should throw an exception if no product is found or something is wrong.
  Future<BaseProductEntity?> fetchProduct(String barcode);
}
