import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/change_password/presentation/page/change_password.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/page/home.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/page/login.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => HomePage());
      case CHANGE_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
