import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/VisitsDetailsPage/UsedWidgets/visitCard.dart';

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
        title: Text('${widget.client.mName} :تفاصيل زيارات '),
        centerTitle: true,
      ),
      body: Background(
        child: FutureBuilder<List<Visit?>?>(
          future: _visitsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Background(
                      child: Center(
                          child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ))));
            }
            if (snapshot.hasError) {
              return const Scaffold(
                body: Background(
                  child: Center(
                    child: Text(
                      'حدث خطأ أثناء تحميل البيانات',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              const Scaffold(
                body: Background(
                  child: Center(
                    child: Text(
                      'لا توجد زيارات',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            final visits = snapshot.data!;
            visits.sort((a, b) => b!.mDate
                .compareTo(a!.mDate)); // Sort visits from most recent to oldest

            return ListView.builder(
              itemCount: visits.length,
              itemBuilder: (context, index) {
                final visit = visits[index]!;
                return visitCard(visit, index + 1);
              },
            );
          },
        ),
      ),
    );
  }
}
