import 'package:openfoodfacts/openfoodfacts.dart';
import '../../../products_repository.dart';

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
    this.measure,
    this.expectedShelfLife,
    this.unsealedLifeTimeInDays,
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
  final Measure? measure;

  @override
  final int? expectedShelfLife;

  @override
  final int? unsealedLifeTimeInDays;

  @override
  List<Object?> get props => [
        id,
        barcode,
        name,
        brand,
        imageFrontUrl,
        imageFrontSmallUrl,
        measure,
        expectedShelfLife,
        unsealedLifeTimeInDays,
      ];

  @override
  bool? get stringify => true;

  @override
  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        barcode = json['barcode'] as String?,
        name = json['name'] as String?,
        brand = json['brand'] as String?,
        imageFrontUrl = json['imageFrontUrl'] as String?,
        imageFrontSmallUrl = json['imageFrontSmallUrl'] as String?,
        // FIXME: it does not work becaus Measure is not serializable
        measure = json['measure'] as Measure?,
        expectedShelfLife = json['expectedShelfLife'] as int?,
        unsealedLifeTimeInDays = json['unsealedLifeTimeInDays'] as int?;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'barcode': barcode,
        'name': name,
        'brand': brand,
        'imageFromUrl': imageFrontUrl,
        'imageFrontSmallUrl': imageFrontSmallUrl,
        'unsealedLifeTimeInDays': unsealedLifeTimeInDays,
        'expectedShelfLife': expectedShelfLife,
        'measure': measure,
      };
}
