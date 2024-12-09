import 'package:flutter/material.dart';
import 'package:vera_clinic/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/View/Pages/CheckInPage.dart';

import '../../Model/Classes/Client.dart';

class ClientSearchPage extends StatelessWidget {
  String state;
  ClientSearchPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Search'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800), // Scales for desktop
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search for a Client",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _SearchBar(), // Search bar widget
              const SizedBox(height: 16),
              const Expanded(
                child: Center(
                  child: Text(
                    'TODO: Display search results here.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              state == "checkIn"
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckInPage(),
                          ),
                        );
                      },
                      child: const Text('Check In'),
                    )
                  : const Text("search"),
              //TODO: pass onTap method instead of if condition
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();
  ClientProvider clientProvider = ClientProvider();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'ادخل هاتف العميل', // Hint text
        prefixIcon: const Icon(Icons.search), // Search icon
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      keyboardType: TextInputType.phone, // Input type for phone numbers
      onSubmitted: (value) {
        // TODO: Implement search logic using the entered phone number
        debugPrint('Search for client with phone number: $value');
        clientProvider.setCurrentClient(client);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
