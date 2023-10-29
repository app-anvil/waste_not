import 'package:items_repository/items_repository.dart';

class Measure {
  Measure({
    required this.quantity,
    required this.unitOfMeasure,
  });

  final double quantity;

  final UnitOfMeasure unitOfMeasure;
}
