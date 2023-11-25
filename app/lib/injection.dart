import 'package:aev_sdk/aev_sdk.dart';
import 'package:get_it/get_it.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import 'db/isar_service.dart';

void initializeDependencies() {
  GetIt.I.registerSingleton<IsarService>(IsarServiceImpl());
  GetIt.I.registerSingleton<ProductsApiClient>(OpenFoodFactsApiClient());
  GetIt.I.registerSingleton<StoragesRepository>(
    StoragesRepositoryImpl(StoragesDbProvider(GetIt.I.get<IsarService>())),
  );
}
