import 'package:flutter/material.dart';

class CategoryConfig {
  static const Map<String, Color> colors = {
    "Food": Color(0xFF7E57C2),
    "Transport": Color(0xFF42A5F5),
    "Shopping": Color(0xFFEC407A),
    "Bills": Color(0xFFFFA726),
    "Health": Color(0xFF66BB6A),
    "Other": Color(0xFF9E9E9E),
  };

  static const Map<String, IconData> icons = {
    "Food": Icons.restaurant,
    "Transport": Icons.directions_car,
    "Shopping": Icons.shopping_bag,
    "Bills": Icons.receipt_long,
    "Health": Icons.favorite,
    "Other": Icons.category,
  };

  static Color getColor(String category) {
    return colors[category] ?? colors["Other"]!;
  }

  static IconData getIcon(String category) {
    return icons[category] ?? icons["Other"]!;
  }
}
