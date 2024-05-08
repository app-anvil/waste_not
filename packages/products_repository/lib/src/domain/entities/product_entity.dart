// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';

import 'entities.dart';

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
  String? get name;

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

  /// `how long the product is expected to last after it has been "produced"
  /// (e.g. packaged, harvested, etc.)
  ///
  /// It is expressed in days;
  abstract final int? expectedShelfLife;

  /// How long the product is expected to last after it has been opened.
  ///
  /// It is expressed in days;
  abstract final int? unsealedLifeTimeInDays;

  abstract final Measure? measure;

  // These two methods are required to enable the conversion from
  // [ProductEntity]
  // object to an encodable object.
  // These methods are used in the Go Router Extra Codec.

  // ignore: avoid_unused_constructor_parameters
  const ProductEntity.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
