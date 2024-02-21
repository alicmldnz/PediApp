import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/consultant_profile.dart';
import 'package:pediapp/Classes/course.dart';
import 'package:pediapp/Widgets/categorieswidget.dart';
import 'package:pediapp/Widgets/consultantprofilewidget.dart';
import 'package:pediapp/Widgets/courseswidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.consultantProfile});

  final ConsultantProfile consultantProfile;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Course> courses = [];

  /*
  Course(
        courseName: "How should pre-school education be?",
        consultantName: "Serhat Ersöz",
        courseImageURL:
            "https://www.shutterstock.com/image-photo/distance-education-smiling-african-american-600nw-2112109130.jpg",
        completionRate: 75),
    Course(
        courseName: "Basics of Pedagogy",
        consultantName: "Melike Kapı",
        courseImageURL:
            "https://thumbs.dreamstime.com/b/kids-playing-puddle-bangkok-thailand-december-boy-having-fun-pushing-his-sister-flooded-square-bangkok-thailand-45572379.jpg",
        completionRate: 30),
    Course(
        courseName: "Self-Confidence Development",
        consultantName: "Rabia S. Şimşek",
        courseImageURL:
            "https://t3.ftcdn.net/jpg/04/31/96/26/360_F_431962610_72IpXMfpopANrur6GY1crTxtXBgv1l2y.jpg",
        completionRate: 90)
   */


  Future<void> getAllCourses() async {

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
            ConsultantProfileWidget(profile: widget.consultantProfile,isConsultant: true,),
            CoursesWidget(courses: courses),
            const ActivitiesWidget(),
          ],
        ),
      ),
    )));
  }
}
