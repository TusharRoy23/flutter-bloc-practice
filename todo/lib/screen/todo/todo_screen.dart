import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/constants/dialog_box.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';
import 'package:todo/logic/bloc/filtered_todos/filtered_todos_bloc.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';
import 'package:todo/logic/cubit/exception_cubit.dart';
import 'package:todo/logic/cubit/internet_cubit.dart';
import 'package:todo/screen/todo/todo_details.dart';
import 'package:todo/widgets/filter_button.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => TodoScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (_, state) {
        if (state is InternetDisconnected)
          DialogBox.showDailogBox(context, 'No Internet Connection!');
      },
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
  var _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        actions: [
          FilterButton(),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<FilteredTodosBloc, FilteredTodosState>(
        builder: (_, state) {
          if (state is TodoLoadInProgress)
            return Center(child: CircularProgressIndicator());
          else if (state is FilteredTodosLoadSuccess) {
            final todo = state.filteredTodos;
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: todo.length,
              itemBuilder: (_, int index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text(todo[index].title),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return TodoDetailsItem(
                            id: todo[index].id,
                          );
                        },
                      ),
                    );
                  },
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
          BlocProvider.of<TodosBloc>(context).add(ErrorClearEvent());
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Title:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                validator: (value) {},
                onSaved: (value) {},
              ),
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                textInputAction: TextInputAction.next,
                maxLines: 10,
                validator: (value) {},
                onSaved: (value) {},
              ),
              ElevatedButton(
                onPressed: () {
                  Todo todo = Todo(
                    id: 220,
                    title: _titleController.value.text,
                    description: _descriptionController.value.text,
                  );
                  BlocProvider.of<TodosBloc>(context).add(
                    TodoCreateEvent(todo),
                  );
                },
                child: Text('Create'),
              ),
              BlocConsumer<ExceptionCubit, ExceptionState>(
                builder: (_, state) {
                  if (state is ExceptionMessage) {
                    if (state.message.isNotEmpty) {
                      return Text(state.message[0]);
                    }
                    return Container();
                  }
                  return Container();
                },
                listener: (_, state) {
                  if (state is FormStatusState) {
                    if (state.status) {
                      _titleController.clear();
                      _descriptionController.clear();
                      Navigator.pop(context);
                    }
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
