import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';

class TodoDetails extends StatelessWidget {
  const TodoDetails({Key? key}) : super(key: key);

  static Page route() {
    return MaterialPage(child: TodoDetails());
  }

  @override
  Widget build(BuildContext context) {
    return TodoDetailsItem();
  }
}

class TodoDetailsItem extends StatefulWidget {
  TodoDetailsItem({Key? key, this.id}) : super(key: key);

  final int? id;

  @override
  _TodoDetailsItemState createState() => _TodoDetailsItemState();
}

class _TodoDetailsItemState extends State<TodoDetailsItem> {
  ValueNotifier<bool> _isFormDirty = ValueNotifier(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _titleController = TextEditingController();

  var _descriptionController = TextEditingController();

  ValueNotifier<Map<String, dynamic>> _formElement = ValueNotifier({
    'id': 0,
    'title': '',
    'description': '',
    'createdDate': '',
  });

  RoundedRectangleBorder _rectangleBorder() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      color: Color.fromARGB(200, 250, 242, 175),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: <Widget>[
          _saveIcon(),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BlocBuilder<TodosBloc, TodosState>(
            builder: (_, state) {
              if (state is TodoLoadSuccess) {
                var todo =
                    state.todos.firstWhere((todo) => todo.id == widget.id);
                _formElement.value['title'] = todo.title;
                _titleController.text = todo.title;

                _formElement.value['description'] = todo.description;
                _descriptionController.text = todo.description;

                _formElement.value['id'] = todo.id;
                _formElement.value['createdDate'] = todo.createdDate;
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        shape: _rectangleBorder(),
                        child: Container(
                          decoration: _boxDecoration(),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Title:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              _buildTitle(todo.title),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Description:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              _buildDescription(todo.description),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Text('No Details');
            },
          ),
        ),
      ),
    );
  }

  void _toogleIsSaveItem() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    Todo todo = Todo().copyWith(
      id: _formElement.value['id'],
      title: _titleController.value.text,
      description: _descriptionController.value.text,
      createdDate: _formElement.value['createdDate'],
    );
    BlocProvider.of<TodosBloc>(context).add(TodoUpdateEvent(todo));
  }

  Widget _saveIcon() {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: _isFormDirty,
        builder: (_, bool _isDirty, __) {
          return IconButton(
            onPressed: _isDirty ? _toogleIsSaveItem : null,
            icon: Icon(Icons.save),
          );
        },
      ),
    );
  }

  TextFormField _buildTitle(String title) {
    return TextFormField(
      controller: _titleController,
      textInputAction: TextInputAction.next,
      validator: (value) => value!.isEmpty ? 'Title is required.' : null,
      onChanged: (value) {
        _isFormDirty.value = true;
      },
    );
  }

  TextFormField _buildDescription(String description) {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 10,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      validator: (value) => value!.isEmpty ? 'Description is required!' : null,
      onChanged: (value) {
        _isFormDirty.value = true;
      },
    );
  }
}
