import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Firebase/VisitFirestoreMethods.dart';

import '../../Model/Classes/Visit.dart';

class VisitProvider with ChangeNotifier {
  final VisitFirestoreMethods _visitFirestoreMethods = VisitFirestoreMethods();

  Visit? _currentVisit;
  List<Visit?> _mCachedVisits = [];
  // List<Visit?> _mCurrentClientVisits = [];

  Visit? get currentVisit => _currentVisit;
  List<Visit?> get cachedVisits => _mCachedVisits;
  // List<Visit?> get currentClientVisits => _mCurrentClientVisits;
  VisitFirestoreMethods get visitFirestoreMethods => _visitFirestoreMethods;

  Future<void> createVisit(Visit visit) async {
    visit.mVisitId = await visitFirestoreMethods.createVisit(visit);
    cachedVisits.add(visit);
    notifyListeners();
  }

  Future<List<Visit?>?> getVisitsByClientId(String clientId) async {
    try {
      List<Visit?>? clientVisits =
          cachedVisits.where((visit) => visit?.mClientId == clientId).toList();

      final fetchedVisits =
          await visitFirestoreMethods.fetchVisitsByClientId(clientId) ?? [];

      for (Visit? visit in fetchedVisits) {
        if (!clientVisits.any((v) => v?.mClientId == visit?.mClientId)) {
          clientVisits.add(visit);
        }
        if(visit != null && !cachedVisits.any((v) => v?.mVisitId == visit.mVisitId)) {
          cachedVisits.add(visit);
        }
      }

      notifyListeners();
      return clientVisits;
    } catch (e) {
      debugPrint('Error getting visits by client ID: $e');
      return null;
    }
  }

  Future<Visit?> getClientLastVisit(String clientId) async {
    try {
      List<Visit?>? clientVisits = await getVisitsByClientId(clientId);
      clientVisits
          ?.sort((a, b) => a?.mDate.compareTo(b?.mDate ?? DateTime(0)) ?? 0);
      return clientVisits?.isNotEmpty == true ? clientVisits?.last : null;
    } catch (e) {
      debugPrint('Error getting client last visit: $e');
      return null;
    }
  }

  Future<bool> updateVisit(Visit visit) async {
    try {
      await visitFirestoreMethods.updateVisit(visit);
      int index = cachedVisits.indexWhere((v) => v?.mVisitId == visit.mVisitId);
      if (index != -1) {
        cachedVisits[index] = visit;
      } else {
        cachedVisits.add(visit);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Failed to update visit: $e");
      return false;
    }
  }

  Future<bool> deleteVisit(String visitId) async {
    try {
      await visitFirestoreMethods.deleteVisit(visitId);
      cachedVisits.removeWhere((v) => v?.mVisitId == visitId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Failed to delete visit: $e");
      return false;
    }
  }

  Future<bool> deleteAllClientVisits(String clientId) async {
    try {
      await visitFirestoreMethods.deleteAllClientVisits(clientId);
      cachedVisits.removeWhere((v) => v?.mClientId == clientId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Failed to delete all client visits: $e");
      return false;
    }
  }

  void setCurrentVisit(Visit visit) {
    _currentVisit = visit;
    notifyListeners();
  }
}
