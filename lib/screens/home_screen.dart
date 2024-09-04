import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo_app/custom%20widgets/todo_widget.dart';
import 'package:firebase_todo_app/database/database_methods.dart';
import 'package:firebase_todo_app/screens/add_todo_screen.dart';
import 'package:firebase_todo_app/screens/todo_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool checkedState = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo Lists",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Logout"),
                          content: const  Text("Are you sure you want to logout?"),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  DatabaseMethods().signOut(context);
                                },
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTodoScreen()));
          },
          backgroundColor: Colors.blue[300],
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StreamBuilder<QuerySnapshot>(
              stream: DatabaseMethods().getTodos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No Todo Items Found'));
                }
                final todoList = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final todo =
                          todoList[index].data() as Map<String, dynamic>;
                      bool checkedState = todo["isCompleted"] ?? false;
                      return TodoWidget(
                        title: todo["Title"],
                        subTitle: todo["Description"],
                        clickCheckbox: (bool? value) {
                          DatabaseMethods().checkTodo(
                            todo["Todo Id"],
                            value ?? false,
                          );
                        },
                        onListTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoScreen(todoId: todo["Todo Id"])));
                        },
                        initialCheckedState: checkedState,
                      );
                    });
              }),
        ));
  }
}
