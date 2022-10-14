import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_architecture_sample/core/constants/api_end_point.dart';
import 'package:flutter_architecture_sample/core/data/remote/api/api_exception.dart';
import 'package:flutter_architecture_sample/core/data/remote/entity/user_entity.dart';
import 'package:flutter_architecture_sample/core/data/remote/services/base_service.dart';


class UserService extends BaseService {
  /// 1101_ログイン処理
  Future<UserEntity?> login(String userId, String password) async {
    UserEntity result;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(
        parseURI(ApiEndPointConstants.login),
        headers: headers,
        body: '{"loginId": "$userId", "password": "$password"}',
      );
      result = UserEntity.fromJson(returnResponse(response));
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    }
    return result;
  }
}
