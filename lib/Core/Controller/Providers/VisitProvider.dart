import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Firebase/VisitFirestoreMethods.dart';

import '../../Model/Classes/Visit.dart';
import '../../Model/Firebase/FirebaseSingelton.dart';

class VisitProvider with ChangeNotifier {
  final VisitFirestoreMethods _visitFirestoreMethods = VisitFirestoreMethods();

  Visit? _currentVisit;
  List<Visit?> _mCachedVisits = [];
  List<Visit?> _mCurrentClientVisits = [];

  Visit? get currentVisit => _currentVisit;
  List<Visit?> get cachedVisits => _mCachedVisits;
  List<Visit?> get currentClientVisits => _mCurrentClientVisits;
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
          await visitFirestoreMethods.fetchVisitsByClientId(clientId);
      for (Visit? visit in fetchedVisits ?? []) {
        if (!clientVisits.any((v) => v?.mClientId == visit?.mClientId)) {
          clientVisits.add(visit);
        }
      }
      for (Visit? visit in clientVisits) {
        if (visit != null && !cachedVisits.contains(visit)) {
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

  Future<void> updateVisit(Visit visit) async {
    await visitFirestoreMethods.updateVisit(visit);
    notifyListeners();
  }

  void setCurrentVisit(Visit visit) {
    _currentVisit = visit;
    notifyListeners();
  }
}
