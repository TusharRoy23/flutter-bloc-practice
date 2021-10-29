import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/login/login_bloc.dart';

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

// class LoginElementScreen extends StatefulWidget {
//   const LoginElementScreen({Key? key}) : super(key: key);

//   @override
//   _LoginElementScreenState createState() => _LoginElementScreenState();
// }

class LoginElementScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final AuthRepository _authRepository = AuthRepository();

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
                // if (state is LoginLoadingState) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else if (state is LoginInitialState) {
                //   return ElevatedButton(
                //     onPressed: () {
                //       context.read<LoginBloc>().add(
                //             LoginAuthValue(
                //               username: _usernameController.value.text,
                //               password: _passwordController.value.text,
                //             ),
                //           );
                //       context.read<LoginBloc>().add(const LoginSubmitted());
                //     },
                //     child: Text('LOGIN'),
                //   );
                // } else {
                //   return Center();
                // }
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
                  child: Text('LOGIN'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
