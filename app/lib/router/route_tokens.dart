enum RouteTokens {
  id('id'),
  storageId('storage_id'),
  itemId('item_id');

  final String value;

  const RouteTokens(this.value);

  String get asPathToken => ':$value';
}
