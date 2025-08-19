import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'skill_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Skills Heading
        Text("Skills", style: AppTextStyles.heading2),
        const SizedBox(height: 20),

        // Skills List
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: const [
            SkillChip("Flutter"),
            SkillChip("Dart"),
            SkillChip("Firebase"),
            SkillChip("REST APIs"),
            SkillChip("UI/UX Design"),
            SkillChip("Git"),
          ],
        ),
      ],
    );
  }
}
