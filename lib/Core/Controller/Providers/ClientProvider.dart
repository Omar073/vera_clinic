import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Firebase/ClientFirestoreMethods.dart';

import '../../Model/Classes/Client.dart';

class ClientProvider with ChangeNotifier {
  final ClientFirestoreMethods _clientFirestoreMethods =
      ClientFirestoreMethods();

  List<Client?> _cachedClients = []; // list of all fetched clients
  List<Client?> _searchResults = [];
  Client? _currentClient;

  List<Client?> get cachedClients => _cachedClients;
  List<Client?> get searchResults => _searchResults;
  Client? get currentClient => _currentClient;
  ClientFirestoreMethods get clientFirestoreMethods => _clientFirestoreMethods;

  Future<void> createClient(Client client) async {
    client.mClientId = await clientFirestoreMethods.createClient(client);
    cachedClients.add(client);
    notifyListeners();
  }

  Future<Client?> getClientById(String clientId) async {
    Client? client = cachedClients.firstWhere(
      (client) => client?.mClientId == clientId,
      orElse: () => null,
    );

    client ??= await clientFirestoreMethods.fetchClientById(clientId);
    client == null ? cachedClients.add(client) : null;
    notifyListeners();
    return client;
  }

  Future<List<Client?>> getClientByPhone(String phoneNum) async {
    debugPrint("getting client by phone number: $phoneNum");
    List<Client?> clients =
        cachedClients //todo: should this be removed or instead if the cached list that matches phone num is not empty then return it directly?, depeding on if the phone num attribute should be unique or not
            .where(
              (client) => client?.mClientPhoneNum == phoneNum,
            )
            .toList();

    final fetchedClients =
        await clientFirestoreMethods.fetchClientByPhone(phoneNum);
    for (var client in fetchedClients) {
      if (!clients.any((c) => c?.mClientId == client?.mClientId)) {
        clients.add(client!);
        debugPrint("client added: ${client.mName}");
      }
    }

    for (var client in clients) {
      if (client != null &&
          !cachedClients.any((c) => c?.mClientId == client.mClientId)) {
        cachedClients.add(client);
      }
    }
    //todo: why 2 for loops?
    notifyListeners();
    return clients;
  }

  Future<List<Client?>> getClientByFirstName(String firstName) async {
    List<Client?> clients = cachedClients //todo: redundant
        .where(
          (client) => client?.mName == firstName,
        )
        .toList();

    final fetchedClients =
        await clientFirestoreMethods.fetchClientByFirstName(firstName);
    for (var client in fetchedClients) {
      if (!clients.any((c) => c?.mClientId == client?.mClientId)) {
        clients.add(client!);
      }
    }

    for (var client in clients) {
      if (client != null &&
          !cachedClients.any((c) => c?.mClientId == client.mClientId)) {
        cachedClients.add(client);
      }
    }
    notifyListeners();
    return clients;
  }

  Future<List<Client?>> getClientByName(String name) async {
    List<Client?> clients = cachedClients //? redundant
        .where(
          (client) => client?.mName == name,
        )
        .toList();

    final fetchedClients = await clientFirestoreMethods.fetchClientByName(name);
    for (var client in fetchedClients) {
      if (!clients.any((c) => c?.mClientId == client?.mClientId)) {
        clients.add(client!);
      }
    }

    for (var client in clients) {
      if (client != null &&
          !cachedClients.any((c) => c?.mClientId == client.mClientId)) {
        cachedClients.add(client);
      }
    }
    notifyListeners();
    return clients;
  }

  Future<bool> isPhoneNumUsed(String phoneNum) async {
    final clients = await clientFirestoreMethods.fetchClientByPhone(phoneNum);
    return clients.isNotEmpty;
    // returns true if the phone number is already used by a client else false
  }

  Future<bool> updateClient(Client client) async {
    try {
      await clientFirestoreMethods.updateClient(client);
      notifyListeners();
      return true;
    } on Exception catch (e) {
      debugPrint("Error updating client: $e");
      return false;
    }
  }

  Future<bool> deleteClient(String clientId) async {
    try {
      await clientFirestoreMethods.deleteClient(clientId);
      cachedClients.removeWhere((c) => c?.mClientId == clientId);
      notifyListeners();
      return true;
    } on Exception catch (e) {
      debugPrint("Error deleting client: $e");
      return false;
    }
  }

  void setCurrentClient(Client client) {
    _currentClient = client;
    notifyListeners();
  }

  void clearCurrentClient() {
    _currentClient = null;
    notifyListeners();
  }

  void addToCachedClients(Client client) {
    if (!cachedClients.any((c) => c?.mClientId == client.mClientId)) {
      cachedClients.add(client);
    }
    notifyListeners();
  }

  void addListToCachedClients(List<Client?> clients) {
    for (var client in clients) {
      if (client != null &&
          !cachedClients.any((c) => c?.mClientId == client.mClientId)) {
        cachedClients.add(client);
      }
    }
    notifyListeners();
  }

  void setSearchResults(List<Client?> clients) {
    _searchResults = clients;
    addListToCachedClients(clients);
    notifyListeners();
  }

  void clearSearchResults() {
    _searchResults.clear();
    notifyListeners();
  }
}
