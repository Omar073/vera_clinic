import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/ClientDetailsPage/ClientDetailsPage.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/MyAlertDialogue.dart';
import 'package:vera_clinic/Core/View/PopUps/MySnackBar.dart';

class DailyClientCard extends StatelessWidget {
  final Client client;
  final int index;
  final VoidCallback onClientRemoved;

  const DailyClientCard({super.key, required this.client, required this.index, required this.onClientRemoved});

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientDetailsPage(client: client),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showAlertDialogue(
      context: context,
      title: 'تأكيد الحذف',
      content: 'هل أنت متأكد أنك تريد حذف هذا العميل من القائمة اليومية؟',
      buttonText: 'حذف',
      returnText: 'إلغاء',
      onPressed: () async {
        await Provider.of<ClinicProvider>(context, listen: false)
            .removeClientFromDailyList(client.mClientId);
        if (context.mounted) {
          showMySnackBar(context, 'تم حذف العميل بنجاح', Colors.green);
          onClientRemoved();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => _navigateToDetails(context),
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'عميل: ${index + 1}',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Text(
                          'الاسم: ${client.mName}',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'رقم الهاتف: ${client.mClientPhoneNum ?? 'غير معروف'}',
                          style: GoogleFonts.cairo(fontSize: 16),
                        ),
                        const SizedBox(width: 24),
                        Text(
                          'نوع الاشتراك: ${getSubscriptionTypeLabel(client.mSubscriptionType ?? SubscriptionType.none)}',
                          style: GoogleFonts.cairo(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _navigateToDetails(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'تفاصيل العميل',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _showDeleteConfirmationDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'حذف',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
