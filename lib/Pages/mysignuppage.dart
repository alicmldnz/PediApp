import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Model/errormessage.dart';
import 'package:http/http.dart' as http;
import 'package:pediapp/Utils/inputdecoration1.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  double padding = 40;
  bool isPasswordMatch = true;

  Future<bool> signUpState() async {
    var urlString = dotenv.env['API_URL'] ?? "API_URL not found";
    var url = Uri.parse("$urlString/register");
    var data = {
      "email_address": emailController.text,
      "password": passwordController.text,
      "username": parentNameController.text,
    };
    var body = json.encode(data);

    var answer = await http.post(url,
        headers: {
          'Content-Type': 'application/json', // Set the content type here
        },
        body: body);

    print("all sign up");

    if (answer.statusCode == 200) {
      print("sign up success");
      return true;
    } else if (answer.statusCode == 400) {
      print("sign up not success");
      var resp = ErrorMessage.fromJson(json.decode(answer.body)["message"]);

      print(resp);
      return false;
    } else {
      print("not 200 and 400:${answer.statusCode} ${answer.body}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  color: MyColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding),
                child: TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration:
                        buildInputDecoration(Icons.email_outlined, "Email")),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: TextFormField(
                  controller: passwordController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration:
                      buildInputDecoration(Icons.lock_outline, "Password"),
                ),
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                cursorColor: Colors.black,
                keyboardType: TextInputType.visiblePassword,
                decoration: buildInputDecoration(
                    Icons.lock_outline, "Confirm Password"),
              ),
              if (!isPasswordMatch)
                const Text(
                  "Passwords do not match",
                  style: TextStyle(color: Colors.red),
                ),
              Padding(
                padding: EdgeInsets.only(top: padding),
                child: TextFormField(
                  controller: parentNameController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,
                  decoration: buildInputDecoration(Icons.person, "Parent Name"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding),
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty ||
                        parentNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill in all the fields")));
                      return;
                    }

                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      var ans2 = await signUpState();
                      setState(() {
                        isPasswordMatch = true;
                      });
                      if (ans2 == true) {
                        print(passwordController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sign Up Success")));
                      } else if (ans2 == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sign Up Failed")));
                      }
                    } else {
                      setState(() {
                        isPasswordMatch = false;
                      });
                    }
                  },
                  style: whiteInsideButtonStyle(120, 40),
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
