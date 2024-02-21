import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Widgets/assignmentcardwidget.dart';

class UpcomingAssignmentsWidget extends StatefulWidget {
  const UpcomingAssignmentsWidget({super.key, required this.assignments});

  final List<Assignment> assignments;

  @override
  State<UpcomingAssignmentsWidget> createState() =>
      _UpcomingAssignmentsWidgetState();
}

class _UpcomingAssignmentsWidgetState extends State<UpcomingAssignmentsWidget> {
  int itemCount = 0;
  bool isMoreVisible = false;
  bool isLessVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.assignments.length > 3) {
      itemCount = 3;
      isMoreVisible = true;
    } else {
      itemCount = widget.assignments.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Assignments",
            style: commonTextStyle,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return AssignmentWidget(assignment: widget.assignments[index]);
            },
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (isMoreVisible)
                  ElevatedButton(
                      onPressed: () {
                        int tempItemCount = itemCount + 3;
                        bool tempIsMoreVisible = true;
                        if (tempItemCount >= widget.assignments.length) {
                          tempItemCount = widget.assignments.length;
                          tempIsMoreVisible = false;
                        }
                        setState(() {
                          itemCount = tempItemCount;
                          isMoreVisible = tempIsMoreVisible;
                          isLessVisible = true;
                        });
                      },
                      style: whiteInsideButtonStyle(120, 40),
                      child: const Text("Show More")),
                if (isLessVisible)
                  ElevatedButton(
                      onPressed: () {
                        int tempItemCount = itemCount - 3;
                        bool tempIsLessVisible = true;
                        if (tempItemCount <= 3) {
                          tempItemCount = 3;
                          tempIsLessVisible = false;
                        }
                        setState(() {
                          itemCount = tempItemCount;
                          isMoreVisible = true;
                          isLessVisible = tempIsLessVisible;
                        });
                      },
                      style: whiteInsideButtonStyle(120, 40),
                      child: const Text("Show Less")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

TextStyle commonTextStyle = const TextStyle(
    color: MyColors.primary, fontSize: 16, fontWeight: FontWeight.bold);

ButtonStyle whiteInsideButtonStyle(double width, double height) {
  return ElevatedButton.styleFrom(
    foregroundColor: MyColors.primary, backgroundColor: Colors.white,
    minimumSize: Size(width, height),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: MyColors.primary, width: 2),
    ),
  );
}

ButtonStyle purpleInsideButtonStyle(double width, double height) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: MyColors.primary,
    minimumSize: Size(width, height),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: MyColors.primary, width: 2),
    ),
  );
}
