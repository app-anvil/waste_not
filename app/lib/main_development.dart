import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
import 'package:base_products_repository/base_products_repository.dart';
import 'package:get_it/get_it.dart';

void main() {
  final baseProductsClient = OpenFoodFactsApiClient();

  GetIt.I.registerSingleton<BaseProductApiClient>(
    baseProductsClient,
  );
  
  bootstrap(() => const App());
}
