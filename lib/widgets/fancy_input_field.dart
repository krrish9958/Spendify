import 'package:flutter/material.dart';

class FancyInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const FancyInputField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : Colors.black.withOpacity(0.06),
            blurRadius: isDark ? 6 : 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF9575CD)),
          hintText: hint,
          hintStyle: TextStyle(color: theme.hintColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
