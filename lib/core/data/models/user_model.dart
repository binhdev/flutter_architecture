
class UserModel {
  String? _loginId;
  String? _password;
  String? _accessToken;

  String? get loginId => _loginId;

  String? get password => _password;

  String? get accessToken => _accessToken;


  static UserModel? _instance;

  /// Constructor
  UserModel._();

  factory UserModel() {
    return _instance ??= UserModel._();
  }

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  void create({
    required String? loginId,
    required String? password,
    required String? accessToken,
  }) {
    _loginId = loginId;
    _password = password;
    _accessToken = accessToken;
  }
}
