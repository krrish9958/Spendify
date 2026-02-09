import 'package:flutter/material.dart';
import '../../data/expense_data.dart';
import '../../models/expense.dart';
import '../../widgets/expense_tile.dart';
import '../../data/category_config.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String searchQuery = "";
  String selectedFilter = "All";

  // Filter logic
  List<Expense> _filteredExpenses() {
    List<Expense> data = ExpenseData.expenses;

    // Search filter
    if (searchQuery.isNotEmpty) {
      data = data.where((e) {
        return e.category.toLowerCase().contains(searchQuery.toLowerCase()) ||
            e.note.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Date filter
    final now = DateTime.now();

    if (selectedFilter == "Today") {
      data = data.where((e) {
        return e.date.day == now.day &&
            e.date.month == now.month &&
            e.date.year == now.year;
      }).toList();
    }

    if (selectedFilter == "This Week") {
      final weekAgo = now.subtract(const Duration(days: 7));
      data = data.where((e) => e.date.isAfter(weekAgo)).toList();
    }

    if (selectedFilter == "This Month") {
      data = data.where((e) {
        return e.date.month == now.month && e.date.year == now.year;
      }).toList();
    }

    return data;
  }

  // Group by date
  Map<String, List<Expense>> _groupByDate(List<Expense> expenses) {
    final Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      final dateKey =
          "${expense.date.day}/${expense.date.month}/${expense.date.year}";

      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(expense);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredExpenses();
    final groupedData = _groupByDate(filtered);
    final dates = groupedData.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("History"), centerTitle: true),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search expenses...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: ["All", "Today", "This Week", "This Month"]
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        onSelected: (_) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 10),

          // Expense list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final expenses = groupedData[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    ...expenses.map(
                      (e) => ExpenseTile(
                        title: e.category,
                        subtitle: e.note,
                        amount: "- ₹${e.amount}",
                        icon: CategoryConfig.getIcon(e.category),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
