import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/consultant_profile.dart';
import 'package:pediapp/Classes/parent_profile.dart';
import 'package:pediapp/Classes/meeting.dart';
import 'package:pediapp/Pages/Parent/MyHomePage.dart';
import 'package:pediapp/Pages/Parent/myassignmentspage.dart';
import 'package:pediapp/Pages/Parent/mycalendarpage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPageBody extends StatefulWidget {
  const MyPageBody({super.key, required this.token, required this.assignments});

  final List<Assignment> assignments;

  final String token;

  @override
  State<MyPageBody> createState() => _MyPageBodyState();
}

class _MyPageBodyState extends State<MyPageBody> {
  int selectedIndex = 0;
  ParentProfile parentProfile = ParentProfile(
      imageURL:
          "https://media.istockphoto.com/id/1388253782/photo/positive-successful-millennial-business-professional-man-head-shot-portrait.jpg?s=612x612&w=0&k=20&c=uS4knmZ88zNA_OjNaE_JCRuq9qn3ycgtHKDKdJSnGdY=",
      parentName: "Deniz Kalın",
      childName: "Cenk Kalın");
  ConsultantProfile consultantProfile = ConsultantProfile(
      imageURL:
          "https://www.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-260nw-1836020740.jpg",
      consultantName: "Canan Misli",
      consultantTitle: "Child Development Consultant",
      clients: ["Canan Misli", "Mehmet Anlı", "Zeynep Şanlı", "Cenk Kalın"]);

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
  String currentPage = "Home";
  List<String> pageKeys = ["Home", "Assignment", "Calendar"];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Assignment": GlobalKey<NavigatorState>(),
    "Calendar": GlobalKey<NavigatorState>(),
  };

  Future<bool> logout() async {
    var urlString = dotenv.env['API_URL'] ?? "API_URL not found";
    var url = Uri.parse("$urlString/logout");
    var data = {
      "session_id": widget.token,
    };
    var body = json.encode(data);

    var answer = await http.delete(url,
        headers: {
          'Content-Type': 'application/json', // Set the content type here
        },
        body: body);
    if (answer.statusCode == 200) {
      return true;
    } else {
      print("not 200:${answer.statusCode} ${answer.body}");
      return false;
    }
  }

  Future<void> launchURL(String urlString) async {
    final uri = Uri.parse("https://"+urlString);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

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
          } else {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Exit"),
                      content: const Text("Are you sure you want to exit?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            var ifLogout = logout();
                            if (await ifLogout) {
                              Navigator.of(context).pop(true);
                              Navigator.of(context).pop(true);
                            }
                          },
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("No"),
                        ),
                      ],
                    ));
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        floatingActionButton: (selectedIndex == 2)
            ? Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        var urlString =
                            dotenv.env['API_URL'] ?? "API_URL not found";
                        var url = Uri.parse("$urlString/api/meetings");
                        var data = {
                          "session_id": widget.token,
                        };
                        var body = json.encode(data);

                        var answer = await http.post(url,
                            headers: {
                              'Content-Type': 'application/json',
                              // Set the content type here
                            },
                            body: body);
                        if (answer.statusCode == 200) {
                          var meetingUrl =
                              json.decode(answer.body)["meeting_url"];
                          print(meetingUrl);
                          launchURL(meetingUrl);
                        } else {
                          print("not 200:${answer.statusCode} ${answer.body}");
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side:
                            const BorderSide(color: MyColors.primary, width: 2),
                      ),
                      backgroundColor: MyColors.white,
                      child: const Icon(
                        Icons.video_call_outlined,
                        size: 40,
                        color: MyColors.primary,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side:
                            const BorderSide(color: MyColors.primary, width: 2),
                      ),
                      backgroundColor: MyColors.white,
                      child: const Icon(
                        Icons.message_outlined,
                        size: 30,
                        color: MyColors.primary,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Home"),
          _buildOffstageNavigator("Assignment"),
          _buildOffstageNavigator("Calendar"),
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
                      Icons.assignment_outlined,
                      size: 35,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.calendar_month_outlined,
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
        assignments: widget.assignments,
        parentProfile: parentProfile,
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
      required this.parentProfile,
      required this.meetings,
      required this.assignments});

  final String tabItem;
  final GlobalKey<NavigatorState> navigatorKey;
  final ConsultantProfile consultantProfile;
  final ParentProfile parentProfile;
  final List<Meeting> meetings;
  final List<Assignment> assignments;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    if (tabItem == "Home") {
      child = MyHomePage(
        profile: parentProfile,
      );
    } else if (tabItem == "Assignment") {
      child = MyAssignmentsPage(
        meetings: meetings,
        assignments: assignments,
        parentprofile: parentProfile,
      );
    } else if (tabItem == "Calendar") {
      child = MyCalendarPage(
        profile: consultantProfile,
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
