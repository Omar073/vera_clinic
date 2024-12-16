import 'package:flutter/material.dart';
import '../../Controller/Providers/ClientProvider.dart';
import '../../Model/Classes/Client.dart';

class MySearchBar extends StatefulWidget {
  final String hintText;
  final List<Client?> searchResults;
  final void Function(List<Client?>) onSearchResultsUpdated;

  MySearchBar({
    super.key,
    required this.hintText,
    required this.searchResults,
    required this.onSearchResultsUpdated,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  ClientProvider clientProvider = ClientProvider();

  Future<void> searchByName(String name) async {
    final results = await clientProvider.getClientByName(name);
    setState(() {
      widget.searchResults.clear();
      widget.searchResults.addAll(results);
      widget.onSearchResultsUpdated(widget.searchResults);
    });
  }

  Future<void> searchByPhone(String phone) async {
    final results = await clientProvider.getClientByPhone(phone);
    setState(() {
      widget.searchResults.clear();
      widget.searchResults.addAll(results);
      widget.onSearchResultsUpdated(widget.searchResults);
    });
  }

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