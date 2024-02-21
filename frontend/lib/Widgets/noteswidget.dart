import 'package:flutter/material.dart';
import 'package:pediapp/Classes/note.dart';
import 'package:pediapp/Pages/Consultant/createnotepage.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';
import 'package:pediapp/Widgets/notewidget.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notes",
          style: commonTextStyle,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return NoteWidget(
                    note: Note(
                        senderName: "Canan Misli",
                        receiverName: "Defne Görmez",
                        date: DateTime.parse("2024-01-24"),
                        time: const TimeOfDay(hour: 19, minute: 54),
                        content:
                            "First of all, we can say that we have made good progress compared to 1 month ago. We are progressing completely except for a few assignments. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet orci sodales, tempor augue eu, sodales lorem. Suspendisse iaculis rhoncus libero in malesuada. Suspendisse eleifend tempus urna id scelerisque. Aliquam et tellus at enim laoreet congue. Duis in consectetur ante. Nunc sagittis semper dui, non rutrum ipsum cursus sed. Etiam malesuada mollis sollicitudin. Etiam in consectetur enim, sit amet rutrum dolor. Nunc euismod lacinia libero, sed feugiat turpis hendrerit vulputate. Mauris tempus vulputate vestibulum. Sed eu ligula sit amet erat aliquet bibendum eget sit amet ligula. Mauris suscipit auctor felis, vitae sollicitudin erat tempus non. Phasellus bibendum nisi in aliquam ultrices. Mauris rutrum, nisl et aliquet dignissim, sem dui cursus arcu, sit amet accumsan quam risus vel ligula. Fusce dapibus tristique eros, et bibendum massa elementum vitae. Nulla facilisi."));
              }),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.0),
            child: SizedBox(
              width: 148,
              height: 40,
              child: ElevatedButton(
                style: whiteInsideButtonStyle(131, 40),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CreateNotePage();
                  }));
                },
                child: const Row(
                  children: [Icon(Icons.add), Text("Create Note")],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
