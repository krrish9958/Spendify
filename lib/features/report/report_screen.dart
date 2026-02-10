import 'package:flutter/material.dart';
import '../../data/expense_data.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  Map<String, double> _categoryTotals() {
    final Map<String, double> totals = {};

    for (var expense in ExpenseData.expenses) {
      totals.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final totalSpend = ExpenseData.totalSpend;
    final budget = ExpenseData.monthlyBudget;
    final remaining = ExpenseData.remainingBudget;
    final categoryTotals = _categoryTotals();

    String topCategory = "None";
    double topAmount = 0;

    categoryTotals.forEach((key, value) {
      if (value > topAmount) {
        topAmount = value;
        topCategory = key;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Monthly Report"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Summary", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            _reportCard("Total Spend", "₹${totalSpend.toStringAsFixed(0)}"),
            _reportCard("Budget", "₹${budget.toStringAsFixed(0)}"),
            _reportCard("Remaining", "₹${remaining.toStringAsFixed(0)}"),
            _reportCard("Top Category", topCategory),

            const SizedBox(height: 24),

            Text(
              "Category Breakdown",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            ...categoryTotals.entries.map(
              (e) => ListTile(
                title: Text(e.key),
                trailing: Text("₹${e.value.toStringAsFixed(0)}"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
