import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/consultant_profile.dart';
import 'package:pediapp/Widgets/consultantprofilewidget.dart';
import 'package:pediapp/Widgets/listclientswidget.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key, required this.consultantProfile,required this.token});

  final ConsultantProfile consultantProfile;
  final String token;
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: RefreshIndicator(
      color: MyColors.primary,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
      },
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: MyColors.primary,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          ConsultantProfileWidget(
            profile: widget.consultantProfile,
            isConsultant: false,
          ),
          ListClientsWidget(clients: widget.consultantProfile.clients,token: widget.token,),
          const ConsultantAssignmentWidget(),
        ]),
      ),
    )));
  }
}

class ConsultantAssignmentWidget extends StatefulWidget {
  const ConsultantAssignmentWidget({super.key});

  @override
  State<ConsultantAssignmentWidget> createState() =>
      _ConsultantAssignmentWidgetState();
}

class _ConsultantAssignmentWidgetState
    extends State<ConsultantAssignmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Assignments', style: commonTextStyle),
        Center(
          child: ElevatedButton(
              style: whiteInsideButtonStyle(96, 34),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.add,
                    size: 24,
                  ),
                  Text('Add Note',
                      style: TextStyle(
                          fontSize: 12,
                          color: MyColors.primary,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold)),
                ],
              )),
        ),
      ],
    );
  }
}
