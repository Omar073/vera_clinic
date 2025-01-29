import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';

import '../../Model/Classes/Client.dart';
import '../../Model/Classes/Visit.dart';
import '../Reusable widgets/MyTextField.dart';

class CheckInPage extends StatefulWidget {
  final Client? client;
  const CheckInPage({super.key, required this.client});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}


class _CheckInPageState extends State<CheckInPage> {
  ClientProvider clientProvider = ClientProvider();
  TextEditingController subscriptionPriceController = TextEditingController();
  ClientConstantInfoProvider clientConstantInfoProvider =
  ClientConstantInfoProvider();
  late Visit lastClientVisit;

  @override
  void initState() {
    super.initState();
    // client = clientProvider.currentClient!;
    client = widget.client!;
    // lastClientVisit = VisitProvider().getClientLastVisit(client.clientPhoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In: ${client.mName}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildClientInfoCard(),
              const SizedBox(height: 24),
              _buildMeasurementsCard(),
              const SizedBox(height: 24),
              _buildSubscriptionCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'معلومات العميل',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              textDirection: TextDirection.rtl,
              children: [
                _buildTableRow(
                  'اسم العميل',
                  client.mName ?? 'unknown',
                  'رقم العميل',
                  client.mClientPhoneNum ?? 'unknown',
                ),
                _buildTableRow(
                  'تاريخ اخر متابعة',
                  "${visit.mDate.day}/${visit.mDate.month}/${visit.mDate.year}",
                  'منطقة العميل',
                  clientConstantInfoProvider
                      .getClientConstantInfo(client.mClientPhoneNum)
                      ?.area ?? 'Unknown',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'القياسات',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              textDirection: TextDirection.rtl,
              children: [
                _buildTableRow(
                  'الطول',
                  '${client.mHeight} سم',
                  'الوزن',
                  '${client.mWeight} كجم',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'معلومات الإشتراك',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.end,
                    controller: subscriptionPriceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                    ],
                    decoration: const InputDecoration(
                      hintText: "أدخل سعر الإشتراك",
                      labelText: "السعر",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                DropdownButton<SubscriptionType>(
                  hint: const Text('اختر نوع الكشف'),
                  items: SubscriptionType.values.map((SubscriptionType type) {
                    return DropdownMenuItem<SubscriptionType>(
                      value: type,
                      child: Text(getSubscriptionTypeLabel(type)),
                    );
                  }).toList(),
                  onChanged: (SubscriptionType? newValue) {
                    if (newValue != SubscriptionType.none && newValue != null) {
                      setState(() {
                        client.subscriptionType = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(width: 16),
                const Text(
                  ": نوع الكشف",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label1, String value1, String label2, String value2) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value2, style: const TextStyle(fontSize: 16)),
              Text(label2, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value1, style: const TextStyle(fontSize: 16)),
              Text(label1, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }
}

//todo: move this Fn somewhere else
String getSubscriptionTypeLabel(SubscriptionType type) {
  switch (type) {
    case SubscriptionType.none:
      return '';
    case SubscriptionType.newClient:
      return 'حالة جديدة';
    case SubscriptionType.singleVisit:
      return 'متابعة منفردة';
    case SubscriptionType.weeklyVisit:
      return 'متابعة أسبوعية';
    case SubscriptionType.monthlyVisit:
      return 'متابعة شهرية';
    case SubscriptionType.afterBreak:
      return 'بعد انقطاع';
    case SubscriptionType.cavSess:
      return 'Cav جلسة';
    case SubscriptionType.cavSess6:
      return 'Cav جلسات 6' ;
    case SubscriptionType.miso:
      return 'ميزو';
    case SubscriptionType.punctureSess:
      return 'جلسة إبر';
    case SubscriptionType.punctureSess6:
      return 'جلسات إبر 6';
    case SubscriptionType.other:
      return 'أخرى';
    default:
      return '';
  }
}