import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Note',
                style: GoogleFonts.rubik(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: widget.titlecontroller,
                decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.descriptioncontroller,
                maxLines: 4,
                decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        createNote();
                      },
                      child: const Text('Add')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))
                ],
              )
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
