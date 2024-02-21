import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/consultant_profile.dart';

class ConsultantProfileWidget extends StatefulWidget {
  const ConsultantProfileWidget(
      {super.key, required this.profile, required this.isConsultant});

  final ConsultantProfile profile;
  final bool isConsultant;

  @override
  State<ConsultantProfileWidget> createState() =>
      _ConsultantProfileWidgetState();
}

class _ConsultantProfileWidgetState extends State<ConsultantProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print("Tapped to profile");
          },
          borderRadius: BorderRadius.circular(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 32,
                  foregroundImage: NetworkImage(widget.profile.imageURL),
                  backgroundImage:
                      const AssetImage("assets/nullProfilePictureIcon.png"),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(
                height: 64,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        (widget.isConsultant)
                            ? const Text("Welcome ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat"))
                            : const SizedBox(),
                        Text(widget.profile.consultantName,
                            style: const TextStyle(
                                fontSize: 16,
                                color: MyColors.primary,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat")),
                      ],
                    ),
                    Text(
                      widget.profile.consultantTitle,
                      style: const TextStyle(
                          color: MyColors.primary,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
