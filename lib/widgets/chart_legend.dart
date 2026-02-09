import 'package:flutter/material.dart';
import '../data/category_config.dart';

class ChartLegend extends StatelessWidget {
  final Map<String, double> data;
  final List<Color> colors;

  const ChartLegend({super.key, required this.data, required this.colors});

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Column(
      children: data.entries.map((entry) {
        final color = CategoryConfig.getColor(entry.key);
        ;
        index++;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              // Color dot
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),

              // Category
              Expanded(
                child: Text(entry.key, style: const TextStyle(fontSize: 14)),
              ),

              // Amount
              Text(
                "₹${entry.value.toStringAsFixed(0)}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
