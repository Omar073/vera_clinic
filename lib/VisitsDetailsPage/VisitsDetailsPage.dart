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

  
  void _refreshVisits() {
    setState(() {
      _visitsFuture = _fetchClientVisits(); // Refresh the Future
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            const Text(
              ' :تفاصيل زيارات',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.client.mName ?? ''),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
              return const Scaffold(
                body: Background(
                  child: Center(
                    child: Text(
                      'لا توجد زيارات للعميل',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
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
                return VisitCard(
                  visit: visit,
                  index: index + 1,
                  onVisitDeleted: () {
                    setState(() {
                      _refreshVisits();
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
