import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable widgets/my_app_bar.dart';
import 'package:vera_clinic/MonthlyFollowUpsDetailsPage/UsedWidgets/monthlyFollowUpDetailsCard.dart';

class MonthlyFollowUpsDetailsPage extends StatefulWidget {
  final Client client;
  const MonthlyFollowUpsDetailsPage({super.key, required this.client});

  @override
  State<MonthlyFollowUpsDetailsPage> createState() =>
      _MonthlyFollowUpsDetailsPageState();
}

class _MonthlyFollowUpsDetailsPageState
    extends State<MonthlyFollowUpsDetailsPage> {
  late Future<List<ClientMonthlyFollowUp?>?> _cmfuFuture;

  @override
  void initState() {
    super.initState();
    _cmfuFuture = _fetchMonthlyFollowUps();
  }

  Future<List<ClientMonthlyFollowUp?>?> _fetchMonthlyFollowUps() async {
    return await context
        .read<ClientMonthlyFollowUpProvider>()
        .getClientMonthlyFollowUps(widget.client.mClientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'متابعات: ${widget.client.mName ?? ''}',
      ),
      body: Background(
        child: FutureBuilder<List<ClientMonthlyFollowUp?>?>(
          future: _cmfuFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent));
            }
            if (snapshot.hasError) {
              return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
            }
            final cmfus = snapshot.data ?? [];
            if (cmfus.isEmpty) {
              return const Center(child: Text('لا توجد متابعات'));
            }

            cmfus.sort((a, b) => (b?.mDate ??
                    DateTime.fromMillisecondsSinceEpoch(0))
                .compareTo(a?.mDate ?? DateTime.fromMillisecondsSinceEpoch(0)));

            return ListView.builder(
              itemCount: cmfus.length,
              itemBuilder: (context, index) {
                final item = cmfus[index]!;
                return MonthlyFollowUpDetailsCard(
                  cmfu: item,
                  index: index + 1,
                  onDeleted: () {
                    setState(() {
                      _cmfuFuture = _fetchMonthlyFollowUps();
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
