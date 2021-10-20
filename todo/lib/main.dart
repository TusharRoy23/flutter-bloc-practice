import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_repository/money_repository.dart';
import 'package:todo/home.dart';
import 'package:todo/logic/bloc/addition_bloc.dart';
import 'package:todo/logic/cubit/addition_cubit.dart';
import 'package:todo/logic/utility/app_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // FirebaseMoneyRepository _moneyRepository = FirebaseMoneyRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AdditionCubit>(
        //   create: (context) =>
        //       AdditionCubit(moneyRepository: FirebaseMoneyRepository()),
        // ),
        BlocProvider<AdditionBloc>(
          create: (context) => AdditionBloc(FirebaseMoneyRepository())
            ..add(GetTransactionListEvent()),
        ),
        // BlocProvider<TransactionListCubit>(
        //   create: (context) =>
        //       TransactionListCubit(moneyRepository: _moneyRepository),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
