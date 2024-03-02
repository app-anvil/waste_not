// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

/// Indicates the status of an item.
///
/// Can be one of the following values:
///
/// - expired
///
/// - opned
///
/// - toBeEaten
enum ItemsStatus {
  expired,
  opened,
  toBeEaten;

  bool get isExpired => this == expired;
  bool get isOpened => this == opened;
  bool get isToBeEaten => this == toBeEaten;

  static ItemsStatus fromValue(String value) {
    if (value == 'expired') {
      return ItemsStatus.expired;
    } else if (value == 'opened') {
      return ItemsStatus.opened;
    } else {
      return ItemsStatus.toBeEaten;
    }
  }
}

abstract interface class ItemEntity extends Equatable {
  /// The identifier of the product.
  ///
  /// Two products with same [barcode] can have the different [uuid].
  abstract final String uuid;

  /// The product with base information such as name, brand, image.
  abstract final ProductEntity product;

  /// The expiration date of the item.
  abstract final DateTime expirationDate;

  /// The created date of the item.
  abstract final DateTime createdAt;

  /// The date when the item was opened.
  abstract final DateTime? openedAt;

  /// The location where the product will be positioned.
  abstract final StorageEntity storage;

  /// The remaining measure of the item.
  abstract final Measure remainingMeasure;
}
