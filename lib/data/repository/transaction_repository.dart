import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionRepository {
  final List<Transaction> _transactions = [];

  List<Transaction> fetchTransactions() {
    return _transactions;
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
  }

  void updateTransaction(int id, Transaction updatedTransaction) {
    final index = _transactions.indexWhere((t) => t.id == id);
    if (index != -1) {
      _transactions[index] = updatedTransaction;
    }
  }

  void deleteTransaction(int id) {
    _transactions.removeWhere((t) => t.id == id);
  }
}