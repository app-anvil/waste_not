import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:products_repository/products_repository.dart';

/// {@template open_food_facts_api_client}
/// A client for the Openfoodfacts API. It extends BaseProductApiClient.
///
/// {@endtemplate}
class OpenFoodFactsApiClient implements ProductsApiClient {
  /// {@macro open_food_facts_api_client}
  OpenFoodFactsApiClient() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'Waste Not',
    );
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ITALIAN,
      OpenFoodFactsLanguage.ENGLISH,
    ];
  }

  @override
  Future<ProductModel> fetchProduct(String barcode) async {
    final config = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    final result = await OpenFoodAPIClient.getProductV3(config);
    // FIXME: parse the possible errors such as connection error.
    if (result.product == null) throw ProductNotFound();
    final offProduct = result.product!;
    return ProductModel.fromOFF(offProduct);
  }
}
