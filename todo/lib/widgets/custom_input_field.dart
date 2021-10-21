import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;

  String get text => controller.value.text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      onSubmitted: (value) {},
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
