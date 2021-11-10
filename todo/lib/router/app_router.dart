import 'package:flutter/material.dart';
import 'package:todo/screen/auth/login_screen.dart';
import 'package:todo/screen/todo/todo_screen.dart';
import 'package:todo/splash_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SplashPage.route();
      case '/login':
        return LoginScreen.route();
      case '/todo':
        return TodoScreen.route();
      // case '/todo-details':
      //   return TodoDetails.route();
      default:
        return null;
    }
  }
}
