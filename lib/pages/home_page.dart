import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/nav_item.dart'
    show ResponsiveScaffoldWrapper;
import '../widgets/navbar.dart';
import '../theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    // Adjust styles/padding for mobile
    final double headingFontSize = isMobile ? 28 : 40;
    final double bodyFontSize = isMobile ? 15 : 20;
    final double buttonFontSize = isMobile ? 15 : 18;
    final double horizontalPadding = isMobile ? 12 : 24;
    final double verticalPadding = isMobile ? 20 : 40;
    final double rowSpacing = isMobile ? 12 : 20;

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
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to My Portfolio",
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: headingFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 12 : 20),
                      Text(
                        "Explore my projects and skills. Let's build something great together!",
                        style: AppTextStyles.body.copyWith(
                          fontSize: bodyFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 18 : 30),
                      isMobile
                          // Stack buttons vertically on mobile, horizontally elsewhere
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _projectsButton(context, buttonFontSize),
                                SizedBox(height: rowSpacing),
                                _resumeButton(context, buttonFontSize),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _projectsButton(context, buttonFontSize),
                                SizedBox(width: rowSpacing),
                                _resumeButton(context, buttonFontSize),
                              ],
                            ),
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

  // View Projects Button
  Widget _projectsButton(BuildContext context, double fontSize) {
    return ElevatedButton(
      onPressed: () {
        context.go('/projects');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        shadowColor: AppColors.secondary.withOpacity(0.6),
      ),
      child: Text(
        "View Projects",
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  // Download Resume Button
  Widget _resumeButton(BuildContext context, double fontSize) {
    return ElevatedButton.icon(
      onPressed: () async {
        final url = Uri.parse('https://yourdomain.com/assets/resume.pdf');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open resume PDF.')),
          );
        }
      },
      icon: const Icon(Icons.download),
      label: Text(
        "Download Resume",
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        shadowColor: AppColors.secondary.withOpacity(0.6),
      ),
    );
  }
}
