import 'package:base_products_repository/base_products_repository.dart';

class BaseProductsRepositoryImpl implements BaseProductsRepository {
  BaseProductsRepositoryImpl(this._client) : super();

  final OpenFoodFactsApiClient _client;

  @override
  Future<BaseProductModel> fetchProduct(String barcode) async {
    try {
      final product = await _client.fetchProduct(barcode);
      return product;
    } catch (e) {
      rethrow;
    }
  }
}
