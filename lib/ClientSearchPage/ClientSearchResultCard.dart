import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/PreferredFoodsProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/WeightAreasProvider.dart';

import '../CheckInPage/View/CheckInPage.dart';
import '../ClientDetailsPage/ClientDetailsPage.dart';
import '../Core/Model/Classes/Client.dart';

class ClientSearchResultCard extends StatefulWidget {
  List<Client?> searchResults = [];
  String state = "";
  final VoidCallback onClientDeleted; // Add this callback

  ClientSearchResultCard({
    super.key,
    required this.searchResults,
    required this.state,
    required this.onClientDeleted, // Initialize the callback
  });
  @override
  State<ClientSearchResultCard> createState() => _ClientSearchResultCardState();
}

class _ClientSearchResultCardState extends State<ClientSearchResultCard> {
  _deleteClient(Client c) async {
    await context.read<ClientProvider>().deleteClient(c.mClientId);
    await context
        .read<ClientConstantInfoProvider>()
        .deleteClientConstantInfo(c.mClientConstantInfoId ?? '');
    await context
        .read<ClientMonthlyFollowUpProvider>()
        .deleteClientMonthlyFollowUp(c.mClientMonthlyFollowUpId ?? '');
    await context.read<DiseaseProvider>().deleteDisease(c.mDiseaseId ?? '');
    await context
        .read<PreferredFoodsProvider>()
        .deletePreferredFoods(c.mPreferredFoodsId ?? '');
    await context.read<VisitProvider>().deleteAllClientVisits(c.mClientId);
    await context
        .read<WeightAreasProvider>()
        .deleteWeightAreas(c.mWeightAreasId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.searchResults.length,
        itemBuilder: (context, index) {
          final client = widget.searchResults[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8.0), // Adjust padding if needed
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.blue[50]!,
                              title: const Text("تأكيد الحذف"),
                              content: const Text(
                                  "هل أنت متأكد أنك تريد حذف هذا العميل؟"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await _deleteClient(client!);
                                    Navigator.of(context).pop();
                                    widget.searchResults.removeAt(index);
                                    widget.onClientDeleted();
                                  },
                                  child: const Text("مسح",
                                      style:
                                          TextStyle(color: Colors.blueAccent)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("رجوع",
                                      style:
                                          TextStyle(color: Colors.blueAccent)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.delete),
                      label: const Text("مسح"),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              client?.mName ?? 'مجهول',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(client?.mClientPhoneNum ?? 'لا يوجد رقم'),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black54,
                        child: const Icon(Icons.person),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      if (widget.state == "checkIn") {
                        return CheckInPage(client: client);
                      } else if (widget.state == "search") {
                        return ClientDetailsPage(client: client);
                      } else {
                        return Container(); // or any other default widget
                      }
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
