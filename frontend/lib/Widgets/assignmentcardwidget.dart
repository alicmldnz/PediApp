import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Pages/assignmentpage.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';

class AssignmentWidget extends StatefulWidget {
  const AssignmentWidget({super.key, required this.assignment});

  final Assignment assignment;

  @override
  State<AssignmentWidget> createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 80,
        width: 352,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [MyColors.primary, Color(0xFFE5B6FF)]),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x5C000000), offset: Offset(0, 3), blurRadius: 6)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print("Tapped to ${widget.assignment.subjectName}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AssignmentPage(assignment: widget.assignment)));
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.assignment.consultantName,
                              style: const TextStyle(
                                  color: MyColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.assignment.subjectName,
                              style: const TextStyle(
                                  color: MyColors.white, fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              formatTimeOfDay(widget.assignment.time),
                              style: const TextStyle(
                                  color: MyColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                            ),
                            Text(
                              formatDateTime(widget.assignment.date),
                              style: const TextStyle(
                                  color: MyColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
