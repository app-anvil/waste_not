import 'package:app/db/isar_service.dart';
import 'package:common_components/common_components.dart';
import 'package:get_it/get_it.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

void initializeDependencies() {
  final baseProductsClient = OpenFoodFactsApiClient();

  GetIt.I.registerSingleton<IsarService>(IsarServiceImpl());

  GetIt.I.registerSingleton<ProductsApiClient>(
    baseProductsClient,
  );

  GetIt.I.registerSingleton<StoragesRepository>(
    StoragesRepositoryImpl(StoragesDbProvider(GetIt.I.get<IsarService>())),
  );
}
