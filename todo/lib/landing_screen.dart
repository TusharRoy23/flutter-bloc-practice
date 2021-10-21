import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todos_bloc.dart';
import 'package:todo/screen/auth/login_screen.dart';
import 'package:todo/screen/todo/todo_screen.dart';
import 'package:todo_repository/todo_repository.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return TodoScreen(
    //   todoRepository: TodoRepository(),
    // );
    return BlocProvider<TodosBloc>(
      create: (context) => TodosBloc(
        todoRepository: TodoRepository(),
      ),
      child: TodoScreen(),
    );
  }
}
