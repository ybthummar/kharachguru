import 'package:hive/hive.dart';

part 'transaction.g.dart'; // This file will be generated

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final bool isIncome;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String description;

  Transaction({
    required this.category,
    required this.amount,
    required this.isIncome,
    required this.date,
    required this.description,
  });
}