import 'package:flutter/material.dart';
import '../../Controller/Providers/ClientProvider.dart';
import '../../Model/Classes/Client.dart';

class ClientSearchWidget extends StatefulWidget {
  final String hintText;
  // final List<Client?> searchResults;
  final void Function(List<Client?>) onSearchResultsUpdated;

  ClientSearchWidget({
    super.key,
    required this.hintText,
    // required this.searchResults,
    required this.onSearchResultsUpdated,
  });

  @override
  State<ClientSearchWidget> createState() => _ClientSearchWidgetState();
}

class _ClientSearchWidgetState extends State<ClientSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  ClientProvider clientProvider = ClientProvider();
  List<Client?> _searchResults = [];

  Future<void> searchByName(String name) async {
    final results = await clientProvider.getClientByName(name);
    setState(() {
      _searchResults = results;
      widget.onSearchResultsUpdated(_searchResults);
    });
  }

  //* we did 2 changes here: 1- instead of using the list that was passed to us
  //* from the search page, instead we created a new list here and passed it to
  //* the onSearchResultsUpdated call back Fn
  //* 2- Instead of clearing the list of search results then adding new values
  //* we can just assign the new values to the list directly which will override all old values

  // Future<void> searchByName(String name) async {
  //   final results = await clientProvider.getClientByName(name);
  //   setState(() {
  //     widget.searchResults.clear();
  //     widget.searchResults.addAll(results);
  //     widget.onSearchResultsUpdated(widget.searchResults);
  //   });
  // }

  Future<void> searchByPhone(String phone) async {
    final results = await clientProvider.getClientByPhone(phone);
    setState(() {
      _searchResults = results;
      widget.onSearchResultsUpdated(_searchResults);
    });
  }

  // Future<void> searchByPhone(String phone) async {
  //   final results = await clientProvider.getClientByPhone(phone);
  //   setState(() {
  //     widget.searchResults.clear();
  //     widget.searchResults.addAll(results);
  //     widget.onSearchResultsUpdated(widget.searchResults);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => searchByName(_controller.text),
              child: const Text('إبحث بالاسم'),
            ),
            ElevatedButton(
              onPressed: () => searchByPhone(_controller.text),
              child: const Text('إبحث بالهاتف'),
            ),
          ],
        ),
      ],
    );
  }
}
