import 'package:flutter/material.dart';
import 'package:vera_clinic/View/Pages/AnalysisPage.dart';
import 'package:vera_clinic/View/Pages/ClientSearchPage.dart';
import 'package:vera_clinic/View/Pages/FollowUpNav.dart';

import 'Pages/NewClientPage.dart';

class NavigationButton extends StatefulWidget {
  final String mButtonText;
  final IconData mButtonIcon;
  NavigationButton(
      {super.key, required this.mButtonText, required this.mButtonIcon});

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize based on widget.mType
  //   if (widget.mType == "new client") {
  //     mButtonText = "عميل جديد";
  //     mButtonIcon = const Icon(Icons.person_add, color: Colors.white, size: 90);
  //   } else if (widget.mType == "previous client") {
  //     mButtonText = "عميل سابق";
  //     mButtonIcon = const Icon(Icons.person, color: Colors.white, size: 90);
  //   } else if (widget.mType == "follow-up") {
  //     mButtonText = "متابعة";
  //     mButtonIcon =
  //         const Icon(Icons.person_search, color: Colors.white, size: 90);
  //   } else if (widget.mType == "analysis") {
  //     mButtonText = "بيانات";
  //     mButtonIcon = const Icon(Icons.area_chart, color: Colors.white, size: 90);
  //   }
  // }

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
      onTap: () {
        debugPrint("Button pressed: ${widget.mButtonText}");
        if (widget.mButtonText == "عميل جديد") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewClientPage()));
        } else if (widget.mButtonText == "عميل سابق") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientSearchPage(
                        state: "checkIn",
                      )));
        } else if (widget.mButtonText == "متابعة") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FollowUpNav()));
        } else if (widget.mButtonText == "بيانات") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnalysisPage()));
        } else if (widget.mButtonText == "بحث") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientSearchPage(state: "search")));
        } else if (widget.mButtonText == "متابعة اسبوعية") {
          // Add code here
        } else if (widget.mButtonText == "متابعة اسبوعية") {
          // Add code here
        }
      },
    );
  }
}

class MyInputField extends StatefulWidget {
  final TextEditingController myController;
  final String hint;
  final String label;
  const MyInputField(
      {super.key,
      required this.myController,
      required this.hint,
      required this.label});

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
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
            mainAxisAlignment:
                MainAxisAlignment.end, // Aligns to the other side
            children: [
              Text(
                widget.label ?? '', // Display the label text
                style: const TextStyle(
                    fontSize: 16), // Customize label style if needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  final String title;
  final String value;
  const MyTextField({super.key, required this.title, required this.value});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          " : ${widget.title}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
    //Text("${client.name} :اسم العميل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
  }
}
