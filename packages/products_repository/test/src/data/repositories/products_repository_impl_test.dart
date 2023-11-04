import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:products_repository/products_repository.dart';

class MockBaseProductsApiClient extends Mock
    implements OpenFoodFactsApiClient {}

void main() {
  late ProductsRepositoryImpl repo;
  late MockBaseProductsApiClient client;

  final product = Product(
    barcode: '0000000000',
    productName: 'Biscotti',
    brands: 'Miluno Bianco',
  );

  final baseModel = ProductModel.fromOFF(product);

  final ProductEntity baseEntity = baseModel;

  setUp(() {
    client = MockBaseProductsApiClient();
    repo = ProductsRepositoryImpl(client);
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
