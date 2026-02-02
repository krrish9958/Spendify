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
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF9575CD)),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
