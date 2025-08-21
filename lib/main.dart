import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kharach_guru/core/theme/app_theme.dart';
import 'package:kharach_guru/data/models/transaction.dart';
import 'package:kharach_guru/data/repository/transaction_repository.dart';
import 'package:kharach_guru/features/home/screens/home_screen.dart';
import 'package:kharach_guru/features/transactions/bloc/transactions_bloc.dart';
import 'package:provider/provider.dart';
import 'package:kharach_guru/l10n/app_localizations.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const KharachGuruApp(),
    ),
  );
}

class KharachGuruApp extends StatelessWidget {
  const KharachGuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return RepositoryProvider(
      create: (context) => TransactionRepository(),
      child: BlocProvider(
        create: (context) => TransactionBloc(
          context.read<TransactionRepository>(),
        )..add(LoadTransactions()),
        child: MaterialApp(
          title: 'KharachGuru',
          theme: AppTheme.darkTheme,
          locale: localeProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}