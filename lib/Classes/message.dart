import 'package:flutter/material.dart';
import 'package:pediapp/Utils/format_day_time.dart';
import 'package:pediapp/Utils/format_time_of_day.dart';

class Message {
  final String sender;
  final TimeOfDay time;
  final DateTime date;
  final String text;
  final bool isLiked;
  final bool unread;
  bool isImage = false;
  String imgURL = '';

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
    required this.date,
    this.isImage = false,
    this.imgURL = '',
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      time: TimeOfDay(
          hour: int.parse(json['time'].split(':')[0]),
          minute: int.parse(json['time'].split(':')[1])),
      text: json['text'],
      isLiked: json['isLiked'],
      unread: json['unread'],
      date: DateTime(
          int.parse(json['date'].split('.')[2]),
          int.parse(json['date'].split('.')[1]),
          int.parse(json['date'].split('.')[0])),
      isImage: json['isImage'],
      imgURL: json['img'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'time': formatTimeOfDay(time),
        'text': text,
        'isLiked': isLiked,
        'unread': unread,
        'date': formatDateTime(date),
        'isImage': isImage,
        'img': imgURL,
      };
}
