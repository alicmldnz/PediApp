import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Classes/parent_profile.dart';

class ParentProfileWidget extends StatefulWidget {
  const ParentProfileWidget(
      {super.key, required this.profile, required this.isConsultant});

  final ParentProfile profile;
  final bool isConsultant;

  @override
  State<ParentProfileWidget> createState() => _ParentProfileWidgetState();
}

class _ParentProfileWidgetState extends State<ParentProfileWidget> {
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
                    RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        (widget.isConsultant)
                            ? const TextSpan()
                            : const TextSpan(
                                text: "Welcome ",
                                style: TextStyle(
                                    color: MyColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat")),
                        TextSpan(
                            text: widget.profile.parentName,
                            style: const TextStyle(
                                color: MyColors.primary,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"))
                      ],
                      style: const TextStyle(fontSize: 16),
                    )),
                    Row(
                      children: [
                        const Icon(
                          Icons.child_care_outlined,
                          color: MyColors.primary,
                        ),
                        Text(
                          widget.profile.childName,
                          style: const TextStyle(color: MyColors.primary),
                        )
                      ],
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
