import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/VisitFirestoreMethods.dart';

import '../../Model/Classes/Visit.dart';
import '../../Model/Firebase/FirebaseSingelton.dart';

class VisitProvider with ChangeNotifier {
  VisitFirestoreMethods _visitFirestoreMethods = VisitFirestoreMethods();

  List<Visit> _visits = [];
  List<Visit> _currentClientVisits = [];
  Visit? _currentVisit;

  List<Visit> get visits => _visits;
  Visit? get currentVisit => _currentVisit;
  List<Visit> get currentClientVisits => _currentClientVisits;

  void createVisit(Visit visit) {
    _visitFirestoreMethods.createVisit(visit);
    // _currentVisit = visit;  //TODO: should we leave this?
    _visits.add(visit);
    notifyListeners();
  }

  getVisits(String phoneNum) {
    for (Visit v in visits) {
      if (v.clientPhoneNum == phoneNum && !visits.contains(v)) {
        visits.add(v);
      }
    }
    _visitFirestoreMethods.fetchVisits(phoneNum).then((fetchedVisits) {
      _visits = fetchedVisits;
      notifyListeners();
    });
    return visits;
  }

  Visit getClientLastVisit(String phoneNum) {
    List<Visit> clientVisits = [];
    if (visits.any((v) => v.clientPhoneNum == phoneNum)) {
      clientVisits.addAll(visits.where((v) => v.clientPhoneNum == phoneNum).toList());
    } else {
      _visitFirestoreMethods.fetchVisits(phoneNum).then((fetchedVisits) {
        clientVisits.addAll(fetchedVisits);
        visits.addAll(fetchedVisits); // to cache them
      });
    }
    clientVisits.sort((a, b) => a.date.compareTo(b.date));
    return clientVisits.last;
  }
}
