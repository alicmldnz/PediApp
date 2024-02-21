import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/parent_profile.dart';
import 'package:pediapp/Classes/meeting.dart';
import 'package:pediapp/Widgets/parentprofilewidget.dart';
import 'package:pediapp/Widgets/recentmeetingswidget.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class MyAssignmentsPage extends StatefulWidget {
  const MyAssignmentsPage(
      {super.key,
      required this.parentprofile,
      required this.assignments,
      required this.meetings});

  final ParentProfile parentprofile;
  final List<Assignment> assignments;
  final List<Meeting> meetings;

  @override
  State<MyAssignmentsPage> createState() => _MyAssignmentsPageState();
}

class _MyAssignmentsPageState extends State<MyAssignmentsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: RefreshIndicator(
          color: MyColors.primary,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
          child: ListView(padding: const EdgeInsets.all(16), children: [
            ParentProfileWidget(profile: widget.parentprofile, isConsultant: false),
            RecentMeetingsWidget(meetings: widget.meetings),
            Center(
              child: ElevatedButton(
                style: whiteInsideButtonStyle(120, 60),
                onPressed: () {},
                child: const Column(
                  children: [
                    Icon(Icons.add_circle_outline),
                    Text("Daily Report")
                  ],
                ),
              ),
            ),
            UpcomingAssignmentsWidget(assignments: widget.assignments),
          ]),
        ),
      ),
    );
  }
}
