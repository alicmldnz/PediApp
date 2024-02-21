import 'package:pediapp/Classes/color.dart';
import 'package:flutter/material.dart';
import 'package:pediapp/Classes/course.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCardWidget extends StatefulWidget {
  const CourseCardWidget({super.key, required this.course});

  final Course course;

  @override
  State<CourseCardWidget> createState() => _CourseCardWidgetState();
}

class _CourseCardWidgetState extends State<CourseCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        height: 144,
        width: 144,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColors.tertiary,
            boxShadow: const [
              BoxShadow(
                  color: Color(0x5C000000), offset: Offset(0, 3), blurRadius: 6)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async{
              // use url launcher to open the course


                final uri = Uri.parse(widget.course.courseURL);
                await launchUrl(uri);

            },
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        widget.course.courseImageURL,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const CircularProgressIndicator();
                        },
                        fit: BoxFit.cover,
                        height: 96,
                        width: 144,
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.course.courseName,
                        style: buildTextStyle(FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.course.consultantName,
                    style: buildTextStyle(FontWeight.normal),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle buildTextStyle(FontWeight fw) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: fw,
        fontSize: 11,
        color: MyColors.white);
  }
}
