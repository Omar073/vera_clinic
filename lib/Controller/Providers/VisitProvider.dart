import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/VisitFirestoreMethods.dart';

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

  void createVisit(Visit visit) {
    visit.visitId = _visitFirestoreMethods.createVisit(visit) as String;
    cachedVisits.add(visit);
    notifyListeners();
  }

  Future<List<Visit?>?> getVisitsByClientId(String clientId) async {
    List<Visit?>? clientVisits =
        cachedVisits.where((visit) => visit?.clientId == clientId).toList();

    final fetchedVisits =
        await _visitFirestoreMethods.fetchVisitsByClientId(clientId);
    for (Visit? visit in fetchedVisits ?? []) {
      if (!clientVisits.any((v) => v?.clientId == visit?.clientId)) {
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
  }

  Future<Visit?> getClientLastVisit(String clientId) async {
    List<Visit?>? clientVisits = await getVisitsByClientId(clientId);
    clientVisits
        ?.sort((a, b) => a?.date.compareTo(b?.date ?? DateTime(0)) ?? 0);
    return clientVisits?.isNotEmpty == true ? clientVisits?.last : null;
  }

  void setCurrentVisit(Visit visit) {
    _currentVisit = visit;
    notifyListeners();
  }
}
