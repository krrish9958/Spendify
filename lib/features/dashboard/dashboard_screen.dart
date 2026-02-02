import 'package:flutter/material.dart';
import 'package:spendify/features/expense/add_expense_screen.dart';
import 'package:spendify/widgets/expense_tile.dart';
import 'package:spendify/widgets/summary_card.dart';
import '../../data/expense_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top summary cards
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: "Monthly Spend",
                    amount: "₹${ExpenseData.totalSpend.toStringAsFixed(0)}",
                    icon: Icons.trending_up,
                    iconColor: Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SummaryCard(
                    title: "Remaining Budget",
                    amount:
                        "₹${ExpenseData.remainingBudget.toStringAsFixed(0)}",
                    icon: Icons.account_balance_wallet,
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Section title
            Text(
              "Recent Expenses",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            // Expense list
            Expanded(
              child: ListView.builder(
                itemCount: ExpenseData.expenses.length,
                itemBuilder: (context, index) {
                  final expense = ExpenseData.expenses[index];

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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddExpenseScreen(
                              expenseToEdit: expense,
                              expenseIndex: index,
                            ),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
