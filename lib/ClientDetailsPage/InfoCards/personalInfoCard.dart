import 'package:flutter/cupertino.dart';

import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/Pages/CheckInPage.dart';
import '../../NewClientRegistration/View/UsedWidgets/MyCard.dart';
import 'infoRow.dart';

Widget personalInfoCard(Client? client, String area) {
  return myCard(
    'Personal Information',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoRow('Name', client?.mName ?? 'Unknown'),
        infoRow('Phone Number', client?.mClientPhoneNum ?? 'Unknown'),
        infoRow('Gender', client?.mGender.name ?? 'Unknown'),
        infoRow(
            'Birthdate',
            client?.mBirthdate?.toLocal().toString().split(' ')[0] ??
                'Unknown'),
        infoRow('Area', area),
        infoRow(
            'Subscription Type',
            getSubscriptionTypeLabel(
                client!.mSubscriptionType ?? SubscriptionType.none)),
      ],
    ),
  );
}