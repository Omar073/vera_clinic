import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/Providers/ClientProvider.dart';
import '../../Model/Classes/Client.dart';

class ClientSearchWidget extends StatefulWidget {
  final String hintText;
  final void Function() onSearchButtonClicked;
  final void Function() setHasSearched;

  ClientSearchWidget({
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
    final results = await context.read<ClientProvider>().getClientByName(name);
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
            hintTextDirection: TextDirection.rtl,
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
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await searchByName(_controller.text);
                      },
                      child: const Text('إبحث بالاسم'),
                    ),
              _isLoadingPhone
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await searchByPhone(_controller.text);
                      },
                      child: const Text('إبحث بالهاتف'),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}