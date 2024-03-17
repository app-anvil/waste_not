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
enum ItemStatus {
  normal,
  expired,
  opened,
  toBeEaten;

  bool get isNormal => this == normal;
  bool get isExpired => this == expired;
  bool get isOpened => this == opened;
  bool get isToBeEaten => this == toBeEaten;

  static ItemStatus fromValue(String value) {
    if (value == 'expired') {
      return ItemStatus.expired;
    } else if (value == 'opened') {
      return ItemStatus.opened;
    } else if (value == 'normal') {
      return ItemStatus.normal;
    } else {
      return ItemStatus.toBeEaten;
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

  /// The status of the itme.
  ///
  /// This getter depends on [expirationDate] and [openedAt] properties.
  ItemStatus get status;

  /// Indicates the number of days the user shoulb be consume an item.
  static const shouldBeItemBeforeDays = 2;
}
