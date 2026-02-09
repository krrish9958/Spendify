import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';

class ExpenseData {
  static final List<Expense> expenses = [];

  static double monthlyBudget = 25000;

  static double get totalSpend => expenses.fold(0, (sum, e) => sum + e.amount);

  static double get remainingBudget => monthlyBudget - totalSpend;

  // 🔹 CATEGORY TOTALS (for chart & legend)
  static Map<String, double> get categoryTotals {
    final Map<String, double> data = {};

    for (var e in expenses) {
      if (data.containsKey(e.category)) {
        data[e.category] = data[e.category]! + e.amount;
      } else {
        data[e.category] = e.amount;
      }
    }

    return data;
  }

  // 🔒 SAVE
  static Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = expenses.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('expenses', encoded);
  }

  // 🔓 LOAD
  static Future<void> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('expenses');

    if (stored != null) {
      expenses
        ..clear()
        ..addAll(stored.map((e) => Expense.fromJson(jsonDecode(e))));
    }
  }

  // SAVE BUDGET
  static Future<void> saveBudget() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('monthly_budget', monthlyBudget);
  }

  // LOAD BUDGET
  static Future<void> loadBudget() async {
    final prefs = await SharedPreferences.getInstance();
    monthlyBudget = prefs.getDouble('monthly_budget') ?? 25000;
  }
}
