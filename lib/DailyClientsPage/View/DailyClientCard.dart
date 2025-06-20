import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vera_clinic/ClientDetailsPage/ClientDetailsPage.dart';
import 'package:vera_clinic/Core/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';

class DailyClientCard extends StatelessWidget {
  final Client client;
  final int index;

  const DailyClientCard({super.key, required this.client, required this.index});

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientDetailsPage(client: client),
      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
