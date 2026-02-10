import 'package:flutter/material.dart';
import 'package:spendify/core/theme/app_theme.dart';
import '../data/expense_data.dart';
import 'app_card.dart';

class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final totalSpend = ExpenseData.totalSpend;
    final budget = ExpenseData.monthlyBudget;

    double progress = 0;
    if (budget > 0) {
      progress = (totalSpend / budget).clamp(0.0, 1.0);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Monthly Budget",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            Text(
              "₹${totalSpend.toStringAsFixed(0)} / ₹${budget.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 6),
            Text(
              "${(progress * 100).toStringAsFixed(0)}% used",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
