import 'dart:async';

import 'package:connectivity/connectivity.dart';

class NetworkUtils {
  static ConnectivityResult _connectivityResult = ConnectivityResult.none;

  static void setConnectivityResult(ConnectivityResult result) {
    _connectivityResult = result;
  }

  static Future connect() async {
    _connectivityResult = await Connectivity().checkConnectivity();
  }

  static bool hasConnection() {
    if (_connectivityResult == ConnectivityResult.mobile) return true;
    if (_connectivityResult == ConnectivityResult.wifi) return true;
    return false;
  }

  static Stream<ConnectivityResult> connectionListener() {
    return Connectivity().onConnectivityChanged;
  }
}
