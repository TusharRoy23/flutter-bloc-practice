import 'package:basic_one/logic/cubit/counter_cubit.dart';
import 'package:basic_one/presentation/screen/home_screen.dart';
import 'package:basic_one/presentation/screen/second_screen.dart';
import 'package:basic_one/presentation/screen/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    // Using Global Access
    // final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: "Home Screen",
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color: Colors.redAccent,
            // homeScreenKey: key,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Thirst Screen",
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }

    // switch (settings.name) {
    //   case '/':
    //     return MaterialPageRoute(
    //       builder: (_) => BlocProvider.value(
    //         value: _counterCubit,
    //         child: HomeScreen(
    //           title: "Home Screen",
    //           color: Colors.blueAccent,
    //         ),
    //       ),
    //     );
    //   case '/second':
    //     return MaterialPageRoute(
    //       builder: (_) => BlocProvider.value(
    //         value: _counterCubit,
    //         child: SecondScreen(
    //           title: "Second Screen",
    //           color: Colors.redAccent,
    //           // homeScreenKey: key,
    //         ),
    //       ),
    //     );
    //   case '/third':
    //     return MaterialPageRoute(
    //       builder: (_) => BlocProvider.value(
    //         value: _counterCubit,
    //         child: ThirdScreen(
    //           title: "Thirst Screen",
    //           color: Colors.greenAccent,
    //         ),
    //       ),
    //     );
    //   default:
    //     return null;
    // }
  }

  // void dispose() {
  //   _counterCubit.close();
  // }
}
