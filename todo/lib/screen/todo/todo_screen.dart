import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/bloc/todos/todos_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => TodoScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosBloc>(
      create: (context) => TodosBloc(
        todoRepository: TodoRepository(),
      )..add(
          TodosLoaded(),
        ),
      child: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  var _titleController = TextEditingController();
  AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<TodosBloc, TodosState>(
        builder: (_, state) {
          if (state is TodoLoadInProgress)
            return Center(child: CircularProgressIndicator());
          else if (state is TodoLoadSuccess) {
            final todo = state.todos;
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: todo.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text(todo[index].title),
                );
              },
            );
          }
          return Center();
        },
        listener: (ctx, state) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void modalBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                validator: (value) {},
                onSaved: (value) {},
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Create'),
              )
            ],
          ),
        );
      },
    );
  }
}
