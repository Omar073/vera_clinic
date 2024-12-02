import 'package:flutter/material.dart';
import 'package:vera_clinic/Model/Firebase/firebase_methods.dart';
import '../../Model/Classes/Client.dart';

class ClientProvider with ChangeNotifier {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  List<Client> _clients = [];
  Client? _currentClient; //TODO: change

  List<Client> get clients => _clients;

  Client? get currentClient => _currentClient;

  void addClient(Client client) {
    _clients.add(client);
    notifyListeners();
  }

  void removeClient(Client client) {
    _clients.remove(client);
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

  void getClientByNum(String phoneNum) {
    _firebaseMethods.fetchClientByNum(phoneNum).then((client) {
      clients.add(client);
      notifyListeners();
    });
  }

  void createClient(Client client) {
    // _firebaseMethods.createClient(client).then((value) {
    //   clients.add(client);
    //   notifyListeners();
    // });
    _firebaseMethods.createClient(client);
    clients.add(client);
    notifyListeners();
  }
}
