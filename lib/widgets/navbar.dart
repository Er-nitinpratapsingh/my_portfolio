import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/about') return 1;
    if (location == '/projects') return 2;
    if (location == '/contact') return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    void _onTap(int index, String route) {
      if (route != GoRouterState.of(context).uri.toString()) {
        context.go(route);
      }
    }

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    final menuItems = [
      {'title': "Home", 'route': "/", 'index': 0, 'icon': Icons.home},
      {'title': "About", 'route': "/about", 'index': 1, 'icon': Icons.person},
      {
        'title': "Projects",
        'route': "/projects",
        'index': 2,
        'icon': Icons.work,
      },
      {
        'title': "Contact",
        'route': "/contact",
        'index': 3,
        'icon': Icons.email,
      },
    ];

    Widget menu = isMobile
        ? Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.amber, size: 30),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          )
        : Row(
            children: menuItems
                .map(
                  (item) => _NavItem(
                    title: item['title'] as String,
                    isActive: selectedIndex == item['index'],
                    onTap: () =>
                        _onTap(item['index'] as int, item['route'] as String),
                    icon: item['icon'] as IconData,
                  ),
                )
                .toList(),
          );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 12 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.indigo[900],
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.go('/'), // Navigate to home
            child: Text(
              "MyPortfolio",
              style: TextStyle(
                color: Colors.amber,
                fontSize: isMobile ? 20 : 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ),
          menu,
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final IconData icon;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: isActive ? Colors.amber[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.indigo : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.indigo : Colors.white,
                fontSize: 18,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
