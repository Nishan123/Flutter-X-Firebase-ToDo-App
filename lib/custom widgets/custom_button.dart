import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon? suffixIcon;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(
                width: 1,
              ),
              suffixIcon!

            ]
          ])),
    );
  }
}
