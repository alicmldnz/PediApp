import 'package:flutter/material.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_duration.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';

class Meeting {
  Meeting(
      {required this.consultantName,
      required this.subject,
      required this.date,
      required this.time,
      required this.status,
      required this.duration});

  String consultantName;
  String subject;
  DateTime date;
  TimeOfDay time;
  int status;
  Duration duration;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      consultantName: json['consultant_name'],
      subject: json['subject'],
      date: DateTime(
          int.parse(json['date'].split('.')[2]),
          int.parse(json['date'].split('.')[1]),
          int.parse(json['date'].split('.')[0])),
      time: TimeOfDay(
          hour: int.parse(json['time'].split(':')[0]),
          minute: int.parse(json['time'].split(':')[1])),
      status: int.parse(json['status']),
      duration: Duration(minutes: json['duration']),
    );
  }

  Map<String, dynamic> toJson() => {
        'consultant_name': consultantName,
        'subject': subject,
        'date': formatDateTime(date),
        'time': formatTimeOfDay(time),
        'status': status,
        'duration': formatDuration(duration),
      };
}
