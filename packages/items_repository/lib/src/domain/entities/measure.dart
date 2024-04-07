import 'package:a2f_sdk/a2f_sdk.dart';

import '../../../items_repository.dart';

class Measure extends Equatable with ModelToStringMixin {
  Measure({
    required this.quantity,
    required this.unitOfMeasure,
  });

  final double quantity;

  final UnitOfMeasure unitOfMeasure;

  @override
  Map<String, dynamic> $toMap() {
    return {
      'quantity': quantity,
      'unitOfMeasure': unitOfMeasure.value,
    };
  }

  @override
  List<Object?> get props => [
        quantity,
        unitOfMeasure,
      ];
}
