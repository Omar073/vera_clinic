import 'package:flutter/material.dart';

import '../Core/Model/Classes/Client.dart';
import 'ClientCard.dart';

class CheckedInClientsList extends StatefulWidget {
  List<Client?> checkInClients;
  CheckedInClientsList({super.key, required this.checkInClients});

  @override
  State<CheckedInClientsList> createState() => _CheckedInClientsListState();
}

class _CheckedInClientsListState extends State<CheckedInClientsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.checkInClients.isEmpty) {
      return const Center(
        child: Text('No clients checked in'),
      );
    }

    return Expanded(
      //* we don't need to add SingleChildScrollView here because ListView.builder is already scrollable
      child: ListView.builder(
        prototypeItem: ClientCard(
          client: widget.checkInClients.first,
          index: 0,
        ),
        itemCount: widget.checkInClients.length,
        itemBuilder: (context, index) {
          return ClientCard(client: widget.checkInClients[index], index: index);
        },
      ),
    );
  }
}
