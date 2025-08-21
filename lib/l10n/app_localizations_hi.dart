// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get kharachGuru => 'खर्चगुरु';

  @override
  String get transactions => 'लेन-देन';

  @override
  String get reports => 'रिपोर्ट';

  @override
  String get addTransaction => 'नया लेन-देन जोड़ें';

  @override
  String get noTransactions => 'कोई लेन-देन नहीं।';

  @override
  String get addNewTransactionPrompt => 'नया जोड़ने के लिए + दबाएं।';

  @override
  String get amount => 'रकम';

  @override
  String get description => 'विवरण';

  @override
  String get category => 'श्रेणी';

  @override
  String get isThisIncome => 'क्या यह आय है?';

  @override
  String get date => 'तारीख';

  @override
  String get saveTransaction => 'लेन-देन सहेजें';

  @override
  String get totalSummary => 'कुल सारांश';

  @override
  String get totalIncome => 'कुल आय';

  @override
  String get totalExpense => 'कुल खर्च';

  @override
  String get expenseCategories => 'व्यय श्रेणियाँ';

  @override
  String get incomeCategories => 'आय श्रेणियाँ';

  @override
  String get noTransactionsFound => 'कोई लेन-देन नहीं मिला।';

  @override
  String get noDataForReport => 'रिपोर्ट के लिए कोई डेटा नहीं।';

  @override
  String get noExpenseData => 'कोई व्यय डेटा नहीं।';
}
