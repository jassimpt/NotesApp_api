import 'package:flutter/material.dart';
import 'package:todo_api/models/todo_model.dart';
import 'package:todo_api/services/todoservices.dart';
import 'package:todo_api/views/widgets/dialogbox.dart';
import 'package:todo_api/views/widgets/notecard.dart';
import 'package:todo_api/views/widgets/shimmer_loader.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    TodoApiServices().getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DialogBox(
                    titlecontroller: titlecontroller,
                    descriptioncontroller: descriptioncontroller);
              },
            );
          },
          backgroundColor: const Color.fromARGB(255, 200, 200, 200),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text('NoteTaker',
                    style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              FutureBuilder<List<TodoModel>>(
                future: TodoApiServices().getTodo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerLoader();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.hasError.toString());
                  } else {
                    return Expanded(
                        child: NoteCard(
                      snapshot: snapshot,
                    ));
                  }
                },
              ),
            ],
          ),
        ));
  }
}
