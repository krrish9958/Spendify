import 'package:flutter/material.dart';
import 'package:spendify/data/category_config.dart';
import 'package:spendify/widgets/glass_card.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final VoidCallback? onTap;

  const ExpenseTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: CategoryConfig.getColor(title).withOpacity(0.15),
            child: Icon(
              CategoryConfig.getIcon(title),
              color: CategoryConfig.getColor(title),
            ),
          ),

          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 0.2,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
