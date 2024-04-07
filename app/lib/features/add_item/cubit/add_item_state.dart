part of 'add_item_cubit.dart';

@immutable
final class AddEditItemState extends SuperBlocState {
  const AddEditItemState._({
    required this.product,
    required this.expirationDate,
    required this.quantity,
    required this.unitOfMeasure,
    required this.storage,
    required this.amount,
    required super.status,
    super.errorMessage,
  });

  AddEditItemState.initial(
    this.product, {
    ItemEntity? item,
  })  : expirationDate = item?.initialExpiryDate,
        storage = item?.storage,
        // quantity = product?.measure.quantity,
        // unitOfMeasure = product?.measure.unitOfMeasure,
        quantity = null,
        unitOfMeasure = null,
        amount = 1,
        super.initial();

  final DateTime? expirationDate;
  final StorageEntity? storage;
  final ProductEntity product;
  final double? quantity;

  final UnitOfMeasure? unitOfMeasure;

  final int amount;

  bool get isValid {
    return expirationDate != null && storage != null && quantity != null;
  }

  @override
  AddEditItemState copyWith({
    StateStatus? status,
    DateTime? expirationDate,
    StorageEntity? storage,
    int? amount,
    double? quantity,
    UnitOfMeasure? unitOfMeasure,
  }) {
    return AddEditItemState._(
      status: status ?? this.status,
      product: product,
      expirationDate: expirationDate ?? this.expirationDate,
      quantity: quantity ?? this.quantity,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      storage: storage ?? this.storage,
      amount: amount ?? this.amount,
    );
  }

  @override
  AddEditItemState copyWithError(String errorMessage) {
    return AddEditItemState._(
      expirationDate: expirationDate,
      storage: storage,
      amount: amount,
      quantity: quantity,
      unitOfMeasure: unitOfMeasure,
      product: product,
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        product,
        expirationDate,
        amount,
        storage,
        quantity,
        unitOfMeasure,
        ...super.props,
      ];

  @override
  bool? get stringify => false;
}
