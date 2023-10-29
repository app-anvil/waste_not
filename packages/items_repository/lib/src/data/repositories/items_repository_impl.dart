import 'package:items_repository/items_repository.dart';

class ProductsRepositoryImpl extends ItemsRepository {
  ProductsRepositoryImpl(this._client);

  final ItemsClientI _client;

  @override
  Future<ItemModel> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<void> addOrUpdate() {
    // TODO: implement addOrUpdate
    throw UnimplementedError();
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
