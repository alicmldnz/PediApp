import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/parent_profile.dart';
import 'package:pediapp/Pages/Consultant/createassignmentpage.dart';
import 'package:pediapp/Widgets/parentprofilewidget.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';
import 'package:pediapp/Widgets/noteswidget.dart';
import 'package:http/http.dart' as http;

import '../../Model/errormessage.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage(
      {super.key, required this.clientName, required this.token});

  static const String routeName = '/clientProfile';
  final String clientName;
  final String token;

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  ParentProfile profile =
      ParentProfile(imageURL: 'null', parentName: 'null', childName: 'null');
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profile = ParentProfile(
        imageURL:
            'https://raisingchildren.net.au/__data/assets/image/0025/48445/parents-familiesnarrow.jpg',
        parentName: widget.clientName,
        childName: 'Ömer Faruk ${widget.clientName.split(' ').last}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton(
              onPressed: () async {
                // open up an alertbox and get a url
                // send the url to the server with the consultant's id and the client's id
                // the server will send a notification to the client

                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Enter the URL of the video call'),
                      content: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter the URL',
                          ),
                          controller: urlController),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var urlString =
                                dotenv.env['API_URL'] ?? "API_URL not found";
                            var url = Uri.parse("$urlString/addMeeting");
                            var data = {
                              "session_id": widget.token,
                              "parent_name": widget.clientName,
                              "meeting_url": urlController.text,
                            };

                            var body = json.encode(data);

                            var answer = await http.post(url,
                                headers: {
                                  'Content-Type': 'application/json',
                                  // Set the content type here
                                },
                                body: body);

                            print("all log in");

                            if (answer.statusCode == 200) {
                              print("add meeting success");
                            } else if (answer.statusCode == 400) {
                              print("add meeting not success");
                            } else {
                              ErrorMessage resp = ErrorMessage.fromJson(
                                  json.decode(answer.body));
                              print(resp.message);
                            }
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: const BorderSide(color: MyColors.primary, width: 2),
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
                side: const BorderSide(color: MyColors.primary, width: 2),
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
      ),
      body: Center(
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
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: IconButton(
                      color: MyColors.primary,
                      splashRadius: 24,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
                ParentProfileWidget(profile: profile, isConsultant: true)
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.assignment_turned_in_outlined,
                        color: MyColors.primary,
                        size: 48,
                      ),
                      Text(
                        '17',
                        style: _textStyle,
                      ),
                      Text(
                        "Homeworks",
                        style: _textStyle,
                      ),
                      Text(
                        "Completed",
                        style: _textStyle,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.checklist,
                        color: MyColors.primary,
                        size: 48,
                      ),
                      Text(
                        '17',
                        style: _textStyle,
                      ),
                      Text(
                        "Activities",
                        style: _textStyle,
                      ),
                      Text(
                        "Done",
                        style: _textStyle,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_circle,
                        color: MyColors.primary,
                        size: 48,
                      ),
                      Text(
                        '12',
                        style: _textStyle,
                      ),
                      Text(
                        "Contents",
                        style: _textStyle,
                      ),
                      Text(
                        "Watched",
                        style: _textStyle,
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CreateAssignmentPage();
                        }));
                      },
                      style: whiteInsideButtonStyle(176, 72),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_month_outlined,
                              color: MyColors.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Create Assignment',
                            style: commonTextStyle,
                          ),
                        ],
                      )),
                ),
              ),
              const NotesWidget(),
            ],
          ),
        ),
      )),
    ));
  }

  TextStyle get _textStyle => const TextStyle(
      fontSize: 15,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: MyColors.primary);
}
