import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/PreferredFoodsProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/WeightAreasProvider.dart';
import 'package:vera_clinic/Core/View/PopUps/MyAlertDialogue.dart';

import '../CheckInPage/View/CheckInPage.dart';
import '../ClientDetailsPage/ClientDetailsPage.dart';
import '../Core/Controller/UtilityFunctions.dart';
import '../Core/Model/Classes/Client.dart';

class ClientSearchResultCard extends StatefulWidget {
  List<Client?> searchResults = [];
  String state = "";
  final VoidCallback onClientDeleted;

  ClientSearchResultCard({
    super.key,
    required this.searchResults,
    required this.state,
    required this.onClientDeleted,
  });
  @override
  State<ClientSearchResultCard> createState() => _ClientSearchResultCardState();
}

class _ClientSearchResultCardState extends State<ClientSearchResultCard> {
  _deleteClient(Client c) async {
    await context.read<ClinicProvider>().checkOutClient(c);
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showAlertDialogue(
                          context: context,
                          title: "تأكيد الحذف",
                          content: "هل أنت متأكد أنك تريد حذف هذا العميل؟",
                          buttonText: "حذف",
                          returnText: "رجوع",
                          onPressed: () async {
                            await _deleteClient(client!);
                            Navigator.pop(context);
                            widget.searchResults.removeAt(index);
                            widget.onClientDeleted();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        foregroundColor: Colors.white,
                      ),
                      icon: const SizedBox.shrink(),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  client?.mClientPhoneNum ?? 'لا يوجد رقم',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'تليفون: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  getSubscriptionTypeLabel(
                                      client?.mSubscriptionType ??
                                          SubscriptionType.none),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
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
                        return Container();
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
