import 'package:flutter/material.dart';

class DialogBox {
  // DailogBox._();
  static void showDailogBox(BuildContext context, String dialog) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(
          dialog,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
