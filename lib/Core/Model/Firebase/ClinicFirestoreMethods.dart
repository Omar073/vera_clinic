import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:vera_clinic/Core/Model/CustomExceptions.dart';

import '../Classes/Clinic.dart';
import 'FirebaseSingelton.dart';

class ClinicFirestoreMethods {
  static const String clinicDocumentId = '52g2WUMJjoTwbu6ioE96';
  final r = RetryOptions(maxAttempts: 5);

  Future<Clinic> fetchClinic() async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      final docSnapshot = await r.retry(
        () => clinicRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        throw FirebaseOperationException('لم يتم العثور على بيانات العيادة.');
      }
      return Clinic.fromFirestore(docSnapshot.data()!);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching clinic: ${e.message}');
      throw FirebaseOperationException(
          'فشل الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      debugPrint('Unknown error fetching clinic: $e');
      throw FirebaseOperationException('حدث خطأ غير متوقع أثناء تحميل البيانات.');
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      await r.retry(
        () => clinicRef.update(clinic.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating clinic: ${e.message}');
      throw FirebaseOperationException(
          'فشل تحديث بيانات العيادة. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      debugPrint('Unknown error updating clinic: $e');
      throw FirebaseOperationException(
          'حدث خطأ غير متوقع أثناء تحديث بيانات العيادة.');
    }
  }

  Future<void> checkInClient(String clientId) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      await r.retry(
        () => clinicRef.update({
          'checkedInClientsIds': FieldValue.arrayUnion([clientId]),
          'dailyClientIds': FieldValue.arrayUnion([clientId])
        }),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error checking in client: ${e.message}');
      throw FirebaseOperationException(
          'فشل تسجيل الدخول. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      debugPrint('Unknown error checking in client: $e');
      throw FirebaseOperationException('حدث خطأ غير متوقع أثناء تسجيل الدخول.');
    }
  }
}
