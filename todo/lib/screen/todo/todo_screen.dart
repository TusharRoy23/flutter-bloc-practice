import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todos_bloc.dart';
import 'package:todo/model/todo.dart';
import 'package:todo_repository/todo_repository.dart';

class TodoScreen extends StatefulWidget {
  // final TodoRepository todoRepository;
  // TodoScreen({Key? key, required this.todoRepository}) : super(key: key);
  TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _titleController = TextEditingController();

  final List<Todo> todoList = [
    Todo(id: 1, title: 'title one', userId: 1),
    Todo(id: 2, title: 'title two', userId: 1),
    Todo(id: 3, title: 'title three', userId: 1),
    Todo(id: 4, title: 'title four', userId: 1),
    Todo(id: 5, title: 'title five', userId: 1),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   widget.todoRepository.getTodo().then((value) {
  //     log('value: ${value[0]}');
  //   }).catchError((error) {
  //     log('I am error');
  //     print('error: $error');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
      ),
      // body: ListView.builder(
      //   itemBuilder: (_, int index) {
      //     return ListTile(
      //       leading: Icon(Icons.list),
      //       title: Text(todoList[index].title),
      //     );
      //   },
      //   itemCount: todoList.length,
      // ),
      body: BlocBuilder<TodosBloc, TodosState>(builder: (_, state) {
        if (state is TodoLoadSuccess) {
          final todo = state.todos;
          return ListView.builder(
            itemBuilder: (_, int index) {
              return ListTile(
                leading: Icon(Icons.list),
                title: Text(todoList[index].title),
              );
            },
            itemCount: todo.length,
          );
        }
        return Center();
      }),
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
                  setState(() {
                    todoList.add(
                      Todo(
                        id: 6,
                        title: _titleController.value.text,
                      ),
                    );
                  });
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
