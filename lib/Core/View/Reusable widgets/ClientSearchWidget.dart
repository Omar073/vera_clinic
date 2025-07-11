import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/Providers/ClientProvider.dart';
import '../../Model/Classes/Client.dart';
import '../PopUps/MySnackBar.dart';

class ClientSearchWidget extends StatefulWidget {
  final String hintText;
  final void Function() onSearchButtonClicked;
  final void Function() setHasSearched;

  const ClientSearchWidget({
    super.key,
    required this.hintText,
    required this.onSearchButtonClicked,
    required this.setHasSearched,
  });

  @override
  State<ClientSearchWidget> createState() => _ClientSearchWidgetState();
}

//todo: revamp and update (fawwar) el search logic kolo and maybe even write it from scratch

class _ClientSearchWidgetState extends State<ClientSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoadingName = false;
  bool _isLoadingPhone = false;

  //* we did 2 changes here: 1- instead of using the list that was passed to us
  //* from the search page, instead we created a new list here and passed it to
  //* the onSearchResultsUpdated call back Fn
  //* 2- Instead of clearing the list of search results then adding new values
  //* we can just assign the new values to the list directly which will override all old values

  Future<void> searchByName(String name) async {
    setState(() {
      _isLoadingName = true;
    });
    widget.onSearchButtonClicked();
    List<Client?> results = [];
    final resultsByFirstName =
        await context.read<ClientProvider>().getClientByFirstName(name);
    final resultsByName =
        await context.read<ClientProvider>().getClientByName(name);
    final resultsByFirstAndSecondName = await context
        .read<ClientProvider>()
        .getClientByFirstAndSecondName(name);
    
    // Use a Map to deduplicate based on clientId
    final Map<String, Client?> uniqueClients = {};
    for (var client in [...resultsByFirstName, ...resultsByName, ...resultsByFirstAndSecondName]) {
      if (client != null && client.mClientId.isNotEmpty) {
        uniqueClients[client.mClientId] = client;
      }
    }
    results = uniqueClients.values.toList();
    
    context.read<ClientProvider>().setSearchResults(results);
    widget.setHasSearched();
    setState(() {
      _isLoadingName = false;
    });
  }

  Future<void> searchByPhone(String phone) async {
    setState(() {
      _isLoadingPhone = true;
    });
    widget.onSearchButtonClicked();
    final List<Client?> results =
        await context.read<ClientProvider>().getClientByPhone(phone);
    context.read<ClientProvider>().setSearchResults(results);
    widget.setHasSearched();
    setState(() {
      _isLoadingPhone = false;
    });
  }

  Future<void> clickedSearchButton(String key, String type) async {
    type == 'name' ? await searchByName(key) : await searchByPhone(key);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            hintTextDirection: TextDirection.rtl,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
              borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 2.0),
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(Icons.search),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _isLoadingName
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_controller.text.isEmpty) {
                          showMySnackBar(
                              context, "الرجاء إدخال اسم للبحث", Colors.red);
                          return;
                        }
                        await searchByName(_controller.text.toLowerCase());
                      },
                      child: const Text(
                        'إبحث بالاسم',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
              _isLoadingPhone
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent, // Text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_controller.text.isEmpty) {
                          showMySnackBar(context,
                              "الرجاء إدخال رقم التليفون للبحث", Colors.red);
                          return;
                        }
                        await searchByPhone(_controller.text);
                      },
                      child: const Text(
                        'إبحث بالرقم',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
