import 'package:flutter/cupertino.dart';

Widget infoField ({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "$title: ",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    ],
  );

}