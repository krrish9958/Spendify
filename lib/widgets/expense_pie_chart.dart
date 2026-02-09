import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../data/expense_data.dart';
import '../data/category_config.dart';

class ExpensePieChart extends StatelessWidget {
  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = ExpenseData.expenses;

    if (expenses.isEmpty) {
      return const Center(
        child: Text("No expenses yet", style: TextStyle(color: Colors.grey)),
      );
    }

    // Group expenses by category
    final Map<String, double> categoryTotals = {};

    for (var e in expenses) {
      categoryTotals[e.category] = (categoryTotals[e.category] ?? 0) + e.amount;
    }

    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.red,
    ];

    int colorIndex = 0;

    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sectionsSpace: 4,
          centerSpaceRadius: 40,
          sections: categoryTotals.entries.map((entry) {
            final color = CategoryConfig.getColor(entry.key);

            colorIndex++;

            return PieChartSectionData(
              value: entry.value,
              title: "₹${entry.value.toStringAsFixed(0)}",
              color: color,
              radius: 60,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
