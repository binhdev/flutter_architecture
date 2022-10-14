import 'package:flutter_architecture_sample/core/data/local/dao/user_dao.dart';
import 'package:flutter_architecture_sample/core/data/local/tables/users_table.dart';
import 'package:flutter_architecture_sample/core/data/models/user_model.dart';
import 'package:flutter_architecture_sample/core/data/remote/entity/user_entity.dart';
import 'package:flutter_architecture_sample/core/data/remote/services/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();
  final UserDao _userDao = UserDao();

  static UserRepository? _instance;

  /// Constructor
  UserRepository._();

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  factory UserRepository() {
    return _instance ??= UserRepository._();
  }

  Future<void> initUserData() async {
    UserTable? row = await _userDao.user();
    if (row != null) {
      UserModel().create(
        loginId: row.loginId,
        password: row.password,
        accessToken: row.accessToken,
      );
    }
  }

  Future<UserEntity?> login(
    String loginId,
    String password) async {
    // Request API
    return await _userService.login(loginId, password).then((entity) async {
      if (entity != null) {
        // Create Model
        UserModel().create(
          loginId: loginId,
          password: password,
          accessToken: entity.accessToken,
        );
        // Insert DB
        await _userDao.insertOrUpdate(
          loginId: loginId,
          password: password,
          accessToken: entity.accessToken,
        );
      }
      return entity;
    });
  }

  Future<bool> logOut(String? loginId) async {
    if (loginId == null) return false;
    // TODO: Logout with API
    if (await _userDao.delete(loginId) != 0) {
      UserModel().destroyInstance();
      return true;
    }
    return false;
  }
}
