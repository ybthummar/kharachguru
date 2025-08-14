import 'package:flutter/material.dart';
import 'package:your_project_name/features/home/screens/home_screen.dart';
import 'package:your_project_name/features/transactions/screens/transaction_screen.dart';
import 'package:your_project_name/features/add_transaction/screens/add_transaction_screen.dart';
import 'package:your_project_name/features/reports/screens/report_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/transactions':
        return MaterialPageRoute(builder: (_) => TransactionScreen());
      case '/add-transaction':
        return MaterialPageRoute(builder: (_) => AddTransactionScreen());
      case '/reports':
        return MaterialPageRoute(builder: (_) => ReportScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}