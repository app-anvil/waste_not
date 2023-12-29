part of 'add_item_cubit.dart';

@immutable
final class AddEditItemState extends SuperBlocState {
  const AddEditItemState._({
    required this.product,
    required this.expirationDate,
    required this.quantity,
    required this.unitOfMeasure,
    required this.storage,
    required super.status,
    super.errorMessage,
  });

  AddEditItemState.initial(
    this.product, {
    ItemEntity? item,
  })  : expirationDate = item?.expirationDate,
        storage = item?.storage,
        quantity = item?.remainingMeasure.quantity,
        unitOfMeasure =
            item?.remainingMeasure.unitOfMeasure ?? UnitOfMeasure.unit,
        super.initial();

  final DateTime? expirationDate;
  final StorageEntity? storage;
  final ProductEntity product;
  final double? quantity;

  final UnitOfMeasure unitOfMeasure;

  bool get isValid {
    return expirationDate != null && storage != null && quantity != null;
  }

  @override
  AddEditItemState copyWith({
    StateStatus? status,
    DateTime? expirationDate,
    StorageEntity? storage,
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
    );
  }

  @override
  AddEditItemState copyWithError(String errorMessage) {
    return AddEditItemState._(
      expirationDate: expirationDate,
      storage: storage,
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
        storage,
        quantity,
        unitOfMeasure,
        ...super.props,
      ];

  @override
  bool? get stringify => false;
}
