import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/course.dart';
import 'package:pediapp/Classes/parent_profile.dart';
import 'package:pediapp/Widgets/courseswidget.dart';
import 'package:pediapp/Widgets/parentprofilewidget.dart';
import 'package:pediapp/Widgets/categorieswidget.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.profile});

  final ParentProfile profile;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Course> courses = [];


  @override
  void initState() {
    super.initState();
  }

  Future<void> getAllCourses() async {
    courses.clear();
    String urlString = dotenv.env['API_URL'] ?? "API_URL not found";
    var url = Uri.parse("$urlString/getAllCourses");
    var answer = await http.get(url);
    if (answer.statusCode == 200) {
      var courseURLs = json.decode(answer.body);
      for (var courseURL in courseURLs) {
        var yt = YoutubeExplode();
        var video = await yt.videos.get(courseURL['courses_url']);
        var course = Course(
          courseURL: courseURL['courses_url'],
          courseName: video.title,
          consultantName: video.author,
          courseImageURL: video.thumbnails.highResUrl,
        );
        courses.add(course);

      }
    } else {
      print("not 200:${answer.statusCode} ${answer.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: RefreshIndicator(
          color: MyColors.primary,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: MyColors.primary,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ParentProfileWidget(
                  profile: widget.profile,
                  isConsultant: false,
                ),
                FutureBuilder(
                  future: getAllCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CoursesWidget(courses: courses);
                    } else {
                      return const Center(child:  CircularProgressIndicator());
                    }
                  },
                ),
                const ActivitiesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
