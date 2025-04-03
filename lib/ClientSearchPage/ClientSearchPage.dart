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
      appBar: AppBar( //todo: change UI to match background
        title: const Text('بحث عن عميل'),
        centerTitle: true,
        backgroundColor: Colors.white70, // or your brand’s light color
        elevation: 0, // removes the default AppBar shadow
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
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // or a very light grey
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      child: const Icon(Icons.person),
                                    ),
                                    title: Text(
                                      client?.mName ?? 'Unknown',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        client?.mClientPhoneNum ?? 'Unknown'),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            if (widget.state == "checkIn") {
                                              return CheckInPage(
                                                  client: client);
                                            } else if (widget.state ==
                                                "search") {
                                              return ClientDetailsPage(
                                                  client: client);
                                            } else {
                                              return Container(); // or any other default widget
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
