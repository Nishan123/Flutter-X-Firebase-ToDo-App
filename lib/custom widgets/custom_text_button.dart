import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final String prefixText;
  final VoidCallback onPressed;
  const CustomTextButton(
      {super.key,
      required this.buttonText,
      required this.prefixText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefixText),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
