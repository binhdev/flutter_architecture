import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture_sample/ui/views/login_view.dart';

class TopScreenNavigatorRoutes {
  static const String loginRoute = 'login';

  static TopScreenNavigatorRoutes? _instance;

  const TopScreenNavigatorRoutes._();

  factory TopScreenNavigatorRoutes() =>
      _instance ??= const TopScreenNavigatorRoutes._();

  void destroyInstance() {
    _instance = null;
  }

  String initialRoute() => loginRoute;

  // void openMainView(BuildContext context) {
  //   Navigator.pushReplacementNamed(context, mainRoute);
  // }

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch (settings.name) {
      // TODO: Add more view here route
      case loginRoute:
        return  MaterialPageRoute<dynamic>(
          builder: (_) => const LoginView(),
        );
      default:
        return  MaterialPageRoute<dynamic>(
          builder: (_) => const LoginView(),
        );
    }
  }
}
