import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pediapp/Widgets/categorycardwidget.dart';
import 'package:pediapp/Classes/activity.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';
import 'package:http/http.dart' as http;

class ActivitiesWidget extends StatefulWidget {
  const ActivitiesWidget({super.key});

  @override
  State<ActivitiesWidget> createState() => _ActivitiesWidgetState();
}

class _ActivitiesWidgetState extends State<ActivitiesWidget> {
  late List<Activity> categories = [];

  Future<void> getActivities() async {
// get categories from the server

    var urlString = dotenv.env['API_URL'] ?? "API_URL not found";
    var url = Uri.parse("$urlString/activities");
    var answer = await http.get(url);

    if (answer.statusCode == 200) {
      var data = json.decode(answer.body);
      List<Activity> temp = [];
      for (var i in data) {
        temp.add(Activity.fromJson(i));
      }
      setState(() {
        categories = temp;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Text(
          "Activities",
          style: commonTextStyle,
        ),
      ),
      GridView.builder(
          itemCount: categories.length,
          clipBehavior: Clip.none,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CategoryCardWidget(category: categories[index]);
          }),
    ]);
  }
}
