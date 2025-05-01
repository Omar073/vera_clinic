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
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.mButtonIcon, color: Colors.blueAccent, size: 50),
            ),
            Text(
              widget.mButtonText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}