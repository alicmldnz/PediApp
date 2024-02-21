import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/consultant_profile.dart';
import 'package:pediapp/Classes/event.dart';
import 'package:pediapp/Classes/meeting.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Widgets/consultantprofilewidget.dart';
import 'package:pediapp/Widgets/recentmeetingswidget.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage(
      {super.key,
      required this.consultantProfile,
      required this.meetings,
      required this.assignments});

  final ConsultantProfile consultantProfile;
  final List<Meeting> meetings;
  final List<Assignment> assignments;

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  DateTime _selectedDay = DateTime.now();
  final Map<String, List<Event>> _events = {
    formatDateTime(DateTime.now()): [
      Event('Event 1', DateTime.now()),
      Event('Event 2', DateTime.now()),
      Event('Event 3', DateTime.now()),
      Event('Event 4', DateTime.now()),
      Event('Event 5', DateTime.now()),
      Event('Event 6', DateTime.now()),
      Event('Event 7', DateTime.now()),
      Event('Event 8', DateTime.now()),
      Event('Event 9', DateTime.now()),
      Event('Event 10', DateTime.now()),
      Event('Event 11', DateTime.now()),
      Event('Event 12', DateTime.now()),
      Event('Event 13', DateTime.now()),
      Event('Event 14', DateTime.now()),
      Event('Event 15', DateTime.now()),
      Event('Event 16', DateTime.now()),
      Event('Event 17', DateTime.now()),
      Event('Event 18', DateTime.now()),
      Event('Event 19', DateTime.now()),
      Event('Event 20', DateTime.now()),
      Event('Event 21', DateTime.now()),
      Event('Event 22', DateTime.now()),
      Event('Event 23', DateTime.now()),
      Event('Event 24', DateTime.now()),
      Event('Event 25', DateTime.now()),
      Event('Event 26', DateTime.now()),
      Event('Event 27', DateTime.now()),
      Event('Event 28', DateTime.now()),
      Event('Event 29', DateTime.now()),
      Event('Event 30', DateTime.now()),
    ],
    "12.02.2024": [
      Event('Event 1', DateTime.parse("2024-02-12")),
    ],
  };
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return SafeArea(
        child: Center(
            child: RefreshIndicator(
      color: MyColors.primary,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: MyColors.primary,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ConsultantProfileWidget(
              profile: widget.consultantProfile,
              isConsultant: false,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: (isLandScape) ? 100 : 0),
              child: TableCalendar(
                  focusedDay: DateTime.now(),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  currentDay: _selectedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(day, DateTime.now());
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _selectedDay = focusedDay;
                  },
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: MyColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: MyColors.primary,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: MyColors.primary,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: MyColors.primary.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: MyColors.primary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                  ),
                  eventLoader: (day) {
                    return _events[formatDateTime(day)] ?? [];
                  },
                  calendarBuilders:
                      CalendarBuilders(markerBuilder: (context, day, events) {
                    if (events.isEmpty) {
                      return const SizedBox();
                    }
                    int numberOfEvents =
                        _events[formatDateTime(day)]?.length ?? 0;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: MyColors.primary),
                      width: 16,
                      height: 16,
                      child: Center(
                          child: (numberOfEvents < 100)
                              ? Text(
                                  numberOfEvents.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Icon(Icons.more_horiz,
                                  color: Colors.white, size: 16)),
                    );
                  })),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: ElevatedButton(
                  style: whiteInsideButtonStyle(120, 60),
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.add),
                      Text("Create Assignment")
                    ],
                  ),
                ),
              ),
            ),
            RecentMeetingsWidget(meetings: widget.meetings),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: UpcomingAssignmentsWidget(assignments: widget.assignments),
            )
          ],
        ),
      ),
    )));
  }
}
