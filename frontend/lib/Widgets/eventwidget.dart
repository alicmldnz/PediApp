import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/event.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key, required this.event});

  final Event event;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.primary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(widget.event.title),
        ),
      ),
    );
  }
}
