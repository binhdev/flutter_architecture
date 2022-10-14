// HTTP Error 401 – Unauthorized
// HTTP Error 400 – Bad Request
// HTTP Error 404 – Page Not Found
// HTTP Error 403 – Forbidden Error
// HTTP Error 500 – Internal Error
// HTTP Error 503 – Service Unavailable
enum StatusCode {
  none,
  success,
  unauthorized,
  badRequest,
  pageNotFound,
  forbiddenError,
  internalError,
  serviceUnavailable,
}

class ApiException implements Exception {
  final String? _message;
  final String? _prefix;
  final StatusCode? _statusCode;

  ApiException([this._message, this._prefix, this._statusCode]);

  @override
  String toString() {
    return "[$_statusCode]$_prefix$_message";
  }
}

class NoInternetException extends ApiException {
  NoInternetException([String? message])
      : super(message, "Internet failure: ", StatusCode.none);
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(
            message, "Error during communication: ", StatusCode.internalError);
}

class ForbiddenException extends ApiException {
  ForbiddenException([String? message])
      : super(message, "Forbidden error: ", StatusCode.forbiddenError);
}

class BadRequestException extends ApiException {
  BadRequestException([String? message])
      : super(message, "Invalid request: ", StatusCode.badRequest);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([String? message])
      : super(
          message,
          "Unauthorised request: ",
          StatusCode.unauthorized,
        );
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException([String? message])
      : super(
          message,
          "Service unavailable: ",
          StatusCode.serviceUnavailable,
        );
}
