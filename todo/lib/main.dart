import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_api/meta_api.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';
import 'package:todo/landing_screen.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';
import 'package:todo/logic/cubit/exception_cubit.dart';
import 'package:todo/logic/cubit/internet_cubit.dart';
import 'package:todo/logic/simple_bloc_observer.dart';

import 'logic/bloc/filtered_todos/filtered_todos_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: await getTemporaryDirectory(),
  // );
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MyApp(
      connectivity: Connectivity(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Connectivity connectivity;
  final AuthRepository _authRepository = AuthRepository();
  final ErrorHandlerRepository _errorHandlerRepository =
      ErrorHandlerRepository();
  MyApp({required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _errorHandlerRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<ExceptionCubit>(
            create: (_) => ExceptionCubit(_errorHandlerRepository),
          ),
          // BlocProvider<ExceptionBloc>(create: (_) => ExceptionBloc()),
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              _authRepository,
              InternetCubit(connectivity: connectivity),
            ),
          ),
          BlocProvider<TodosBloc>(
            create: (_) => TodosBloc(
              TodoRepository(),
              _errorHandlerRepository,
            )..add(
                TodosLoadedEvent(),
              ),
          ),
          BlocProvider<FilteredTodosBloc>(
            create: (context) => FilteredTodosBloc(
              todosBloc: BlocProvider.of<TodosBloc>(context),
            ),
          ),
        ],
        child: LandingScreen(),
      ),
    );
    // return RepositoryProvider.value(
    //   value: _authRepository,
    // child: MultiBlocProvider(
    //   providers: [
    //     BlocProvider<InternetCubit>(
    //       create: (_) => InternetCubit(connectivity: connectivity),
    //     ),
    //     BlocProvider<ExceptionCubit>(
    //       create: (_) => ExceptionCubit(_errorHandlerRepository),
    //     ),
    //     // BlocProvider<ExceptionBloc>(create: (_) => ExceptionBloc()),
    //     BlocProvider<AuthBloc>(
    //       create: (_) => AuthBloc(
    //         _authRepository,
    //         InternetCubit(connectivity: connectivity),
    //       ),
    //     ),
    //     BlocProvider<TodosBloc>(
    //       create: (_) => TodosBloc(
    //         TodoRepository(),
    //       )..add(
    //           TodosLoadedEvent(),
    //         ),
    //     ),
    //   ],
    //   child: LandingScreen(),
    // ),
    // );
  }
}
