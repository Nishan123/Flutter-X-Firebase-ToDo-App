import 'package:flutter/material.dart';

class MultiLinedTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const MultiLinedTextField({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      minLines: 1,
      maxLines: null,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.description,color: Colors.black26,),
        hintText: "Descrption here......",
        hintStyle:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.w200),
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}
