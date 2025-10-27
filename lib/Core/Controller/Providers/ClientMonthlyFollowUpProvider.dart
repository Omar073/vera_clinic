import 'package:flutter/cupertino.dart';
import '../../Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Model/Firebase/ClientMonthlyFollowUpFirestoreMethods.dart';

class ClientMonthlyFollowUpProvider with ChangeNotifier {
  final ClientMonthlyFollowUpFirestoreMethods
      _mClientMonthlyFollowUpFirestoreMethods =
      ClientMonthlyFollowUpFirestoreMethods();

  ClientMonthlyFollowUp? _mCurrentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp> _mCachedClientsMonthlyFollowUps = [];

  ClientMonthlyFollowUp? get currentClientMonthlyFollowUp =>
      _mCurrentClientMonthlyFollowUp;
  List<ClientMonthlyFollowUp> get cachedClientsMonthlyFollowUps =>
      _mCachedClientsMonthlyFollowUps;
  ClientMonthlyFollowUpFirestoreMethods
      get clientMonthlyFollowUpFirestoreMethods =>
          _mClientMonthlyFollowUpFirestoreMethods;

  void _addCmfuToCacheSorted(ClientMonthlyFollowUp cmfu) {
    // Handle null dates gracefully
    if (cmfu.mDate == null) {
      _mCachedClientsMonthlyFollowUps.add(cmfu);
      // debug print the cmfu and the problem
      debugPrint('Adding cmfu to cache: $cmfu');

      debugPrint('Problem: ${cmfu.mDate}');      
      return;
    }

    int insertIndex = _mCachedClientsMonthlyFollowUps.indexWhere((cachedCmfu) {
      if (cachedCmfu.mDate == null) return false;
      return cmfu.mDate!.isAfter(cachedCmfu.mDate!);
    });

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

  Future<List<ClientMonthlyFollowUp>> getClientMonthlyFollowUps(
      String clientId) async {
    try {
      final fetched = await clientMonthlyFollowUpFirestoreMethods
              .fetchClientMonthlyFollowUps(clientId) ??
          [];

      for (final cmfu in fetched) {
        if (!cachedClientsMonthlyFollowUps.any((c) =>
            c.mClientMonthlyFollowUpId == cmfu.mClientMonthlyFollowUpId)) {
          _addCmfuToCacheSorted(cmfu);
        }
      }

      return fetched;
    } catch (e) {
      debugPrint('Error getting client monthly follow ups by client ID: $e');
      return [];
    }
  }

  Future<ClientMonthlyFollowUp?> getClientMonthlyFollowUpById(
      String clientMonthlyFollowUpId) async {
    // check cache first
    ClientMonthlyFollowUp? clientMonthlyFollowUp;
    try {
      clientMonthlyFollowUp = cachedClientsMonthlyFollowUps.firstWhere(
          (cmfu) => cmfu.mClientMonthlyFollowUpId == clientMonthlyFollowUpId);
    } catch (e) {
      clientMonthlyFollowUp = null;
    }

    clientMonthlyFollowUp ??= await clientMonthlyFollowUpFirestoreMethods
        .fetchClientMonthlyFollowUpById(clientMonthlyFollowUpId);

    if (clientMonthlyFollowUp != null &&
        !cachedClientsMonthlyFollowUps.any((c) =>
            c.mClientMonthlyFollowUpId ==
            clientMonthlyFollowUp!.mClientMonthlyFollowUpId)) {
      _addCmfuToCacheSorted(clientMonthlyFollowUp);
    }
    return clientMonthlyFollowUp;
  }

  Future<ClientMonthlyFollowUp?> getLatestClientMonthlyFollowUp(
      String clientId) async {
    try {
      // Check cache first for any follow-ups for this client
      ClientMonthlyFollowUp? latestFromCache = cachedClientsMonthlyFollowUps
          .where((cmfu) => cmfu.mClientId == clientId)
          .where((cmfu) => cmfu.mDate != null)
          .fold<ClientMonthlyFollowUp?>(null, (latest, current) {
        if (latest == null) return current;
        if (current.mDate == null) return latest;
        return current.mDate!.isAfter(latest.mDate!) ? current : latest;
      });

      if (latestFromCache != null) {
        return latestFromCache;
      }

      // If not in cache, fetch from Firestore
      ClientMonthlyFollowUp? latestFromFirestore = await clientMonthlyFollowUpFirestoreMethods
          .fetchLastClientMonthlyFollowUp(clientId);

      if (latestFromFirestore != null) {
        _addCmfuToCacheSorted(latestFromFirestore);
      }

      return latestFromFirestore;
    } catch (e) {
      debugPrint('Error getting latest client monthly follow up: $e');
      return null;
    }
  }

  Future<bool> updateClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      await clientMonthlyFollowUpFirestoreMethods
          .updateClientMonthlyFollowUp(clientMonthlyFollowUp);
      int index = cachedClientsMonthlyFollowUps.indexWhere((c) =>
          c.mClientMonthlyFollowUpId ==
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
          (cmfu) => cmfu.mClientMonthlyFollowUpId == clientMonthlyFollowUpId);
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
          .removeWhere((cmfu) => cmfu.mClientId == clientId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting all client monthly follow ups: $e');
      return false;
    }
  }
}
