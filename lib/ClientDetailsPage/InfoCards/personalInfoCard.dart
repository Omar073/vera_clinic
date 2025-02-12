import 'package:flutter/cupertino.dart';

import '../../CheckInPage/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
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