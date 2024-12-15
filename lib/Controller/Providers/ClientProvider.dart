import 'package:flutter/material.dart';
import 'package:vera_clinic/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Model/Firebase/ClientFirestoreMethods.dart';

import '../../Model/Classes/Client.dart';
import '../../Model/Classes/Disease.dart';
import '../../Model/Classes/PreferredFoods.dart';
import '../../Model/Classes/Visit.dart';
import '../../Model/Classes/WeightAreas.dart';

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
      (client) => client?.clientId == clientId,
      orElse: () => null,
    );

    client ??= await clientFirestoreMethods.fetchClientById(clientId);
    client == null ? cachedClients.add(client) : null;
    notifyListeners();
    return client;
  }

  Future<List<Client?>?> getClientByNum(String phoneNum) async {
    List<Client?>? clients = cachedClients
        .where(
          (client) => client?.clientPhoneNum == phoneNum,
        )
        .toList();

    final fetchedClients =
        await clientFirestoreMethods.fetchClientByNum(phoneNum);
    for (var client in fetchedClients ?? []) {
      if (!clients.any((c) => c?.clientId == client?.clientId)) {
        clients.add(client!);
      }
    }

    for (var client in clients) {
      if (client != null &&
          !cachedClients.any((c) => c?.clientId == client.clientId)) {
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
