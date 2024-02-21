import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class CreateAssignmentPage extends StatefulWidget {
  const CreateAssignmentPage({super.key});

  static const String routeName = '/createAssignment';

  @override
  State<CreateAssignmentPage> createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
  final TextEditingController _aimController = TextEditingController();
  final TextEditingController _gainsController = TextEditingController();
  final TextEditingController _materialsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.parse('2024-01-01'),
      lastDate: DateTime.parse('2030-01-01'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: MyColors.primary,
            colorScheme: const ColorScheme.light(primary: MyColors.primary),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: MyColors.primary,
            colorScheme: const ColorScheme.light(primary: MyColors.primary),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: MyColors.primary,
                    )),
                const Text(
                  'Create Assignment',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Aim',
                  style: localTextStyle(),
                ),
              ),
            ),
            custom_text_field(_aimController, 1),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gains',
                  style: localTextStyle(),
                ),
              ),
            ),
            custom_text_field(_gainsController, 1),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Materials',
                  style: localTextStyle(),
                ),
              ),
            ),
            custom_text_field(_materialsController, 1),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notes',
                  style: localTextStyle(),
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: custom_text_field(_notesController, 7),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: whiteInsideButtonStyle(120, 40),
                    onPressed: () {
                      _selectDate(context)
                          .then((value) => _selectTime(context));
                    },
                    child: const Text('Select Date and Time')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: whiteInsideButtonStyle(120, 40),
                  child: const Text(
                    "Done",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    ));
  }

  Widget custom_text_field(TextEditingController controller, int maxLines) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(color: MyColors.primary, width: 1)),
            filled: true,
            fillColor: Colors.transparent,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(color: MyColors.primary, width: 3)),
            contentPadding:
                const EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20)),
        cursorColor: MyColors.primary,
      ),
    );
  }

  TextStyle localTextStyle() {
    return const TextStyle(
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
    );
  }
}
