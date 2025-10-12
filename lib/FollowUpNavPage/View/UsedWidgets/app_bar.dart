import 'package:flutter/material.dart';
import 'package:vera_clinic/ClientDetailsPage/ClientDetailsPage.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';

class FollowUpNavAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Client client;

  const FollowUpNavAppBar({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Vera-Life Clinic',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientDetailsPage(client: client),
                ),
              );
            },
            child: const Text(
              'عرض بيانات العميل',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

