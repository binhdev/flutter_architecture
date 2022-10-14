import 'dart:convert';

import 'package:flutter_architecture_sample/core/data/remote/api/api_exception.dart';
import 'package:http/http.dart' as http;

abstract class BaseService {
  final String _baseUrl =
      "ADD URL HERE"; // TODO: add url

  Map<String, dynamic> returnResponse(http.Response response) {
    print("[$runtimeType][RESPONSE_RESULT] [${response.statusCode}]");
    switch (response.statusCode) {
      case 200:
        final body = response.body
            .replaceAll("\\\"", "\"")
            .replaceAll("\"{", "{")
            .replaceAll("}\"", "}")
            .toString(); // replace character not support
        dynamic responseJson = jsonDecode(body);
        print("[$runtimeType][responseJson] $responseJson");
        return responseJson as Map<String, dynamic>;
      case 400:
        throw BadRequestException("Error 400");
      case 401:
        throw UnauthorisedException("Error ${response.statusCode}");
      case 403:
        throw ForbiddenException("Error ${response.statusCode}");
      case 500:
        throw FetchDataException(
            'Error occurred while communication with server'
            ' with status code : ${response.statusCode}');
      case 503:
      default:
        throw ServiceUnavailableException(
            'Service unavailable ${response.statusCode}');
    }
  }

  Uri parseURI(String path) {
    return Uri.parse("$_baseUrl$path");
  }
}
