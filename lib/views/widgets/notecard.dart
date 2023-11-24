import 'package:flutter/material.dart';
import 'package:todo_api/models/todo_model.dart';

class NoteCard extends StatelessWidget {
  AsyncSnapshot<List<TodoModel>> snapshot;
  NoteCard({
    required this.snapshot,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: snapshot.data!.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final tododata = snapshot.data![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(tododata.title!),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(tododata.description!),
              )
            ]),
          ),
        );
      },
    );
  }
}
