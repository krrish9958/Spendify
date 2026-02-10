import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Food",
      "Transport",
      "Shopping",
      "Entertainment",
      "Bills",
      "Others",
    ];
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          dropdownColor: theme.cardColor,
          icon: Icon(Icons.keyboard_arrow_down, color: theme.iconTheme.color),
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16,
          ),
          items: categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}
