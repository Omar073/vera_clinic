import 'package:flutter/material.dart';
import 'package:vera_clinic/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/View/Pages/CheckInPage.dart';
import 'package:vera_clinic/View/Reusable%20widgets/MySearchBar.dart';
import '../../Model/Classes/Client.dart';
import 'ClientDetailsPage.dart';

class ClientSearchPage extends StatefulWidget {
  final String state;
  // final VoidCallback onTap;
  // late Client? client;
  ClientSearchPage({super.key, required this.state});

  @override
  State<ClientSearchPage> createState() => _ClientSearchPageState();
}

class _ClientSearchPageState extends State<ClientSearchPage> {
  List<Client?> searchResults = [];

  void updateSearchResults(List<Client?> results) {
    setState(() {
      //todo: should you add a new searchResults list to the provider and use that instead?
      //todo: re-review the search process
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Search'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints:
              const BoxConstraints(maxWidth: 800), // Scales for desktop
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search for a Client",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              MySearchBar(
                hintText: "Enter client name or phone",
                searchResults: searchResults,
                onSearchResultsUpdated: updateSearchResults,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          'No results found.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final client = searchResults[index];
                          return ListTile(
                            title: Text(client?.name ?? 'Unknown'),
                            subtitle: Text(client?.clientPhoneNum ?? 'Unknown'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    if (widget.state == "checkIn") {
                                      return CheckInPage(client: client);
                                    } else if (widget.state == "search") {
                                      return ClientDetailsPage(client: client);
                                    } else {
                                      return Container(); // or any other default widget
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              // const SizedBox(height: 50),
              // widget.state == "checkIn"
              //     ? ElevatedButton(
              //         onPressed: widget.onTap,
              //         child: const Text('Check In'),
              //       )
              //     : const Text("search"),
            ],
          ),
        ),
      ),
    );
  }
}
