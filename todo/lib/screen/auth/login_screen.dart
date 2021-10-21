import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {},
                onSaved: (value) {},
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {},
                onSaved: (value) {},
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
