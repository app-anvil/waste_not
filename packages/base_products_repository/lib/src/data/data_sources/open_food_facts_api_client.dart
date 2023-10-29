import 'package:base_products_repository/base_products_repository.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

/// {@template open_food_facts_api_client}
/// A client for the Openfoodfacts API. It extends BaseProductApiClient.
///
/// {@endtemplate}
class OpenFoodFactsApiClient implements BaseProductApiClient {
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
  Future<BaseProductModel> fetchProduct(String barcode) async {
    final config = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    final result = await OpenFoodAPIClient.getProductV3(config);
    // FIXME: parse the possible errors such as connection error.
    if (result.product == null) throw BaseProductNotFound();
    final offProduct = result.product!;
    return BaseProductModel.fromOFF(offProduct);
  }
}
