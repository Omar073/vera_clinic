import 'dart:async';

import 'package:flutter/material.dart';

Future showAlertDialogue({
  required BuildContext context,
  required String title,
  required String content,
  String buttonText = 'نعم',
  String returnText = 'لا',
  required FutureOr<void> Function() onPressed,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.blue[50]!,
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () async {
            await onPressed();
            Navigator.of(context).pop();
          },
          child: Text(buttonText, style: const TextStyle(color: Colors.blueAccent)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(returnText, style: const TextStyle(color: Colors.blueAccent)),
        ),
      ],
    ),
  );
}
