import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay time) {
  // Format TimeOfDay manually
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}