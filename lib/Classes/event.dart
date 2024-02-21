import 'package:pediapp/Utils/format_day_time.dart';

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      json['title'],
      DateTime(
          int.parse(json['date'].split('.')[2]),
          int.parse(json['date'].split('.')[1]),
          int.parse(json['date'].split('.')[0])),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': formatDateTime(date),
      };
}
