class UserTable {
  static const String tableName = 'users';
  static const String columnId = 'id';
  static const String columnLoginId = 'login_id';
  static const String columnPassword = 'password';
  static const String columnAccessToken = 'access_token'; // アクセストークン

  String? loginId;
  String? password;
  String? accessToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
        columnLoginId: loginId,
        columnPassword: password,
        columnAccessToken: accessToken,
      };

  static List<UserTable> fromJsonList(List<Map> json) {
    List<UserTable> list = [];
    for (Map obj in json) {
      list.add(UserTable.fromJson(obj as Map<String, dynamic>));
    }
    return list;
  }

  UserTable.fromJson(Map<String, dynamic> json) {
    loginId = json[columnLoginId].toString();
    password = json[columnPassword].toString();

    accessToken = json[columnAccessToken].toString();
  }

  UserTable.fromParam({
    this.loginId,
    this.password,
    this.accessToken,
  });

  static String create() {
    return "CREATE TABLE $tableName ("
        "$columnId INTEGER NOT NULL UNIQUE,"
        "$columnLoginId TEXT, "
        "$columnPassword TEXT, "
        "$columnAccessToken TEXT, "
        "PRIMARY KEY($columnId AUTOINCREMENT)"
        ")";
  }
}
