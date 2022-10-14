import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_sample/core/data/models/user_model.dart';
import 'package:flutter_architecture_sample/core/data/remote/api/api_exception.dart';
import 'package:flutter_architecture_sample/core/data/repository/user_repository.dart';
import 'package:flutter_architecture_sample/core/enums/enums.dart';
import 'package:flutter_architecture_sample/view_models/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final UserRepository _userRepository = UserRepository();
  final UserModel _userModel = UserModel();
  final TextEditingController userIdTextFieldController =
      TextEditingController();
  final TextEditingController passwordIdTextFieldController =
      TextEditingController();

  String _userId = "";

  String _password = "";

  bool isShowLoading = false;

  LoginValidateError _loginValidateError = LoginValidateError.none;

  LoginValidateError get loginValidateError => _loginValidateError;

  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
  }

  void setUserId({required String userId}) {
    _userId = userId;
    if (_loginValidateError != LoginValidateError.none) {
      _loginValidateError = LoginValidateError.none;
      updateUI();
    }
  }

  void setPassword({required String password}) {
    _password = password;
    if (_loginValidateError != LoginValidateError.none) {
      _loginValidateError = LoginValidateError.none;
      updateUI();
    }
  }

  Future<void> onPressLogin({
    required Function(String message) onSuccess,
  }) async {
    print('ログイン');
    isShowLoading = true;
    _loginValidateError = LoginValidateError.none;
    updateUI();
    if (_userId.isEmpty) {
      isShowLoading = false;
      _loginValidateError = LoginValidateError.userIdNull;
      updateUI();
      return;
    }

    if (_password.isEmpty) {
      isShowLoading = false;
      _loginValidateError = LoginValidateError.passwordNull;
      updateUI();
      return;
    }
    await _userRepository
        .login(_userId, _password)
        .then(
      (userEntity) {
        if (userEntity == null) {
          _loginValidateError = LoginValidateError.unauthorized;
        } else {
          _loginValidateError = LoginValidateError.none;
          onSuccess.call("Login success");
        }
      },
    ).catchError(
      (dynamic error) {
        print("[Login Failure] $error");
        if (error is NoInternetException) {
          _loginValidateError = LoginValidateError.noInternet;
        } else {
          _loginValidateError = LoginValidateError.unauthorized;
        }
      },
    );
    isShowLoading = false;
    updateUI();
  }
}
