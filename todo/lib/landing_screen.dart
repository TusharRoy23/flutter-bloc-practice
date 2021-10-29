import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/screen/auth/login_screen.dart';
import 'package:todo/screen/todo/todo_screen.dart';
import 'package:todo/splash_page.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // log('now state: ${state.status}');
            // switch (state.status) {
            //   case AuthenticationStatus.authenticated:
            //     _navigator.pushAndRemoveUntil<void>(
            //       TodoScreen.route(),
            //       (route) => false,
            //     );
            //     break;
            //   case AuthenticationStatus.unauthenticated:
            //     _navigator.pushAndRemoveUntil<void>(
            //       LoginScreen.route(),
            //       (route) => false,
            //     );
            //     break;
            //   default:
            //     break;
            // }

            if (state is AuthenticatedState) {
              _navigator.pushAndRemoveUntil<void>(
                TodoScreen.route(),
                (route) => false,
              );
            } else {
              _navigator.pushAndRemoveUntil<void>(
                LoginScreen.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
