import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
import 'package:get_it/get_it.dart';
import 'package:products_repository/products_repository.dart';

void main() {
  final baseProductsClient = OpenFoodFactsApiClient();

  GetIt.I.registerSingleton<ProductsApiClient>(
    baseProductsClient,
  );
  
  bootstrap(() => const App());
}
