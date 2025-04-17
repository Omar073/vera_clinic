import 'package:flutter/cupertino.dart';
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

  Future<void> createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    clientMonthlyFollowUp.mClientMonthlyFollowUpId =
        await clientMonthlyFollowUpFirestoreMethods
            .createClientMonthlyFollowUp(clientMonthlyFollowUp);
    cachedClientsMonthlyFollowUps.add(clientMonthlyFollowUp);
    notifyListeners();
  }

  Future<ClientMonthlyFollowUp?> getClientMonthlyFollowUpByClientId(
      String clientId) async {
    // check cache first
    ClientMonthlyFollowUp? clientMonthlyFollowUp =
        cachedClientsMonthlyFollowUps.firstWhere(
            (clientMonthlyFollowUp) =>
                clientMonthlyFollowUp?.mClientId == clientId,
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
                clientMonthlyFollowUp?.mClientMonthlyFollowUpId ==
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

  Future<bool> updateClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      await clientMonthlyFollowUpFirestoreMethods
          .updateClientMonthlyFollowUp(clientMonthlyFollowUp);
      int index = cachedClientsMonthlyFollowUps.indexWhere((c) =>
          c?.mClientMonthlyFollowUpId ==
          clientMonthlyFollowUp.mClientMonthlyFollowUpId);
      if (index != -1) {
        cachedClientsMonthlyFollowUps[index] = clientMonthlyFollowUp;
      } else {
        cachedClientsMonthlyFollowUps.add(clientMonthlyFollowUp);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating client monthly follow up: $e');
      return false;
    }
  }

  Future<bool> deleteClientMonthlyFollowUp(
      String clientMonthlyFollowUpId) async {
    try {
      await clientMonthlyFollowUpFirestoreMethods
          .deleteClientMonthlyFollowUp(clientMonthlyFollowUpId);
      cachedClientsMonthlyFollowUps.removeWhere(
          (cmfu) => cmfu?.mClientMonthlyFollowUpId == clientMonthlyFollowUpId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting client monthly follow up: $e');
      return false;
    }
  }
}
