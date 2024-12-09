import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/Client.dart';

import '../../Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Model/Firebase/ClientMonthlyFollowUpFirestoreMethods.dart';

class ClientMonthlyFollowUpProvider with ChangeNotifier {
  final ClientMonthlyFollowUpFirestoreMethods
      _clientMonthlyFollowUpFirestoreMethods =
      ClientMonthlyFollowUpFirestoreMethods();

  ClientMonthlyFollowUp? _currentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp> _cachedClientsMonthlyFollowUps = [];

  ClientMonthlyFollowUp? get currentClientMonthlyFollowUp =>
      _currentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp> get cachedClientsMonthlyFollowUps =>
      _cachedClientsMonthlyFollowUps;
  ClientMonthlyFollowUpFirestoreMethods
      get clientMonthlyFollowUpFirestoreMethods =>
          _clientMonthlyFollowUpFirestoreMethods;

  void createCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    clientMonthlyFollowUp.clientMonthlyFollowUpId =
        clientMonthlyFollowUpFirestoreMethods
            .createClientMonthlyFollowUp(clientMonthlyFollowUp) as String;
    cachedClientsMonthlyFollowUps.add(clientMonthlyFollowUp);
    notifyListeners();
  }

  ClientMonthlyFollowUp? getClientMonthlyFollowUp(String clientPhoneNum) {
    return cachedClientsMonthlyFollowUps.firstWhere(
        (clientMonthlyFollowUp) =>
            clientMonthlyFollowUp.clientPhoneNum == clientPhoneNum,
        orElse: () => clientMonthlyFollowUpFirestoreMethods
            .fetchClientMonthlyFollowUpByNum(clientPhoneNum));
  }

  void setCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    _currentClientMonthlyFollowUp = clientMonthlyFollowUp;
    notifyListeners();
  }
}
