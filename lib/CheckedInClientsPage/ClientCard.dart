import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/CheckInPage/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/CheckedInClientsPage/CheckedInClientsPage.dart';
import 'package:vera_clinic/Core/View/Pages/FollowUpNav.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Model/Classes/Client.dart';

class ClientCard extends StatefulWidget {
  final Client? client;
  final int index;
  const ClientCard({super.key, required this.client, required this.index});

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: ListTile(
          title: Wrap(
            spacing: 30,
            children: [
              Text('عميل: ' '${widget.index + 1}'),
              Text('الاسم: ${widget.client?.mName ?? 'No name'}'),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'نوع الاشتراك: '
              '${getSubscriptionTypeLabel(widget.client?.mSubscriptionType ?? SubscriptionType.none)}',
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ClinicProvider>().checkOutClient(widget.client!);
            },
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => FollowUpNav(client: widget.client!)),
            );
          },
        ),
      ),
    );
  }
}
