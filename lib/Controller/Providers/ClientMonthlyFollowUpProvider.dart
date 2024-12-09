import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/Client.dart';

import '../../Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Model/Firebase/ClientMonthlyFollowUpFirestoreMethods.dart';

class ClientMonthlyFollowUpProvider with ChangeNotifier {
  ClientMonthlyFollowUpFirestoreMethods _clientMonthlyFollowUpFirestoreMethods =
      ClientMonthlyFollowUpFirestoreMethods();

  ClientMonthlyFollowUp? _currentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp> _clientsMonthlyFollowUps = [];

  ClientMonthlyFollowUp? get currentClientMonthlyFollowUp =>
      _currentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp> get clientsMonthlyFollowUps =>
      _clientsMonthlyFollowUps;
  ClientMonthlyFollowUpFirestoreMethods
      get clientMonthlyFollowUpFirestoreMethods =>
          _clientMonthlyFollowUpFirestoreMethods;

  void createCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    clientMonthlyFollowUp.clientMonthlyFollowUpId =
        clientMonthlyFollowUpFirestoreMethods
            .createClientMonthlyFollowUp(clientMonthlyFollowUp) as String;
    // _currentClientMonthlyFollowUp = clientMonthlyFollowUp;
    notifyListeners();
  }

  ClientMonthlyFollowUp getClientMonthlyFollowUp(String clientPhoneNum) {
    return clientsMonthlyFollowUps.firstWhere(
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
