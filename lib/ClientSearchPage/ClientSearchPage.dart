import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/CheckInPage/View/CheckInPage.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/ClientSearchWidget.dart';
import '../Core/Model/Classes/Client.dart';
import '../ClientDetailsPage/ClientDetailsPage.dart';

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
  bool _isLoading = false;
  bool _hasSearched = false;

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void setHasSearched() {
    setState(() {
      _hasSearched = true;
      _isLoading = false;
      for (var client in searchResults) {
        debugPrint(client!.mName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    searchResults = context.watch<ClientProvider>().searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text('بحث عن عميل'),
        centerTitle: true,
      ),
      body: Background(
        child: Center(
          child: Container(
            constraints:
                const BoxConstraints(maxWidth: 800), // Scales for desktop
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   "Search for a Client",
                //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 16),
                ClientSearchWidget(
                  hintText: "أدخل اسم او رقم العميل",
                  onSearchButtonClicked: () {
                    setLoading(true);
                  },
                  setHasSearched: setHasSearched,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _hasSearched && searchResults.isEmpty
                          ? const Center(
                              child: Text(
                                'No results found.',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final client = searchResults[index];
                                return ListTile(
                                  title: Text(client?.mName ?? 'Unknown'),
                                  subtitle:
                                      Text(client?.mClientPhoneNum ?? 'Unknown'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          if (widget.state == "checkIn") {
                                            return CheckInPage(client: client);
                                          } else if (widget.state == "search") {
                                            return ClientDetailsPage(
                                                client: client);
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
      ),
    );
  }
}
