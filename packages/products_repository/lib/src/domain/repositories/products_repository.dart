import '../../../products_repository.dart';

/// {@template base_products_repository}
/// The [ProductsRepository] allows to fetch a [ProductEntity] by a
/// barcode.
/// {@endtemplate}
// ignore: one_member_abstracts
abstract interface class ProductsRepository {
  /// Fetchs a product by its barcode.
  ///
  /// Should throw an exception if no product is found or something is wrong.
  Future<ProductEntity> fetchProduct(String barcode);
}
