import 'package:TodoApp/custom%20widgets/custom_button.dart';
import 'package:TodoApp/database/database_methods.dart';
import 'package:TodoApp/screens/home_screen.dart';
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
                                        builder: (_) => const HomeScreen()));
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
                TextEditingController descriptionController =
                    TextEditingController(text: description);
                TextEditingController titleController =
                    TextEditingController(text: title);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      minLines: 1,
                      maxLines: null,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
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
                    TextField(
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.black87),
                      minLines: 1,
                      maxLines: null,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Save changes ",
                      onPressed: () {
                        //Todo: add update functionality
                        Map<String, dynamic> updatedTodo = {
                          "Title": titleController.text.toString(),
                          "Description": descriptionController.text.toString()
                        };
                        DatabaseMethods()
                            .updateTodo(updatedTodo, widget.todoId);
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
