import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kharach_guru/data/models/transaction.dart';

class TransactionRepository {
  // The Hive box for storing transactions
  final Box<Transaction> _transactionBox;

  // Initialize the repository by getting the Hive box instance
  TransactionRepository() : _transactionBox = Hive.box<Transaction>('transactions');

  // Adds a new transaction to the box
  Future<void> addTransaction(Transaction transaction) async {
    await _transactionBox.add(transaction);
  }

  // Deletes a transaction from the box at a specific index
  Future<void> deleteTransaction(int index) async {
    await _transactionBox.deleteAt(index);
  }

  // Retrieves all transactions from the box and sorts them by date (newest first)
  List<Transaction> getAllTransactions() {
    final transactions = _transactionBox.values.toList();
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }
}