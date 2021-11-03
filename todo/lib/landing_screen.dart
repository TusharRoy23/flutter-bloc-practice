import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';
import 'package:todo/screen/auth/login_screen.dart';
import 'package:todo/screen/todo/todo_screen.dart';
import 'package:todo/splash_page.dart';

import 'logic/cubit/internet_cubit.dart';

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
            if (state is AuthenticatedState) {
              _navigator.pushAndRemoveUntil<void>(
                TodoScreen.route(),
                (route) => false,
              );
            } else if (state is UnAuthenticatedState) {
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
    // return Container(
    //   child: BlocListener<AuthBloc, AuthState>(
    //     listener: (context, state) {
    //       if (state is AuthenticatedState) {
    //         _navigator.pushAndRemoveUntil<void>(
    //           TodoScreen.route(),
    //           (route) => false,
    //         );
    //       } else if (state is UnAuthenticatedState) {
    //         _navigator.pushAndRemoveUntil<void>(
    //           LoginScreen.route(),
    //           (route) => false,
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
