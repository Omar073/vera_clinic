import 'package:flutter/material.dart';
import 'package:vera_clinic/Model/Classes/Client.dart';

class ClientDetailsPage extends StatefulWidget {
  final Client? client;
  const ClientDetailsPage({super.key, required this.client});

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints:
              const BoxConstraints(maxWidth: 800), // Scales for desktop
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Client Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
