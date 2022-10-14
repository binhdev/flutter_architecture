
import 'package:sqflite/sqflite.dart';

abstract class BaseDao<T> {
  late final Database db;
}