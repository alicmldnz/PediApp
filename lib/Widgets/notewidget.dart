import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/note.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key, required this.note});

  final Note note;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  //implement a function to show a box with note dialogs on the screen
  function() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFD86B),
          title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 3, child: Text(widget.note.senderName)),
                Flexible(
                    flex: 2, child: Text(formatDateTime(widget.note.date))),
                Flexible(
                    flex: 1, child: Text(formatTimeOfDay(widget.note.time)))
              ]),
          titleTextStyle: const TextStyle(
              color: MyColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 3),
            child: SingleChildScrollView(


              child: Text(
                widget.note.content,
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: commonTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        height: 144,
        width: 104,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFFD86B),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5C000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              function();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDateTime(widget.note.date),
                        style: localTextStyle,
                      ),
                      Text(
                        formatTimeOfDay(widget.note.time),
                        style: localTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.note.content,
                    maxLines: 5,
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle localTextStyle = const TextStyle(
      color: MyColors.primary, fontSize: 10, fontWeight: FontWeight.bold);
}
