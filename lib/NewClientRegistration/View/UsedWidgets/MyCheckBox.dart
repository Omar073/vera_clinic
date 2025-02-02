import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const MyCheckBox({super.key, required this.controller, required this.text});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.text =
                    widget.controller.text == 'true' ? 'false' : 'true';
              });
            },
            child: Icon(
              widget.controller.text == 'true'
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            widget.text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
