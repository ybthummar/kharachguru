import 'package:flutter/material.dart';
import 'package:kharach_guru/features/add_transaction/screens/add_transaction_screen.dart';
import 'package:kharach_guru/features/reports/screens/reports_screen.dart';
import 'package:kharach_guru/features/transactions/screens/transaction_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:kharach_guru/main.dart';
import 'package:kharach_guru/l10n/app_localizations.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KharchGuru',
          style: TextStyle(fontFamily: 'KharchGuru', fontSize: 28),
        ),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(locale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem(value: Locale('en'), child: Text('English')),
              const PopupMenuItem(value: Locale('gu'), child: Text('ગુજરાતી')),
              const PopupMenuItem(value: Locale('hi'), child: Text('हिन्दी')),
            ],
            icon: const Icon(Icons.language),
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
                builder: (context) => const AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(l10n),
    );
  }

  Widget _buildBottomNavBar(AppLocalizations l10n) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: const Color(0xFF16213E),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(
              icon: Icons.receipt_long, index: 0, label: l10n.transactions),
          const SizedBox(width: 40),
          _buildNavItem(icon: Icons.donut_large, index: 1, label: l10n.reports),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required int index, required String label}) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
