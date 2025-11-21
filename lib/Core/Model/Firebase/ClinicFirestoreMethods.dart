import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:vera_clinic/Core/Model/CustomExceptions.dart';

import '../Classes/Clinic.dart';
import 'FirebaseSingelton.dart';

import '../../../Core/Services/DebugLoggerService.dart';
class ClinicFirestoreMethods {
  static const String clinicDocumentId = '52g2WUMJjoTwbu6ioE96';
  // Limit retries; we'll avoid a hard global timeout and rely on Firestore + retry
  final r = RetryOptions(maxAttempts: 3, delayFactor: const Duration(milliseconds: 300));

  Future<Clinic> fetchClinic({void Function(int nextAttempt, int maxAttempts, Object error)? onRetry}) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      int nextAttempt = 2; // If first attempt fails, we will retry attempt #2
      final int maxAttempts = r.maxAttempts;
      final docSnapshot = await r.retry(
        () => clinicRef.get(),
        // Retry only on transient Firebase exceptions (network/unavailable)
        retryIf: (e) {
          if (e is FirebaseException) {
            return e.code == 'unavailable' || e.code == 'aborted' || e.code == 'deadline-exceeded';
          }
          return false;
        },
        onRetry: (e) {
          try {
            onRetry?.call(nextAttempt, maxAttempts, e);
          } catch (_) {}
          nextAttempt++;
        },
      );

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        // Fail fast with a meaningful message when collection/doc is missing
        throw FirebaseOperationException('لم يتم العثور على بيانات العيادة.');
      }
      return Clinic.fromFirestore(docSnapshot.data()!);
    } on FirebaseException catch (e) {
      mDebug('Firebase error fetching clinic: ${e.message}');
      throw FirebaseOperationException(
          'فشل الاتصال بالخادم. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      mDebug('Unknown error fetching clinic: $e');
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
      mDebug('Firebase error updating clinic: ${e.message}');
      throw FirebaseOperationException(
          'فشل تحديث بيانات العيادة. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      mDebug('Unknown error updating clinic: $e');
      throw FirebaseOperationException(
          'حدث خطأ غير متوقع أثناء تحديث بيانات العيادة.');
    }
  }

  Future<void> checkInClient(String clientId, String checkInTime) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      await r.retry(
        () => clinicRef.update({
          'checkedInClients.$clientId': {
            'checkInTime': checkInTime,
            'hasArrived': false,
          },
          'dailyClientIds': FieldValue.arrayUnion([clientId])
        }),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error checking in client: ${e.message}');
      throw FirebaseOperationException(
          'فشل تسجيل الدخول. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      mDebug('Unknown error checking in client: $e');
      throw FirebaseOperationException('حدث خطأ غير متوقع أثناء تسجيل الدخول.');
    }
  }

  Future<void> checkOutClient(String clientId) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      await r.retry(
        () => clinicRef.update({
          'checkedInClients.$clientId': FieldValue.delete(),
        }),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error checking out client: ${e.message}');
      throw FirebaseOperationException(
          'فشل تسجيل الخروج. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      mDebug('Unknown error checking out client: $e');
      throw FirebaseOperationException('حدث خطأ غير متوقع أثناء تسجيل الخروج.');
    }
  }

  Future<void> updateArrivedStatus(String clientId, bool newStatus) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      await r.retry(
        () => clinicRef.update({
          'checkedInClients.$clientId.hasArrived': newStatus,
        }),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error updating arrived status: ${e.message}');
      throw FirebaseOperationException(
          'فشل تحديث حالة الوصول. الرجاء التأكد من اتصالك بالإنترنت.');
    } catch (e) {
      mDebug('Unknown error updating arrived status: $e');
      throw FirebaseOperationException(
          'حدث خطأ غير متوقع أثناء تحديث حالة الوصول.');
    }
  }
}
