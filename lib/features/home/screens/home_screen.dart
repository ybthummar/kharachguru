import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kharach_guru/features/add_transaction/screens/add_transaction_screen.dart';
import 'package:kharach_guru/features/reports/screens/reports_screen.dart';
import 'package:kharach_guru/features/transactions/screens/transaction_list_screen.dart';
import 'package:kharach_guru/l10n/app_localizations.dart';
import 'package:kharach_guru/main.dart';
import 'package:kharach_guru/features/home/widgets/kharach_guru_logo.dart'; // Import the logo widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const TransactionListScreen(),
    const ReportsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        // The Text widget has been replaced with your KharchGuruLogo widget
        title: const KharchGuruLogo(size: 120),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem(value: Locale('en'), child: Text('English')),
              const PopupMenuItem(value: Locale('gu'), child: Text('ગુજરાતી')),
              const PopupMenuItem(value: Locale('hi'), child: Text('हिन्दी')),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        backgroundColor: theme.colorScheme.secondary,
        child: Icon(Icons.add, color: theme.colorScheme.onSecondary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: theme.cardTheme.color, // Using card color for consistency
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              icon: Icons.receipt_long_rounded,
              label: l10n.transactions,
              index: 0,
            ),
            const SizedBox(width: 40), // Spacer for FAB
            _buildNavItem(
              icon: Icons.pie_chart_rounded,
              label: l10n.reports,
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final theme = Theme.of(context);
    final isSelected = _selectedIndex == index;
    final color = isSelected ? theme.primaryColor : theme.textTheme.bodyMedium?.color;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}