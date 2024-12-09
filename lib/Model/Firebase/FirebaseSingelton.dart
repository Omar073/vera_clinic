import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSingleton {
  FirebaseSingleton._();
  static FirebaseSingleton get instance => _instance;

  static final FirebaseSingleton _instance = FirebaseSingleton._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;
  //todo: understand????
}
