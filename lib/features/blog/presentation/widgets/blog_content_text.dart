import 'package:flutter/material.dart';

class BlogContentText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool mutliline;
  const BlogContentText(
      {super.key,
      required this.hintText,
      required this.controller,
      this.mutliline = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      minLines: mutliline ? 2 : 1,
      maxLines: mutliline ? null : 1,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
