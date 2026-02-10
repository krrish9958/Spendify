import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/expense_data.dart';
import '../../widgets/expense_tile.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/expense_pie_chart.dart';
import '../../widgets/chart_legend.dart';
import '../../widgets/budget_progress_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _selectedMonth = DateTime.now();

  // Filter expenses by selected month
  List get filteredExpenses {
    return ExpenseData.expenses.where((expense) {
      return expense.date.month == _selectedMonth.month &&
          expense.date.year == _selectedMonth.year;
    }).toList();
  }

  // Total for selected month
  double get filteredTotal {
    return filteredExpenses.fold(0, (sum, e) => sum + e.amount);
  }

  // Category totals for pie chart
  Map<String, double> get filteredCategoryTotals {
    final Map<String, double> data = {};

    for (var expense in filteredExpenses) {
      data.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          _selectedMonth = DateTime(
                            _selectedMonth.year,
                            _selectedMonth.month - 1,
                          );
                        });
                      },
                    ),
                    Text(
                      DateFormat.yMMMM().format(_selectedMonth),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        setState(() {
                          _selectedMonth = DateTime(
                            _selectedMonth.year,
                            _selectedMonth.month + 1,
                          );
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: "Monthly Spend",
                        amount: "₹${filteredTotal.toStringAsFixed(0)}",
                        icon: Icons.trending_up,
                        iconColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryCard(
                        title: "Remaining",
                        amount:
                            "₹${(ExpenseData.monthlyBudget - filteredTotal).toStringAsFixed(0)}",
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Budget card
                const BudgetProgressCard(),

                const SizedBox(height: 24),

                // Pie chart title
                Text(
                  "Spending Breakdown",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                // Pie chart
                SizedBox(
                  height: 220,
                  child: ExpensePieChart(data: filteredCategoryTotals),
                ),

                const SizedBox(height: 12),

                // Chart legend
                ChartLegend(
                  data: filteredCategoryTotals,
                  colors: const [
                    Color(0xFF7E57C2),
                    Color(0xFF9575CD),
                    Color(0xFFB39DDB),
                    Color(0xFFD1C4E9),
                  ],
                ),

                const SizedBox(height: 24),

                // Section title
                Text(
                  "Recent Expenses",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                // Expense list
                Column(
                  children: filteredExpenses.map((expense) {
                    final index = ExpenseData.expenses.indexOf(expense);

                    return Dismissible(
                      key: ValueKey(expense),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        final removedExpense = ExpenseData.expenses[index];
                        final removedIndex = index;

                        setState(() {
                          ExpenseData.expenses.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).clearSnackBars();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Expense deleted"),
                            action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () {
                                setState(() {
                                  ExpenseData.expenses.insert(
                                    removedIndex,
                                    removedExpense,
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: ExpenseTile(
                        title: expense.title,
                        subtitle: expense.note,
                        amount: "- ₹${expense.amount}",
                        icon: Icons.receipt_long,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
