import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/nav_item.dart'
    show ResponsiveScaffoldWrapper;
import 'package:my_portfolio/widgets/skills_section.dart';
import '../widgets/navbar.dart';
import '../theme/app_theme.dart'; // ✅ Import theme

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffoldWrapper(
      body: Column(
        children: [
          const NavBar(),

          // Main About Section
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.backgroundLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Heading
                      Text(
                        "About Me",
                        style: AppTextStyles.heading1.copyWith(
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Profile Image
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: const AssetImage('assets/profile.jpg'),
                        backgroundColor: AppColors.secondary.withOpacity(0.3),
                      ),
                      const SizedBox(height: 30),

                      // About Text
                      Text(
                        "Hi! I'm John Doe, a passionate Flutter developer with a knack for creating beautiful, "
                        "responsive, and high-performance mobile and web applications.\n\n"
                        "I have experience in Dart, Flutter, Firebase, and various backend technologies. "
                        "I love crafting interactive UIs and building apps that make a difference.\n\n"
                        "When I'm not coding, you can find me exploring new tech, reading, or enjoying nature.",
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      const SkillsSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
