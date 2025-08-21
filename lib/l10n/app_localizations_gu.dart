// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get kharachGuru => 'ખર્ચગુરુ';

  @override
  String get transactions => 'વ્યવહારો';

  @override
  String get reports => 'અહેવાલ';

  @override
  String get addTransaction => 'નવો વ્યવહાર ઉમેરો';

  @override
  String get noTransactions => 'કોઈ વ્યવહાર નથી.';

  @override
  String get addNewTransactionPrompt => 'નવો ઉમેરવા માટે + દબાવો.';

  @override
  String get amount => 'રકમ';

  @override
  String get description => 'વર્ણન';

  @override
  String get category => 'શ્રેણી';

  @override
  String get isThisIncome => 'આવક છે?';

  @override
  String get date => 'તારીખ';

  @override
  String get saveTransaction => 'વ્યવહાર સાચવો';

  @override
  String get totalSummary => 'કુલ સારાંશ';

  @override
  String get totalIncome => 'કુલ આવક';

  @override
  String get totalExpense => 'કુલ ખર્ચ';

  @override
  String get expenseCategories => 'ખર્ચની શ્રેણીઓ';

  @override
  String get incomeCategories => 'આવકની શ્રેણીઓ';

  @override
  String get noTransactionsFound => 'કોઈ વ્યવહાર મળ્યા નથી.';

  @override
  String get noDataForReport => 'અહેવાલ માટે કોઈ ડેટા નથી.';

  @override
  String get noExpenseData => 'કોઈ ખર્ચનો ડેટા નથી.';
}
