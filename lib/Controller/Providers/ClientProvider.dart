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
  List<Client> _cachedClients = []; // list of all fetched clients
  List<Client> _checkedInClients = [];
  Client? _currentClient;

  List<Client> get cachedClients => _cachedClients;
  List<Client> get checkedInClients => _checkedInClients;
  Client? get currentClient => _currentClient;
  ClientFirestoreMethods get clientFirestoreMethods => _clientFirestoreMethods;

  void getClientByNum(String phoneNum) {
    for (Client c in cachedClients) {
      if (c.clientPhoneNum == phoneNum) {
        // _currentClient = c; //TODO: should we leave this?
        notifyListeners();
        return;
      }
    }
    clientFirestoreMethods.fetchClientByNum(phoneNum).then((client) {
      cachedClients.add(client);
      notifyListeners();
    });
  }

  // void getClientById(String Id) {
  //   for (Client c in cachedClients) {
  //     if (c.clientPhoneNum == phoneNum) {
  //       // _currentClient = c; //TODO: should we leave this?
  //       notifyListeners();
  //       return;
  //     }
  //   }
  //   clientFirestoreMethods.fetchClientByNum(phoneNum).then((client) {
  //     cachedClients.add(client);
  //     notifyListeners();
  //   });
  // }

  void createClient(Client client) {
    clientFirestoreMethods.createClient(client);
    cachedClients.add(client);
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
}
