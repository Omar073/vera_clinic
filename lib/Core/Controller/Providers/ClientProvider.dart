import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Firebase/ClientFirestoreMethods.dart';

import '../../Model/Classes/Client.dart';

class ClientProvider with ChangeNotifier {
  final ClientFirestoreMethods _clientFirestoreMethods =
      ClientFirestoreMethods();
  List<Client?> _cachedClients = []; // list of all fetched clients
  List<Client?> _checkedInClients = [];
  Client? _currentClient;

  List<Client?> get cachedClients => _cachedClients;
  List<Client?> get checkedInClients => _checkedInClients;
  Client? get currentClient => _currentClient;
  ClientFirestoreMethods get clientFirestoreMethods => _clientFirestoreMethods;

  void createClient(Client client) {
    client.clientId = clientFirestoreMethods.createClient(client) as String;
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
    List<Client?> clients = cachedClients  //? redundant
        .where(
          (client) => client?.mClientPhoneNum == phoneNum,
        )
        .toList();

    final fetchedClients =
        await clientFirestoreMethods.fetchClientByPhone(phoneNum);
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
    //todo: why 2 for loops?
    notifyListeners();
    return clients;
  }

  Future<List<Client?>> getClientByName(String name) async {
    List<Client?> clients = cachedClients  //? redundant
        .where(
          (client) => client?.mName == name,
        )
        .toList();

    final fetchedClients =
        await clientFirestoreMethods.fetchClientByName(name);
    for (var client in fetchedClients ?? []) {
      if (!clients.any((c) => c?.mClientId == client?.clientId)) {
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

  void updateClient(Client client) {
    clientFirestoreMethods.updateClient(client);
    notifyListeners();
  }

  void setCurrentClient(Client client) {
    _currentClient = client;
    notifyListeners();
  }

  void clearCurrentClient() {
    _currentClient = null;
    notifyListeners();
  }

  void addCheckedInClient(Client client) {
    _checkedInClients.add(client);
    notifyListeners();
  }

  void removeCheckedInClient(Client client) {
    _checkedInClients.remove(client);
    notifyListeners();
  }

  void clearCheckedInClients() {
    _checkedInClients.clear();
    notifyListeners();
  }
}
