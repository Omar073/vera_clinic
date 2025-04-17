import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customAppBar() {
  return Container(
    padding: const EdgeInsets.all(15),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Image.asset('assets/logo.png', height: 40), // Add your logo
        Text(
          'Vera-Life Clinic',
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
        //todo: do we need this?
        // IconButton(
        //   icon: const Icon(Icons.settings),
        //   onPressed: () {},
        // ),
      ],
    ),
  );
}
