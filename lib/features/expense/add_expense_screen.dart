import 'package:flutter/material.dart';
import 'package:spendify/widgets/categoryDropdown.dart';
import 'package:spendify/widgets/datepicker.dart';

import '../../widgets/gradient_button.dart';
import '../../widgets/fancy_input_field.dart';
import '../../data/expense_data.dart';
import '../../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expenseToEdit;
  final int? expenseIndex;
  const AddExpenseScreen({super.key, this.expenseToEdit, this.expenseIndex});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  // Selected category
  String selectedCategory = "Food";

  // Controller for amount input
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen to amount input changes
    amountController.addListener(() {
      setState(() {});
    });

    // Prefill when editing
    if (widget.expenseToEdit != null) {
      selectedCategory = widget.expenseToEdit!.category;
      amountController.text = widget.expenseToEdit!.amount.toString();
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense"), centerTitle: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Amount label
              const Text(
                "Amount",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              FancyInputField(
                hint: "Enter amount",
                icon: Icons.currency_rupee,
                controller: amountController,
              ),

              const SizedBox(height: 20),

              // Category label
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              CategoryDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Date label
              const Text(
                "Date",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              const DatePickerField(),

              const SizedBox(height: 20),

              // Note label
              const Text(
                "Note",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              const FancyInputField(
                hint: "Optional note",
                icon: Icons.note_outlined,
              ),

              const SizedBox(height: 30),

              // Save button
              GradientButton(
                text: "Save Expense",
                onPressed: amountController.text.isEmpty
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        final enteredAmount = double.tryParse(
                          amountController.text,
                        );

                        if (enteredAmount == null || enteredAmount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter a valid amount"),
                            ),
                          );
                          return;
                        }

                        final newExpense = Expense(
                          title: selectedCategory,
                          note: "Expense added",
                          amount: enteredAmount,
                          date: DateTime.now(),
                          category: selectedCategory,
                        );

                        if (widget.expenseIndex != null) {
                          ExpenseData.expenses[widget.expenseIndex!] =
                              newExpense;
                        } else {
                          ExpenseData.expenses.add(newExpense);
                        }

                        ExpenseData.saveExpenses();

                        amountController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Expense saved")),
                        );

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
