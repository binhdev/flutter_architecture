import 'package:flutter_architecture_sample/core/data/local/app_database.dart';
import 'package:flutter_architecture_sample/core/data/local/dao/user_dao.dart';
import 'package:flutter_architecture_sample/core/data/models/user_model.dart';
import 'package:flutter_architecture_sample/core/data/repository/user_repository.dart';
import 'package:flutter_architecture_sample/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:flutter_architecture_sample/ui/shared/dimens/dimens_manager.dart';

class ApplicationViewModel {

  void destroySingletonObject() {
    // Route
    _destroyRouteInstance();
    // Database
    _destroyDatabaseInstance();
    // Repository
    _destroyRepositoryInstance();
    // SharedPreference
    _destroySharedPreferenceInstance();
    // Model
    _destroyModelInstance();
    // Dimens
    _destroyDimensInstance();
  }

  void _destroyRouteInstance() {
    TopScreenNavigatorRoutes().destroyInstance();
  }

  void _destroyDatabaseInstance() {
    AppDatabase().destroyInstance();
    // DAO
    UserDao().destroyInstance();
  }

  void _destroyRepositoryInstance() {
    UserRepository().destroyInstance();
  }

  void _destroySharedPreferenceInstance() {
    // TODO(後で処理する)
  }

  void _destroyModelInstance() {
    UserModel().destroyInstance();
  }

  void _destroyDimensInstance() {
    DimensManager().destroyInstance();
  }
}
