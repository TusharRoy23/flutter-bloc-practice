import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';
import 'package:todo/landing_screen.dart';
import 'package:todo/logic/cubit/internet_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Connectivity connectivity;
  final AuthRepository _authRepository = AuthRepository();
  MyApp({required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      // child: BlocProvider(
      //   create: (_) => AuthBloc(
      //     _authRepository,
      //     InternetCubit(connectivity: connectivity),
      //   ),
      //   child: LandingScreen(),
      // ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              _authRepository,
              InternetCubit(connectivity: connectivity),
            ),
          )
        ],
        child: LandingScreen(),
      ),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BlocConsumer<InternetCubit, InternetState>(
      //   builder: (_, state) => LandingScreen(),
      //   listener: (_, state) {
      //     if (state is InternetDisconnected) {
      //       showDialog(
      //         context: context,
      //         builder: (BuildContext context) => AlertDialog(
      //           content: const Text(
      //             'No Internet Connection!',
      //             style: TextStyle(
      //               fontSize: 20,
      //             ),
      //           ),
      //           actions: <Widget>[
      //             TextButton(
      //               onPressed: () => Navigator.pop(context, 'OK'),
      //               child: const Text('OK'),
      //             ),
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<InternetCubit, InternetState>(
              listener: (_, state) {
                if (state is InternetDisconnected) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text(
                        'No Internet Connection!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            LandingScreen(),
          ],
        ),
      ),
    );
  }
}

class InternetChecker extends StatelessWidget {
  const InternetChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
      builder: (_, state) {
        return LandingScreen();
      },
      listener: (ctx, state) {
        log('listen state: $state');
        if (state is InternetDisconnected) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: const Text(
                'No Internet Connection!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
