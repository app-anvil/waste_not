import 'package:base_products_repository/base_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class MockBaseProductsApiClient extends Mock
    implements OpenFoodFactsApiClient {}

void main() {
  late BaseProductsRepositoryImpl repo;
  late MockBaseProductsApiClient client;

  final product = Product(
    barcode: '0000000000',
    productName: 'Biscotti',
    brands: 'Miluno Bianco',
  );

  final baseModel = BaseProductModel.fromOFF(product);

  final BaseProductEntity baseEntity = baseModel;

  setUp(() {
    client = MockBaseProductsApiClient();
    repo = BaseProductsRepositoryImpl(client);
  });

  test('Fetch a product', () async {
    // arrange
    when(() => client.fetchProduct('0000000000')).thenAnswer(
      (_) async => baseModel,
    );

    // act
    final result = await repo.fetchProduct('0000000000');

    // assert
    verify(() => client.fetchProduct('0000000000'));

    expect(result, baseEntity);
  });
}
