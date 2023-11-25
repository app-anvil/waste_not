import '../../products_repository.dart';

// ignore: one_member_abstracts
abstract interface class ProductsApiClient {
  Future<ProductEntity> fetchProduct(String barcode);
}
