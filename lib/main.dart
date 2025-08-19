import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:my_portfolio/pages/about_page.dart';
import 'package:my_portfolio/pages/contact_page.dart';
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/pages/project_page.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/scroll_behavior.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    // Remove const from here
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/about', builder: (context, state) => AboutPage()),
      GoRoute(path: '/projects', builder: (context, state) => ProjectPage()),
      GoRoute(path: '/contact', builder: (context, state) => ContactPage()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      scrollBehavior: NoGlowScrollBehavior(),
      theme: AppTheme.lightTheme, // ✅ Apply here
    );
  }
}
