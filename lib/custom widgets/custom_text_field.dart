import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Icon suffixIcon;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w200),
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.black26
      ),
    );
  }
}
