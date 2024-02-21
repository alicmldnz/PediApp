import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/consultant_profile.dart';
import 'package:pediapp/Classes/meeting.dart';
import 'package:pediapp/Pages/Consultant/mycalendarpage.dart';
import 'package:pediapp/Pages/Consultant/MyHomePage.dart';
import 'package:pediapp/Pages/Consultant/myprofilepage.dart';

class MyConsultantPageBody extends StatefulWidget {
  const MyConsultantPageBody({super.key, required this.token});

  final String token;

  @override
  State<MyConsultantPageBody> createState() => _MyConsultantPageBodyState();
}

class _MyConsultantPageBodyState extends State<MyConsultantPageBody> {
  int selectedIndex = 0;
  ConsultantProfile consultantProfile = ConsultantProfile(
      imageURL:
          "https://www.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-260nw-1836020740.jpg",
      consultantName: "Defne Görmez",
      consultantTitle: "Child Development Consultant",
      clients: ["Omer Faruk Colakel"]);
  List<Meeting> meetings = [
    Meeting(
        consultantName: "Canan Misli",
        subject: "Pedagogy",
        date: DateTime.parse("2024-02-05"),
        time: const TimeOfDay(hour: 18, minute: 30),
        status: 0,
        duration: const Duration(hours: 1, minutes: 32)),
    Meeting(
        consultantName: "Mehmet Anlı",
        subject: "Pedagogy",
        date: DateTime.parse("2024-02-02"),
        time: const TimeOfDay(hour: 18, minute: 30),
        status: 1,
        duration: const Duration(minutes: 56)),
    Meeting(
        consultantName: "Mehmet Anlı",
        subject: "Pedagogy",
        date: DateTime.parse("2024-02-02"),
        time: const TimeOfDay(hour: 18, minute: 30),
        status: 2,
        duration: const Duration(minutes: 56)),
  ];

  /*
  List<Assignment> assignments = [
    Assignment(
        consultantName: "Cahit Berkay",
        subjectName: "Child Development",
        date: DateTime.parse("2024-03-12"),
        time: const TimeOfDay(hour: 20, minute: 00),
        activities: ["activity1", "activity2", "activity3"],
        objective: "objective",
        tableVariables: [
          ["activity/date","activity1", "activity2", "activity3"],
          [formatDateTime(DateTime.parse("2024-01-01")),"true", "false", "true"],
          [formatDateTime(DateTime.parse("2024-01-02")),"true","false", "true" ],
          [formatDateTime(DateTime.parse("2024-01-03")),"true","true", "true"]
        ]),
    Assignment(
        consultantName: "Rabia S. Şimşek",
        subjectName: "Pedagogy",
        date: DateTime.parse("2024-03-13"),
        time: const TimeOfDay(hour: 15, minute: 00),
        activities: ["activity1", "activity2", "activity3"],
        objective: "objective",
        tableVariables: [
          ["activity/date","activity1", "activity2", "activity3"],
          [formatDateTime(DateTime.parse("2024-01-01")),"true", "false", "true"],
          [formatDateTime(DateTime.parse("2024-01-02")),"true","false", "true"],
          [formatDateTime(DateTime.parse("2024-01-03")),"true","true", "true"]
        ]),
    Assignment(
        consultantName: "Murat Ses",
        subjectName: "Communication with Child",
        date: DateTime.parse("2024-03-17"),
        time: const TimeOfDay(hour: 19, minute: 30),
        activities: ["activity1", "activity2", "activity3"],
        objective: "objective",
        tableVariables: [
          ["activity/date","activity1", "activity2", "activity3"],
          [formatDateTime(DateTime.parse("2024-01-01")),"true", "false", "true"],
          [formatDateTime(DateTime.parse("2024-01-02")),"true","false", "true"],
          [formatDateTime(DateTime.parse("2024-01-03")),"true","true", "true"]
        ]),
    Assignment(
        consultantName: "Cahit Berkay",
        subjectName: "Child Development 2",
        date: DateTime.parse("2024-03-12"),
        time: const TimeOfDay(hour: 20, minute: 00),
        activities: ["activity1", "activity2", "activity3"],
        objective: "objective",
        tableVariables: [
          ["activity/date","activity1", "activity2", "activity3"],
          [formatDateTime(DateTime.parse("2024-01-01")),"true", "false", "true"],
          [formatDateTime(DateTime.parse("2024-01-02")),"true","false", "true" ],
          [formatDateTime(DateTime.parse("2024-01-03")),"true","true", "true"]
        ]),
    Assignment(
        consultantName: "Rabia S. Şimşek",
        subjectName: "Pedagogy 2",
        date: DateTime.parse("2024-03-13"),
        time: const TimeOfDay(hour: 15, minute: 00),
        activities: ["activity1", "activity2", "activity3"],
        objective: "objective",
        tableVariables: [
          ["activity/date","activity1", "activity2", "activity3"],
          [formatDateTime(DateTime.parse("2024-01-01")),"true", "false", "true"],
          [formatDateTime(DateTime.parse("2024-01-02")),"true","false", "true"],
          [formatDateTime(DateTime.parse("2024-01-03")),"true","true", "true"]
        ]),
    Assignment(
        consultantName: "Murat Ses",
        subjectName: "Communication with Child 2",
        date: DateTime.parse("2024-03-17"),
        time: const TimeOfDay(hour: 19, minute: 30),
        activities: ["activity1", "activity2", "activity3"],
        objective: "objective",
        tableVariables: [
          ["activity/date","activity1", "activity2", "activity3"],
          [formatDateTime(DateTime.parse("2024-01-01")),"true", "false", "true"],
          [formatDateTime(DateTime.parse("2024-01-02")),"true","false", "true"],
          [formatDateTime(DateTime.parse("2024-01-03")),"true","true", "true"]
        ]),
  ];
  */

