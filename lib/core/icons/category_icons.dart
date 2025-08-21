import 'package:flutter/material.dart';

// A map to associate category names with specific icons
const Map<String, IconData> categoryIcons = {
  // Expenses
  'Food': Icons.lunch_dining_rounded,
  'Shopping': Icons.shopping_bag_rounded,
  'Bills': Icons.receipt_long_rounded,
  'Transport': Icons.directions_bus_rounded,
  'Other': Icons.more_horiz_rounded,

  // Gujarati Expenses
  'ખોરાક': Icons.lunch_dining_rounded,
  'ખરીદી': Icons.shopping_bag_rounded,
  'બિલ': Icons.receipt_long_rounded,
  'પરિવહન': Icons.directions_bus_rounded,
  'અન્ય': Icons.more_horiz_rounded,

  // Hindi Expenses
  'खाना': Icons.lunch_dining_rounded,
  'खरीदारी': Icons.shopping_bag_rounded,
  'बिल': Icons.receipt_long_rounded,
  'परिवહન': Icons.directions_bus_rounded,
  'अन्य': Icons.more_horiz_rounded,

  // Income
  'Salary': Icons.account_balance_wallet_rounded,
  'Business': Icons.business_center_rounded,
  'Gift': Icons.card_giftcard_rounded,

  // Gujarati Income
  'પગાર': Icons.account_balance_wallet_rounded,
  'વ્યવસાય': Icons.business_center_rounded,
  'ભેટ': Icons.card_giftcard_rounded,

  // Hindi Income
  'वेतन': Icons.account_balance_wallet_rounded,
  'व्यापार': Icons.business_center_rounded,
  'उपहार': Icons.card_giftcard_rounded,
};

// A helper function to get an icon for a category, with a fallback
IconData getIconForCategory(String category) {
  return categoryIcons[category] ?? Icons.help_outline_rounded;
}