// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';

/// A base product entity. It is a sample mapping of a [OpenFoodFacts]' product.
abstract class BaseProductEntity extends Equatable {
  /// {@macro base_product}
  const BaseProductEntity({
    this.barcode,
    this.brand,
    this.name,
    this.imageFrontUrl,
    this.imageFrontSmallUrl,
  });

  /// The barcode of the product.
  ///
  /// Cannot be changed.
  final String? barcode;

  /// The name of the product.
  ///
  /// Cannot be changed.
  final String? name;

  /// The brand of the product.
  ///
  /// Cannot be changed.
  final String? brand;

  /// The image front url of the product.
  ///
  /// Cannot be changed.
  final String? imageFrontUrl;

  /// The image front small url of the product.
  ///
  /// Cannot be changed.
  final String? imageFrontSmallUrl;

  @override
  List<Object?> get props => [
        barcode,
        name,
        brand,
        imageFrontUrl,
        imageFrontSmallUrl,
      ];
}
