import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/custom%20widgets/custom_button.dart';
import 'package:firebase_todo_app/custom%20widgets/custom_text_field.dart';
import 'package:firebase_todo_app/custom%20widgets/multi_lined_text_field.dart';
import 'package:firebase_todo_app/database/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    DateTime currentDate = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();

    // Formatting the date and time as strings
    String formattedDate =
        "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
String formattedTime = "${currentTime.hourOfPeriod.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')} ${currentTime.period == DayPeriod.am ? 'AM' : 'PM'}";


    String todoId = randomAlphaNumeric(8);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your ToDo List"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                  hintText: "What is to be done?",
                  textEditingController: titleController,
                  suffixIcon: const Icon(Icons.edit)),
              const SizedBox(
                height: 20,
              ),
              MultiLinedTextField(
                textEditingController: descriptionController,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  text: "Add List",
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Title cannot be empty !"),
                              Spacer(),
                              Icon(
                                Icons.error,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      Map<String, dynamic> todoMap = {
                        "Todo Id": todoId,
                        "Title": titleController.text.toString(),
                        "Description": descriptionController.text.toString(),
                        "Date added": formattedDate,
                        "Time added": formattedTime,
                        "isCompleted": false,
                        "uid":FirebaseAuth.instance.currentUser?.uid.toString()
                      };
                      DatabaseMethods().addTodo(todoMap, todoId).then(
                        (_) {
                          Navigator.pop(context);
                        },
                      );
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}
