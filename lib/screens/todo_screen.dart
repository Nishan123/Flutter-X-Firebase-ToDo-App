import 'package:firebase_todo_app/custom%20widgets/custom_button.dart';
import 'package:firebase_todo_app/database/database_methods.dart';
import 'package:firebase_todo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  final String todoId;
  const TodoScreen({
    super.key,
    required this.todoId,
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Todo"), actions: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm delete"),
                      content: const Text(
                          "Are you sure you want to Delete this list ?"),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              DatabaseMethods()
                                  .deleteTodo(widget.todoId)
                                  .then((_) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              });
                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.delete)),
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: StreamBuilder<Map<String, dynamic>?>(
              stream: DatabaseMethods().getSpecificTodo(widget.todoId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var todoData = snapshot.data;
                String title = todoData?["Title"];
                String description = todoData?["Description"];
                String date = todoData?["Date added"];
                String time = todoData?["Time added"];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          date,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const Spacer(),
                        Text(
                          time,
                          style: const TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Save changes ",
                      onPressed: () {
                        //Todo: add update functionality
                      },
                      suffixIcon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
