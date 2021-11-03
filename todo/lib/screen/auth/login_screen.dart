import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/constants/enums.dart';
import 'package:todo/logic/bloc/login/login_bloc.dart';
import 'package:todo/logic/cubit/internet_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        RepositoryProvider.of<AuthRepository>(context),
      ),
      child: LoginElementScreen(),
    );
  }
}

class LoginElementScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {},
                onSaved: (value) {},
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {},
                onSaved: (value) {},
              ),
              SizedBox(
                height: 50,
              ),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(
                          LoginAuthValue(
                            username: _usernameController.value.text,
                            password: _passwordController.value.text,
                          ),
                        );
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  },
                  child: state is LoginLoadingState
                      ? CircularProgressIndicator(
                          color: Colors.white70,
                        )
                      : Text('LOGIN'),
                );
              }),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginExceptionState) {
                  return Text(state.message[0]);
                }
                return Center();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
