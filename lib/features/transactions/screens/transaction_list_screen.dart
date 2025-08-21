import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kharach_guru/data/models/transaction.dart';
import 'package:kharach_guru/features/transactions/bloc/transactions_bloc.dart';
import 'package:kharach_guru/l10n/app_localizations.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TransactionFilter { all, income, expense }

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  TransactionFilter _filter = TransactionFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.status == TransactionStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final transactions = state.transactions;
        final totalIncome = transactions
            .where((t) => t.isIncome)
            .fold(0.0, (sum, item) => sum + item.amount);
        final totalExpense = transactions
            .where((t) => !t.isIncome)
            .fold(0.0, (sum, item) => sum + item.amount);
        final totalBalance = totalIncome - totalExpense;

        final List<Transaction> filteredTransactions;
        if (_filter == TransactionFilter.income) {
          filteredTransactions = transactions.where((t) => t.isIncome).toList();
        } else if (_filter == TransactionFilter.expense) {
          filteredTransactions =
              transactions.where((t) => !t.isIncome).toList();
        } else {
          filteredTransactions = transactions;
        }

        return Column(
          children: [
            _buildSummaryHeader(totalBalance, totalIncome, totalExpense),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SegmentedButton<TransactionFilter>(
                segments: <ButtonSegment<TransactionFilter>>[
                  const ButtonSegment(
                      value: TransactionFilter.all, label: Text("All")),
                  ButtonSegment(
                      value: TransactionFilter.income,
                      label: Text(l10n.totalIncome)),
                  ButtonSegment(
                      value: TransactionFilter.expense,
                      label: Text(l10n.totalExpense)),
                ],
                selected: {_filter},
                onSelectionChanged: (newSelection) {
                  setState(() => _filter = newSelection.first);
                },
              ),
            ),
            Expanded(
              child: filteredTransactions.isEmpty
                  ? _buildEmptyState(l10n)
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 80, top: 8, left: 16, right: 16),
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index),
                          child: _buildTransactionTile(transaction),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryHeader(double balance, double income, double expense) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Balance", style: TextStyle(color: Colors.grey)),
          Text("₹${balance.toStringAsFixed(2)}",
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIncomeExpense("Income", "₹${income.toStringAsFixed(2)}",
                  Colors.greenAccent),
              _buildIncomeExpense("Expense", "₹${expense.toStringAsFixed(2)}",
                  Colors.redAccent),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIncomeExpense(String title, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(amount,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildTransactionTile(Transaction transaction) {
    // SVG આઇકન માટેનો પાથ અહીં બનાવવામાં આવ્યો છે
    final iconPath = 'assets/icons/${transaction.category.toLowerCase()}.svg';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E), // Card color
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                transaction.isIncome ? Colors.greenAccent : Colors.redAccent,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
              // જો આઇકન ન મળે તો ફોલબેક
              placeholderBuilder: (context) => Icon(
                Icons.help_outline_rounded,
                color: transaction.isIncome
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(DateFormat.yMMMd().format(transaction.date),
                    style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ),
          Text(
            '${transaction.isIncome ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color:
                  transaction.isIncome ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: FadeIn(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 100, color: Colors.grey.shade800),
            const SizedBox(height: 24),
            Text(l10n.noTransactions,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            Text(l10n.addNewTransactionPrompt,
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
