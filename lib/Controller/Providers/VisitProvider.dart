import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/VisitFirestoreMethods.dart';

import '../../Model/Classes/Visit.dart';
import '../../Model/Firebase/FirebaseSingelton.dart';

class VisitProvider with ChangeNotifier {
  final VisitFirestoreMethods _visitFirestoreMethods = VisitFirestoreMethods();

  List<Visit> _mCachedVisits = [];
  List<Visit> _mCurrentClientVisits = [];
  Visit? _currentVisit;

  List<Visit> get cachedVisits => _mCachedVisits;
  Visit? get currentVisit => _currentVisit;
  List<Visit> get currentClientVisits => _mCurrentClientVisits;

  void createVisit(Visit visit) {
    visit.visitId = _visitFirestoreMethods.createVisit(visit) as String;
    cachedVisits.add(visit);
    notifyListeners();
  }

  getVisits(String clientId) {
    List<Visit> clientVisits = cachedVisits.where((v) => v.clientId == clientId).toList();
    if (clientVisits.isEmpty) {
      // _visitFirestoreMethods.fetchVisits(clientId).then((fetchedVisits) {
      //   clientVisits.addAll(fetchedVisits);
      //   cachedVisits.addAll(fetchedVisits); // to cache them
      // });
      clientVisits.addAll(_visitFirestoreMethods.fetchVisits(clientId));
      cachedVisits.addAll(clientVisits); // to cache them

    }
    return clientVisits;

    List<Visit> clientVisits = cachedVisits.where((v) => v.clientId == clientId).toList();
    if (clientVisits.isEmpty) {
      clientVisits.addAll(await _visitFirestoreMethods.fetchVisits(clientId));
      cachedVisits.addAll(clientVisits); // to cache them
    }
  }

  Visit getClientLastVisit(String phoneNum) {
    List<Visit> clientVisits = [];
    if (cachedVisits.any((v) => v.clientPhoneNum == phoneNum)) {
      clientVisits.addAll(
          cachedVisits.where((v) => v.clientPhoneNum == phoneNum).toList());
    } else {
      _visitFirestoreMethods.fetchVisits(phoneNum).then((fetchedVisits) {
        clientVisits.addAll(fetchedVisits);
        cachedVisits.addAll(fetchedVisits); // to cache them
      });
    }
    clientVisits.sort((a, b) => a.date.compareTo(b.date));
    return clientVisits.last;
  }

  void setCurrentVisit(Visit visit) {
    _currentVisit = visit;
    notifyListeners();
  }
}
