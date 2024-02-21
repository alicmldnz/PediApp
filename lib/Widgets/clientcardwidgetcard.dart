import 'package:flutter/material.dart';
import 'package:pediapp/Classes/color.dart';
import 'package:pediapp/Pages/Consultant/clientprofilepage.dart';

class ClientCardWidget extends StatefulWidget {
  const ClientCardWidget({super.key, required this.clientName,required this.token});

  final String clientName;
  final String token;

  @override
  State<ClientCardWidget> createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends State<ClientCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5C000000),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage('assets/kid1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientProfilePage(
                    clientName: widget.clientName,
                    token: widget.token,
                  ),
                ),
              );

            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0x00000000), MyColors.secondary],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.clientName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
