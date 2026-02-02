import '../models/expense.dart';

class ExpenseData {
  static final List<Expense> expenses = [];

  static double monthlyBudget = 25000;

  static double get totalSpend {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  static double get remainingBudget {
    return monthlyBudget - totalSpend;
  }
}
