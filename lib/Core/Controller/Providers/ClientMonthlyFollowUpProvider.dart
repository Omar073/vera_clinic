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

  void _addCmfuToCacheSorted(ClientMonthlyFollowUp cmfu) {
    int insertIndex = _mCachedClientsMonthlyFollowUps
        .indexWhere((cachedCmfu) => (cmfu.mDate)!.isAfter(cachedCmfu!.mDate!));

    if (insertIndex == -1) {
      _mCachedClientsMonthlyFollowUps.add(cmfu);
    } else {
      _mCachedClientsMonthlyFollowUps.insert(insertIndex, cmfu);
    }
  }

  Future<void> createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    clientMonthlyFollowUp.mClientMonthlyFollowUpId =
        await clientMonthlyFollowUpFirestoreMethods
            .createClientMonthlyFollowUp(clientMonthlyFollowUp);
    _addCmfuToCacheSorted(clientMonthlyFollowUp);
    notifyListeners();
  }

  Future<List<ClientMonthlyFollowUp?>?> getClientMonthlyFollowUps(
      String clientId) async {
    try {
      final fetched = await clientMonthlyFollowUpFirestoreMethods
              .fetchClientMonthlyFollowUps(clientId) ??
          [];

      for (final cmfu in fetched) {
        if (!cachedClientsMonthlyFollowUps.any((c) =>
            c?.mClientMonthlyFollowUpId == cmfu.mClientMonthlyFollowUpId)) {
          _addCmfuToCacheSorted(cmfu);
        }
      }

      return fetched;
    } catch (e) {
      debugPrint('Error getting client monthly follow ups by client ID: $e');
      return null;
    }
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

    if (clientMonthlyFollowUp != null &&
        !cachedClientsMonthlyFollowUps.any((c) =>
            c?.mClientMonthlyFollowUpId ==
            clientMonthlyFollowUp?.mClientMonthlyFollowUpId)) {
      _addCmfuToCacheSorted(clientMonthlyFollowUp);
    }
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
        _addCmfuToCacheSorted(clientMonthlyFollowUp);
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

  Future<bool> deleteAllClientMonthlyFollowUps(String clientId) async {
    try {
      await clientMonthlyFollowUpFirestoreMethods
          .deleteAllClientMonthlyFollowUps(clientId);
      cachedClientsMonthlyFollowUps
          .removeWhere((cmfu) => cmfu?.mClientId == clientId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting all client monthly follow ups: $e');
      return false;
    }
  }
}
