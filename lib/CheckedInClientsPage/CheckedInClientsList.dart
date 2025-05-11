import 'package:flutter/material.dart';

import '../Core/Model/Classes/Client.dart';
import 'ClientCard.dart';

class CheckedInClientsList extends StatefulWidget {
  List<Client?> checkInClients;
  final VoidCallback onClientCheckedOut;
  CheckedInClientsList({
    super.key, 
    required this.checkInClients,
    required this.onClientCheckedOut,
  });

  @override
  State<CheckedInClientsList> createState() => _CheckedInClientsListState();
}

class _CheckedInClientsListState extends State<CheckedInClientsList> {
  void _handleClientCheckedOut() {
    setState(() {
      // Trigger local state update
    });
    // Call parent callback
    widget.onClientCheckedOut();
  }

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
          onClientCheckedOut: _handleClientCheckedOut,
        ),
        itemCount: widget.checkInClients.length,
        itemBuilder: (context, index) {
          return ClientCard(
            client: widget.checkInClients[index], 
            index: index,
            onClientCheckedOut: _handleClientCheckedOut,
          );
        },
      ),
    );
  }
}
