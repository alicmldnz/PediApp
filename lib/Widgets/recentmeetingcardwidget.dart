import 'package:flutter/material.dart';
import 'package:pediapp/Classes/meeting.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';
import 'package:pediapp/Utils/format_duration.dart';

class RecentMeetingCardWidget extends StatefulWidget {
  const RecentMeetingCardWidget({super.key, required this.meeting});

  final Meeting meeting;

  @override
  State<RecentMeetingCardWidget> createState() =>
      _RecentMeetingCardWidgetState();
}

class _RecentMeetingCardWidgetState extends State<RecentMeetingCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13),
      child: Container(
        height: 144,
        width: 144,
        decoration: BoxDecoration(
            color: meetingColor(widget.meeting.status),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x5C000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              )
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              print("Tapped ${widget.meeting.subject} meeting");
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.meeting.consultantName,
                        style: timeStyles(20),
                      ),
                      Text(
                        widget.meeting.subject,
                        style: timeStyles(12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        formatDuration(widget.meeting.duration),
                        style: timeStyles(10),
                      ),
                      Text(
                        formatTimeOfDay(widget.meeting.time),
                        style: timeStyles(10),
                      ),
                      Text(
                        formatDateTime(widget.meeting.date),
                        style: timeStyles(10),
                      ),
                    ],
                  ),
                  buildRow(widget.meeting.status)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle timeStyles(double fontSize) {
    return TextStyle(color: Colors.white, fontSize: fontSize);
  }

  Color meetingColor(int status) {
    if (status == 0) {
      return const Color(0xFFCF8CF4);
    } else if (status == 1) {
      return const Color(0xFF8BEA8E);
    } else {
      return Colors.grey;
    }
  }

  Row buildRow(int status) {
    if (status == 0) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.warning_amber,
          color: Colors.white,
          size: 12,
        ),
        Text(
          "Not evaluated yet",
          style: timeStyles(12),
        )
      ]);
    } else if (status == 1) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 12,
        ),
        Text(
          "Evaluated",
          style: timeStyles(12),
        )
      ]);
    } else {
      return const Row();
    }
  }
}
