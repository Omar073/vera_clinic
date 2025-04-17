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
    //* we propbably never go into that condition because we already check if the list is empty in the previous page
    if (widget.checkInClients.isEmpty) {
      return const Center(
        child: Text(
          'لا يوجد عملاء',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
