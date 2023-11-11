// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

abstract interface class ItemEntity extends Equatable {
  /// The identifier of the product.
  ///
  /// Two products with same [barcode] will have the different [id].
  abstract final String id;

  /// The product with base information such as name, brand, image.
  abstract final ProductEntity product;

  /// The expiration date of the item.
  abstract final DateTime expirationDate;

  /// The created date of the item.
  abstract final DateTime createdAt;

  /// The location where the product will be positioned.
  abstract final StorageEntity storage;

  /// The remaining measure of the item.
  abstract final Measure remainingMeasure;
}
