import 'package:flutter/material.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';

class Note {
  Note(
      {required this.senderName,
      required this.receiverName,
      required this.date,
      required this.time,
      required this.content});

  final String senderName;
  final String receiverName;
  final DateTime date;
  final TimeOfDay time;
  final String content;

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      senderName: json['sender_name'],
      receiverName: json['receiver_name'],
      date: DateTime(
          int.parse(json['date'].split('.')[2]),
          int.parse(json['date'].split('.')[1]),
          int.parse(json['date'].split('.')[0])),
      time: TimeOfDay(
          hour: int.parse(json['time'].split(':')[0]),
          minute: int.parse(json['time'].split(':')[1])),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sender_name': senderName,
        'receiver_name': receiverName,
        'date': formatDateTime(date),
        'time': formatTimeOfDay(time),
        'content': content,
      };
}