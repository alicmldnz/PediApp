import 'package:flutter/material.dart';
import 'package:pediapp/Widgets/upcomingassignmentswidget.dart';
import 'package:pediapp/Widgets/clientcardwidgetcard.dart';

class ListClientsWidget extends StatefulWidget {
  const ListClientsWidget(
      {super.key, required this.clients,required this.token});

  final List<String> clients;
  final String token;

  @override
  State<ListClientsWidget> createState() => _ListClientsWidgetState();
}

class _ListClientsWidgetState extends State<ListClientsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Clients",
              style: commonTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return ClientCardWidget(
                    clientName: widget.clients[index],
                    token: widget.token,

                  );
                },
                itemCount: widget.clients.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ]),
    );
  }
}
