import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool isObsureText;
  final TextEditingController controller;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      obscureText: isObsureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "You are missing $hintText";
        }
        return null;
      },
    );
  }
}
