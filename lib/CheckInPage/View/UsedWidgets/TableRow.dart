import 'package:flutter/cupertino.dart';

TableRow tableRow(List<Map<String, String>> labelValuePairs) {
  return TableRow(
    children: labelValuePairs.map((pair) {
      final label = pair['label'] ?? '';
      final value = pair['value'] ?? '';
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(value, style: const TextStyle(fontSize: 18)),
            Text(" :$label",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }).toList(),
  );
}