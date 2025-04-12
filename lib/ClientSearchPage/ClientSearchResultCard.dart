import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';

import '../CheckInPage/View/CheckInPage.dart';
import '../ClientDetailsPage/ClientDetailsPage.dart';
import '../Core/Model/Classes/Client.dart';

class ClientSearchResultCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final client = searchResults[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white, // or a very light grey
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
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
                                    await context
                                        .read<ClientProvider>()
                                        .deleteClient(client?.mClientId ?? "");
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    searchResults.removeAt(
                                        index); // Remove the client from the list
                                    onClientDeleted(); // Trigger the callback
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
                      if (state == "checkIn") {
                        return CheckInPage(client: client);
                      } else if (state == "search") {
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
