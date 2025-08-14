import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kharach_guru/core/theme/app_theme.dart';
import 'package:kharach_guru/data/models/transaction.dart';
import 'package:kharach_guru/data/repository/transaction_repository.dart';
import 'package:kharach_guru/features/home/screens/home_screen.dart';
import 'package:kharach_guru/features/transactions/bloc/transactions_bloc.dart';

void main() async {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();
  // Register the adapter for your Transaction model
  Hive.registerAdapter(TransactionAdapter());
  // Open the box where transactions will be stored
  await Hive.openBox<Transaction>('transactions');

  runApp(const KharachGuruApp());
}

class KharachGuruApp extends StatelessWidget {
  const KharachGuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provides the TransactionRepository to the widget tree
    return RepositoryProvider(
      create: (context) => TransactionRepository(),
      // Provides the TransactionBloc to manage state
      child: BlocProvider(
        create: (context) => TransactionBloc(
          context.read<TransactionRepository>(),
        )..add(LoadTransactions()), // Initial event to load data
        child: MaterialApp(
          title: 'KharachGuru',
          theme: AppTheme.lightTheme,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}