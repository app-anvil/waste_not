// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';

/// A product entity interface. It is a sample mapping of a [OpenFoodFacts]'
/// product.
abstract interface class ProductEntity extends Equatable {
  abstract final String? id;

  /// The barcode of the product.
  ///
  /// Cannot be changed.
  abstract final String? barcode;

  /// The name of the product.
  ///
  /// Cannot be changed.
  abstract final String? name;

  /// The brand of the product.
  ///
  /// Cannot be changed.
  abstract final String? brand;

  /// The image front url of the product.
  ///
  /// Cannot be changed.
  abstract final String? imageFrontUrl;

  /// The image front small url of the product.
  ///
  /// Cannot be changed.
  abstract final String? imageFrontSmallUrl;

  // These two methods are required to enable the conversion from
  // [ProductEntity]
  // object to an encodable object.
  // These methods are used in the Go Router Extra Codec.

  // ignore: avoid_unused_constructor_parameters
  const ProductEntity.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
