import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/FollowUpNavPage/View/FollowUpNavPage.dart';
import 'package:vera_clinic/Core/View/PopUps/MyAlertDialogue.dart';

import '../Core/Controller/Providers/ClinicProvider.dart';
import '../Core/Controller/UtilityFunctions.dart';
import '../Core/Model/Classes/Client.dart';

class ClientCard extends StatefulWidget {
  final Client? client;
  final int index;
  final VoidCallback onClientCheckedOut;
  const ClientCard({
    super.key, 
    required this.client, 
    required this.index,
    required this.onClientCheckedOut,
  });

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  bool _isCheckingOut = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClinicProvider>(
      builder: (context, clinicProvider, child) {
        // Get check-in time from clinic data
        final checkInTime = clinicProvider.clinic?.getCheckInTime(widget.client?.mClientId ?? '');
        String displayTime = 'غير محدد';
        if (checkInTime != null) {
          try {
            final dateTime = DateTime.parse(checkInTime);
            displayTime = formatTimeToArabic12Hour(dateTime);
          } catch (e) {
            displayTime = 'غير صحيح';
          }
        }

        final weightValue = widget.client?.mWeight;
        final weightText = (weightValue != null && weightValue > 0)
            ? '${weightValue.toStringAsFixed(weightValue % 1 == 0 ? 0 : 1)} كجم'
            : 'غير متوفر';
        final dietRaw = widget.client?.mDiet?.trim() ?? '';
        final dietText = dietRaw.isNotEmpty ? dietRaw : 'غير محدد';

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => FollowUpNavPage(client: widget.client!)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('عميل: ${widget.index + 1}', style: const TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(width: 16),
                              Text('الاسم: ${widget.client?.mName ?? 'غير معروف'}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'الوزن الحالي: $weightText   |   النظام الحالي: $dietText',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'نوع الاشتراك: ${getSubscriptionTypeLabel(widget.client?.mSubscriptionType ?? SubscriptionType.none)}',
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'وقت تسجيل الدخول: $displayTime',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (clinicProvider.clinic?.hasClientArrived(widget.client!.mClientId) ?? false)
                                    ? Colors.red
                                    : Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<ClinicProvider>()
                                    .toggleArrivedStatus(widget.client!.mClientId);
                              },
                              child: Text(
                                (clinicProvider.clinic?.hasClientArrived(widget.client!.mClientId) ?? false)
                                    ? 'لم يصل'
                                    : 'وصل',
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                              icon: _isCheckingOut
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              onPressed: _isCheckingOut
                                  ? null
                                  : () async {
                                      await showAlertDialogue(
                                        context: context,
                                        title: 'تأكيد تسجيل الخروج',
                                        content: 'هل أنت متأكد من تسجيل خروج العميل ${widget.client?.mName}؟',
                                        onPressed: () async {
                                          setState(() {
                                            _isCheckingOut = true;
                                          });
                                          try {
                                            await context.read<ClinicProvider>().checkOutClient(widget.client!);
                                            widget.onClientCheckedOut();
                                          } finally {
                                            if (mounted) {
                                              setState(() {
                                                _isCheckingOut = false;
                                              });
                                            }
                                          }
                                        },
                                      );
                                    },
                              label: Text(
                                _isCheckingOut ? 'جاري تسجيل الخروج...' : 'تسجيل خروج',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
