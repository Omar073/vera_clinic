import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/myCard.dart';

class VisitsDetailsPage extends StatefulWidget {
  final Client client;
  const VisitsDetailsPage({super.key, required this.client});

  @override
  State<VisitsDetailsPage> createState() => _VisitsDetailsPageState();
}

class _VisitsDetailsPageState extends State<VisitsDetailsPage> {
  late Future<List<Visit?>?> _visitsFuture;

  @override
  void initState() {
    super.initState();
    _visitsFuture = _fetchClientVisits();
  }

  Future<List<Visit?>?> _fetchClientVisits() async {
    return await context
        .read<VisitProvider>()
        .getVisitsByClientId(widget.client.mClientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل زيارات ${widget.client.mName}'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Visit?>?>(
        future: _visitsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ ما'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد زيارات'));
          }

          final visits = snapshot.data!;
          visits.sort((a, b) => b!.mDate
              .compareTo(a!.mDate)); // Sort visits from most recent to oldest

          return ListView.builder(
            itemCount: visits.length,
            itemBuilder: (context, index) {
              final visit = visits[index]!;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                child: myCard(
                  'زيارة رقم ${visits.length - index}',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('التاريخ: ${visit.mDate.toLocal()}'),
                      Text('النظام الغذائي: ${visit.mDiet}'),
                      Text('الوزن: ${visit.mWeight} كجم'),
                      Text('مؤشر كتلة الجسم: ${visit.mBMI}'),
                      Text('ملاحظات: ${visit.mVisitNotes}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