  String currentPage = "Home";
  List<String> pageKeys = ["Home", "Calendar", "Profile"];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Calendar": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage != "Home") {
            setState(() {
              currentPage = "Home";
              selectedIndex = 0;
            });
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Home"),
          _buildOffstageNavigator("Calendar"),
          _buildOffstageNavigator("Profile"),
        ]),
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0),
              topRight: Radius.circular(60.0),
            ),
          ),
          child: Material(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.0),
                topRight: Radius.circular(60.0),
              ),
            ),
            color: const Color(0xFFCF8CF4),
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              backgroundColor: Colors.transparent,
              selectedItemColor: MyColors.primary,
              unselectedItemColor: Colors.white,
              onTap: (index) {
                if (selectedIndex != index) {
                  setState(() {
                    currentPage = pageKeys[index];
                    selectedIndex = index;
                  });
                } else {
                  navigatorKeys[pageKeys[index]]!
                      .currentState!
                      .popUntil((route) => route.isFirst);
                }
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 35,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      size: 35,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline,
                      size: 35,
                    ),
                    label: ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        tabItem: tabItem,
        navigatorKey: navigatorKeys[tabItem]!,
        consultantProfile: consultantProfile,
        meetings: meetings,
        assignments: const [],
        token: widget.token,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key,
      required this.tabItem,
      required this.navigatorKey,
      required this.consultantProfile,
      required this.meetings,
      required this.assignments,
      required this.token});

  final String tabItem;
  final GlobalKey<NavigatorState> navigatorKey;
  final ConsultantProfile consultantProfile;
  final List<Meeting> meetings;
  final List<Assignment> assignments;
  final String token;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    if (tabItem == "Home") {
      child = MyHomePage(
        consultantProfile: consultantProfile,
      );
    } else if (tabItem == "Calendar") {
      child = MyCalendarPage(
        assignments: assignments,
        consultantProfile: consultantProfile,
        meetings: meetings,
      );
    } else if (tabItem == "Profile") {
      child = MyProfilePage(
        consultantProfile: consultantProfile,
        token: token,
      );
    }
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => child,
          );
        });
  }
}
