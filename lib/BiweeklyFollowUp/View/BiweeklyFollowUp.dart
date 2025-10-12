import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/BiweeklyFollowUp/View/UsedWidgets/ActionButton.dart';

import '../../../Core/View/Reusable widgets/my_app_bar.dart';
import '../../Core/Model/Classes/Client.dart';
import '../Controller/BiweeklyFollowUpTEC.dart';
import 'UsedWidgets/LastFollowUpInfo.dart';
import 'UsedWidgets/newBiweeklyFollowUp.dart';

class BiweeklyFollowUp extends StatefulWidget {
  final Client client;
  const BiweeklyFollowUp({super.key, required this.client});

  @override
  State<BiweeklyFollowUp> createState() => _BiweeklyFollowUpState();
}

class _BiweeklyFollowUpState extends State<BiweeklyFollowUp> {
  late Future<ClientMonthlyFollowUp?> _lastMonthlyFollowUpFuture;

  @override
  void initState() {
    super.initState();
    BiweeklyFollowUpTEC.init();
    _lastMonthlyFollowUpFuture = _fetchLastMonthlyFollowUp();
  }

  @override
  void dispose() {
    BiweeklyFollowUpTEC.dispose();
    super.dispose();
  }

  Future<ClientMonthlyFollowUp?> _fetchLastMonthlyFollowUp() async {
    final cmfu = await context
        .read<ClientMonthlyFollowUpProvider>()
        .getClientMonthlyFollowUpByClientId(widget.client.mClientId);
    return cmfu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '${widget.client.mName!} :متابعة أسبوعين',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                FutureBuilder<ClientMonthlyFollowUp?>(
                  future: _lastMonthlyFollowUpFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'حدث خطأ أثناء تحميل البيانات',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      final cmfu = snapshot.data!;
                      return Column(
                        children: [
                          LastFollowUpInfo(client: widget.client, cmfu: cmfu),
                          const SizedBox(height: 20),
                          newBiweeklyFollowUpForm(),
                          const SizedBox(height: 50),
                          ActionButton(client: widget.client, cmfu: cmfu),
                          const SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return const Center(child: Text('لا توجد بيانات'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
