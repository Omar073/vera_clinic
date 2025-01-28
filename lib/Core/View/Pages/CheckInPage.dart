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
      body: Center(
        child: Container(
          // constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(16.0),
          child: Container(
            // color: Colors.red[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    // color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyTextBox(
                            title: "تاريخ اخر متابعة",
                            value:
                                " ${visit.mDate.day}/${visit.mDate.month}/${visit.mDate.year}"), //TODO: change to get last visit date
                        const SizedBox(width: 50),
                        // MyTextField(
                        //     title: "منطقة العميل",
                        //     value: clientConstantInfoProvider
                        //         .getClientConstantInfo(client.clientPhoneNum)
                        //         ?.area ?? 'Unknown'),
                        const SizedBox(width: 50),
                        MyTextBox(
                            title: "رقم العميل",
                            value: client.mClientPhoneNum ?? 'unknown'),
                        const SizedBox(width: 50),
                        MyTextBox(
                            title: "اسم العميل",
                            value: client.mName ?? 'unknown'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyTextBox(
                        title: "الوزن", value: client.mHeight.toString()),
                    const SizedBox(width: 50),
                    MyTextBox(
                        title: "الطول", value: client.mHeight.toString()),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      // child: MyInputField(myController: subscriptionPriceController, hint: "أدخل سعر الإشتراك", label: "السعر"),
                      child: Container(
                        width: 250,
                        child: TextField(
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.end,
                          controller: subscriptionPriceController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'))
                          ],
                          decoration: const InputDecoration(
                            hintText: "أدخل سعر الإشتراك",
                            hintStyle: TextStyle(fontSize: 15),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "السعر",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    DropdownButton<SubscriptionType>(
                      // value: client.subscriptionType,
                      items: [
                        // DropdownMenuItem<SubscriptionType>(
                        //   value: client.subscriptionType,
                        //   child: const Text('اختر نوع الكشف'),
                        // ),
                        ...SubscriptionType.values.map((SubscriptionType type) {
                          return DropdownMenuItem<SubscriptionType>(
                            value: type,
                            child: Text(getSubscriptionTypeLabel(type)),
                          );
                        }).toList(),
                      ],
                      onChanged: (SubscriptionType? newValue) {
                        if (newValue != SubscriptionType.none &&
                            newValue != null) {
                          setState(() {
                            client.subscriptionType = newValue;
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      ": نوع الكشف",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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