import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/nav_item.dart'
    show ResponsiveScaffoldWrapper;
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> projects = [
      {
        'title': 'Portfolio Website',
        'description':
            'A clean portfolio website built with Flutter and Firebase.',
      },
      {
        'title': 'Task Manager App',
        'description': 'A cross-platform todo app to help you stay organized.',
      },
      {
        'title': 'Weather App',
        'description':
            'A simple app that shows weather forecasts using open APIs.',
      },
    ];

    return ResponsiveScaffoldWrapper(
      body: Column(
        children: [
          const NavBar(),

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Projects",
                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Project cards
                    ...projects.map(
                      (project) => _projectCard(
                        title: project['title'] ?? '',
                        description: project['description'] ?? '',
                      ),
                    ),

                    const SizedBox(height: 80), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectCard({required String title, required String description}) {
    return Container(
      width: 400,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTextStyles.body.copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
