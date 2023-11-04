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
}
