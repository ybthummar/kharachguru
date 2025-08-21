import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharach_guru/data/models/transaction.dart';
import 'package:kharach_guru/features/transactions/bloc/transactions_bloc.dart';
import 'package:kharach_guru/l10n/app_localizations.dart';  
import 'package:animate_do/animate_do.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<bool> _isSelected = [true, false]; // 0: Expense, 1: Income

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isExpenseView = _isSelected[0];

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.transactions.isEmpty) {
          return Center(child: Text(l10n.noDataForReport));
        }

        final expenses = state.transactions.where((t) => !t.isIncome).toList();
        final income = state.transactions.where((t) => t.isIncome).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: ToggleButtons(
                  isSelected: _isSelected,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < _isSelected.length; i++) {
                        _isSelected[i] = i == index;
                      }
                    });
                  },
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(l10n.totalExpense)),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(l10n.totalIncome)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isExpenseView
                      ? _buildPieChart(expenses, l10n)
                      : _buildPieChart(income, l10n),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPieChart(List<Transaction> transactions, AppLocalizations l10n) {
    if (transactions.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(child: Text(l10n.noExpenseData)),
      );
    }
    Map<String, double> categoryMap = {};
    for (var transaction in transactions) {
      categoryMap.update(transaction.category, (value) => value + transaction.amount,
          ifAbsent: () => transaction.amount);
    }

    final colors = [
      const Color(0xFF00BFA6),
      const Color(0xFFF9A825),
      const Color(0xFFEF5350),
      const Color(0xFFAB47BC),
      const Color(0xFF29B6F6),
    ];
    int colorIndex = 0;

    List<PieChartSectionData> sections = categoryMap.entries.map((entry) {
      final sectionColor = colors[colorIndex % colors.length];
      colorIndex++;
      final total = transactions.fold(0.0, (sum, e) => sum + e.amount);
      final percentage = total > 0 ? (entry.value / total) * 100 : 0;

      return PieChartSectionData(
        color: sectionColor,
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 80,
        titleStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 2)]),
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 4,
          centerSpaceRadius: 60,
        ),
      ),
    );
  }
}