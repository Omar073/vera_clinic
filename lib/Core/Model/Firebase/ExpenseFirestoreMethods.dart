import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';

import '../Classes/Expense.dart';

class ExpenseFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createExpense(Expense expense) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection("Expenses")
            .add(expense.toMap()),
        retryIf: (e) => true,
      );

      await docRef.update({
        "expenseId": docRef.id,
      });
      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint('Firebase error creating expense: ${e.message}');
      return '';
    } catch (e) {
      debugPrint('Unknown error creating expense: $e');
      return '';
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      final expenseRef = FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .doc(expense.mExpenseId);

      final docSnapshot = await r.retry(
        () => expenseRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching expense found with expenseId: ${expense.mExpenseId}');
      }

      await r.retry(
        () => expenseRef.update(expense.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating expense: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error updating expense: $e');
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      final expenseRef = FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .doc(expenseId);

      final docSnapshot = await r.retry(
        () => expenseRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching expense found with expenseId: $expenseId');
      }

      await r.retry(
        () => expenseRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting expense: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error deleting expense: $e');
    }
  }

  Future<List<Expense?>> fetchAllExpenses() async {
    try {
      final snapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore.collection('Expenses').get(),
        retryIf: (e) => true,
      );

      return snapshot.docs
          .map((doc) => Expense.fromFirestore(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching all expenses: ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unknown error fetching all expenses: $e');
      return [];
    }
  }

  Future<Expense?> fetchExpenseById(String expenseId) async {
    try {
      final snapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Expenses')
            .where('expenseId', isEqualTo: expenseId)
            .get(),
        retryIf: (e) => true,
      );

      return snapshot.docs.isEmpty
          ? null
          : Expense.fromFirestore(snapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching expense by ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unknown error fetching expense by ID: $e');
      return null;
    }
  }

  Future<void> clearAllExpenses() async {
    try {
      final snapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore.collection('Expenses').get(),
        retryIf: (e) => true,
      );

      for (var doc in snapshot.docs) {
        await r.retry(
          () => doc.reference.delete(),
          retryIf: (e) => true,
        );
      }
    } on FirebaseException catch (e) {
      debugPrint('Firebase error clearing all expenses: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error clearing all expenses: $e');
    }
  }
}
