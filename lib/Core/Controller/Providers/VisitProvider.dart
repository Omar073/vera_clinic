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

  void _addVisitToCacheSorted(Visit visit) {
    int insertIndex = _mCachedVisits.indexWhere(
        (cachedVisit) => (visit.mDate).isAfter(cachedVisit!.mDate));

    if (insertIndex == -1) {
      _mCachedVisits.add(visit);
    } else {
      _mCachedVisits.insert(insertIndex, visit);
    }
  }

  Future<void> createVisit(Visit visit) async {
    visit.mVisitId = await visitFirestoreMethods.createVisit(visit);
    _addVisitToCacheSorted(visit);
    notifyListeners();
  }

  Future<List<Visit?>?> getClientVisits(String clientId) async {
    try {
      final fetchedVisits =
          await visitFirestoreMethods.fetchVisitsByClientId(clientId) ?? [];

      for (Visit? visit in fetchedVisits) {
        if (visit != null &&
            !cachedVisits.any((v) => v?.mVisitId == visit.mVisitId)) {
          _addVisitToCacheSorted(visit);
        }
      }

      notifyListeners();
      return fetchedVisits;
    } catch (e) {
      debugPrint('Error getting visits by client ID: $e');
      return null;
    }
  }

  Future<Visit?> getVisit(String visitId) async {
    try {
      Visit? visit = cachedVisits.firstWhere(
        (v) => v?.mVisitId == visitId,
        orElse: () => null,
      );
      if (visit != null) {
        return visit;
      }
      visit = await visitFirestoreMethods.fetchVisitById(visitId);
      if (visit != null &&
          !cachedVisits.any((v) => v?.mVisitId == visit!.mVisitId)) {
        _addVisitToCacheSorted(visit);
      }
      notifyListeners();
      return visit;
    } catch (e) {
      debugPrint('Error getting visit by ID: $e');
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
        _addVisitToCacheSorted(visit);
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
