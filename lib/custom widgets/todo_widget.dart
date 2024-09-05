import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final VoidCallback onListTap;
  final bool initialCheckedState;
  final Function(bool?) clickCheckbox;
  const TodoWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.clickCheckbox,
    required this.onListTap,
    required this.initialCheckedState,
  });

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late bool isTicked;
  @override
  void initState() {
    super.initState();
    isTicked = widget.initialCheckedState;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue[300]),
      child: ListTile(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: isTicked ? TextDecoration.lineThrough : null,
              decorationColor: Colors.white),
        ),
        subtitle: Text(widget.subTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            )),
        onTap: widget.onListTap,
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              isTicked = !isTicked;
            });
            widget.clickCheckbox(isTicked);
          },
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: isTicked,
              onChanged: (bool? value) {
                setState(() {
                  isTicked = value ?? false;
                });
                widget.clickCheckbox(isTicked);
              },
              checkColor: Colors.black,
              fillColor: WidgetStateProperty.all(const Color.fromARGB(70, 255, 255, 255)),
              side: const BorderSide(color: Colors.white,width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
