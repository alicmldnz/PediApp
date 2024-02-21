import 'package:flutter/material.dart';
import 'package:pediapp/Classes/meeting.dart';
import 'package:pediapp/Widgets/recentmeetingcardwidget.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class RecentMeetingsWidget extends StatefulWidget {
  const RecentMeetingsWidget({super.key, required this.meetings});

  final List<Meeting> meetings;

  @override
  State<RecentMeetingsWidget> createState() => _RecentMeetingsWidgetState();
}

class _RecentMeetingsWidgetState extends State<RecentMeetingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Meetings",
          style: commonTextStyle,
        ),
        SizedBox(
            height: 164,
            child: (widget.meetings.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.meetings.length,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          return RecentMeetingCardWidget(
                              meeting: widget.meetings[index]);
                        }),
                  )
                : const Center(child: Text("No meetings yet")))
      ],
    );
  }
}
