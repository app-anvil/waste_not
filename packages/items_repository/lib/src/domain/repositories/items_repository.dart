import '../../../items_repository.dart';

abstract class ItemsRepository {
  // get
  // fetch
  Future<ItemEntity> fetch();
  // addOrUpdate
  // TODO: add ItemInput as a parameter
  Future<void> addOrUpdate();

  // update-quantity (use)

  // delete
  // TODO: add ItemInput is as a parameter
  Future<void> delete();
}
