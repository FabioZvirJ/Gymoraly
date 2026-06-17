import 'package:flutter/material.dart';

class MultiSelectOptionCard extends StatelessWidget {
  const MultiSelectOptionCard({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(title),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: const Color(0xFF2196F3).withValues(alpha: 0.14),
      checkmarkColor: const Color(0xFF2196F3),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF2196F3) : Colors.grey.shade700,
        fontWeight: FontWeight.w700,
      ),
      side: BorderSide(color: selected ? const Color(0xFF2196F3) : Colors.grey.shade300),
      backgroundColor: Colors.white,
    );
  }
}
