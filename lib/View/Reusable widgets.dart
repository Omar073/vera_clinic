import 'package:flutter/material.dart';
import 'package:vera_clinic/View/Pages/ClientSearchPage.dart';

import 'Pages/NewClientPage.dart';

class NavigationButton extends StatefulWidget {
  final String mType;
  NavigationButton({super.key, required this.mType});

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  late String mButtonText;
  late Icon mButtonIcon;

  @override
  void initState() {
    super.initState();
    // Initialize based on widget.mType
    if (widget.mType == "new client") {
      mButtonText = "عميل جديد";
      mButtonIcon = const Icon(Icons.person_add, color: Colors.white, size: 90);
    } else if (widget.mType == "previous client") {
      mButtonText = "عميل سابق";
      mButtonIcon = const Icon(Icons.person, color: Colors.white, size: 90);
    } else if (widget.mType == "follow-up") {
      mButtonText = "متابعة";
      mButtonIcon =
          const Icon(Icons.person_search, color: Colors.white, size: 90);
    } else if (widget.mType == "analysis") {
      mButtonText = "بيانات";
      mButtonIcon = const Icon(Icons.area_chart, color: Colors.white, size: 90);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            mButtonIcon, // Use the Icon directly
            Text(
              mButtonText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      onTap: () {
        debugPrint("Button pressed: $mButtonText");
        if (widget.mType == "new client") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewClientPage()));
        } else if (widget.mType == "previous client") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ClientSearchPage()));
        } else if (widget.mType == "follow-up") {
          // Add code here
        } else if (widget.mType == "analysis") {
          // Add code here
        }
      },
    );
  }
}

class MyTextField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  const MyTextField(
      {super.key,
      required this.myController,
      required this.hint,
      required this.label});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.end,
        controller: widget.myController,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns to the other side
            children: [
              Text(
                widget.label ?? '', // Display the label text
                style: const TextStyle(fontSize: 16), // Customize label style if needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}

