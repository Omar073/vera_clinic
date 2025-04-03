import 'package:flutter/cupertino.dart';

Widget infoField ({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      Text(
        " :$title",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );

}