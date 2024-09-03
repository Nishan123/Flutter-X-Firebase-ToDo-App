import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/screens/auth/signup_screen.dart';
import 'package:firebase_todo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseMethods {
  Future addTodo(Map<String, dynamic> todoMap, String todoId) {
    return FirebaseFirestore.instance
        .collection("ToDo Lists")
        .doc(todoId)
        .set(todoMap);
  }

  Future checkTodo(String todoId, bool isCompleted) {
    return FirebaseFirestore.instance
        .collection("ToDo Lists")
        .doc(todoId)
        .update({'isCompleted':isCompleted});
  }

  Stream<QuerySnapshot> getTodos() {
    return FirebaseFirestore.instance.collection("ToDo Lists").snapshots();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case "weak-password":
          message = "Password is too weak";
          break;
        case "email-already-in-use":
          message = "Email is already in use";
          break;
        case "user-disabled":
          message = "User account has been disabled.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
          break;
      }
      _showToast(message);
      debugPrint(e.code);
    } catch (e) {
      _showToast("An error occurred: ${e.toString()}");
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case "invalid-email":
          message = "Invalid email! Check again";
          break;
        case "invalid-credential":
          message = "Email or password didn't match";
          break;
        case "user-disabled":
          message = "User account has been disabled.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
          break;
      }
      _showToast(message);
      debugPrint(e.code);
    } catch (e) {
      _showToast("An error occurred: ${e.toString()}");
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().then((user) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignupScreen()));
      });
    } catch (e) {
      _showToast(e.toString());
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
