import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kharach_guru/data/models/transaction.dart';
import 'package:kharach_guru/features/transactions/bloc/transactions_bloc.dart';
import 'package:kharach_guru/l10n/app_localizations.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _category;
  bool _isIncome = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    final categories = _isIncome
        ? l10n.incomeCategories.split(',')
        : l10n.expenseCategories.split(',');
    if (_category == null || !categories.contains(_category)) {
      _category = categories[0];
    }
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final transaction = Transaction(
        category: _category!,
        amount: double.parse(_amountController.text),
        isIncome: _isIncome,
        date: _selectedDate,
        description: _descriptionController.text,
      );
      context.read<TransactionBloc>().add(AddTransaction(transaction));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final expenseCategories = l10n.expenseCategories.split(',');
    final incomeCategories = l10n.incomeCategories.split(',');

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addTransaction)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<bool>(
                  value: _isIncome,
                  decoration: InputDecoration(labelText: "Transaction Type"),
                  items: [
                    DropdownMenuItem(value: false, child: Text(l10n.totalExpense)),
                    DropdownMenuItem(value: true, child: Text(l10n.totalIncome)),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _isIncome = value!;
                      _category = (_isIncome ? incomeCategories : expenseCategories)[0];
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: l10n.amount),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: InputDecoration(labelText: l10n.category),
                  items: (_isIncome ? incomeCategories : expenseCategories)
                      .map((label) => DropdownMenuItem(value: label, child: Text(label)))
                      .toList(),
                  onChanged: (value) => setState(() => _category = value!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: l10n.description),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                      "${l10n.date}: ${DateFormat.yMMMd().format(_selectedDate)}"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => _selectedDate = picked);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _submitData,
                  icon: const Icon(Icons.save),
                  label: Text(l10n.saveTransaction),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}