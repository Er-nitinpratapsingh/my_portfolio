import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: Colors.indigo[900],
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.amber[300],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
