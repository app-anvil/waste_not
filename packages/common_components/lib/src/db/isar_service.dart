import 'package:common_components/common_components.dart';

abstract interface class IsarService {
  abstract Future<Isar> db;

  Future<Isar> openDB();
}
