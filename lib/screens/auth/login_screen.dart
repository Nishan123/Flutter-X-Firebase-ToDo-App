import 'package:firebase_todo_app/custom%20widgets/custom_button.dart';
import 'package:firebase_todo_app/custom%20widgets/custom_text_button.dart';
import 'package:firebase_todo_app/custom%20widgets/custom_text_field.dart';
import 'package:firebase_todo_app/database/database_methods.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            const Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: "Email",
              textEditingController: emailController,
              suffixIcon: const Icon(
                Icons.person_rounded,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                hintText: "Passsword",
                textEditingController: passwordController,
                suffixIcon: const Icon(
                  Icons.lock_rounded,
                  color: Colors.black54,
                )),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              text: "Login",
              onPressed: () {
                DatabaseMethods().login(
                    context,
                    emailController.text.toString(),
                    passwordController.text.toString());
              },
            ),
            const Spacer(),
            CustomTextButton(
              buttonText: "Login",
              prefixText: "Already have an account?",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )),
    );
  }
}
