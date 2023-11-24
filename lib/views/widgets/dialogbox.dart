import 'package:flutter/material.dart';
import 'package:todo_api/models/todo_model.dart';
import 'package:todo_api/services/todoservices.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.titlecontroller,
    required this.descriptioncontroller,
  });

  final TextEditingController titlecontroller;
  final TextEditingController descriptioncontroller;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget.titlecontroller,
                decoration: const InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.descriptioncontroller,
                decoration: const InputDecoration(
                    hintText: 'Description', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    createNote();
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  createNote() {
    final title = widget.titlecontroller.text;
    final description = widget.descriptioncontroller.text;
    TodoApiServices()
        .createTodo(TodoModel(title: title, description: description));
    setState(() {
      TodoApiServices().getTodo();
    });
    widget.titlecontroller.clear();
    widget.descriptioncontroller.clear();
    Navigator.pop(context);
  }
}
