// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

abstract interface class ItemEntity extends Equatable {
  /// The identifier of the product.
  ///
  /// Two products with same [barcode] can have the different [uuid].
  abstract final String uuid;

  /// The product with base information such as name, brand, image.
  abstract final ProductEntity product;

  /// The initial expiration date of the item. It is the former expiration date.
  abstract final DateTime initialExpiryDate;

  /// The created date of the item.
  abstract final DateTime createdAt;

  /// The date when the item was opened.
  abstract final DateTime? openedAt;

  /// The location where the product will be positioned.
  abstract final StorageEntity storage;

  /// The number of days the item can last after it has been opened.
  /// This property is initially copied from the [ProductEntity]'s property
  /// unsealedLifeTimeInDays and can be changed by the user.
  abstract final int? unsealedLifeTimeInDays;

  /// The amount of items user wants to add to and the remaining items
  /// his inventory.
  ///
  /// The minimum amount of items is 1.
  abstract final int amount;

  /// The actual expiry date of the item.
  DateTime get actualExpiryDate;

  /// Indicates the number of days the user should be consume an item before
  /// [initialExpiryDate].
  ///
  /// This value is used only if [openedAt] is null.
  static const shouldBeEatenBeforeDays = 2;
}
