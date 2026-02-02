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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount
              FancyInputField(
                hint: "Amount (₹)",
                icon: Icons.currency_rupee,
                controller: amountController,
              ),

              // Category
              const SizedBox(height: 16),
              CategoryDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              // Date
              const SizedBox(height: 16),
              const DatePickerField(),

              // Note
              const SizedBox(height: 16),
              const FancyInputField(
                hint: "Note (optional)",
                icon: Icons.note_outlined,
              ),

              const SizedBox(height: 32),

              // Save Button
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
