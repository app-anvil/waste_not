import 'package:products_repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(this._client) : super();

  final ProductsApiClient _client;

  @override
  Future<ProductEntity> fetchProduct(String barcode) async {
    try {
      final product = await _client.fetchProduct(barcode);
      return product;
    } catch (e) {
      rethrow;
    }
  }
}
