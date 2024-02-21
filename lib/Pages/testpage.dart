import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.assignments});

  final List<Assignment> assignments;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () async {

          },
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Center(
              // List all assignments if there are any. if not show a message
              child: widget.assignments.isNotEmpty
                  ? Column(
                      children: widget.assignments
                          .map((assignment) => Text(assignment.subjectName))
                          .toList(),
                    )
                  : const Text("No assignments"),
            ),
          ]),
        ),
      ),
    );
  }
}
