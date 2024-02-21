import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => {
                            print(_noteController.text),
                            if (_noteController.text == "")
                              {Navigator.pop(context)}
                            else
                              {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Do you want to discard the note and go back?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();

                                              },
                                              child: const Text("Yes"))
                                        ],
                                      );
                                    })
                              }
                          },
                      color: MyColors.primary,
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  const Text(
                    "Create Note",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: MyColors.primary),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  controller: _noteController,
                  maxLines: 15,
                  cursorColor: MyColors.primary,
                  decoration: const InputDecoration(
                    hintText: 'Enter your note here',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: MyColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: MyColors.primary),
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: whiteInsideButtonStyle(100, 40),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: MyColors.primary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
