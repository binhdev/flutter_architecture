
import 'package:flutter_architecture_sample/core/data/local/dao/base_dao.dart';
import 'package:flutter_architecture_sample/core/data/local/tables/users_table.dart';
import 'package:sqflite/sqflite.dart';

class UserDao extends BaseDao<UserTable> {
  static UserDao? _instance;

  UserDao._();

  factory UserDao() => _instance ??= UserDao._();

  void init({required Database database}) {
    db = database;
    print("init [$db]");
  }

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  Future<int> insertOrUpdate({
    required String loginId,
    required String password,
    required String? accessToken,
  }) async {
    final userTable = UserTable.fromParam(
      loginId: loginId,
      password: password,
      accessToken: accessToken,
    );
    if (await isUserExists(loginId)) {
      final id = await db.update(
        UserTable.tableName,
        userTable.toJson(),
        where: '${UserTable.columnLoginId} = ?',
        whereArgs: [loginId],
      );
      return id;
    } else {
      final id = await db.insert(UserTable.tableName, userTable.toJson());
      return id;
    }
  }

  Future<int> delete(String loginId) async {
    return await db.delete(
      UserTable.tableName,
      where: '${UserTable.columnLoginId} = ?',
      whereArgs: [loginId],
    );
  }

  Future<UserTable?> user() async {
    List<UserTable> list = [];
    List<Map> maps = await db.query(UserTable.tableName, columns: [
      UserTable.columnLoginId,
      UserTable.columnPassword,
      UserTable.columnAccessToken,
    ]);
    print("[getUser:value] $maps");
    if (maps.isNotEmpty) {
      list = UserTable.fromJsonList(maps);
      return list.first;
    }
    return null;
  }

  Future<bool> isUserExists(String loginId) async {
    List<Map> maps = await db.query(UserTable.tableName,
        columns: [UserTable.columnLoginId],
        where: '${UserTable.columnLoginId} = ?',
        whereArgs: [loginId]);
    if (maps.isNotEmpty) {
      return true;
    }
    return false;
  }
}
