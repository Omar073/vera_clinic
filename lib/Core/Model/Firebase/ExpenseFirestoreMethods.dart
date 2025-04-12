import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';

import '../Classes/Expense.dart';

class ExpenseFirestoreMethods {
  Future<String> createExpense(Expense expense) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection("Expenses")
          .add(expense.toMap());

      await docRef.update({
        "expenseId": docRef.id,
      });
      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint(
          "Firebase error: $e fetching expense by ID: ${expense.mExpenseId}");
      return '';
    } catch (e) {
      debugPrint("Error: $e fetching expense by ID: ${expense.mExpenseId}");
      return '';
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      final expenseRef = FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .doc(expense.mExpenseId);

      final docSnapshot = await expenseRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching expense found with expenseId: ${expense.mExpenseId}');
      }

      await expenseRef.update(expense.toMap());
    } on FirebaseException catch (e) {
      debugPrint("Firebase error updating expense: $e");
      return;
    } catch (e) {
      debugPrint("Error updating expense: $e");
      return;
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    try {
      final expenseRef = FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .doc(expense.mExpenseId);

      final docSnapshot = await expenseRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching expense found with expenseId: ${expense.mExpenseId}');
      }

      await expenseRef.delete();
    } on FirebaseException catch (e) {
      debugPrint("Firebase error deleting expense: $e");
    } catch (e) {
      debugPrint("Error deleting expense: $e");
    }
  }

  Future<List<Expense?>> fetchAllExpenses() async {
    try {
      final snapshot = await FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .get();

      return snapshot.docs
          .map((doc) => Expense.fromFirestore(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint("Firebase error fetching expenses : $e");
      return [];
    } catch (e) {
      debugPrint("Error fetching expenses");
      return [];
    }
  }

  Future<Expense?> fetchExpenseById(String expenseId) async {
    try {
      final snapshot = await FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .where('expenseId', isEqualTo: expenseId)
          .get();

      return snapshot.docs.isEmpty
          ? null
          : Expense.fromFirestore(snapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint("Firebase error: $e fetching expense by ID: $expenseId");
      return null;
    } catch (e) {
      debugPrint("Error: $e fetching expense by ID: $expenseId");
      return null;
    }
  }

  Future<void> clearAllExpenses() async {
    try {
      final snapshot = await FirebaseSingleton.instance.firestore
          .collection('Expenses')
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      debugPrint("Firebase error clearing all expenses: $e");
    } catch (e) {
      debugPrint("Error clearing all expenses: $e");
    }
  }
}
