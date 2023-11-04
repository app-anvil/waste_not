import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:products_repository/products_repository.dart';

/// {@template product_model}
/// The implementation of a [ProductEntity].
/// {@endtemplate}
class ProductModel implements ProductEntity {
  /// {@macro product_model}
  const ProductModel({
    this.id,
    this.barcode,
    this.brand,
    this.name,
    this.imageFrontUrl,
    this.imageFrontSmallUrl,
  });

  /// {@macro product_model}
  /// Creates a new product from a open food facts product.
  ProductModel.fromOFF(Product product)
      : this(
          barcode: product.barcode,
          brand: product.brands,
          name: product.productName,
          imageFrontUrl: product.imageFrontUrl,
          imageFrontSmallUrl: product.imageFrontSmallUrl,
        );

  @override
  final String? id;

  @override
  final String? barcode;

  @override
  final String? name;

  @override
  final String? brand;

  @override
  final String? imageFrontUrl;

  @override
  final String? imageFrontSmallUrl;

  @override
  List<Object?> get props => [
        id,
        barcode,
        name,
        brand,
        imageFrontUrl,
        imageFrontSmallUrl,
      ];

  @override
  bool? get stringify => true;
}
