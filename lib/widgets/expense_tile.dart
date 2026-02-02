import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFEEE7F8),
            child: Icon(icon, color: const Color(0xFF7E57C2)),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Text(
            amount,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
