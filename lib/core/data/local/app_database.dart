import 'package:flutter_architecture_sample/core/data/local/tables/users_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const String databaseName = "bassist.db";
  static const int databaseVersion = 1;
  Database? _database;

  Database? get database => _database;

  static AppDatabase? _instance;

  /// Constructor
  AppDatabase._();

  factory AppDatabase() {
    return _instance ??= AppDatabase._();
  }

  Future<Database?> onInit() async {
    print("[DATABASE] init...");
    if (_database == null) {
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, databaseName);
      _database = await openDatabase(
        path,
        version: databaseVersion,
        onCreate: (db, version) async {
          await db.execute(UserTable.create());
          // TODO: Add table create
        },
      );
    }
    return _database;
  }

  void destroyInstance() {
    _database!.close();
    _database = null;
  }
}
