import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todos_bloc.dart';
import 'package:todo/model/todo.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
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
