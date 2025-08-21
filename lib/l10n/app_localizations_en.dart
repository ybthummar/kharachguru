// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get kharachGuru => 'KharachGuru';

  @override
  String get transactions => 'Transactions';

  @override
  String get reports => 'Reports';

  @override
  String get addTransaction => 'Add New Transaction';

  @override
  String get noTransactions => 'No Transactions Yet.';

  @override
  String get addNewTransactionPrompt => 'Press + to add a new one.';

  @override
  String get amount => 'Amount';

  @override
  String get description => 'Description';

  @override
  String get category => 'Category';

  @override
  String get isThisIncome => 'Is this an income?';

  @override
  String get date => 'Date';

  @override
  String get saveTransaction => 'Save Transaction';

  @override
  String get totalSummary => 'Total Summary';

  @override
  String get totalIncome => 'Total Income';

  @override
  String get totalExpense => 'Total Expense';

  @override
  String get expenseCategories => 'Expense Categories';

  @override
  String get incomeCategories => 'Income Categories';

  @override
  String get noTransactionsFound => 'No transactions found.';

  @override
  String get noDataForReport => 'No data available for report.';

  @override
  String get noExpenseData => 'No expense data to display.';
}
