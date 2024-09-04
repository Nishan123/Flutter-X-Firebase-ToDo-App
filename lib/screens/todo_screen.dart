import 'package:firebase_todo_app/custom%20widgets/custom_button.dart';
import 'package:firebase_todo_app/database/database_methods.dart';
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      description,
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    CustomButton(
                      text: "Mark as Complete    ",
                      onPressed: () {},
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
