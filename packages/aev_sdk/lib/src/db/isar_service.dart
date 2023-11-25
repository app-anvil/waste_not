import 'package:isar/isar.dart';

abstract interface class IsarService {
  abstract Future<Isar> db;

  Future<Isar> openDB();
}
