import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/Client.dart';

import '../../Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Model/Firebase/ClientMonthlyFollowUpFirestoreMethods.dart';

class ClientMonthlyFollowUpProvider with ChangeNotifier {
  final ClientMonthlyFollowUpFirestoreMethods
      _mClientMonthlyFollowUpFirestoreMethods =
      ClientMonthlyFollowUpFirestoreMethods();

  ClientMonthlyFollowUp? _mCurrentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp?> _mCachedClientsMonthlyFollowUps = [];

  ClientMonthlyFollowUp? get currentClientMonthlyFollowUp =>
      _mCurrentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp?> get cachedClientsMonthlyFollowUps =>
      _mCachedClientsMonthlyFollowUps;
  ClientMonthlyFollowUpFirestoreMethods
      get clientMonthlyFollowUpFirestoreMethods =>
          _mClientMonthlyFollowUpFirestoreMethods;

  void createCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    clientMonthlyFollowUp.clientMonthlyFollowUpId =
        clientMonthlyFollowUpFirestoreMethods
            .createClientMonthlyFollowUp(clientMonthlyFollowUp) as String;
    cachedClientsMonthlyFollowUps.add(clientMonthlyFollowUp);
    notifyListeners();
  }

  Future<ClientMonthlyFollowUp?> getClientMonthlyFollowUpByClientId(
      String clientId) async {
    // check cache first
    ClientMonthlyFollowUp? clientMonthlyFollowUp =
        cachedClientsMonthlyFollowUps.firstWhere(
            (clientMonthlyFollowUp) =>
                clientMonthlyFollowUp?.clientId == clientId,
            orElse: () => null);

    clientMonthlyFollowUp ??= await clientMonthlyFollowUpFirestoreMethods
        .fetchClientMonthlyFollowUpByClientId(clientId);

    clientMonthlyFollowUp == null
        ? cachedClientsMonthlyFollowUps.add(clientMonthlyFollowUp)
        : null;
    notifyListeners();
    return clientMonthlyFollowUp;
  }

  Future<ClientMonthlyFollowUp?> getClientMonthlyFollowUpById(
      String clientMonthlyFollowUpId) async {
    // check cache first
    ClientMonthlyFollowUp? clientMonthlyFollowUp =
        cachedClientsMonthlyFollowUps.firstWhere(
            (clientMonthlyFollowUp) =>
                clientMonthlyFollowUp?.clientMonthlyFollowUpId ==
                clientMonthlyFollowUpId,
            orElse: () => null);

    clientMonthlyFollowUp ??= await clientMonthlyFollowUpFirestoreMethods
        .fetchClientMonthlyFollowUpById(clientMonthlyFollowUpId);

    clientMonthlyFollowUp == null
        ? cachedClientsMonthlyFollowUps.add(clientMonthlyFollowUp)
        : null;
    notifyListeners();
    return clientMonthlyFollowUp;
  }

  void updateCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    clientMonthlyFollowUpFirestoreMethods
        .updateClientMonthlyFollowUp(clientMonthlyFollowUp);
    notifyListeners();
  }

  void setCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    _mCurrentClientMonthlyFollowUp = clientMonthlyFollowUp;
    notifyListeners();
  }
}
