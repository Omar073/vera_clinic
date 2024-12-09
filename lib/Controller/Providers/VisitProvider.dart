import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/VisitFirestoreMethods.dart';

import '../../Model/Classes/Visit.dart';
import '../../Model/Firebase/FirebaseSingelton.dart';

class VisitProvider with ChangeNotifier {
  final VisitFirestoreMethods _visitFirestoreMethods = VisitFirestoreMethods();

  List<Visit> _cachedVisits = [];
  List<Visit> _currentClientVisits = [];
  Visit? _currentVisit;

  List<Visit> get cachedVisits => _cachedVisits;
  Visit? get currentVisit => _currentVisit;
  List<Visit> get currentClientVisits => _currentClientVisits;

  void createVisit(Visit visit) {
    _visitFirestoreMethods.createVisit(visit);
    // _currentVisit = visit;  //TODO: should we leave this?
    cachedVisits.add(visit);
    notifyListeners();
  }

  getVisits(String phoneNum) {
    List<Visit> clientVisits = [];
    if (cachedVisits.any((v) => v.clientPhoneNum == phoneNum)) {
      clientVisits.addAll(cachedVisits.where((v) => v.clientPhoneNum == phoneNum).toList());
    } else {
      _visitFirestoreMethods.fetchVisits(phoneNum).then((fetchedVisits) {
        clientVisits.addAll(fetchedVisits);
        cachedVisits.addAll(fetchedVisits); // to cache them
      });
    }
    return clientVisits;
  }

  Visit getClientLastVisit(String phoneNum) {
    List<Visit> clientVisits = [];
    if (cachedVisits.any((v) => v.clientPhoneNum == phoneNum)) {
      clientVisits.addAll(cachedVisits.where((v) => v.clientPhoneNum == phoneNum).toList());
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
