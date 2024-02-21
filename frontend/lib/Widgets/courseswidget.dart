import 'package:flutter/material.dart';
import 'package:pediapp/Classes/course.dart';
import 'package:pediapp/Widgets/coursecardwidget.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class CoursesWidget extends StatefulWidget {
  const CoursesWidget({super.key, required this.courses});

  final List<Course> courses;

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    print("Courses are:");
    for (var i = 0; i < widget.courses.length; i++) {
      print(widget.courses[i].courseName);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels ==
        (_controller.position.maxScrollExtent)) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Courses",
        style: commonTextStyle,
      ),
      SizedBox(
        height: 160,
        child: ListView.builder(

            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: widget.courses.length,
            controller: _controller,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: CourseCardWidget(course: widget.courses[index]),
              );
            }),
      ),
      /*Center(
        child: ElevatedButton(
          onPressed: () {
            print("Tapped View All Courses button");
          },
          child: const Text("Show All"),
        ),
      ),*/
    ]);
  }
}
