import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pediapp/Classes/assignment.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Pages/Parent/mypagebody.dart';
import 'package:pediapp/Pages/Consultant/mypagebody.dart';
import 'package:pediapp/Pages/mysignuppage.dart';
import 'package:pediapp/Utils/inputdecoration1.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';
import 'package:pediapp/Model/login.dart';
import 'package:pediapp/Model/errormessage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  late String token;
  late List<Assignment> assignments;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var snackBar = const SnackBar(
      content: Text(
    "Login Error",
    style: TextStyle(fontFamily: 'Ubuntu'),
  ));

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> loginState() async {
    var urlString = dotenv.env['API_URL'] ?? "API_URL not found";
    var url = Uri.parse("$urlString/login");
    var data = {
      "email_address": emailController.text,
      "password": passwordController.text,
    };

    var body = json.encode(data);

    var answer = await http.post(url,
        headers: {
          'Content-Type': 'application/json', // Set the content type here
        },
        body: body);

    print("all log in");

    if (answer.statusCode == 200) {
      print("login success");
      Login resp = Login.fromJson(json.decode(answer.body));
      token = resp.session_id;
      return true;
    } else if (answer.statusCode == 400) {
      print("login not success");
      ErrorMessage resp = ErrorMessage.fromJson(json.decode(answer.body));
      print(resp.message);
      return false;
    } else {
      ErrorMessage resp = ErrorMessage.fromJson(json.decode(answer.body));
      print(resp.message);
      return false;
    }
  }

  Future<bool> getAllAssignments() async {
    var urlString = dotenv.env['API_URL'] ?? "API_URL not found";
    var url = Uri.parse("$urlString/assignments");
    var data = {
      "session_id": token,
    };
    var body = json.encode(data);

    var answer = await http.post(url,
        headers: {
          'Content-Type': 'application/json', // Set the content type here
        },
        body: body);
    if (answer.statusCode == 200) {
      var asses = json.decode(answer.body);
      assignments =
          List<Assignment>.from(asses.map((i) => Assignment.fromJson(i)));
      return true;
    } else {
      print("not 200:${answer.statusCode} ${answer.body}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            height: MediaQuery.of(context).size.height - 25,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Image(
                  image: AssetImage('assets/PediAppLogoBeyazArkaPlan.png'),
                ),
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: MyColors.primary,
                        decoration: buildInputDecoration(
                            Icons.email_outlined, 'E-mail'),
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: MyColors.primary,
                        decoration:
                            buildInputDecoration(Icons.lock, 'Password'),
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                MyColors.primary.withOpacity(0.2)),
                          ),
                          onPressed: () {},
                          child: buildText("Forgot Password", Colors.black,
                              FontWeight.bold, 13)),
                      Align(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  var ansLogin = await loginState();
                                  var ansAssign = await getAllAssignments();

                                  var finalAnswer = ansLogin && ansAssign;

                                  if (finalAnswer == true) {
                                    print('assignments: $assignments');
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return MyPageBody(
                                        assignments: assignments,
                                        token: token,
                                      );
                                    }));
                                  } else if (finalAnswer == false) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                style: purpleInsideButtonStyle(120, 40),
                                child: buildText("Login", MyColors.white,
                                    FontWeight.bold, 20)),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const MySignUpPage();
                                }));
                              },
                              style: whiteInsideButtonStyle(120, 40),
                              child: buildText("Sign Up", MyColors.primary,
                                  FontWeight.bold, 20),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var ansLogin = await loginState();
                          var ansAssign = await getAllAssignments();

                          var finalAnswer = ansLogin && ansAssign;

                          if (finalAnswer == true) {
                            print('assignments: $assignments');
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return MyConsultantPageBody(
                                token: token,
                              );
                            }));
                          } else if (finalAnswer == false) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        style: purpleInsideButtonStyle(double.infinity, 40),
                        child: buildText("Consultant Login", MyColors.white,
                            FontWeight.bold, 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildText(String txt, Color color, FontWeight fw, double fs) {
    return Text(
      txt.toString(),
      style: TextStyle(
          fontSize: fs, fontFamily: 'Montserrat', fontWeight: fw, color: color),
    );
  }

  ButtonStyle buildButtonStyle(
      Color backgroundColor, Color overlayColor, double width) {
    return ButtonStyle(
      overlayColor: MaterialStateProperty.all<Color>(overlayColor),
      minimumSize: MaterialStateProperty.all<Size>(Size(width, 40)),
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: const BorderSide(color: MyColors.primary, width: 3),
      )),
    );
  }
}
