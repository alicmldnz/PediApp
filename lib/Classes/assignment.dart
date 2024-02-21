import 'package:flutter/material.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';

class Assignment {
  Assignment({
    required this.assignmentId,
    required this.parentId,
    required this.consultantId,
    required this.consultantName,
    required this.subjectName,
    required this.date,
    required this.time,
    required this.objective,
    required this.activities,
    required this.tableVariables,
  });

  final String assignmentId;
  final String parentId;
  final String consultantId;
  final String subjectName;
  final DateTime date;
  final TimeOfDay time;
  final String objective;
  final List<String> activities;
  final List<List<String>> tableVariables;
  final String consultantName;

  factory Assignment.fromJson(Map<String, dynamic> json) {
    List<String> activities = [];
    for (var activity in json['activities']) {
      activities.add(activity);
    }
    List<List<String>> tableVariables = [];
    for (var row in json['table_variables']) {
      List<String> newRow = [];
      for (var cell in row) {
        newRow.add(cell);
      }
      tableVariables.add(newRow);
    }

    return Assignment(
      assignmentId: json['assignment_id'],
      parentId: json['parent_id'],
      consultantId: json['consultant_id'],
      subjectName: json['subject_name'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
          hour: int.parse(json['time'].split(":")[0]),
          minute: int.parse(json['time'].split(":")[1])),
      objective: json['objective'],
      activities: activities,
      tableVariables: tableVariables,
      consultantName: json['consultant_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'assignment_id': assignmentId,
        'parent_id': parentId,
        'consultant_id': consultantId,
        'subject_name': subjectName,
        'date': formatDateTime(date),
        'time': formatTimeOfDay(time),
        'objective': objective,
        'activities': activities,
        'table_variables': tableVariables,
        'consultant_name': consultantName,
      };
}
