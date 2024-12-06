import 'package:flutter/material.dart';

class MyNavigationButton extends StatefulWidget {
  final String mButtonText;
  final IconData mButtonIcon;
  final VoidCallback onTap;

  const MyNavigationButton(
      {super.key,
        required this.mButtonText,
        required this.mButtonIcon,
        required this.onTap});

  @override
  State<MyNavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<MyNavigationButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(widget.mButtonIcon,
                color: Colors.white, size: 90), // Use the Icon directly
            Text(
              widget.mButtonText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}