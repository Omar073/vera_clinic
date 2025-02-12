import 'package:cloud_firestore/cloud_firestore.dart';
import '../Classes/Clinic.dart';
import 'FirebaseSingelton.dart';

class ClinicFirestoreMethods {
  static const String clinicDocumentId = '52g2WUMJjoTwbu6ioE96';

  Future<Clinic?> fetchClinic() {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      return clinicRef.get().then((docSnapshot) {
        if (!docSnapshot.exists) {
          throw Exception('No matching clinic found');
        }

        return Clinic.fromFirestore(docSnapshot.data()!);
      });
    } catch (e) {
      throw Exception('Error fetching clinic: $e');
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      final docSnapshot = await clinicRef.get();

      if (!docSnapshot.exists) {
        throw Exception('No matching clinic found');
      }

      await clinicRef.update(clinic.toMap());
    } catch (e) {
      throw Exception('Error updating clinic: $e');
    }
  }
}